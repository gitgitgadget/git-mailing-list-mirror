Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850756;
	b=ZReFt0LkPJTX9kdk5+kUdYC5ybGzKX0KO7QLjodq2HYj+qlI5O0YpsJOsXxQmgSVvYLb
	 c/ZsQC6hP3Xy6SwX9MW48ofA0Ad5Nno1HW8dRXN9oMsCzdebmpPP/uyfrb7oBi59xfVrn
	 6Dg637hn/jwLdb6t3M8UfAWMmDfUkWAQUueTUQaS6CD7VJ23jWjsXYsgISK7RHvVcEFHy
	 uhyUyN2WmIJ2XTqlwuJqj26mCqyEOeYtaiPHfnYnePvQetPH1laz/xsqHLTj8F1YIn2Wd
	 mUKmarfmY/6+jbtb6IFMkHfkXuZRNv68MeL8Ga55jjhSa8YuCyUzm7RbcradsKM5WjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850756;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=92XlINy6PkjSBF7lKjEFXKfpYs/Je9OJS/PWrf/QNxE=;
	b=Ogx0tvH09TcD7vHhaz7byIa0VIW7VYbgXhnzw93GDJW9SY1m91dk8rUMeOZOG13q8YSO
	 eXNqzktXpU3Lp730BsEZlbKhGBhEKV8uHowPcUy2jI6UYv0Lskh+mU4feMB1h/RYwM8x3
	 qYsDThzkbwOsn5nGjurL9NEvI7RgjPDzxwIdrun4tevjpnT6x6J/HlR50gILITGXptDXF
	 tKYPZfn+YhqdEzmZ00t6bDus+RSmY8mpdTJIZ+hDt3Af26j8KflyRApv5kWfV1Lnckkin
	 sku1cXHUSChqPJv7wN5BGMOqTpQRlbcSgTC5Gxw5MXIqMwMAPxcMAF6zuNirBbrLGsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bdZ8DIYX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uelo50zj;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2628606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 17:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2628606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bdZ8DIYX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uelo50zj
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DD9FFEC05C8
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 12:39:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 12:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794850754; x=1794937154; bh=92XlINy6Pk
	jSBF7lKjEFXKfpYs/Je9OJS/PWrf/QNxE=; b=bdZ8DIYXcObNb501AFv0cELnBJ
	zMTYpIKvOm78CPaTZ1Cd2UUMm4rGdjkelW8rprIJp6SwSnlJA6E6g10L2Rdmtkdf
	KwaNKQHZLfylBjQdu0DO5AOE6ogC4hix+DYnncPVrGuOlnFHKhXLShBEHMXjFXnh
	nSMmx3lSyxXgUrwjdSJuS76nXfpDETJzAX4P1HVpPrN/jSurkkwwXSen4HP7Ywfd
	Mr/k0jnOzswCwJ1KBbmQHx4s8ArYQCH9Fk/lH5K7j+l+ARI2JdqxX/BIpuvC0Yqg
	PvSTmcTHOb3jJ0y8u2Bp7awKfbqghg4l73Njxzf6xmzWJqiHITFLo4JtO5EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794850754; x=1794937154; bh=92XlINy6PkjSBF7lKjEFXKfpYs/Je9OJS/P
	Wrf/QNxE=; b=uelo50zja4j6te+EY6b+XW4IBmLrn3aN1FiWKT+XaxXE1sOkLcp
	6lbLqMO7vqNKX8Bj6xk/aebpIlwb0TfZb7dJ22DQ86Uh5hk4Uz4NrRO4XRreWQuI
	i8+2Ymyv2GD0Fr1vtusVo8e6nsKdHOqXXK3uQ5Ql4yw7A26zBUsoqkF723AkJ7VI
	1rpYhfm4e5zSt/olaewQGequASSTUnI9VWO3R8S8Slz5zXMhY+6DDxMxs4hr3su0
	LnOf1WmoZlvgHegwc+yN//PGr6MQ9Fz18v9+j/GPPrkh3teIAM+to8ViJZbKG+UR
	aAwjOL9TSvIa5dOXTGikIIxc7xcuCe4Lp0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794850754; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lXbvW/NnPx17PO5JC/V193XnQPXLUaZXPmXN7WEUcHLlSEM
	TBCoW9bTAt6Hj4qmeolTfEzt3o96CDWD7Kosp/+5i2oKmFj1n3BjfLDEtawm/LQI
	xHL4p74aj3WGPs9ZRAoKiNOCqSUTZ26DRdopuWuAhHlRQvDwCu94EUrqq272U3s2
	wjPYxOlfyEUezhdbE58ATqrKbNSbgvGTL6ujLby/rKV/kUPK+fh9vJxkFqXbVmFd
	YT52n+dD2cnCstZ1QWa+WCnJ3zhhtOda/qob85dJR3EPFdECtJZWRWOC8sL95t2V
	8my8RZO+uxWXlJHhlDV2s6Ggu0C1XOP6TAWSXVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jMmL0vng61cD365lHJml4qEOAu7xSWtnd+YGoa231vo=:92XlINy6PkjSBF7lKjEFXKfpYs/Je9OJS/PWrf/QNxE=;
X-ME-Sender: <xms:wT_7aueUE35zIuP_4ujRbVuTibTV01HklkLLfYQFNjtyyek57YVSpg>
    <xme:wT_7ar4xg9QpbFfeqKDq_UKv7-rou6AMO_3f3dc0NP_lDi0rMhEc7gtODLNLqopAc
    _dM3apfYqg3N2rUw_DK0iHgVLYOxxkmT-Ds7V_V73pVzxxo2bvaDw>
X-ME-Received: <xmr:wT_7apU8eEIgHwuKhd5bbSDF_n_tKdwHlw0t9vlUI8Ggubxo4u9qA_2ASBYe8ODP-GnAMG_6eshgZjxgW86PY0z3JUuSN-lS7a8b>
X-ME-Proxy-Cause: dmFkZTF4kIj1bcm9qWSo1NHqnYVAmUL4es72R4WzJmpZX79mM+dGsgomQXKI753f5Rl/1R
    +FIypGIYKSYgBR1ljKihtc60L/ecUi2+BXDAqOKil26Bv30ekipysaS1RfJWLuq85jv7+/
    pZ8+JSFj2kpP5X3yZzInf+IRVfrlG7yN/vN0n9zlpZxBEeLyxWVk7YaN8jV3JnGBS0sOLB
    1DVF1ZBkbF+QrCkbA+V9TFzLC24ujECTMuC3DizYUCaalZcoYrjXLuS2f49+eJxDg4ugel
    0r4M+du+qcfRVhmNqyqHo88ny02Z/4ghZE6Vfq8BRqDu3yHVm5MdH4Ec6q87wZgW+Tf+YT
    MwiccJXRCCTKW5I7r3A4MQNOfX05FknitBFcKmmQ6XsWjpr9KUYhJZp8s8440vkDBk9e+Q
    pEsnt7hsSusvIPdmjD0d1CZmaWGyFVEwWsVHhKBWGIbaBCK9xgEoGya4fyh8mr84MdaTkf
    VN/zzkEFqSTBvwDM7J2MUQv7uKWpQAECdWkfGDtVs4PjuHLNC/Q7e4HKtbwt8Nm75xeVPL
    bPUNlKtn98jysg13AxX59UuHSioTyDIKDI8aX73U8GUvfH91zTTnlTZxsz3FpBylnKUy2d
    hCBxs+SoGni4mwe0fbpLdcLil2g/6FjNcS4XiFuFK3NcI/PbloaPz8JrsZQw
X-ME-Proxy: <xmx:wT_7ai4Z6Ua_drlu1cEX5nu7zUkU3uhDaL7AO0QfoI1LwAICPPw5rw>
    <xmx:wT_7asrbvB5bWwpP30pyEhgsDMz0w67dQ4_P7kVMR31oPC-xAwofpw>
    <xmx:wT_7atkvSR004s5oM18tXdWLszZPza7zZO8woZmqyJqOr-JptO_b3g>
    <xmx:wT_7agPMOpEW0C585Qq9qR38kcSUzxnmO85NJzylv_IQkN38SYgdng>
    <xmx:wj_7avanBHj0zaPRdwm_b4hskf-CyO6kXu7oxFUeGHMuIoD_fNUikdWZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 12:39:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Miklos Vajna <vmiklos@collabora.com>,  jltobler@gmail.com,
  szeder.dev@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH v2] log: make --follow following renames for non-linear
 history optional
In-Reply-To: <avq4QewLSGVLkCjv@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Nov 2026 09:01:05 +0100")
References: <ava1ax5UFfcvkU_d@pks.im> <avqyVuMvKeQshZYS@collabora.com>
	<avq4QewLSGVLkCjv@pks.im>
Date: Mon, 16 Nov 2026 09:39:12 -0800
Message-ID: <xmqqld6sllq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> One hint: please reply to review feedback on the mail that gave the
> feedback instead of posting it as part of v2. That makes it easier for
> others to see which review feedback was addressed.
>
> ...
> Thanks, this version looks good to me.

OK, let me mark the topic ready for 'next'.

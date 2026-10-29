Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307024;
	b=liwSmbqt1tt8fNYBU/qtbEzx85XWotzW1DKNgksdWSzG8eZRKvJ63CvAOximqn3E3o+Q
	 75FVAvH/SCP25FNsJiQ2JElD3sskHWwH07Et5ALK4Ok6+vXjp6wiPRhH/MIAqV3POI3KD
	 BnKdflwvyzhympbUjksOqu9lu05v5WmDwtdPM/qDw7KIUtpo80Tcv0/tXs1w67Kt8f25M
	 VN23XHNLLnIC1cuJ+5YsgFKr2xsYxv4oOIdv0LaioWrZr4pbGW7V4ATA9fu5PiCP9cKQO
	 gsmSfomxcauUVOuveKazl7eaEJ5c2FRTsBh8UxycdehbzllnNCrqJtuCT6ZTJjSqRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307024;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NBvWvFXTt6VHYEy0QMgO46bnjHd64TcyUSUjtFbWes8=;
	b=l9Jvr7mT9Ea5T23TNZ98grGaw0LSsAWj0HwsG+eO28xesYIayw+w6G02rzsI6R2mlim4
	 DrGfYQamuTbUz7HyC7hXUCzHN26rvDXxLCi6YoQWISVXP28ZvEFGUhYLMuf2dEHCR6eWO
	 dBNljCAFC3VWOA4lel/p6nFdomqiS3zaZVsPmUDccaOK5lCi0vEXi7exUGDwxGXTDO/ie
	 4ndqxgOta6mESdtcmYLO3y4BrVpw3OVgLkcQWJTWQG+zoL7YhSzggP3ULa09NLNO947hL
	 Nfh0yrbR7ec6wmZoMYuKLI8RwXyF4Y2izFiQzJc9xpqhfJW/9iei/vpLeHz3/MiLgsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JknkMLzh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TqUhUd2F;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25B606A322
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD25B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JknkMLzh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TqUhUd2F
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DB6A1D00134
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:50:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 16:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793307022; x=1793393422; bh=NBvWvFXTt6
	VHYEy0QMgO46bnjHd64TcyUSUjtFbWes8=; b=JknkMLzhyXCS6tr962PXoY0RKw
	lAM/f9fthYhWwOdu6y4wT8u9UFHlzK/qBOA3esQk6qG6gtdBFABuZGcyPbRcK4VQ
	+6qWVLt/RTVD2Po2rCgcG8wIcK5pog1XO4YNRURPuqUjBtzDZP8HfjMwYNgGhkx5
	myOz++tnCDZk6Cz7ssDttbRdQFhSXJ49qiVBSbEDFzVvZBLSJFexjARbhIwAFzjc
	59FD0N10aA7k3TBakQcqfJ5RUa9aiBNvYi614z/wMjzTTaSC54dwKIWk6NkRy7DU
	Q7MQ5T21W/BGAGW7GxwQhZCIurM0k4J2bK5y9XAme1fZht82seSqAr5CTjDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793307022; x=1793393422; bh=NBvWvFXTt6VHYEy0QMgO46bnjHd64TcyUSU
	jtFbWes8=; b=TqUhUd2FfxBD4i5QS8QJJpyrBSYAk/xQqjCNalHeu2+RfSQcKLb
	plXDRAuWF05hkJpjRN1TU/WwNE2noYbaY+foDVcc50Wta7jqyEzr/qrQ435Xy3Cf
	xnL/EMYSnvlRirgK89OqS7b+3vhjHpgsoITbRTwaT9FzpFjyZWmjLn7brPkI1YIv
	ZMbRyBeaRh6tOla7BA37v7mFjEGEQ9NBrlE/W24AqvsZ4jEPnodBb+W6ww3Owpo1
	pW5snqpfj7g7CKKUqzgnDIDW5IIIjD7ER4KvvsqsA/XFFxbKwpsJq+IZ1oXFE+97
	QvKij2GX7It1Uztoes6HYU0n4I2fMZ+VGCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793307022; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UJfJ3L2bU6PtJoh8ZMW3zBZfHdLxpn/cbxJey4NfB1dBY17
	X7cIa42cmvsCaJqgLY/JhfCqYsLfg770WGcwCH2hW47G1FfAJE04oYIcuJ8KYKMy
	nvS3RvKUbzfngrO4lit28g7abciCoH5VHjNaYJmx/j+tkhQY3fklxQmJFawnn3WX
	r58hDaWTH19f92P6hqXk/R4GuWhxtIZ0nyrGKQdtKUb0k7NuC+Ob6P4wUV7YgWOh
	gAKmnbIxNWLnL3/BRDGHIfGjGiY6VfkTATqAhP8SG7SDCEySIGN1Ygp/bE+vVvST
	OzjOtDsgK8NLiWfCyVK6jFTHeSigCoQBF269P2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gPC8fb5dhiB7yHf0T43JnF8amqqTbJcR1l22wMloz7c=:wQHoebN4eMW4ZktylMHrGZW0Y+VCaYmnJ4KXjWspcrs=;
X-ME-Sender: <xms:jrHjajc_p3hfxNfd5D7q486YYYFd0zjyk8pKB2yyKhsmOA5Qyzr7kA>
    <xme:jrHjas6VJpKudq358aZ85trPEQ-7ISRp6E7LWz1SbRYlnJYcgCkScGhnnrqtChy3e
    y1_aO0gxYjSrSdt3qeBND1VBfkgJnclXjbtf51AcfEinfder8lIGw>
X-ME-Received: <xmr:jrHjamU3sOv6PPq0L3Y4YIPFJhD6JtIDYqbLDmttOy5NhuH8Jr2OkkTBZf7x_QKd2YxDdm5x8i7rQHZbM2C7G1xIjb7Sa2vRdDd3>
X-ME-Proxy-Cause: dmFkZTGNBpQdiS6y1myHSSPp/UJBmMppTtDPszGy9fDLYVsrcLvwG6wwmWWOqHDmZJm8Tp
    iXqRDjVl3Rb4Ca+DpyH+AJbJZKXOSzAGKa4xt2flWm4yaYJqZMgudgDoWpo0NVXz+l7pL1
    Kwe/CiAQIOeai10NoTG912TKyP/HZarSHrwwNqNPX4X1DICl4Powmzq91ORz2IzAUCnIAl
    JieLVyBHSh1fMtuS9C9iTfNpUqzh3KM13vyynShxkJpsDHFE6KJ+BpJBY8Tf3reWDyQ4ef
    ZRtOWC5asUfjEVKq3AW61hXhzBYB2JuL7XshYwVzLvGEfOxGZOLZ5+apvLDTfcela9XGBh
    nKgVDUJyI7/EFNyU3AnvbSiOFkPoY+xblHBODiNEzTOvAzMSA45ssoBHX41hAy5Uel6Bqr
    FQF4YHNm9qjY97pLiI62ObO1Uu2fgmWs28fKxYeAJbCzAN0hy1qkLIcsTUI20zHYg0Sg4p
    TUDW6Wy6HNGLdESNk11NmtmOdK2iq0HvV9i/iZylCL+jrAD6abT9WQ4SLmsPrb+tOhN481
    Ow4uJ37fHkVTBm3xg373ojKoRf62QSTUUZon423w2P/cU31dYX2aqOTht+aqnT6b0wjwyd
    SHac5pm3cgx21SYdoVHWn9MAVEMQuCXtI2ck6n8/8NH4Osp4rnB8b6Ey1dCg
X-ME-Proxy: <xmx:jrHjar7D1TYnCq0dDYjrIaG2klHLcsOfw4OVaYuj4kW6lv0rxZxFRg>
    <xmx:jrHjahrbfgSmxc2xA6cC0lMMr-SsLiYGtOy8xoLhxWJcLCJVeATZeA>
    <xmx:jrHjaunEBPrSRxJTrU9rbzrzBUF5Hadug3Pi-77TttbeCs_G2jENUQ>
    <xmx:jrHjatOjxV9wpofCzV2XTPF_R6m_1R4unmHGNCra4D8dSq6FDlcHrw>
    <xmx:jrHjagQH8l6Bd5BKQghHkf8INsPX0rh1AmL2Gz8R6ybfPkK6hOVC8e8l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 16:50:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Pia Park <pia@pierre.co>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] midx-write: skip writes with no object entries
In-Reply-To: <auOtMGiGOvWVtkl7@com-79390> (Taylor Blau's message of "Thu, 29
	Oct 2026 15:31:44 -0500")
References: <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
	<97eca05600afc5828e3f27c6fcfd3f7872ca326b.1793260625.git.pia@pierre.co>
	<auOtMGiGOvWVtkl7@com-79390>
Date: Thu, 29 Oct 2026 13:50:20 -0700
Message-ID: <xmqq8q3g1bar.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> On Thu, Oct 29, 2026 at 01:26:17AM -0700, Pia Park wrote:
>>  midx-write.c                            |  5 +--
>>  t/t5319-multi-pack-index.sh             | 15 +++++++
>>  t/t5326-multi-pack-bitmaps.sh           |  9 ++---
>>  t/t5334-incremental-multi-pack-index.sh | 52 +++++++++++++++++++++++++
>>  4 files changed, 72 insertions(+), 9 deletions(-)
>
> Thanks, this version looks good to me. I agree that the remaining set of
> questions can be dealt with outside of this series. Thanks for working
> on this, Pia!
>
> Thanks,
> Taylor

Thanks for writing and reviewing.  Will queue.


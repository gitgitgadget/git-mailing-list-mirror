Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778148;
	b=nnZPXo8y+ua7PG9/ukjQ6k8GKXkKgYfpXXYR1xITG9oUyqYju+fVXEy13laZ0h7vcFFS
	 lyrMBjH+Vac/A07m++RfhM64yhUGEdfsytLCIypbhqJSS0D+v5wzK0Zaw7h83v2J2HBRN
	 /yQMyNr8v8/BxF8o7Na/MXA6MfE+bx3Yp0tk5rgnoD706AVi3gXaH3qL3o1RnRtFpADF6
	 Z6arY+Vnq7OXbnt3enJdBjA5l+LKv+vFziEdSPMoohpqh9NkDIR8uZX7ElHJO/rvCwBPj
	 GSLmHVNDBjnEtNcDL3q9vP17zMDZCQZf8eiPfQdGxDk1Z2luJbyyZFLvhQwXxiGH8yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778148;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5i5RxjoSxPwl3aVVBgA6/fRRGT9HLkfp6JbMh5BThEU=;
	b=M7ZHiSiJ7LDv8Kd+J/nyUs7EXw+loskZpmfbfEpKtf66T60/jSPpGu4Af/GTmucwK4/D
	 JDp62hGgwjEgIHtbwarNz2BNRQIgO1rGWhLhT+bIw03/hXtRyirEX4v63crDI8ViEYLRd
	 MRKSD1uR6d1AI2weIPd137VePNdMUvMAJZNIUEI8O6zP+OKn9t3RhJ+LXavGxBnHEkf2+
	 wUgTceepxUvkCdWsdeVBnQYfzgc1dW0Kl3V6cFWGrO2l1M5krbGoi2l8OTqEXbMBKun4W
	 LZmB5LMgdx74/l7joKL6PbZa85oMEMctWu9aIphwpaxb+j3PR1Hz8P4Amf3/IOo83zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CTLY9S0N;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fEXTUywn;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0665606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0665606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CTLY9S0N;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fEXTUywn
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F473EC0187
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:55:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 23 Oct 2026 13:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792778147; x=1792864547; bh=5i5RxjoSxP
	wl3aVVBgA6/fRRGT9HLkfp6JbMh5BThEU=; b=CTLY9S0N02Xf9gjwM76M/gv7DO
	6eWvN5XxaWLBZWiiOqwEgT7U4Sb0soFEz2Vq9bSGF71lgBFdpzGSNX02UtJVEp5w
	UfmxU8o1ROQTOn0dQKvJ26iRes8oLXBVvPce02zG2fob5HHYSJPc0DuAcblKwRlX
	7Kzg3PE/lCvdKWAuJ6+bNRKOjTkx2FHe7pvUE2Qs4CneuDD5lGw7z2NaVCiLH8fH
	Xcg5yWewiXCQmU2zfgqIKN3nMgNeyNTg5rsUqaDDtlMcwZW1oM3nt42RQxPMtk1A
	Bde54m97dqHZ1VpH78H4Tf5NhLjMbjqVOwSB5OQGPq/HdV2j5DFKF30+ec3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792778147; x=1792864547; bh=5i5RxjoSxPwl3aVVBgA6/fRRGT9HLkfp6Jb
	Mh5BThEU=; b=fEXTUywnjyf8nXuxGsjXFbl+GRw6alnu5dwiYr6+UX6NmZMCqqR
	4VBo5bmsS//HEropmfozN3N/RsRiysJ3hcyDAeWl7PxRMkBI3T0GIwRYSjgpmeXL
	2aOlk1kQXWfoiLuKP7dbThy0kffe0gbSI1+MiDVACb5mmoQmrj5OYfDn5sgjveW+
	Af7bwQr3OEkg/S1jSsIx2MzALf4WRARJuysHqgZrCZH7hms7xOHBAvsBfMX9d85o
	3WrHo6e38UXm2d014b7nqzuQQUtQMhsyCE35UfOZl4dqCqmg3kmwy/YLpqf789Uu
	fCYRmUqtF9QeO/2SfU1gUl7xkIZzFoHhupw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792778147; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YvCU/1A2LPD85GykVySZVEyjprm0v6lut1W6ZykL2LJ/Ll/
	kPQOD3r8bKvfYZj/YOr+r4G6VzT2l3jINxgg2r4G/dZVfduUmo8bOluLd/rsT4qk
	7W1xNJFbRvqu4p6HoKb1vQ1MmM5D2DB+xSetHTl2mrGjG1HhJXc+JZOCgybdfKPa
	AbkqElTehd4a8Cwq2wmBUbofloB/DRSGZQWzOhGAlCMhvOUgAUWjIqXdWD50g58Q
	lGx9+REaXfrOTdGPIiaMMUVTQPPk9/4Cy0m/z1LiRR35VNIQRthUzDrQH5XscciA
	kBERjQrbihtt6adzanwHRZ5xNWkjoSR5HqmIdPQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:U4nQoYx9wKRko3z5UzGfha9Yq6yIW5tc5xwvGneP81c=:yGnte1rQcEGry2iOtSeo2LN+XKZCJP+dKJLnHUCFrBc=;
X-ME-Sender: <xms:op_basaEIbqse-6pfpYiC4LVJOKsZ9NtadF49x8becRFQzh8neltIQ>
    <xme:op_bap9My6rbpZVk5wbpiJiR-ig1DsmLXu0HV_N3t-LFNghW5PcweTa08JRgs7JRa
    8BcDinrUK3RxCYn3NDKdmyOOfED5-k6i-YFjVQkhUPl0Gl27q1hPyg>
X-ME-Received: <xmr:op_baqlOGGsyToJ6iLLIHIzayRmIrAqkla_Sk1jiX-Pa1QiIy0vST0vp9JhGuQ2nlVaM6vXLzEfuTrM2D-_6iRB6zBU4-w9TZNzU>
X-ME-Proxy-Cause: dmFkZTFniN5BSUprVIw5my1B9GTkYleM9h/XaypKRztnR3ZPwa/flygLED6ZqVu9ZYz76W
    VavGWEcB5ZlY7/f/RrNAPA1HbYTx/bNw8QTnGB3Ru6ENZ5ZgJyRFKhxD/uPejnUePPaAaQ
    t1Z4Bkvna9nkzNOOj+nAMm2lEhokuD2ttD239pcKk8Lf/isXi+BZL0IKsy9JGxLo1ayp4I
    cwxr0jKCBE+YqPvao9Su0pMujD6ZfeprX95Kt78Ew8Wh4Dvd68tyU2aCObNxyslaXVZ7nL
    5aIaT1DjBpd07ob+OwuhUZyTWmvO6Ue5fjpIY9kg2UG55CST7RScO3VV3sQAhlyeKrvlAs
    UV3/ZJotPk7g/9YbfmvMRGxTUe1wg4+AOUSigKCswQVPUW5Z1kLpT7C9WtLZrnUwEr0W3L
    a9aBoOhU0+yv2r1Jkn848aYxhBhKikv08tHsCRorDHY6fXVovVir/Ei8zLoqQZgLe+xm3y
    pdeNVss+uyeg4Ai8oYqxzD5eLLdd+PthPkBYddQbh2ywwigeKM6d9XK3VoNiy2ZV76n7Yo
    wjIGoUJ8NAiJNXfkutRGWS80+/9OqZut1AJwGpdb2lQfyO6E2olt6g06HQzNd+fhcCd6fD
    0UQkupZCHhDu3/O1TSiwO4FLXZg8P/tFW6K5O4SZRI7P5+3W0Gj25x0vsUNA
X-ME-Proxy: <xmx:op_bamwJXo_fdYyElQQd0RdK_bRwcZVWxLDmymUlGs37dn17bshrZg>
    <xmx:op_bas46kWDcc70DbrlOGjcQb9hRX_6aM_O-a3U-PF-P2k5_eglnMQ>
    <xmx:op_bauXTNISw8N07J4ZWw73qDS86uf45lls_S-I3DT6LFESON9tMSA>
    <xmx:op_basLyAHfJ0t36FCEe-N3Bg_Pyqv9VY-6JRhgM2Wlkrq-updhB_Q>
    <xmx:o5_basi4IGEm7H4DbTIcnC4uL-haWrR30eEgweU9QyNhG0XzWfyxnG50>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:55:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com,  taahol@utu.fi,  ibnmuhyideen95@gmail.com
Subject: Re: [Outreachy PATCH v2] checkout: use Q_() for messages with counts
In-Reply-To: <20261022004834.246892-1-tangajoris@gmail.com> (Tanga Joris's
	message of "Thu, 22 Oct 2026 03:48:34 +0300")
References: <20261021022156.119947-1-tangajoris@gmail.com>
	<20261022004834.246892-1-tangajoris@gmail.com>
Date: Fri, 23 Oct 2026 10:55:44 -0700
Message-ID: <xmqqcxt0713z.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

>  - Also converted "only one reference expected, %d given.",
>    as discussed by Tuomas in Mudi's thread.
>
> Interdiff against v1:
>   diff --git a/builtin/checkout.c b/builtin/checkout.c
>   index 49239f029f..91b7c52396 100644
>   --- a/builtin/checkout.c
>   +++ b/builtin/checkout.c
>   @@ -1491,7 +1491,9 @@ static int parse_branchname_arg(int argc, const char **argv,
>    	else if (dash_dash_pos == 1)
>    		has_dash_dash = 1; /* case (3) or (1) */
>    	else if (dash_dash_pos >= 2)
>   -		die(_("only one reference expected, %d given."), dash_dash_pos);
>   +		die(Q_("only one reference expected, %d given.",
>   +		       "only one reference expected, %d given.",
>   +		       dash_dash_pos), dash_dash_pos);
>    	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
>    
>    	if (!strcmp(arg, "-"))
>
>  builtin/checkout.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Looks good to me.  Will queue.  Thanks.

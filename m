Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088889;
	b=s1nPz63gpPx8IkJi5aoKBvehL0ASHlclFoWIz06byAUb9Iul06mldwuCC8fjsx502CpX
	 DPgTfIGzwGcSshzJTLZIhJPTT7LdIAdpq+ahhUOypkiCau2MC2oDf4Id2ULclCmtxgK0A
	 WXVTH5oZGV3/ZetHQHKeB/6FHmGreEptTXesnma6mlSeTvEyzQK3gHdWbXwlTl/BXZgzL
	 yA8Dwurt1JNxQGw3YsVV3a4HUzjZh4YmlJjBiVcTFbNhaSsI8DbJY+dNKau4wrJKH4rOY
	 FH9xIDjDPSGw6f6XcrB4BomadvHY9PZ6AshDgFSXl1y6IBA/b8pFAvw4O0dzYZlSYMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088889;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=3Zfw/RggnnkFOtzpSu5rgJfqWv27uIQ/JRcuGr9NaT8=;
	b=ZadeCH21RczKGxeec7NpDTPuQjkERCVsA9XzKCPPsq3VuloOYAyI6pbCYfMF6y9wor5Z
	 N2Fox3ERiXCz5vAeIis16+mJlp/C+YXfPeX0IsTCLy+wJt9TSxqll3JnmuQYxunObpswC
	 KGcp1O4sUcmgXoPIMXiaBuafKZqAlZdZWctZANv2jnRpFTNF4BXyzu7fsh8G/3PpXSSzD
	 kmqvW+GVe7B3yF/QBLxr/2QhykQROPNv1rYKFTYQuJ3Qp2NOMAEE1ziT7CVTtG1A8l1mW
	 sDttlXQUe+3qPq/EjyT/2fXm90DdhSFPCKp1kI9OtrdgDgMSLtHumBwEBRs+EGNHnIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="Cg/NvKQb";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="QHPwA/l+";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09210606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09210606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Cg/NvKQb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QHPwA/l+
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 28A7EEC0941
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:48:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 06:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088888;
	 x=1795175288; bh=3Zfw/RggnnkFOtzpSu5rgJfqWv27uIQ/JRcuGr9NaT8=; b=
	Cg/NvKQbgxtJQWkHo4PO/f9Ck5gYvjZgrOALH4S41VIqbmVfMIJOMp+E2BEQGSNT
	HR/vrZkDOlAwwvMonOyJa9DiiAopZuPcl1gJchLTzMeYFKRmzxWPWrPR9YN5Orqd
	2FrredE2Fr3baEsUoP/Zzjix1LbVv0OcBk7F0gKVJiX964ApkplUI6jCFIsAExRj
	BoclWX90W5NUikuI23KNNoxr9UTZu3ok0KA/ratuNa8oiqPBgEVN3wDwnzgw5DPm
	GlBjDqwZ4NkUCJ65TGwhDW1E3CimhTV7JQsTS15msux7LLEKMLMtnuyw5IDt6tFZ
	K9va9lSeMI7wSwMbvJoEGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088888; x=
	1795175288; bh=3Zfw/RggnnkFOtzpSu5rgJfqWv27uIQ/JRcuGr9NaT8=; b=Q
	HPwA/l+EiXbrlEVhMMKzJhYG4QIMHcGgODKjXIUdPkskQbQGgu0ejfBGvyHmTnp8
	TBFiOfGXZlrylzqS3erThVf7C6fpq0I38CkMxUKgedZSOUyQTVkwyRaJnYyWMtcF
	t7gQ6k8gNcdzlcfNgMjdYZX6GFtWFB8J1BoOiUvpioa+MpTLUHtw0cPUvb+UDiJ0
	Gr4VElfx7kknvS16WHt/Q5zhf1B0ZF50//gNsowXQHRcXCLbndhmhjLm93gCuTFp
	wkc70QAFdFoBj+itHwD+m9xu5KmxQ2EfH0qWnz4PPUCdBPnZxRFlDPsvYEFoJhZL
	I1xYA+3vntardNrLMYdJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088888; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:SUp3f7rNsR9cZk+PeXjF2pWN6ZG7EOkb8vfVKmx5gN8ST3N
	2sKpXP1I+hUT29bvUDIs0V9Vbl7UL9eNlx1e0regYput4kENhwcETcbLRFE8VEki
	OZWNwjP7XKC6pGhcBYvvuwsVmD7yJ2J3Vny1fMTkOemZW4ZT2HxHXdzAACFQQLkY
	sJdc4qiZgQ3NAo07c2lHR/2JzdgqDghfBwjGZH7+F6t2OvI1f+9cc9Iv8ofhSDA4
	Y4Au5Ocw/Cs9OqASiadQJ5psob6IWzpPb5mZia59sAT4FrYByGWTu+YysQ6w3ah6
	GOZslz4k8CVo/Mat0DEzylaSaTM5sHujHED40ig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Sk7VikXwPAWunZhuLRTLwrrQLpDU2Em9iN7k7BnP2GE=:rOCbdoCmHXrv5nkVKooxSyaBnQa1ngAeTLGR+rU3lp4=;
X-ME-Sender: <xms:-OH-al52zssxOTSmtnxMqmBBsWuY-16qW7yK36Go_VW24M5_QG_HfA>
    <xme:-OH-ap6aF0s6XO48PKyJGFEbeBOY0DfbquZtc1_j45W3JHoQ1rV5mHrBfk2WWZbvp
    5lI2Zp3TaJp2kdDcoI-N7q4xK7HBDpxbEF16ev5qeP9c7ojsLrmdjI>
X-ME-Received: <xmr:-OH-ahfXiCnkIwmYlblJVb0Z5cSfN0idg13WH2Nur73XV6SvA5T3il6vmNczYWTNA1aTXN8>
X-ME-Proxy-Cause: dmFkZTEKKI8yGf48wgPThKhlCtdrEnUbwtshCR1M3ay6poXMFiL/UxahGfI5SWy0nQXBQ2
    7ljWeTtD3L/za1J6LPfF4eMsGFjpdxZd32Kg4QrMG2BSl5yg4ZnnNfFob1gD5pxwsHy2xZ
    HTHuUW1xIlV7spyuOCi6mvTQEzBCzLdW6VHsmRGSHBBlmjI+Cue/It8eJfXzK3ZEwKRnIs
    hO+7ueuAUrAoKq4lZsdSghYOaZttquiLFxwkDQlSdsdS/PJfc0S9ChV1hjcxaaxGZce0uK
    v/dmTudVdvHzQjIKAGovusdDGI3vKYOq5Hs61iXB/XErjv5YzCLyBfiG5BNYxjaV/3+6mn
    q9K/mrf/bkEAKWQq2WztuK0WYikBVZNQhQDbeP0sy+F7Fw0Vv0SwMMd1ON4huYzVjZG+rX
    oCaxyNomOyiAFhHwAdTe37GS9m0FnuCkVBKZ1mzU3YUnmJSSdsAHVJYbPcKinUw0EwzAfj
    bDK9eQ32Pd2j2QWSjmYBpkyZZN9nIAA6GAGP1xarSJAEYg6LAybJ4Us0FtynS/LmEggYEP
    UP8oisrRUVDzCzzpQkPjhOTz49gs8BwNGKNLWve+/Yp6eUCCkkbSPw41xx5YUPvdIwtRFF
    XtKEK7cNvwN5jS3R7L8PcJ28U96FgvENzhEzBHXEaZnBt8JGV7TSMlQ3mgXQ
X-ME-Proxy: <xmx:-OH-atBM1rSrFbHenSIBI4u52gN0iekSNTNfmGex5GkzACpO_Z3hMg>
    <xmx:-OH-ak_KQmVV_TdrtRYLqwOT60tS25-u2lpS9s3A2PNR-NzqarSzvg>
    <xmx:-OH-aoJrnXCdZ4NvH3Ouxhoa70TMzjADqAT9o-Yc2075nXdkD35cjQ>
    <xmx:-OH-atilYMEWffm_A3XZxKGVxiWS2ZPTka0HfMHOO1HWHoA9GpHuUg>
    <xmx:-OH-ag8ggGP63BSWNVKXb8aBJAhm6Ce9zTrCbN_CtxzPucB3ETkxoutw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:48:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4396f90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:48:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:14 +0100
Subject: [PATCH v5 13/13] Documentation/git-rerere: drop claim that we pass
 args to diff(1)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-pks-rerere-subcommands-v5-13-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Back in the old days, `git rerere diff` accepted arbitrary arguments
that would be passed on to the system `diff` command. This has changed
in 658f3650273 (Make git-rerere a builtin, 2006-12-20), even though that
change seems to have been unintentional. And in fact, our documentation
still claims that arbitrary arguments are accepted.

While the original change was unintended, nobody has complained in the
last two decades, so it's rather unlikely that anybody cares about this
regression nowadays. Adapt the documentation to match current behaviour.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rerere.adoc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index e04e9ef3ef8..2a5b443610a 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -56,8 +56,7 @@ conflicts in paths that match <pathspec>.
 
 Display diffs for the current state of the resolution.  It is
 useful for tracking what has changed while the user is resolving
-conflicts.  Additional arguments are passed directly to the system
-'diff' command installed in PATH.
+conflicts.
 
 'status'::
 

-- 
2.56.1.831.g720f3f5937.dirty


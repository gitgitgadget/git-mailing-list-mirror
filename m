Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379556;
	b=2A7EwH4cUNzjLqVMnA/ZCImAQM08GV8MyDNeNVCnlP5TqjqAGPjeT/EN8u9xBj/E6Z3l
	 AQrb1wZ3YdLCr5LbP8FUvZQ+q7YJSxP6O1vKrK4PT2l9V2JiHtpPSHU21LxL4xF5I38Un
	 HMh7LW9IGyQwwdFNHfhkXPMHQzOIqoXoOibDrJCIfu/k2ZJwB2L36tjrUTdLPdSRV+7o4
	 boucVCUIdSfWxzjWAdD/mrER4sjC6W52H4TjYsX4xe8TvVS+DOizodnKMyKx+bQPDT6/O
	 7yb/3rsT7T9+sAYz90CRQvOTadxoHgLeEZWm6QvbRMJByXEVpVUtX7YbOT41pKRptXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379556;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iqERUGJ3m8BWocc14o+S5UOkjKS8/jSvxyNvss38l5M=;
	b=cmwrRuX9rxwmwUH/pmUnvRBLe+AhWjC88osjAUyaghiQxB6VxCiL0N3nRGm7MtgUGCf5
	 Sr8Cp8ItIqILTAiRhXYbJ1yT52snzQ0waX1aEi8Dt3VT47Qmx1Q4x5j2Oo4SyCfdCZveB
	 FXjjzSscrke8ZrcjSaeguf1KGQUx7uqRMvK4qX7KODMxfJzWSE0zm8gUKAJ9hxucCQAxQ
	 qppEZPdY+j8Ev/ggIKhZF03tepZAVd24OUMIsAjpdDIB8RrW4RGOeVfpLl2PrwIKPvT4b
	 ZkDYU/u7KoPVUcruRFY2iTPLmz+5QT6BIKc2MXoY75wXRhCBdLnNMbInnmrBew46a+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="eM5/DUkT";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E7a1MSYO;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A0606A31D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C64A0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eM5/DUkT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E7a1MSYO
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E01BE7A00D8
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 12:59:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 30 Oct 2026 12:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793379554;
	 x=1793465954; bh=iqERUGJ3m8BWocc14o+S5UOkjKS8/jSvxyNvss38l5M=; b=
	eM5/DUkTcxcBswYesLEGkfOu7C1n/St1isTjpC+AwwLKxs32vdDlVSgNKvrQI1Yc
	uVOqG65mqzkQPncvdSA4MKpzTtBI435bsbnlGGn7UyXMvJXJhRP9eiZX+COR9zUL
	EjEYnEOGSK4Q6NS8IwciUAoQ/6XDgPcnoQU6SQ/3GDaMqxpeFESXzsPIxwjwLhM5
	JulVVCrk4+898ew0/w8y1ygD0+UXAChQjPkhj0mUTEebLtQUqMkUlM/mxUTKSuQ7
	nX0F+XV98757rnLfloZ7xxPiHn1iiad165uqy2rYU4135fnPF/PUOgmzVSc2gikT
	GQCPoLusGhpGDK3smgy/ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793379554; x=
	1793465954; bh=iqERUGJ3m8BWocc14o+S5UOkjKS8/jSvxyNvss38l5M=; b=E
	7a1MSYOjmBiQX8hVIUg59Y3Rshhh4FXJKDLmMNv2IX5WmBGC86qcFIrN36Srbzka
	crTTRKV/WDXQBI2SaucMKCG5Ae5l5nhytypE3rgG3ivPqXBiRPftQifc+P6PgFpm
	nr3BxEwQN7f2vWdqopRvCAkl6Kas+I43al7XPEkHsQCdJAmB3EijMbUfOqjcCSb2
	2xs74l1KJoXObwlO7Gp/aUPo1AqgT4O8D9ytxPmOCN0IZv63XT7hqdQBvAlNinxY
	JFjlDl44HWxoJo72tYS27NK5xyK4CPhPA+Gy9O8EP8v/PlhS8Ypjm2qpGXp2Sjkm
	HK+qI5nHS2zO3i8DY/u5A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793379554; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:k1/gLbInNvP8mcSwKkO+SFhnVcYsjWfumk0CP0MQJV0njeI
	vzuvwZgUMuCtcu71544fNwYozS7uGRDxjBwwr61oDgW2mdm4EXoAzVGyhR68D4OK
	I9n9SzOiO+Ldjt/hfYGIayOe4+EmeBDjI2NxMwqmUC9Abj5YRDfWlUQtPrVx2X1u
	hdTTREt9dNI6PXdnnUBvfWSNeni3I0F8zO1PAPQ39qwjPuUw9IEPWTWJBsOnbl1h
	C1AUdQln5yd9GiOnmoBPCColV1I0lz8tUln2zlgepvdORUl86hqrCFyOg6rTQf3o
	hxXnx7hRms+9SKQRWvCx5trSsEChfOu4Su64bhg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:ywUVtFCRcs8nm6tGFMOaQg24Oa37UKVVa+/ni8Bwiq8=:x19N+z/Pasr7intik+GrShKgLNJlB9yYE1saVOZcI20=;
X-ME-Sender: <xms:4szkatulVNPACDw6H7jkf4IVXIC3g4U9NDC-KWkFd_Uw1mBM52O1cg>
    <xme:4szkat5Xw4l4nn3mPbxjOHxOBkqnpGcO5Nucq5C_VeltfAano6DrtQdNwkA1HgFaF
    _hejBE8Qc9PcRhHql2PnmSHUqrBbvnBVrxot2V0TdDVqtvBT5Tquw>
X-ME-Received: <xmr:4szkauLlQ-KPQG0vllzeQjDrnmXvccxpSs-RShV2_ilvSjpSCDOFkiCaRPIVi8KZQxf-7vRjbD_4XIfKPMWsXpt1gX2U9FVvG9i3>
X-ME-Proxy-Cause: dmFkZTGk94ehy9fIpCv8C8I7oKIBApgyUP13hvXg1/SFk6W/IAQN07MpVfvYDQWRswtJfe
    WKctGgXm9kwx3zNnU9Qe7nUW42TO5Hn+FRt4GdRVVVaogPO6ej8ZZYDoZNQNAAP9rZ3IRX
    v5CR+8lbFZzdRhuqYRhNxN8fFpusgJimw2GMGsB6PNO2HmhmPe17Tn710yw+YD/14j4DKa
    G1+7YlGwGSea7Zc7AVQVQws+wiQ4v2BeBdYYhRXvIG93GHrQ9WjkpSYVm+9j8pCKrFKhXz
    hmBcMYJpUo89NjTjeDjj0mKoSsvIn8O7LzJIE7sABcA1byAwBPTD2cIigqNwzkDyt1Owr7
    q4sHErSvV8nc2uA6Uag33377NYWz1mbnTusfW6Xaxy8uWmQk1gRbqVM/Stwug3oHoFZ2DX
    ES8Kwt5uEBFIqW346N+6iw7nF51rNByc89/c31ktGx3YASPRomF7V7iM5733SpiwEX+mVS
    RQsyCOk8oi/3g98DeaW5z8bP0uv64wo7aKxNR7aVzYZ9TKc+NjhtGMPPg04iIwY6tWOBNs
    6yPmp+m6pJc9N8i9vN5Hs1ewJufer6B0AuvQToE4mb72fBZCsoViXbhwWXAxJWMrHHdPcP
    osRSulNVse4iIPIiqUtWNmx9CpNyotSWRY42iMBMj4B5atuNKZDbkec0F/VQ
X-ME-Proxy: <xmx:4szkat5wlCj5jdmcHnqFPK6aMzrRBBbrDkekHB_hqqVpMhuyWm0KJA>
    <xmx:4szkahz-pJ-NksCJA1UJXhwiQMaQKRMDEUxRNtoFr17z8rlhPS-z2A>
    <xmx:4szkahbb7smip94Wci2UgagC2515oEc9kiLj8oFYhTmQxYy8O3tUzQ>
    <xmx:4szkajQWpA2cTB2I5uoE7qd1f-e7yKIJQ8b77WeuRBv72yWSOdppPA>
    <xmx:4szkalguAgkObtZJHLSBkA6hJobOcR2jRUFjkKHDAt4dj4lLzud4zQVu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 12:59:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Windl, Ulrich" <u.windl@ukr.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Q: .gitignore and asterisk "*"
In-Reply-To: <07b3498d83424cac87221724b371839a@ukr.de> (Ulrich Windl's message
	of "Fri, 30 Oct 2026 10:46:01 +0000")
References: <07b3498d83424cac87221724b371839a@ukr.de>
Date: Fri, 30 Oct 2026 09:59:12 -0700
Message-ID: <xmqq5wyjxgyn.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Windl, Ulrich" <u.windl@ukr.de> writes:

> I think the documentation for gitignore(5) could be improved regarding "*":
> It's nor clear whether "*" matches an empty string.
> So when I have
> foo.log
> foo.msg
> foo.sh
> foo-whatever.log
> foo-whetever.msg
> Would e.g. "foo*.log" cover all the logs?
>
> The manual says:
>        •   An asterisk "*" matches anything except a slash. The character "?"
>            matches any one character except "/". The range notation, e.g.
>            [a-zA-Z], can be used to match one of the characters in a range.
>            See fnmatch(3) and the FNM_PATHNAME flag for a more detailed
>            description.

Very good point.

The reference to fnmatch(3) may not make readers to consult the
documentation for the library function.  The system they are on may
not even have "man".  fnmatch(3) often refers to glob(7), which
typically would say that a '*' (not between brackets) matches any
string, including the empty string.  The reference to FNM_PATHNAME
we have there is an attempt to refer back to fnmatch(3) that would
typically say that the wildcard does not match a slash.

How about rewriting the entry like so to reduce external references?

----- >8 -----
Subject: gitignore: rewrite wildcard description

The documentation for '.gitignore' makes reference to fnmatch(3) and
FNM_PATHNAME to describe how an asterisk "*" and a question mark "?"
behave.  Even though it spells out that these wildcard characters
do not match a slash, it does not say if an asterisk matches an
empty string (it does).

Rewrite the section so that the readers would get a more complete
picture without requiring them to know what fnmatch(3) and glob(7)
says.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitignore.adoc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git c/Documentation/gitignore.adoc w/Documentation/gitignore.adoc
index 7979e50f18..671a5a4c99 100644
--- c/Documentation/gitignore.adoc
+++ w/Documentation/gitignore.adoc
@@ -110,11 +110,16 @@ PATTERN FORMAT
    and `a/frotz` that is a directory (all paths are relative from
    the `.gitignore` file).
 
- - An asterisk "`*`" matches anything except a slash.
-   The character "`?`" matches any one character except "`/`".
-   The range notation, e.g. `[a-zA-Z]`, can be used to match
-   one of the characters in a range. See fnmatch(3) and the
-   FNM_PATHNAME flag for a more detailed description.
+ - An asterisk "`*`" matches string of any length, and a question mark
+   "`?`" matches any single character, but these wildcard characters
+   do not match a slash "`/`".
+
+ - A pair of brackets that enclose characters match one of the listed
+   characters, and a range notation inside them, e.g., "`[a-zA-Z]`",
+   would behave as if all the characters in the range were listed there
+   instead.  Wildcard characters "`*`" and "`?`" lose their special
+   meaning inside a pair of brackets, e.g., "`[*]`" would match an
+   asterisk and nothing else.
 
  - A backslash ("`\`") can be used to escape any character. E.g., "`\*`"
    matches a literal asterisk (and "`\a`" matches "`a`", even though

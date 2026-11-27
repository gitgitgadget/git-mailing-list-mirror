Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813405;
	b=j6G9Ec16ZcG45tBPOvJdih8BmqZorvuAe8t4ZrpseXpiqmlMi2JBb6z/1h8xreP6En61
	 ML23IXorRK3rx2b9S5I5HN5DaDReVB607zPyYWJgNjgKTCcnBjX3tHjcs13oTS9z26txt
	 d94Fqdzr09D5N0aygRop4olxf1BCEjXQcdY9gApNjn9YHSOd71YCM4+qGqH3VN/Ig9qJ4
	 1Tju+mmSjJB/MjRZljO8bDHcc6bfLiARWk6pUv2uuu3ZMO8l8xoy8gm6ZUWaX8NczHZj1
	 QX88QqY43UxYv4n5c/DXtQSchhmgJHcm7tIBrfqHYr+95eCTz5vY9CMcM3zpIhOazhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813405;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=NXRIFxIKt7m73XoofSePpxNtVYY+8ZwHW9Kp6bVDJN8=;
	b=xV6PdK7nlwMWdUbQApP0Xyj/p0/jNMriuTTXmuOfAg7bQXCqmMXNrmbuKsLoenMjcXjh
	 QknRjk2aAfZq451CZituQphE5Fa/n/Bj6Rxf1OyYzRSEy4Y+lCoxNW26Bn65LyW5bY/7h
	 p4ZN0lh+fEYb8QIQviTpBVr/4u7EsqJAlzpaKsWK3evbRJs2T0YIDvnqojr3y5zNv/EXW
	 c9rdKkRYPQ9ghqjP1g5u6/0toYhTsDKeJsB9pZQV3SuDrvlQx1MXkdcx2Irp1PykaG/BU
	 0mIruMeeOFbWQefuKlnyCNf2mKN/8VgfNKXl54eKSRP+wQR/MyNbSax6T44q5wpIHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b="kl/0PzvQ";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xkf7u48D;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E1606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 21:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB4E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=kl/0PzvQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xkf7u48D
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DE671D003A9
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:03:23 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 27 Nov 2026 16:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795813401;
	 x=1795899801; bh=NXRIFxIKt7m73XoofSePpxNtVYY+8ZwHW9Kp6bVDJN8=; b=
	kl/0PzvQ5n9jxv0rYcAuiQmQ79rekGzLt6tUOYHAcDlgjtgNWwHz5q165pmTsaH9
	T1m2IZjaB+1zke9JcDWcNasLWkcPXdQZmHJbm2+AdLApeVIiOLgutukXA++l0CiT
	IddN9/3AQXVcLKot7gI8skB95Nm1JkDV0D2ca8VeMeHtSN5U3rP6FCSnqj3V4DaI
	J/ajzVPpzYW2H6JkeFEaFdBnUOn2L1iAzYDqxubYyFNRa30rNzVeunk2wsqNbz3V
	8Wia+5U/xXtbgy/CgsfV4/JCUGTcb75AKVuegzDG/yBiKnQ8FguO50lVVq6LndSc
	YMEPRXsj6eoHEyP9kAGJZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795813401; x=
	1795899801; bh=NXRIFxIKt7m73XoofSePpxNtVYY+8ZwHW9Kp6bVDJN8=; b=x
	kf7u48DG1biK1DqqNzjItgwVI/x8XDiRaYRexFkuwZ4FHqbfYd6yT146lELapgBY
	A1u6yvM15kyo+SiYTIVl7RTblPm7Gr2eXLlfgM2UP3rmBqbIxIFAolIicB5eiji/
	BnnxrFNewtXnW12mbrVRG4Xzh6B3jgOYnhCz2+mA7/F8VP4htfuOHZDeEm7FA6Gr
	rgvSbpF3RSUZOwXfaAnHZSLSlrk3QgRJTLp8KDUyLcn1AlF9wBZRaDQnhpiUSLA/
	Gzfb0z9oUA+X5tvOMBHOihdkRwdZH4ZcrKmwlT1ym+eC5QQ2YKLWbfmt5nY13Ju1
	dy+e1pr+ovgu2cLBzfPfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795813401; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UhQ9V8fkUzg3KaPhq6H8kvZ7HAgq9ie9Yx5ezn9BdCgS6YM
	D4cUI+4iFVY/PJlvPbW0ODLqlrI8b+xhhusC41nBfYMOHHZGhmJB84bAnzbNJeHa
	0XtemT48tqn6/gDBK5XLcnBzs/aEMou++3tbWULPAEL4caqlTzjNVUp93Tu0d+Ml
	lYnKAKS/ZtQZUj6oHPM9E2n0DUFNi7zxsDiclNVN/OxyhQfvXXvFk+H2J3GrWPT3
	ILHcKJl4xlBkoA513nGPkKSQIPfs0pvwWfrDn9awdft/JzEGWuv3hFnWSnhOHLwK
	+Fy1VfxzCKBKagS4haQDsWADlc1sMSyocZBmH6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iw0VNBnfUfD3M/Svt2hM4MuzG0Dr1Q+3Wxzh33jgNc8=:Hywv+7Outgq1NZ3VJHiOTDXvCGTYgTUUA2vGTrETfJo=;
X-ME-Sender: <xms:FvAJa0XOsCFi8DsM2GYDbfsRq9jUJx_Lk6CvehCzJ8mEKpkRZVpIBYM>
    <xme:FvAJazalxAoPxD-ccQf1JUXkVzn5q3buu1LIl-lWo1RMuugZFb9nsPaV5rhsG-ge2
    GfcB7sdX3ymNMClSE1GDy-bAqjY7icqcFutc8_HuxPtNpwL0lSg88QJ>
X-ME-Proxy-Cause: dmFkZTEQ1eI9EHF3Z0+vxbcCx5JOc5FJBdCl2l/mBfmo6UYvx8gu5rLz+eotAaKXY1WnZ3
    KFFiCFo2LwDatxWaQ4cOT1nJtw90bmBN5g4dGQ9w4wIIYScLBUMl6LFHdHYWfaRwmhbcqc
    u9Pcr/0NyiU4ycaHR/CjMDxjN/iKhilCJJ3W77WxRTELPIxLV8s3SjdErdGhfdxE5C9VdA
    fza/3zN9VG0tgripr97r/NHnnRegssVnfij3r0XACpbCXSwrx5UcI5LX4ingO/XplNp3NY
    cIOwTR1MJBWGPhqq39axSB0kuQAwpmkz2LJfI3HbYErI2sXUk8i0ikPd7W9Zd6tuAPzgIn
    rZhYseWkJhgN99hYBl+GxaZibne2pgnqxq4Pm/GuJlgHgPF6WZRHk8h8bpy8bCX2R5JlX4
    xCC4eeCtxPFTIXolrQzaTLSCd/RM8knho7H4tBeWJQpznOJ7oqJlNcYHIHVZ2CsLl9gViZ
    tMaGCquIanARXB91EITRrpvkchyWyMPYIdZM6xiNl1S4HJyAAfXHLD/s0SLHtJ6SFDhNVP
    yQgEBNc30qA/YIGarxZWfb++kkscQhYkFu53374dWqSNEO0gFi9CSz75nsKNEg5utzNrg/
    VNJad1Cn81KnUQimwdmQs+eGzywR2ntdLPy+bE3BVt3uVCxR1t/vuNpMVUdg
X-ME-Proxy: <xmx:GPAJazitiLlIC2az1-zdPWP8ppsAW33hW8YF-afc4CoOwUYPXrToQA>
    <xmx:GPAJa5dGs7dWv2BVZkJ9sM-swb4baLjZR9SY9ih7anZayXSRKMpm9Q>
    <xmx:GPAJayoGi5wEcOIDTDd6F1rWexQdUo8Kc5UC44wGr39BywOCn4UnOA>
    <xmx:GPAJa2BvXjFcfhdRculh314g6dD2SqUdr9nikyePIEAd4KvyH3STAQ>
    <xmx:GfAJa6gYIC4-lk6XiCJKLr3zvrpYD_rgk6jDeliwiZ3A6VwUi8PCdoE7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 918DD22C00A0; Fri, 27 Nov 2026 16:03:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AeJYkkWRInug
Date: Fri, 27 Nov 2026 22:02:57 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Tuomas Ahola" <taahol@utu.fi>
Cc: git@vger.kernel.org, "Julia Evans" <julia@jvns.ca>
Message-Id: <faf10eb1-bb8f-47f0-960c-d54c6fad01d8@app.fastmail.com>
In-Reply-To: <xmqq33sme4u5.fsf@gitster.g>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261126201110.9046-1-taahol@utu.fi> <20261126201110.9046-2-taahol@utu.fi>
 <xmqq33sme4u5.fsf@gitster.g>
Subject: Re: [PATCH v4 1/2] command-list.txt: add gitformat-loose(5) and gitpacking(7)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026, at 15:17, Junio C Hamano wrote:
> Tuomas Ahola <taahol@utu.fi> writes:
>>[snip]
>> That leaves only gitweb.conf(5) which could be added to
>> 'userinterfaces'.  However, the manual would then appear
>> as "web.conf" in `git help -a` which is just confusing.
>> So, perhaps we are better off by leaving it out.
>
>[snip]
>
> By the way, plain single quotes 'git help -a' instead of backticks are
> preferred in the commit messages.  Nobody passes these proposed log
> messages through AsciiDoc or Markdown processors, and they are supposed
> to be pure text.

I use backticks in commit messags for my own personal work just because
I prefer the look. So it=E2=80=99s not for some markup language. And in =
that
sense using `, ', or " are all equally pseudo-markup.

The only time I actively dislike no quoting at all is when the code part
is a simple and commonplace word and the context makes the sentence read
weird enough for me to do a double take.

>[snip]

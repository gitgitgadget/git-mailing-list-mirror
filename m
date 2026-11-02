Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793592484;
	b=Yhwmauio4zlbvK9uCo1jJvVXQQ2vija+ZT/VPUmJ3y1CGYZW8ywVpQi1D8hmyZWVtW2s
	 JvHI6hvodtnoBTcyODdcJRE84EJDd/VnP9fqPTA+AMhBBq4JtGX8KQcPJ8xWuzfPLh2Y8
	 L6j7qn0FBGsJ4+e+3oXEOG/7fAFlt/npYTGHDdsPOShg/jgOtNev/dsPlHgcsUdiN1cK3
	 tVlZweihJGpE027YWUy25QR9L0rJks4AcD40jc4A7u8CaDAXGD+VpFWgc7J9ln8vbZ4JA
	 IWpk1rKJfnu7/a/DFC0jukBK1/ul7CTzi2qllquBv5sT/KngCXoylY56aX3z5Rn2lWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592484;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4I1CF0hlZUPuJJ+WMFmjUFgZ74ZXDkhwyCICDgq2t2U=;
	b=rloiqUwZmyADNorVuD1IA6cJhgECNJ2zHFsyWynHuoLWedwxgAJezmVzmd+Idayy2Wac
	 0aLfIQ/VN5wPisf4H6NXwXxa7YWeZkdlI4fgq1XERXmcSAR7FFk+1rzmGDx2ejrMJayeG
	 T3u86xDlgJZiJK84n0bxk4OjrLeEW3LPh6pK/6uSsqvsC0JTBpWq3G57A/+rCQAtM3dUy
	 MInC1jq7imLp68Ql0zYUh3uju3ux5zLJpprch7ATySvjd2KzJ1qzqyXS3zZ85hES1mU6C
	 9jZaa6atT9gJgCy7Qwk1+9zu3Ymu218Qy/YWP2wAHes8CGnG8gJ1CYyNldyfE7ci7PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="KP0/7q8c";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p13d7ecB;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64931606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64931606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KP0/7q8c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p13d7ecB
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 721587A0190
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:08:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 23:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793592482; x=1793678882; bh=4I1CF0hlZU
	PuJJ+WMFmjUFgZ74ZXDkhwyCICDgq2t2U=; b=KP0/7q8cPF0sBY7Dml2DmtmlyK
	DxpwH1N10NutKunTZyZphPzKC1q2Ccp/KZmkWz+AyELEH3ZakfP57Ooi5O45sNqW
	c5Gx8Mun+HGd1XT58JET0C+q6H/ccjwEe+8ZD86m8USbo8DPdbTZoMtdmftIXgJ5
	xQ0SZ9T+R3ElqEjTMqJKhGswfBO57CwMERegUKt2zBtC0zmy40C26rbLE6re0fWa
	h0iVwUJFNmI1xphuB0C8pObk6XaHuxLtAyaG9n9UBukr6rx44v1w0qlMnn/nFC4e
	Euvd1Dch3zpKIGt6a1RwwxYSruxNK+SUgMUDntYFdQ4UF+ujp9PuP9nkfJ9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793592482; x=1793678882; bh=4I1CF0hlZUPuJJ+WMFmjUFgZ74ZXDkhwyCI
	CDgq2t2U=; b=p13d7ecBt0UmkDYC4LNTPBinorZn/H5PHDn5k3HJY/IQzkgk1rE
	W8NeVlTrLtp5nzDx2P8oVM8QQlQSoo+YcgiwWJZK0Ga3t6NlvMlxKjUrlLvDxNkX
	lMMJgH13QMqM6YKq0PyGYdRAgij9K6v7sGK2gK1JNW8wypart33BY9EHDETIa1+t
	n5gSEXXBCFFCAISlSQnLBFh9drmXZBze/cWQzNFAD5XjAKwk2xkBGq+gesNDsH6X
	QX26Z+CPcbxLlkHdmDDwxsRNSrGSv9PmN4mUhpZZVhsAo+wRgTSJq4IWHMa2N6ok
	cNmzrxnSDhLxxWRv4rSpBeZhXcbByoRdT6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793592482; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LzKSzwoqCkffZ4nTY2DFCgKW/9JW/wj0bKpoghcGGtt4PPI
	YXaj8/iTTWkPWmkzUkDp4s8pQ3EB2kdu5CGPrbzuZgZjUJPvVDifixvqzA1Zj30l
	7jgPykwBGGsw7C0gtezFas6+HhY29v7xmG7ICcIInr5kUAy+DDwEKc2C6Cqicf1A
	1pRtvVbB/Rv5iun6oLNOdSpB0xXKUa/4rfQ+lhX7k06HIkhafdYIgS6S3/9h8f8u
	KlXniQN65wiBplXjg3hpeYWMcAmz0SSGeEeMZAtkxZzU9gy/9pgiNhWcZkEipopm
	us17Jx/Xa+1GU40iQIQbipORR+2HgFbqF4SsiGA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b2/TMJaImT/S9OrAfmClBrh8kObOCkffdQxZ9HTkXLw=:8PGHvXG/Q6E48kyZP2SKtugjsTEiPN4zLQEgifzu9Dw=;
X-ME-Sender: <xms:oQzoat9b2d_JsMItHPk6GUMHphghi0pqbTSExFxK1Fw95fzM0e5eaA>
    <xme:oQzoapJvfF3vfdcwiuMksvEjR4UhKNB8QdbRtM5DYvZl9divwaVSp8lGXcz0MGIyr
    E9q_B49KPOHLCaaxenmbHsm6SgJbUkAXbz8VPOPZFGbN88QI_lYwQ>
X-ME-Received: <xmr:oQzoaoa1TkUjedKMAyTXtVCDCFW5RwlOP0DWAiorXdVrlOz9-_DPIuOOSC81HJj4e3U_0yp53jRa2-kwgiPKqO3hTxXWNM9z0zdK>
X-ME-Proxy-Cause: dmFkZTEjVoxbfsi39jDaUuDfw3wIkS19s1La/j7F741dJBML+ecWthUTlOsKX8fmvQdJ6X
    n3lFLeaW1Yz8iXHzYutAlRxN/JV9xX389T/o0QG3rI8vt2suE+oIyOjCV9BWKbjEI3VbHf
    91cP2pEgp0maFDbF1m+OWYHOR9Nw+7GZrH0D+lOJM7GRdt9R5IcmKVECyTYhFnqsT13Whr
    pkHw/1E/2o5KA/6paI7rHaspeGGTTEPWPMXt724SaGanqj8TXVnBiTeDTFp+L5TDe0CM5M
    GeJ8CrC9gb+7Sax/z3xpMmvO4DjBpbJXQDKk0tnS9tVvyxt0tlzC5kdT3Syq15ROfbUvVB
    z7EZxDnU93JHYwAIcqJ9RkTkfQgtPz9etxi9f5c0oZ28/AOy0T95e5baEE2iPtnKQ5EVSZ
    +Jc1Nve+RS8e/N3pNRp/MLK715IH+FYvSGzvWyt9jPJfVfHYldMlRB+hUIlu9PU43JHxpN
    wda7PSwdBLrYK+/tjUM0P+e9r8Pu60r7GSaqoPdwqAX08RBPvANzYrDGe4JEomLwpnawS4
    UMvmzNF+Dqh5TFsuzPwYvnJj3KvcwDr0Y5kcqPj31Y6jdw1KvlW40+me8tuoOA5abMu5Db
    xp4/3ncOu7gx/3kKD9O39VVj/AdKOLRwq45X7l6DuMAigFFHsU0k6PP2vPCg
X-ME-Proxy: <xmx:oQzoarIx7K0LTKyq0Hm-mNsTv-7F2RV2BJS715Gp_zbekU04Z8i4Jg>
    <xmx:oQzoamCQsNh776jDPUCPlmm7gvq6YgJKKUt6aDiRKGdZn7y_8ezgPA>
    <xmx:oQzoago69Ude2tbJYrto6xL5qe6Hm74IwUXKCtG_Qd20QCxgy9fg5g>
    <xmx:oQzoahi8mZBkHgKRguICtx2ZZ12-TgyDVWn6difgeRPX0b6KF9XoIw>
    <xmx:ogzoar27npYRl_f2vjiLSbCK-0SpJL5mlIynJUMYzfUCNgaCOXShAg1y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 23:08:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: update the required Perl version
In-Reply-To: <20261101185846.24208-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Sun, 1 Nov 2026 20:58:46 +0200")
References: <20261101185846.24208-1-taahol@utu.fi>
Date: Sun, 01 Nov 2026 20:08:00 -0800
Message-ID: <xmqqjymvooyn.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
> requirement.  Update CodingGuidelines accordingly.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/CodingGuidelines | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c06f5d3071..9b17ab34db 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -703,7 +703,7 @@ For Perl programs:
>  
>   - Most of the C guidelines above apply.
>  
> - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
> + - We try to support Perl 5.26.0 and later ("use Perl 5.026000").

Is this in line with what 702d8c1f3b did?  Shouldn't we say

> + - We try to support Perl 5.26.0 and later ("require v5.26").

"require v5.26" instead?

commit 702d8c1f3b5377a64670b0f22add157b0bfc33dd
Author: brian m. carlson <sandals@crustytoothpaste.net>
Date:   Wed Oct 23 00:45:59 2024 +0000

    Require Perl 5.26.0
...    
    This change was made with the following one-liner, which intentionally
    excludes modifying the vendored modules we include to avoid conflicts:
    
        git grep -l 'use 5.008001' |
	grep -v 'LoadCPAN/' |
	xargs perl -pi -e 's/use 5.008001/require v5.26/'
    
    Use require instead of use to avoid changing the behavior as the latter
    enables features and the former does not.
    
    Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    Signed-off-by: Taylor Blau <me@ttaylorr.com>

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 636add6968..3d061bc0b7 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -1,6 +1,6 @@
 package DiffHighlight;
 
-use 5.008001;
+require v5.26;
 use warnings FATAL => 'all';
 use strict;

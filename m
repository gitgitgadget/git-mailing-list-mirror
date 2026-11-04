Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822221;
	b=3w4oHA1gE0is7VhoePNkk1NS35I0aTt/i357PV/keF55i/1xFMyJR0o/NvoqixCindYq
	 pfb1N0Cm52+0vrvdBr8M3GHLVQ0b2TelloAgqOJBYGyoUqkURFhSi0yuHPYdMO0zo0G8M
	 oKuMdA7Ji56YWNsLH3s37ji9UN8HILjEh573SDLL50NFXPIFyQrwgz9mSIGNSKvTemniO
	 CfX1Y5mC6K038E6mcXRO97gH3pRhT/xqIxIKJbhq/najNk/dEshWqzA4PxxZMXjcYzNDE
	 MYmp4fEN471g9HGEas2dkUQ4kKhQtVL8grz0a8Kya591z4ScjP+E4/q8EdXEJroGIMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822221;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aZjAsiUn2ZMnFk/23PdaIv+flWo+97iozVhtNn92mbQ=;
	b=cy7tivDid7fZu1A6OSd9/Bs/fN/fa4fS8y8ZGakFnzTq781Jwp6iyOy0LF4yWL22rab7
	 yzcZnzPEEO3G1QST/WrYFPhvmSPaadViAjz3c0Zw953br6QRvpHq7QQgAEWKQwhITU72e
	 5bbsACM4xmPZMA31qEcm8JlXFHNut99S6QknfpNFMzpmFmqjTEI3qecZzBFVAvJhd2TAR
	 Is0jQq6E7vtEZ/MSLedLi/cTsNH5KfgWwh/MXN0fDcFex9pPDizLw8wUonM6iN+G9cSAs
	 i6JOY2T4Kw5g9smMsPFr/6Z8mpQuLbyWobuRQ7xzmwxd6kVH7KpcxttQyToqiyA17Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D4HBO4AV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=E6bnZarp;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E0609DC93
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C84E0609DC93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D4HBO4AV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=E6bnZarp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 19F6DEC0077
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 14:57:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 04 Nov 2026 14:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793822220; x=1793908620; bh=aZjAsiUn2Z
	MnFk/23PdaIv+flWo+97iozVhtNn92mbQ=; b=D4HBO4AVe4W/yPV2BYqSivQZsz
	GpJHX/1Ogl+EcYFe0KIU+DiYNCIdkPmHXuGWAR6+d8izWjtonb6UQNGYRnk8Mhog
	tycgFj/Lrs2H5338Qpobe1f3Qcxxkl91/8m2uvZBuzOXdhz+aKXH+W4llOuzzHWx
	bEEUU7jSyfa9xcy6LrkQ/OtvKuI/6y/AvrcbllN5CrQaoi/NnJW6lktFNZO9eZ1v
	wgaqhoksI+GTXV9YQQbOJd/DoKaxnSpvAKsiN6KuP6IdhLiayT8MrpnTR1K33TKR
	6p8BBL2YckDniqpx4LopsVH6eW2f1s8wxV1bTa3Fk7A1Winy6Oa0lymlinYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793822220; x=1793908620; bh=aZjAsiUn2ZMnFk/23PdaIv+flWo+97iozVh
	tNn92mbQ=; b=E6bnZarp8OLAnQB13Ih1JS4AGjcIQLAWUgsPBcZpX+kA8YhJesU
	f711Z1d9gs8M8RXAEyPKgucUjTB4fN77yRJ9KcIOXCowCilkcy1ul/LLUEFdR235
	p7UFuKidp2KQPD4PVyrBfVoL72lqvcqGKywLgbPYHAQYQ8kXRovyl3xzGOgrKRm7
	jELYqZm7rg6tv6iEtzjOZN6bPaFParO15f9yUxnqr9bANg69JiuLzvE8WWOtA+9W
	DCQjfrcuxCrY2NqwMJ99MvPXh/rh57sgyZV+dEtbv02KL3QRxZNOUchjNDi3ggkx
	ex8Jb55xP/2K6iAqqofBemDRiU+ktGuNY5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793822220; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hDN9jNaZRflR3veLDW/77GQNNfT/UGa8jPD5WqkvlNw5gfJ
	gtqUiuhZr+sJy3pfflndpDE63eCbdE2jGZhVlMQNuwVgMhWgcwUDc4x4NJWywei1
	nPgI2pslok+Cal5/x7HVTKOkCyjhIE9GEY8A6Uj4pIyylmcwCSotdKBqPijlb88d
	I/FkBL0VTnzu8ELf+/JGzRQBRFlggu1B4rq94kkdz1kieySxJbAgmPZn7WYKbiN0
	jzOGDaAHlH/jW2jdVclX2/7ZI8GRz2ZvMpCTD8RNZRqEccCWMuKgmAjxa39ayqXA
	rL8HbDCbxG58VUNUN49UNavytMFVZuqCQfJETWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:OQ73f0Q76GA7nRBvHHthcsOlxHo3kbdI8veR7E0iNfs=:xBbrq5PRqsbam95w232vZryl8TNVqqlMHCmmMDtcCNI=;
X-ME-Sender: <xms:C47rapqpl2hQ-vv1tYtA7JAWTI4Py8qzfzjHqVevHidO4Vn2No-Ggw>
    <xme:C47raipTGhTcd1QKZ83aDCYmf_RT2QM-NDW6BBaFmmk8LibgSFdVT-zCLCfaw7PFT
    _Ba_cr-UFFjBVAgtVaBj0GoMeWdGXIkSl9lzKIEx1vaBlxfPZJhig>
X-ME-Received: <xmr:C47rarMyj7ptlmNi-ljc-h2GR08luhsPQrWnfH395r3lYYso2iVGhanwnpwX0c5PNXsf7mAR0mLe6-Gz-7HJD_JtJUhPrpVbD1gO>
X-ME-Proxy-Cause: dmFkZTGEFL9X2kOfwt5Em4ks48F7ccfvb6m1W6HzeOHT2canu4bUNwCWvaNgnfnJlJt6n1
    FoWPyFPm7LhmTL2/QySjB1e9osoz8A2WzihN3m7X1oR80EHQa0RtbhIrawv6+yfW18YKpN
    zcDR8Z96jVglqa1vvk0EyVPIuE5KZgrqwFfAc3EDi23bw98dEzaulzpHlb92KTKbNjKm2/
    u1efcf4MOUE+a+kKBA39vXRNPxZWqfbxqNjCr3RfMsVVFgbcQ6F0PuD3eM2AYVosMnkIxI
    P4nnDEpGbpeYGsTrhpH+JAQX9oLP2C/Vs1LCn8qhSwdl3U+DkU7oBvks4ZV2WCOySPwsSZ
    xIVkxpze/RnYbdRJOXauki0NJD98D6OK5Wj0aoIKKPCKmBu/FkTBl0DzR/4C6n+9Gre6OP
    zngTBoeREyVjR/eJgZA0IzC5NRRjh6W5zT7sBBBUwf+tiBMlCbymXMLZ5tyMgnobvUNPJR
    FWwptAZTm7wO6sP8JXYeFTo7FGM05vr4PEEHCsjEKOdCy81pDc9Qg29aiwOtitWO14S3KG
    7Hgd/yRPQaVpS0HrFZ1MXNw1Me6ULtZdT6AmII3ee3nAoe2Rv0RxWraALCWLLonm9dcqQ7
    C74yJ+ELlaYUJqqfRmO43s0XTaoPlZEXG5bMtnsJdIJ8S8a3YgQ+qqWeUYFA
X-ME-Proxy: <xmx:C47rajx2qeZp597Lyy1porl3GdV7nz6xoIYbcUFaALnTBwsJUwtkww>
    <xmx:C47rakt18iqPygqlWagBniBUgw5ZCv4yyS_uO4ISRWqIUAGwMNnWgQ>
    <xmx:C47ras6gV5ggyK3NuLjjREklFR8Ug5b8ivew5xb96HJeTDyZUNuj1A>
    <xmx:C47rajSfmwEOyqxfpFXO-bCC5GNdqJTjvM9sXzqVGmZmeLmASD57Aw>
    <xmx:DI7rahKsDFZtbft1zyUIXDJccvQn4pVei9f32NQpB4wz0wTipFd84PJX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 14:56:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] CodingGuidelines: update the required Perl version
In-Reply-To: <20261104193450.XvTBf%taahol@utu.fi> (Tuomas Ahola's message of
	"Wed, 4 Nov 2026 21:34:50 +0200")
References: <20261101185846.24208-1-taahol@utu.fi>
	<xmqqjymvooyn.fsf@gitster.g> <20261104193450.XvTBf%taahol@utu.fi>
Date: Wed, 04 Nov 2026 11:56:57 -0800
Message-ID: <xmqq5wyc1iba.fsf@gitster.g>
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

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Tuomas Ahola <taahol@utu.fi> writes:
>> 
>> > 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
>> > requirement.  Update CodingGuidelines accordingly.
>> >
>> > Signed-off-by: Tuomas Ahola <taahol@utu.fi>
>> > ---
>> >  Documentation/CodingGuidelines | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> > index c06f5d3071..9b17ab34db 100644
>> > --- a/Documentation/CodingGuidelines
>> > +++ b/Documentation/CodingGuidelines
>> > @@ -703,7 +703,7 @@ For Perl programs:
>> >  
>> >   - Most of the C guidelines above apply.
>> >  
>> > - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
>> > + - We try to support Perl 5.26.0 and later ("use Perl 5.026000").
>> 
>> Is this in line with what 702d8c1f3b did?  Shouldn't we say
>> 
>> > + - We try to support Perl 5.26.0 and later ("require v5.26").
>> 
>> "require v5.26" instead?
>> 
>
> Frankly, I don't make head nor tail of such Perl minutiae.  I would find that
> parenthetical much more useful if it told exactly when we are supposed to use
> such incantations.

I do not claim to be intimately familiar, but you can consult the
commit you cited as the reason why you decided to make this update.

    $ git show 702d8c1f3b
    commit 702d8c1f3b5377a64670b0f22add157b0bfc33dd
    Author: brian m. carlson <sandals@crustytoothpaste.net>
    Date:   Wed Oct 23 00:45:59 2024 +0000

        Require Perl 5.26.0

        Our platform support policy states that we require "versions of
        ...
        Use require instead of use to avoid changing the behavior as the latter
        enables features and the former does not.

        Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
        Signed-off-by: Taylor Blau <me@ttaylorr.com>

    ...
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

It looks to me that the "parenthetical" you called was designed to
be useful by telling you what to have near the top of your Perl
source files.  Replacing it with "require v5.26" is exactly in line
with that, I would think.

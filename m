Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989142;
	b=vPdf+T8Bf7R9NLlNUmt6gsVjKw2dyZvaY0Ou9dK1axI4PV7srDzdOzs1tWx0Eg1S27ft
	 nVyGqyH2yTYBEuC9gY2X+L0cU4KzMm2wmNF6MzXhU2G71th5o5bdkQWPKc0iRLGV+8Lp7
	 U8bARVOZIbxlsK05aD9OKCQ8g97r5FoWFODhINMDG1rb1YE82H3OSA7aY+s8YEw2j2cBe
	 en2+aqVmxHfcZG4mCYg0wXi0mwKAhMbVnPJwDLfu3peZk3OHD6EJX0qapaNV73cWuEjdo
	 iVx/JL7NwJdtsFLoa5EXUgN7LRs/mjXop0C1u4n7z3DqkObPQ5RLuKnOabsxA/0YzUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=HgFHtc3vpS75sXxDau4YA1sKVAfJ4MaaaTvsDAPPhXs=;
	b=rRSTBfLQ5yrv25rg3341KAQ8XsDXGsqetDo37ZvRnSzIB4zVH1r2B6wp2pVU1Ml1GkdO
	 anmWmQIwbkISBRVA7/zHNyH6SYLaVAwU+Vfe4f1rLosGXojuo/E2ul0ogUFyqFyhDfBh1
	 6OqX0ZcATlo3rNMnsj+1pEtFC7obW6jt7vWk5xo/fzBraPEksFDOQzZ005wyx88fbnDPh
	 gDaQVu9G6lub8jzKQVZgikvrst++dag0Skr8YbWZGGYKTiwM3XM5E8VFaJcJr+STXXw0H
	 nZE7Go2oUeuHUjSS2toqGx4HBNYUXIhfK//W0cXeAJwdEpmA8mTcTGaGLj4vsUQh/Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=G7iBixhv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="1+px/92E";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AF606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 362AF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=G7iBixhv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1+px/92E
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7889014000ED
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:19:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 13:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793989141; x=1794075541; bh=HgFHtc3vpS
	75sXxDau4YA1sKVAfJ4MaaaTvsDAPPhXs=; b=G7iBixhvvhULKq4couBFW8uNH0
	yeUtcygMzf6J+l5wkzC8ghNjy6TMG7raJYRk3CwHrmRqxmqgTWlrp1MokS1Ke7av
	sh5v36An0fasQdTb6orJXnGGa1K3RwhuQ7MunFjtfebgSAxqqn6Hc+FBL26J+K51
	H1FBNnuIPi04wSSFBiBrG/qfWFZvLgcpJRER42NfU9x+kXIAkCnplwe0DYgRP6oj
	Yx3NoeU1856A+FKtYscz8Em4U0rrfRC1OhxUcUV3OUUsZTx7I/eSPQpY90lSl49G
	YfK/A88jq2mvB282kGW4/XGe9GmpBsfma04MMdhS9f4pcAmaGTmexzKFWGew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793989141; x=1794075541; bh=HgFHtc3vpS75sXxDau4YA1sKVAfJ4MaaaTv
	sDAPPhXs=; b=1+px/92EODK0FMf/JlgTidjphEgeiFrji1SFYJkQwAGEmHz1OdJ
	ovKVy3X/iePrJiT1Ks3zMrf4llaeIqTfefqOyKQtdKTYBF0WzODzN5qG5cBKUqG3
	BM4S3h2PcC6x6bu3EMAZNukot5dvalVjjRmlOk1YOG16EMPX+0FP4/Zd8dIQ1Qca
	JDGzDyp3eNT3HJO6fSWXA7dSnF8HyMV189hYn8ojF0B/BRMGneDA9IvrGHh+BGOY
	n6ivGzknVZ6boH50CWhR9RyiGFu2wFX9ovdvdkAaVnLDFlT1KU+CLTPrRE22oiEp
	6xHLf0/sKTl1SbA7RlRMs1UvlqUO7zjiH+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793989141; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZO1Pc8Kk4h/TXqOPSKH6exTGKtN0lnBEVYGzbVGA6Cxbim0
	ECCkmvSZubRyW4qmMWDZOCn/DujlZLroSw1Fgp/aQawlBXPvR3M/D+9XWf5QM92P
	zpOIHgyTJ5nqc1utDCmBR8brLZj/I3zQbGps6QNOf2UrrOKJPHUDHdnZaS5wR5K4
	qS8Xrv2fwSXFnZKV9WZaiQAM1Fop3diy5WpW3n8WUGAo2CjN1jyGGA1fH9OBpJf/
	8GGzfXoPnu5nISBZ4r8Om/H6naSTrZlFyRx/gpQjh/s4h1fJ8Zz1mFrjW+3arxcx
	I9eCCL2S48LiaxXCCA0eqZWPD477HX/iF6hL0Wg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:H4YeTtDyuCYbRgFpnLzj2Az8UfCfjY3m1BFa7n0XNFo=:VIdxAsBfxH7yPBVSwQTX0GSKrgtyY1HHNpXj86yUZjc=;
X-ME-Sender: <xms:FRruarLgJsRS8gJuqluYHyDLXyHqyZvPScj24ngnM02UwznLLilMbw>
    <xme:FRruai3Z9ukRdUlHeWN8nJlFS1QDMjZybMuLwcMEfuP9e9mQzeoZ2pricDKUPCquI
    LBmPghNbFEdIKYXQivdEqhoENJlhopqkCRa1ZdJ9zNnuo17mdFlVRUs>
X-ME-Received: <xmr:FRruathAeOmInB5jFsnyn2z7LWUHB8q-k_Spso5LjHnf8iuPQEhI27ps-dZaumqdSdlvxPNPOWL2lIC6Y-O-VY4Tr0YW4674Luxk>
X-ME-Proxy-Cause: dmFkZTEeixv+cekEKj/1wDbKvtJBtJU/xUHuBENgpbwrxweTg0jO0vBbBLt7nX4L3IthyP
    SLnd5A9xZjJpAF0DYB59uoxBc9wyIKTpSjjFTvoGRvx6mFt1sbP54y8N1jfH7OpkrEE6Il
    wG9dJSNMDD0KyWmyfpcI1cywlGQCyR8T4JbVUQDC+0loZhyB6+MWToDaMbjuvzKJnXMlWv
    zvOzoXUjXYpvR0UyzZSN7ImHwUbfzLxu60vZGfzPYUW9O+B6ovs8pVymAkKaNda+9IcnqY
    FBwi1F9RyyDnBKZUyqfH0UgUvZWo3/wRynk72ejcmH7DZd2vQGzHDHRRktJiqhtsJFh6Lw
    +twGUZTuC2BMkvS5KW+w3sbWDd3Sq0GBPEiBrfY9c6ogdHaA53lRYd6D6CtVKCSZdaRzKc
    DlHiLexwuDkNFb5sKuI/ZoQIRs9bA6g1kbj7c4dsK7UM122+63RXJzWwUblMdGXLs32mdK
    9Q43G7rz5kuKymvjbTOfUAoqKpWxX0qPYmXxntmOYDTmRq89PMD6mnOwUj5LWzuKaboPIM
    7w7tjEkTiW7f6hmpBJzIdoUlAWFwVhJIE2/rgA2a9QGhyaZ4rWSrLip9Z2uRH6V0IwvLT5
    3CT8Xy8rA5/73aMilS8PMzKKbdyxN7vuan+YcTAohcHyIWcfxDrFgQpuU9KQ
X-ME-Proxy: <xmx:FRruarUbg23MInFyDjYlgcWOQuKJTBIfAtuf3v1sEmwLq7SLDAE_Xg>
    <xmx:FRruakU5CVPI0tRbqIFfzx-djXKarr-C98Wre2iLckH3Crew9yG_gg>
    <xmx:FRruajh_LdUVn8K3IZBdIRhNNcRIw_Njc-ccUsscdK9ZowtMaQAepQ>
    <xmx:FRruanbxU4qhXFbZWN0mIdqoWhmgE5Jv3wvXpyPzBZ7yXIq1oaasCw>
    <xmx:FRruaqtFuEtNyR_nI4nPP4LFYtMG_Flnx-8ootBYnEtjLU1eVhP0GTfN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 13:19:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Azuama Odinaka Maximus <azuama69@gmail.com>
Cc: git@vger.kernel.org,  tangajoris@gmail.com,
  pushkarkumarsingh1970@gmail.com,  christian.couder@gmail.com
Subject: Re: [PATCH v4] rev-list: handle arguments in early option scan
In-Reply-To: <CAPki72HBWEP8t9mu1zuKBA33SU1Oj-4bL4SQTqrn0G-H0P+g=g@mail.gmail.com>
	(Azuama Odinaka Maximus's message of "Fri, 6 Nov 2026 14:25:56 +0100")
References: <CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com>
	<20261105120937.10269-1-azuama69@gmail.com>
	<xmqqwlqqokxr.fsf@gitster.g>
	<CAPki72HBWEP8t9mu1zuKBA33SU1Oj-4bL4SQTqrn0G-H0P+g=g@mail.gmail.com>
Date: Fri, 06 Nov 2026 10:18:59 -0800
Message-ID: <xmqqa4nlkelo.fsf@gitster.g>
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

Azuama Odinaka Maximus <azuama69@gmail.com> writes:

> I've investigated the relevant parsing paths further:
>
> 1. Revision options are handled by handle_revision_opt() in
> revision.c. It already determines argument consumption through helpers
> such as parse_long_opt(), which returns whether an option uses an
> attached or separate argument. However, the function also applies the
> option's effects to struct rev_info, so calling it again purely to
> determine argument consumption would be unsafe.

Correct.  There is no dry-run mode for this.

> 2. Revision pseudo-options are handled separately by
> handle_revision_pseudo_opt().

Yes, this is called from various code paths.  No dry-run, either.

> 3. Diff-merge options are handled by diff_merges_parse_opts() in diff-merges.c.
>
> 4. Diff options are defined through add_diff_options() in diff.c,
> which provides an existing struct option table. This includes options
> such as --src-prefix and --dst-prefix.

Correct.  I do not think there is any dry-run to any of these.

I am not sure if the above is exhausitve, though.  I didn't check.

> This suggests that the early scan needs to obtain argument-consumption
> information from the same option definitions or recognition logic used
> by normal parsing, rather than maintaining another list of option
> names.

It is what the NEEDSWORK comment boils down to, I think.  I do not
see how the above survey helps with that conclusion, though.

> One direction I'm considering is separating option recognition and
> argument consumption from option application, so that the early scan
> and normal parser can share the recognition logic without executing
> parsing side effects twice.
>
> I have not settled on the implementation yet, particularly how best to
> accommodate the hand-written revision and diff-merge parsers alongside
> the diff option table.
>
> Would you consider this a reasonable direction? Or do you see an
> existing Git parser interface or abstraction that would be preferable
> to extend for this purpose?

All of the above assumes that we want to keep a separate "early
scan", but I wonder if that is really a good direction to go.  If
you can clearly identify the problem the "early scan" wanted to
solve, and can come up with a way to solve that problem without
scanning the list of arguments twice (i.e., not involving an "early
scan" at all), would that give you a cleaner implementation?

If the default of an option (is it '.fetch_if_missing' alone, or are
there many other settings involved?) needs to depend on other
options, perhaps fixing it is simpler if the presence of an explicit
option that sets '.fetch_if_missing' is recorded in a separate
member of the struct, and then at the very end after all the command
line options have been seen, take these other options and the
explicit option setting for it into account to synthesize the
result?  If '.fetch_if_missing' was explicitly set from what the
user said from the command line, there is no need to look at any
other options, and if not, then the settings left by parsing other
options that the misdesigned "early scan" pays attention to can be
consulted to decide what the desirable value should be.

Just thinking out loud.  It seems that this started at df11e19648
(rev-list: support termination at promisor objects, 2017-12-08), and
then other needs may have been piled on top, but going back to that
original commit may be a good place to start understanding and
reevaluating if the "early scan" was the best approach to solve
whatever problem it was trying to solve.

> Thanks again for the guidance.
>
> On Fri, 6 Nov 2026 at 01:36, Junio C Hamano <gitster@pobox.com> wrote:

Never top-post.

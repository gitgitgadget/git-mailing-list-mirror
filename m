Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941BB1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeGaTow (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:44:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34109 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeGaTow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:44:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so11716664wme.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jq8xMCZyye4q3r5LtGBFZT2XBWOTqF9meQPpeceDbns=;
        b=R3cfReN4BHUBM9G6oUNFfCDaJ9VcPqxnJMux6wT50yM6OnmeNNPEpGO5ZLLlbwQCA6
         85AL4Fw8jVgLoLghVya62Fwp5QaIwCe8t/3XRD5cBFwXswgAfL7fR5qJOlPr3J3F2ug2
         Kzr8IZsR4slSoJdvCBq1StYDkrMmlnGluq5cGuKiaQcQLzLfQj+t/Ih5/xsm1Dc6FMCf
         od2Od/1vlqldgh01wzvrfTCUvM24pNHdYRzLOPAv1QOTxJ6zL436hzHm5BltnBMw74H2
         xwHEPcl3Mqlc9RScb0wGBaqKXgr3jW+MCRHtMLrzC+ujXs052D5BvoS2IFdz7gGYgZkI
         POOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jq8xMCZyye4q3r5LtGBFZT2XBWOTqF9meQPpeceDbns=;
        b=aJBXK+99eDHF7kXl8ARKf5K5ivRA2dePaKkAUV1MTIdpN2/Lg8req4beWpTTfOCwN3
         ILHr6FtNUkokGN12TzeVKk7w/BrOuOPT0f1jPnkXR5zcpPCCNxKThwGtG1qNPDay0aPN
         QPchWtM8+NYXk6UnjoYa4rLm/49TJHp9q53gCYfv3A0TxcYpS3qS73zjnHg6jIa/LB66
         4k49b1R0lgwIvX8L7L2ZXrKUYTSSk0EI2bStluJHptP6HN2jbk5jHI3V5irp/WXHP2qf
         N4r7E1BE8ENnDL/pAOhINIoj8sZCvXTr8mmH3zN4tYSEDL/0nhVARb1IJqQzRxxxTrYr
         cR8w==
X-Gm-Message-State: AOUpUlFsAOfqAJffWuTNXsZAL79zTSQrUzBHEsETtYqqtMCE2SKGme/n
        TLaIVNDxtF0rgDYIFeb6E50=
X-Google-Smtp-Source: AAOMgpeHIaCghzlQqZQ2mjY2mRaQi4bMt+e5VnMWnssS4uGrso9aHyv0yUx0rNhyv5vAcQbUu6BpeA==
X-Received: by 2002:a1c:1d2:: with SMTP id 201-v6mr481565wmb.4.1533060203182;
        Tue, 31 Jul 2018 11:03:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q11-v6sm14371550wrp.58.2018.07.31.11.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 11:03:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 10/10] fetch: stop clobbering existing tags without --force
References: <20180429202100.32353-1-avarab@gmail.com>
        <20180731130718.25222-11-avarab@gmail.com>
Date:   Tue, 31 Jul 2018 11:03:22 -0700
In-Reply-To: <20180731130718.25222-11-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 31 Jul 2018 13:07:18 +0000")
Message-ID: <xmqqzhy7b7v9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 97d3217df9..5b624caf58 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -49,11 +49,16 @@ endif::git-pull[]
>  
>  -f::
>  --force::
> -	When 'git fetch' is used with `<rbranch>:<lbranch>`
> -	refspec, it refuses to update the local branch
> -	`<lbranch>` unless the remote branch `<rbranch>` it
> -	fetches is a descendant of `<lbranch>`.  This option
> -	overrides that check.
> +	When 'git fetch' is used with `<src>:<dst>` refspec it may
> +	refuse to update the local branch as discussed
> +ifdef::git-pull[]
> +	in the `<refspec>` part of the linkgit:git-fetch[1]
> +	documentation.
> +endif::git-pull[]
> +ifndef::git-pull[]
> +	in the `<refspec>` part below.
> +endif::git-pull[]
> +	This option overrides that check.

Ah, that's tricky.  I could not locate "the `<refspec>` part" in
Documentation/git-fetch.txt and was scratching my head, but it
comes from pull-fetch-param.txt by inclusion ;-)

> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index f1fb08dc68..acb8e1a4f0 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -33,11 +33,21 @@ name.
>  it requests fetching everything up to the given tag.
>  +
>  The remote ref that matches <src>
> -is fetched, and if <dst> is not an empty string, the local
> -ref that matches it is fast-forwarded using <src>.
> -If the optional plus `+` is used, the local ref
> -is updated even if it does not result in a fast-forward
> -update.
> +is fetched, and if <dst> is not an empty string, an attempt
> +is made to update the local ref that matches it.
> ++
> +Whether that update is allowed without `--force` depends on the ref
> +namespace it's being fetched to, and the type of object being
> +fetched. If it's a commit under `refs/heads/*` only fast-forwards are
> +allowed.
> ++
> +By having the optional leading `+` to a refspec (or using `--force`
> +command line option) you can tell Git to update the local ref even if
> +it is not allowed by its respective namespace clobbering rules.

The above two paragraphs imply that I can "fetch +blob:refs/heads/master"
to cause havoc locally?

> +Before Git version 2.19 tag objects under `refs/tags/*` would not be
> +protected from updates, but since then the `+` (or `--force`) syntax
> +is required to clobber them.

I think that is a good change; it belongs more to the b/c notes in
the release notes; while I do not think it is wrong describe "it
used to be that way" just after a drastic change in the immediate
past, we shouldn't carry that forever, so perhaps we can leave a
"NEEDSWORK: remove the 'it used to be this way' in 2020" comment
around here?


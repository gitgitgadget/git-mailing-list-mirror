Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6171F597
	for <e@80x24.org>; Wed,  1 Aug 2018 21:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHAXBl (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 19:01:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43664 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeHAXBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 19:01:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so155381edt.10
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7UYizXAe+QYWz6u1plpLzkJw9Mg2BI9xWngQYQCl8s0=;
        b=AvRjQeHKdRI8d3tmdC3l5x9gGJuMfPH5flApStJvuli8ZhSvvTMy6nxBBUkdp40+NK
         ET1mg8/I9FETfdVwK+FJrImXKHaNQiWkT2KTh2oeehsdE5V+kBgDt9vpSaN0XhgmKJBN
         rafQfgBgIZOftDRldJ58VWDpJPMTsQ9PwoFTfS/5l4r+BB3KFB8PJt6VHWqXqPof0s3y
         sN8ef7eACKpsEQkvf/JMKOENPD30aJfVQeofOnS3/eoBNtFOY4Pe0kvXZR+CvQKFPXVw
         Goh4ZCebonahEFhgvPhtbGGvd6fc14DyYzetSLfDxFc5RxF3bs5IAbA1lNvrE14mwKBL
         KG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7UYizXAe+QYWz6u1plpLzkJw9Mg2BI9xWngQYQCl8s0=;
        b=SBCMbnWVzhGG66VmXi6FjTEyV8Kd0CznUwA5E1owUt4MD/rgcwCZrQTd4cRzd1QUso
         b7aaaESVU/jj/WsIw1Flqq8y6gz3ygF7lkRdP8EhiLpkli0JFo4X6NK7bMKkrr/DM0i7
         io6N5i99Yb8aNYr4udoFqg1FJY0y8gYeLFNekytbIDMZ1sip11DAtR2adJruS8Ojv1vu
         xtj7t2qx+nFZa4nwh3u/JFu3By9NN7kb2iCaZHCq4l18Ri/dKhECKmlr+XtY0L3omzOd
         iDp+AnI0oYKU+wsJEMBQrYUTJ4GUk58dsmwvIm+ACU938Kj1YC0Rv2XXPR7l9SPV8cnp
         KFnw==
X-Gm-Message-State: AOUpUlGHxgRUQW8YrLSgekuEP7VqcO56I/JyfAUVJGR0LJ5AMz53yH/6
        YLTIF09iLpRuMJcg1VnCCUs=
X-Google-Smtp-Source: AAOMgpcJtRcz3NhBGYDSb//fnTDH+YJ7EAPZfLo6A4NlfdPVgjNo0PQYDiB0/5/kSw4CshvaDFX9Qg==
X-Received: by 2002:a50:ade6:: with SMTP id b35-v6mr447897edd.168.1533158038773;
        Wed, 01 Aug 2018 14:13:58 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id s27-v6sm194036edb.73.2018.08.01.14.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:13:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/2] negotiator: improve recent behavior + docs
References: <20180801151835.9182-1-avarab@gmail.com> <20180801202545.204151-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180801202545.204151-1-jonathantanmy@google.com>
Date:   Wed, 01 Aug 2018 23:13:56 +0200
Message-ID: <87in4tu6wb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 01 2018, Jonathan Tan wrote:

>> I think 01/02 in this patch series implements something that's better
>> & more future-proof.
>
> Thanks. Both patches are:
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>
> A small note:
>
>> -	packfile; any other value instructs Git to use the default algorithm
>> +	packfile; The default is "default" which instructs Git to use the default algorithm
>
> I think we generally don't capitalize words after semicolons.

Yeah I think that's right. Will fix (or if there's no other comments
perhaps Junio will munge it...) :)

> Thanks for noticing that the check of fetch.negotiationAlgorithm only
> happens when a negotiation actually occurs - before your patches, it
> didn't really matter because we tolerated anything, but now we do. I
> think this is fine - as far as I know, Git commands generally only read
> the configs relevant to them, and if fetch.negotiationAlgorithm is not
> relevant in a certain situation, we don't need to read it.

Yeah I think that's OK.

>> That's awesome. This is exactly what I wanted, this patch series also
>> fixes another small issue in 02/02; which is that the docs for the two
>> really should cross-link to make these discoverable from one another.
>
> That's a good idea; thanks for doing it.
>
>> I.e. the way I'm doing this is I add all the remotes first, then I
>> fetch them all in parallel, but because the first time around I don't
>> have anything for that remote (and they don't share any commits) I
>> need to fake it up and pretend to be fetching from a repo that has
>> just one commit.
>>
>> It would be better if I could somehow say that I don't mind that the
>> ref doesn't exist, but currently you either error out with this, or
>> ignore the glob, depending on the mode.
>>
>> So I want this, but can't think of a less shitty UI than:
>>
>>     git fetch --negotiation-tip=$REF --negotiation-tip-error-handling=missing-ref-means-no-want
>>
>> Or something equally atrocious, do you have any better ideas?
>
> If you wanted to do this, it seems better to me to just declare a "null"
> negotiation algorithm that does not perform any negotiation at all.

I think such an algorithm is a good idea in general, especially for
testing, and yeah, maybe that's the best way out of this, i.e. to do:

    if git rev-parse {}/HEAD 2>/dev/null
    then
        git fetch --negotiation-tip={}/HEAD {}
    else
        git -c fetch.negotiationAlgorithm=null fetch {}
    fi

Would such an algorithm be added by overriding default.c's add_tip
function to never add anything by calling default_negotiator_init()
followed by null_negotiator_init(), which would only override add_tip?
(yay C OO)

If so from fetch-pack.c it looks like there may be the limitation on the
interface that the negotiator can't exit early (in
fetch-pack.c:mark_tips). But I've just skimmed this, so maybe I've
missed something.

Also, looks like because of the current interface =null and
--negotiation-tip=* would (somewhat confusingly) do a "real" negotiation
if done that way, since it'll bypass the API and insert tips for it to
negotiate, but it looks like overriding next() will get around that.

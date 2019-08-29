Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155ED1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 09:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfH2JPL (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 05:15:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42227 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2JPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 05:15:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so2275004ljj.9
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rzr+sSeaIjXwcYXxbR9nhSHua55WYsGhOzdgcmD9+KE=;
        b=JqRVu/3YevrJOcll7ZqGtSMXYusWlZz4npqnYOm+0QtT2k0yi1/m5TFxomOiaEwOwK
         8/pPNL4+NqPG3wzgCRkju/MiDFYKdk27wf4LTuDhgJwvm5uNhTXaAz01V7xgNrBKWnvW
         xRDshbo0pWUSgrhdedVn7BTzi9laZQJpiQSXt1ycaiqcxza3kn0Jn8nnibrGA4eIVLoO
         xQMFWk3Z0qT9e06TcYJ7LpFwjJzCdhCyZugJiiBH4fZ9BbdQxqTeimWbb2B6iqo1KK+j
         x4/orfVX/c19chpWGkTFBVMo9WUGww/SB1dnTbeLFmWz3x98kHUJJs4f6JiZviQFC5Fi
         zJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Rzr+sSeaIjXwcYXxbR9nhSHua55WYsGhOzdgcmD9+KE=;
        b=mlcONvKUnh0auV0tFlSZtYeYlAnMyWGv/jK9Peisr6B7qxcXdgMjKvUwgWRT0jzOPY
         bQcpj81jbIJS+Vx5M0VrrioKt3rf9OB6mIW4XxnKNNqlPYWIFGSp0lukSz3j2Pzqd6Mx
         Bu06knYS3NqkVNlTD90WYZ6tEmQS5+bVzurXo7GO3DLqbwrJB9gIKGNHuBUDNBAshVUF
         s6vzsbsGkio7p9sqlNzNsO2STZeJ9bscTAQrvGHS3EiUk8RWhlDlr9vuYphMLrUOsjZL
         TrTUESl74C9vU3nnfeZozAu3yAcjKpNwIT6lLbf407JfQwIHXE9+cNbbj15c9YefzK1U
         DufQ==
X-Gm-Message-State: APjAAAVi9Z1XznHJv3LugrcateZsyF5KRc+66coNiFxGg9h/kdnbJGVT
        OPvcnqnTYuchmcu2Lrj1S1ooXkDw
X-Google-Smtp-Source: APXvYqygT9xryfVjtjpNy+aBifF2ZOdGWvMppGspXvIXlBesvP+uiaD6dTYtnLFL5zDV9pYB4U0cBA==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr4631540ljg.184.1567070109127;
        Thu, 29 Aug 2019 02:15:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f22sm263321ljh.22.2019.08.29.02.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 02:15:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various ff-related options
References: <877e6x3bjj.fsf@osv.gnss.ru>
        <20190828155131.29821-1-newren@gmail.com>
        <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
        <87a7btqeyx.fsf@osv.gnss.ru>
        <CABPp-BEsRL-JipotZ2FyrXiPcry6aSAvL8e5cbOm5jrPM63j-g@mail.gmail.com>
Date:   Thu, 29 Aug 2019 12:15:07 +0300
In-Reply-To: <CABPp-BEsRL-JipotZ2FyrXiPcry6aSAvL8e5cbOm5jrPM63j-g@mail.gmail.com>
        (Elijah Newren's message of "Wed, 28 Aug 2019 15:51:14 -0700")
Message-ID: <874l20nxic.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Aug 28, 2019 at 12:15 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Hi,
>>
> [...]
>> Dunno if it helps, but here is what I came up with somewhere in previous
>> discussions:
>>
>> --ff::
>> --no-ff::
>> --ff-only::
>>         When the merge resolves as a fast-forward, only update the
>
> I think this loose wording (that you just took from the original) is
> problematic.  Saying that a "merge resolves as a fast-forward" seems
> to imply that there are circumstances when a fast-forward is the only
> option.  An _individual_ can decide to resolve a merge as a
> fast-forward in some circumstances, but it's certainly not the only
> choice in any circumstance.  If you want to keep this wording short,
> you could replace "resolves" with "can be resolved".
>
>>         branch pointer (without creating a merge commit).  When a fast
>
> Only update the branch pointer to what?  (Yes, I know the original
> text we were improving left this unclear, but it's worth noting.)
>
>>         forward update is not possible, create a merge commit.  This is
>>         the default behavior, unless merging an annotated (and possibly
>>         signed) tag that is not stored in its natural place in
>>         'refs/tags/' hierarchy, in which case --no-ff is assumed.
>
> Maybe it's just me, but I think it takes extra human cycles to figure
> out that this paragraph is referring just to the --ff case, and that
> users might not be able to do so until after reading the next 2-3
> sentences.  While more brief, I think it will cause people to need to
> read the description for these three options twice, removing most the
> savings from being shorter.  It'd be better if it could be re-worded
> to not need re-reads.
>
>> +
>> With --no-ff create a merge commit even when the merge could instead
>> resolve as a fast-forward.
>> +
>> With --ff-only resolve the merge as a fast-forward (never create a merge
>> commit). When fast-forward is not possible, refuse to merge and exit
>> with non-zero status.
>
> Something else I was trying to address with my patch that perhaps you
> can see a different way to tackle: Using the wording "when possible"
> is probably going to make users wonder when a fast forward is
> possible; the "can be resolved" wording tweak also makes it more
> likely they will wonder about this.  Another question they will be
> wondering about is what a fast forward is (which you partially
> explain).  Some basic knowledge of both are probably very useful in
> helping them decide which option to actually pick.  As such, I think
> trying to explain the answers to these sub-questions will assist them
> in knowing which option to use.  Simply inserting a couple phrases
> (e.g. "when the merged branch contains the current branch in its
> history", and "only update the branch pointer *to match the merged
> branch* and do not create a merge commit") may help a lot.
>
> Anyway, I'll send a v3 addressing Martin's comments; if you've got
> further suggestions for streamlining or rearranging, though, please do
> send them along.

Thanks for thorough reply!

My version was meant to show how to re-arrange the description
preserving original wording as much as possible, so your version should
be better, as it addresses other problems as well.

-- 
Sergey

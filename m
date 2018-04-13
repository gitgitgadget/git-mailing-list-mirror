Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798FF1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 20:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbeDMUEE (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 16:04:04 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:43174 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMUEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 16:04:04 -0400
Received: by mail-ua0-f177.google.com with SMTP id u4so6525114uaf.10
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v6qUXq9imfLL/VIx8xowLBRjGpQXfzXeh85Wxg4m+sk=;
        b=DEuUOqyeBy3SZFgUBj6fvJ1zSzjqkb5Levq4DFWRQvQ0mkFVfpnTYoN7AuBVi9PAaa
         e0Kk8BLLkSnev1xxAOFOZ8qs/9o7xuqQzR2hjAnuOiZFyGQa2t/E+eViAueaecD8uAjT
         3XxYjcr+6X/8JLD3UadV9eYTYXYmLT61ZTkoeghnhHmlhL4sAEd0f/5J+fLvmls7ib/U
         RzhiklAyZtLZGss/T7I0NsRfN+4Z7nVLQQhg+bYdI3P8y9MW22+qTA8io2Ya9dSlZrOP
         XUUnZ/aQ4f7vySX5/EBB+qtdwmEZmgNu668Xj3nvqrB9Nk5eulBfJMeWpH4ryiL48Ouo
         RIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v6qUXq9imfLL/VIx8xowLBRjGpQXfzXeh85Wxg4m+sk=;
        b=ROPvSVUb4UiqqcVGT66A01GOvqGMDz/1AwDJhnuVMc1uxcwcH8Sq2eqZeMBH/zF7uC
         YIwLRsL1mYL26lMDo5pKPB8GgDnuxG1r7IPMr6hxtEOX5b7lgclNxTJLMQrCL7fGgtDQ
         5+cfgk/WuJPeKHqPdx3I+c7qX4F945m58fbrnTWq6Ku9Fn6Rx2dlUhgCoOWoFIi/PLm1
         8Aa0xrBOBknirvtTV8qMwgmlisrN/ZJnBepta5v1Wt6pBtXo4L/tZw2gM2YVngakYsrf
         oBLs+Vy/C4ek9pLytgeEB9EN+Egjz5t3VTVKBx80sDB8r0NYA4ASsLtavm3HvJE2TGFB
         D94g==
X-Gm-Message-State: ALQs6tBNvCloR0NJFh+FkudYx50Ved/M/TohV99Wg2KM5GaY+I2w6Ghk
        HVXBS1R5NJZwDNRZUUtrJcN2rLGWCYRITaYluNM=
X-Google-Smtp-Source: AIpwx49JLfUEWj4ZRSRdaPYwrjx+7qPRyyYpa0AlHcawynNf0vEmsuHGJk4Y8o2PHpGP9EyFa3STN0GphHTNTfkenoQ=
X-Received: by 10.176.90.38 with SMTP id l35mr5063299uad.79.1523649842859;
 Fri, 13 Apr 2018 13:04:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Fri, 13 Apr 2018 13:04:01 -0700 (PDT)
In-Reply-To: <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com> <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Apr 2018 13:04:01 -0700
Message-ID: <CABPp-BFZZJ=rgOYqgsxD1A-Q5AU91e-HQ6WbAsGSqNppADXySQ@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 13, 2018 at 10:14 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Apr 13, 2018 at 12:02 AM, Elijah Newren <newren@gmail.com> wrote:

>> However, it turns out we have this awesome function called
>> "was_tracked(const char *path)" that was intended for answering this
>> exact question.  So, assuming was_tracked() isn't buggy, the correct
>> patch for this problem would look like:
>
> Apparently that causes problems, for some odd reason.
>
> I like the notion of checking the index, but it's not clear that the
> index is reliable in the presence of renames either.

Yes, precisely.  Checking the *current* index is not reliable in the
presence of renames.

Trying to use the current index as a proxy for what was in the index
before the merge started is a problem.  But we had a copy of the index
before the merge started; we just discarded it at the end of
unpack_trees().  We could keep it around instead.  That would also
have the benefits of making the was_dirty() checks more accurate too,
as using the mtime's in the current index as a proxy for what was in
the original index has the potential for the same kinds of problems.

>>   A big series
>> including that patch was merged to master two days ago, but
>> unfortunately that exact patch was the one that caused some
>> impressively awful fireworks[1].
>
> Yeah, so this code is fragile.
>
> How about we take a completely different approach? Instead of relying
> on fragile (but clever) tests, why not rely on stupid brute force?
>
> Yeah, yeah, it's bad to be stupid, but sometimes simple and stupid
> really does work.
>
<snip>
> Comments? Because considering the problems this code has had, maybe
> "stupid" really is the right approach...

It's certainly tempting as an interim solution.  I have an alternative
interim solution that I think explains well why the code here had been
fragile, and how to just implement what we want to know rather than
making approximations to it, which I just posted at [2].  But I can
see the draw of just gutting the code and replacing with simple brute
force.  Long term, I think the correct solution is still Junio's
suggested rewrite[1].  My alternative is slightly closer to that
end-state, so I favor it over simple brute-force, but if others have
strong preferences here, I can be happy with either.


Elijah

[1] https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/
[2] https://public-inbox.org/git/20180413195607.18091-1-newren@gmail.com/

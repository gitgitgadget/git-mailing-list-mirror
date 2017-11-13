Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9593C1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 23:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbdKMXqO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 18:46:14 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:55273 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdKMXqM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 18:46:12 -0500
Received: by mail-qt0-f171.google.com with SMTP id c36so15601709qtc.11
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CHQQ36LsucSJfq6tRn47yaG27IGuxptLM+ZiKam84Ho=;
        b=CN3+e4pFExP18FQHtgmc+JdOxUiz5oCLgvkFHScg9z0ANmluExvgGuH6P5UgGF0WLD
         HV1TyoznCUG1NwvltU3Chy/E62sDA/ego6RdYN5xwU/16qU6DynI8Tl0LSLvq6RL3Bbn
         +WSqYHibb/Lt4xbiMurk6SaJqfKUCvnX7GsDaMqFxumKq2T9gkPCBvqDqXQcoWBYC/GA
         vcPp+klF8kDLBZATJoU1gENl2RLA1XaE9pI+gkOGVz+to4K6CJ/iZKuIIT9l7NCFtrRg
         p4ky5nwuImKo1uCWK1XGnHpjx7R6BOzZmjE0qYfmdKdAW2m9KMFSNcLUBnSPBK4Hpvl2
         z1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CHQQ36LsucSJfq6tRn47yaG27IGuxptLM+ZiKam84Ho=;
        b=COrZ1HC74oVmiQrCBYwGYa8H/udGiqN1RgWAbRUmLzWWPogv+jEMhOsXYdwl4zMXtp
         3mMsYWtP+b3j5KFd8fVLsHPYiXfyT7ooB2Ft4O+nJhSA6y2trY2E9OtiaI0OiSmS1kRc
         9gi12dvwpsyULu4B6WJvyCOtjZ6I+TDGv/VXeqMMgh307d5x1oUcNjPPRHBRRHAtKKfE
         9Is6xcZlmivuH66xrbzzWyVNyLmGCN0JH4HWrq9mrn0LCyd/mL5A4mpYXy8k/75GdsyW
         9xLdaoreNcDRSRdT0DpEpBREEhpEMga9SG3o6Qe+Ob/wRxhchnns5xvCCgv/4sI7SN5a
         DiwA==
X-Gm-Message-State: AJaThX7gkQsA0MfS5Ls+ChWh+jpXnQ8qAiRxa0KHMgEjReD7IIa/V95F
        XpiHJZKBn7cEIB2iSAum3Xp+muqhTmgHrP8Fga5f9wojpSg=
X-Google-Smtp-Source: AGs4zMaKNFAoaFa57CQnQcsUWfvWUcfUIyZVbQTZ3AWpQb+gigXhJZ7XeGO4qKEjeF2HBq/UR9b4N6lVR/VnwSYTlpk=
X-Received: by 10.237.34.201 with SMTP id q9mr17043740qtc.198.1510616771875;
 Mon, 13 Nov 2017 15:46:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 15:46:11 -0800 (PST)
In-Reply-To: <CABPp-BFynaf6abbd2ywzjuQnus5BFp=DQmKd80qHj9vFOqEmig@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-3-newren@gmail.com>
 <CAGZ79kYXbvDL_SoEENf60DsDFA-yEWfvgv8bNv_v+mw042ZH=w@mail.gmail.com>
 <CABPp-BFX-xZf962vuCjJSaB0=sPMT_zNF8+mGPG04dFi5PE6SQ@mail.gmail.com>
 <CAGZ79kYEwOhjMfNH3ovfEnRdU_OYWnGnai8HrZWxoBEC67xKVw@mail.gmail.com> <CABPp-BFynaf6abbd2ywzjuQnus5BFp=DQmKd80qHj9vFOqEmig@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 15:46:11 -0800
Message-ID: <CAGZ79ka=7NPU7vm5Onx89+qR3wU6UqDuPVbWsmwpk2Q_b1pjGA@mail.gmail.com>
Subject: Re: [PATCH 02/30] merge-recursive: Fix logic ordering issue
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 3:39 PM, Elijah Newren <newren@gmail.com> wrote:
> On Mon, Nov 13, 2017 at 2:12 PM, Stefan Beller <sbeller@google.com> wrote:
>> I wanted to debug a very similar issue today just after reviewing this
>> series, see
>> https://public-inbox.org/git/743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru/
>
> Oh, bleh.  That's not a D/F conflict at all, it's the code assuming
> there's a D/F conflict because the entry it is processing ("sub") is a
> submodule rather than a file, and it panics when it sees "a directory
> in the way" -- a directory that just so happens to be named "sub" and
> which is in fact the desired submodule, meaning that the working
> directory is already good and needs no changes.

yup, I came to find the same snippet of code to be the offender,
I just haven't figured out how to fix this bug.

Thanks for taking a look!

As you have a lot of fresh knowledge in the merge-recursive case
currently, how would we approach the fix here?

(there is a test available at
remotes/origin/sb/test-cherry-pick-submodule-getting-in-a-way)

> In this case, the relevant code from merge-recursive.c is the following:
>
>         /* Case B: Added in one. */
>         /* [nothing|directory] -> ([nothing|directory], file) */
> <snip>
>         if (dir_in_way(path, !o->call_depth,
>                    S_ISGITLINK(a_mode))) {
>             char *new_path = unique_path(o, path, add_branch);
>             clean_merge = 0;
>             output(o, 1, _("CONFLICT (%s): There is a directory with
> name %s in %s. "
>                    "Adding %s as %s"),
>                    conf, path, other_branch, path, new_path);
>
> Note that the comment even explicitly assumes the newly added entry is
> a file.  We should expect there to be a directory present (the
> submodule being added), but the code doesn't have a check for that.
> The S_ISGITLINK(a_mode) makes you think it has special handling for
> the submodule case, but that's for the reverse situation (the
> submodule isn't yet present in the working copy, it came from the
> other side of history, but there is an empty directory present).

oh :/

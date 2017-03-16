Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB75F20323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbdCPWmi (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:42:38 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34295 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdCPWmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:42:37 -0400
Received: by mail-pg0-f48.google.com with SMTP id 141so31695240pgd.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8BcHnwHkfUVNlsU4ctvJlTLozNd6J4aoX0CrANMZKGM=;
        b=ttGMlL3yxpVfSnscv09T9qvGNvDXcYj9ZXioGoJKpVPCNOIQhzK2NT+ZmwutJWZM3w
         1GNOF5WnnRbt5WnGDcmHWNuXLdzFyVwMKDFrWnQFqky2/tE7htGGW7C6PSBVVeSL79ZX
         honNn/oD6Kl5OxP3ygSx9QqII11xGv/pIDxY35cPOyvt7tWLvOLbX/+rkKZiYC5s1K6R
         ynbPXMx2bZP3L2hWClLQNfqig6ESWuCcgXjRWmwWiOi7YJdb0XwpFuQHW1SkTbYjlZ4C
         x5zrG6uHEFPCt2yxTY3bldWgsmBC7w4N8zLbPaHG5IRDr3W5otLfroCpbvxZohcvrRsR
         J3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8BcHnwHkfUVNlsU4ctvJlTLozNd6J4aoX0CrANMZKGM=;
        b=bsJWFUDvOae9dNHxTqiX8gbD8azuKs7cjtwIghj0h4jXMvQZ4E/33Tj6WhdFV0fw44
         dBXZGhzvgrMEEx77UfKU2c5J4Fhuu7AQ4naS4cMCTUkkUCSBLfBDJR4bfqDtZHYw8qFT
         ddOmyo1sj59tDFD2rWJQKHwHtv9B7+GCT5OoqMtsc3cA4SzDqgks1VOLmGSc3CduKsfw
         Wrk2qS78ioHxs6xBrMxbAcbI6PzoQdamTR5QMlVj14VXrnMi1fAQpj3nSRJ/I1eB3fyY
         1XyoHXj+/Oz3pCWVdKpy+2RfnPr86DYgg7/XVOWYoZR6dcQThKrCPkrJ8KWhPCyyzbdb
         sksw==
X-Gm-Message-State: AFeK/H3QusHWiGQbwD+nxU1I/D9QWNikLLzJzPGX8J7ZL4rE53ontLmnz+8t8e33M8UIIEdR5ftd4jduK7US5iFo
X-Received: by 10.98.112.134 with SMTP id l128mr13231592pfc.81.1489704155708;
 Thu, 16 Mar 2017 15:42:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Thu, 16 Mar 2017 15:42:35 -0700 (PDT)
In-Reply-To: <20170316221907.GA9135@aiede.mtv.corp.google.com>
References: <CAGZ79kZ7rWw=q6a2AomTw20DsU1h+7ou4i8A14a2bcg+asRwLA@mail.gmail.com>
 <20170316204644.11616-1-sbeller@google.com> <20170316221907.GA9135@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Mar 2017 15:42:35 -0700
Message-ID: <CAGZ79kagA38GjXcRp1XBXhjR6OLgk-zrVC5MC2eo+nZziBETLg@mail.gmail.com>
Subject: Re: [PATCH v2] short status: improve reporting for submodule changes
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Is it important to avoid clutter by showing the submodule only once?
> What would you think of showing whatever subset of those three
> statuses apply to a given submodule as separate lines instead, to
> match the information that long-form "git status" shows?

I considered it, but it would break the visual appeal of git status --short ?

>
> How should a new untracked file in a submodule of a submodule be
> shown?

The same way " ?" indicates that (1) there is an untracked file due to
the question mark and (2) that you need to recurse because it differs from
"??" for regular untracked files.

The problem here is that we do not know about these nested untracked files,
because we use --porcelain instead of --short for submodules in
submodule.c#is_submodule_modified(). I am rewriting that function anyway
for the "git-describe --dirty" bug, so maybe it's time to switch to porcelain=2
internally there, which can surface untracked files in nested subs.


>
> [...]
>> --- a/Documentation/git-status.txt
>> +++ b/Documentation/git-status.txt
>> @@ -181,6 +181,12 @@ in which case `XY` are `!!`.
>>      !           !    ignored
>>      -------------------------------------------------
>>
>> +Submodules have more state to it, such that it reports instead:
>
> Language nits: s/ to it//; s/, such that it reports instead/ and instead report/
>
>> +             M    the submodule has a different HEAD than recorded
>
> than recorded in the index?

ok, will fix.


>> +test_expect_success 'status with modified file in submodule (short)' '
>> +     (cd sub && git reset --hard) &&
>
> not about this patch: this could use "git -C sub" and avoid a
> subshell.  But what you have here matches the existing style, so I
> wouldn't suggest changing it here.
>
>> +     echo "changed" >sub/foo &&
>> +     git status --short >output &&
>> +     diff output - <<-\EOF
>
> similarly, this could use test_cmp, but that seems out of scope for
> this change.

Yes I considered if I want to redo the whole file to meet
'modern Git test suite style'. I'll think about it again.

> [...]
>> +test_expect_success 'status with added file in submodule (short)' '
> [...]
>> +test_expect_success 'status with untracked file in submodule (short)' '
>
> Test wishlist:
> * --porcelain output for these cases
> * behavior with nested submodules

Look at the test file, please.
I copied the tests cases (porcelain) and replaced s/porcelain/short/,
so they exist.

>
> [...]
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1664,9 +1664,19 @@ static void wt_shortstatus_status(struct string_list_item *it,
>>               color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
>>       else
>>               putchar(' ');
>> -     if (d->worktree_status)
>> +     if (d->worktree_status) {
>> +             if (!s->submodule_porcelain1 &&
>
> Isn't this 's->status_format != STATUS_FORMAT_PORCELAIN'?

yes.

>> +                 (d->dirty_submodule || d->new_submodule_commits)) {
>> +                     /* It is a submodule, and we're not in plumbing mode. */
>> +                     if (d->new_submodule_commits)
>> +                             d->worktree_status = 'M';
>> +                     else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
>> +                             d->worktree_status = 'm';
>> +                     else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
>> +                             d->worktree_status = '?';
>> +             }
>
> Is this the right place to do this?  Could wt_status_collect_changed_cb set
> worktree_status to the right value in the first place based on whether
> 'status_format == STATUS_FORMAT_SHORT' or would that have undesirable
> knock-on effects elsewhere?
>

yes that would be better. I totally missed status_format as a variable.

>> +     int submodule_porcelain1;
>
> As described above, this shouldn't be needed since status_format
> already has this information.

good point. will omit this variable.

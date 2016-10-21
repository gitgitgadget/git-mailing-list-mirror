Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38E520229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935017AbcJUWBs (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:01:48 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34672 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934966AbcJUWBr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:01:47 -0400
Received: by mail-yw0-f179.google.com with SMTP id w3so117260909ywg.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=imtS0L5+IRm8Inpiw5U+30gpFBUUEVmpdg/+IReWpgM=;
        b=KgtnlartIONTNw0GCsWO8up+sBvc+H8R/oSsFaxnNv0i8UaPNQGF8BwCOff2HMx0nA
         TklmnpEBUivQi/Whwn75d25KqVFOq0Xaa+iUcJmlHr/evdWEjdvl3MY2Z4RCSxd/MDj3
         OnpSZB8uFed6vcQtG96xMYBY568V0ocm+DDdcvrzRr1RYQmRsD6hJHLZC/Hrb+NyshBa
         BmlBXQg+nRLxSbUBN3bzrSe/MFf6GGYhf8dLbQA4YXTbSsTH7ZC0QZUKmH74m8jxj6E0
         hmp+DJy+ZQ08tIll362ytWPfDOP72lNZJ8RjF7CaiTRXgieXZEcivHWilnUErJUwd7yA
         lLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=imtS0L5+IRm8Inpiw5U+30gpFBUUEVmpdg/+IReWpgM=;
        b=YCT4lZKwBJS2OulxtvvnlacMSx1/Ibgy4V6Gdw5oewIGnCVwBgnJ1tcQHvJgcuGRMv
         3mMCkCFKMsyG0x6rytnpCtHu2j8jWHl8ghamzu1LzUyJ4LNem6EEH06lH5zFAOaxV7M1
         UGAEvKJdM3iwsZ4DHBcemiSAeJJUT/+cOXWfH+F9qO1STdW29c8J286t6FfpT58XyfrF
         2ouiNqFl70BU+TDkxnTUUbuRK2gnNpkFkXphrIu4kHN6TuJ8asIyBMPSJCWCQ9QM8aUf
         H0I5aJQoq7O3A4NOp/qNn+GisTBUmYDBD0GCk6wf5l3lkUrevia1eJ32/NY9B24/Ngmg
         7fVg==
X-Gm-Message-State: ABUngvcZ+VxSZwScHJZDSZ8Cu/otC2tOmFh3HgF73uNj3DS1V/YiKi48uca9OhSJUlXuCmBSwPnjCS2HwTPkAw==
X-Received: by 10.129.102.85 with SMTP id a82mr3493968ywc.160.1477087306026;
 Fri, 21 Oct 2016 15:01:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Fri, 21 Oct 2016 15:01:25 -0700 (PDT)
In-Reply-To: <CA+P7+xrN-_zP40uAUGtqZW+OO4D4Z65SiPRykdKvauO1zgNNcQ@mail.gmail.com>
References: <CA+P7+xrN-_zP40uAUGtqZW+OO4D4Z65SiPRykdKvauO1zgNNcQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Oct 2016 15:01:25 -0700
Message-ID: <CA+P7+xoTO6MqdBjekbSpSs=w_dJ-1h_ypMDAo50mm95iTOo9Pw@mail.gmail.com>
Subject: Re: generating combined diff without an existing merge commit
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 2:40 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hi,
>
> I recently determined that I can produce an interdiff for a series
> that handles rebasing nicely and shows the conflicts resolved when
> rebasing plus any other changes.
>
> The basic idea is something like the following, assuming that v1 is a
> tag that points to the first version, v2 is a tag that points to the
> rebased new version, and base is a tag that points to the new base of
> the series (ie: the upstream if the v2 is on a branch and has been
> fully rebased)
>
> git checkout v1
> git merge base
> #perform any further edits to get everything looking like v2
> git commit
> git show -cc HEAD
>
> This is also equivalent to the following without having to actually do
> the merge manually:
>
> git commit-tree v2^{head} -p v1 -p master -m "some merge message"
> git show <output from the commit tree above)
>
> this nicely shows us the combined diff format which correctly shows
> any conflicts required to fix up during the rebase (which we already
> did because we have v2) and it also shows any *other* changes caused
> by v2 but without showing changes which we didn't actually make. (I
> think?)
>
> The result is that we can nicely see what was required to produce v2
> from v1 but without being cluttered by what changed in base.
>
> However, I have to actually generate the commit to do this. I am
> wondering if it is possible today to actually just do something like:
>
> git diff <treeish> <treeish> <treeish> and get the result that I want?
>
> I've already started digging to see if I can do that but haven't found
> anything yet.
>
> Thanks,
> Jake

Turns out that somehow I must have messed up my command because "git
diff <treeish> <treeish> <treeish>" does indeed do exactly what I
want.

Thanks,
Jake

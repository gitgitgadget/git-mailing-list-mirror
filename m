Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EBE1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935298AbcIFTAR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 15:00:17 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:34172 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933499AbcIFTAP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 15:00:15 -0400
Received: by mail-yb0-f173.google.com with SMTP id x93so95886353ybh.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b+Mo7Zz+H8jlzuA61cXwoEvwbFm/1B5Zlsq6pfFSVYg=;
        b=jf+tgMbH2qeFMCEC7dSfUwjdBJ6Kzb7h5rqNhSwnfz129CV3DDNF1oiFtOJNWcNi13
         xnnuPfo/2P7z+3c/AlZa8O/cIq9vQhzfcuV7KFF6zJwIGysLJtoolYuOLRSHTtQPnB/x
         lT78g+lZbDfQPg6jiXsIxrCpn6BL8ae6/8q/gbBCZAnd8nzp+BHkL7BIfR8aZER6o+XW
         P9qyp8/pCeRe5iUDE8ZlD8KHjlhHVnHJu1aSEm1pJYkIKS0hqG+k+99QqqKrP6uCBPEL
         JOHBURLXkw8Yc9IkG90iHXilwLY8sXJYwU0TtA1tW6j8d0s8C/z1asVlJD2x4BOo8h7C
         +MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b+Mo7Zz+H8jlzuA61cXwoEvwbFm/1B5Zlsq6pfFSVYg=;
        b=a+XsgnOPzF18ihS1YvGAYVzQbugmWIEqKngVlDsu+lk2Jahf2/u2iAMQ5arDNQS6jF
         ApMyRkCGmi3Q0jcdUlUQ1jIG/x2yw8heSEV4y4CZ+d5ccVLODrXT+cHKHpJ6k/+joAuF
         +vIPQ0gOQ+xVlR8xf9MBFFx3KWlwvQ+F0XHJU2v6KVMUG8Kun4Ov0bRkO5B5HvtmQ9MM
         caz60kq4rWubPHcP5ZWsfi5WKamZ6FOZta25CWoHybKNlmHhfeiUJZdVxnQEvM2jkncb
         4szVOeqtiS537f8t4DgwjqFf019qXtREkpa5j8BjerKJJcCQH0dHZKBBFXDt/fw3P+B6
         jdhw==
X-Gm-Message-State: AE9vXwOJhNTHGFP1jXGeQ+JxpAKANGNfs8N4mZVy39aGptWXYkfDdIZhKFU+buyZmKVMNX2Y0XIg9UV+LnXXwPVL
X-Received: by 10.36.123.199 with SMTP id q190mr356548itc.46.1473188414520;
 Tue, 06 Sep 2016 12:00:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 6 Sep 2016 12:00:14 -0700 (PDT)
In-Reply-To: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
References: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Sep 2016 12:00:14 -0700
Message-ID: <CAGZ79kb=LyusFH6tGirGP9qK1k-cov2UubEbKPfeyPRThUsa-Q@mail.gmail.com>
Subject: Re: If a branch moves a submodule, "merge --ff[-only]" succeeds while
 "merge --no-ff" fails with conflicts
To:     Dakota Hawkins <dakotahawkins@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, mwitte@ara.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 12:22 PM, Dakota Hawkins <dakotahawkins@gmail.com> wrote:
> Below is a simple reproduction of the issue.
>
> The _real_ problem is that this is how our pull request merges work,

So your workflow is the problem or is the actual bug just exposed in
your workflow?

> they're not allowed to do fast-forward merges. To work around this we
> are having to split this up into two pull requests/merges: One that
> copies the submodules to the new location and includes any fixes
> required to support the move, and a second that removes the old
> locations.
>
> ## Setup steps
> git clone https://github.com/dakotahawkins/submodule-move-merge-bug-main-repo.git
> cd submodule-move-merge-bug-main-repo
>     ## How it was initially constructed
>     # git submodule add ../submodule-move-merge-bug-submodule-repo.git
> ./submodule-location-1
>     # git commit -m "Added submodule in its initial location"
>     # git push
>     # git checkout -b move-submodule
>     # git mv ./submodule-location-1 ./submodule-location-2
>     # git commit -m "Moved submodule"
>     # git push --set-upstream origin move-submodule
> git branch move-submodule origin/move-submodule
>
> ## Test fast-forward merge, this will work
> git checkout -b merge-ff-test master # warning: unable to rmdir
> submodule-location-2: Directory not empty
> rm -rf ./submodule-location-2
> git merge --ff-only move-submodule
>

And no reset/rm in between, i.e. we still have
submodule-location-2 from  merge-ff-test still around?

> ## Test no-fast-forward merge, this will fail with conflicts:
> git checkout -b merge-no-ff-test master
> git merge --no-ff move-submodule
>     # Auto-merging submodule-location-2
>     # Adding as submodule-location-2~move-submodule instead
>     # Automatic merge failed; fix conflicts and then commit the result.
> git status
>     # On branch merge-no-ff-test
>     # You have unmerged paths.
>     #   (fix conflicts and run "git commit")
>     #   (use "git merge --abort" to abort the merge)
>     #
>     # Changes to be committed:
>     #
>     #         modified:   .gitmodules
>     #         deleted:    submodule-location-1
>     #
>     # Unmerged paths:
>     #   (use "git add <file>..." to mark resolution)
>     #
>     #         added by us:     submodule-location-2
>     #
>     # fatal: Not a git repository: 'submodule-location-1/.git'
>     # Submodule changes to be committed:
>     #
>     # * submodule-location-1 07fec24...0000000:

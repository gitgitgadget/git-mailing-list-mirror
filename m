Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F0AC43214
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D3E610FE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhHBNuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhHBNtR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:49:17 -0400
Received: from forward103p.mail.yandex.net (forward103p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA9C06121C
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:48:26 -0700 (PDT)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id B13DC18C3690;
        Mon,  2 Aug 2021 16:48:20 +0300 (MSK)
Received: from vla5-7c8bfce2718b.qloud-c.yandex.net (vla5-7c8bfce2718b.qloud-c.yandex.net [IPv6:2a02:6b8:c18:348f:0:640:7c8b:fce2])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id ABFF4CF40005;
        Mon,  2 Aug 2021 16:48:20 +0300 (MSK)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by vla5-7c8bfce2718b.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 31UBLiqmOd-mKH8mX1i;
        Mon, 02 Aug 2021 16:48:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1627912100;
        bh=wIZSfWYBqT5ZRudtIKHR0pERPIQlah9Du5aHCDIlNvQ=;
        h=In-Reply-To:Subject:To:Message-ID:From:References:Date:CC;
        b=Y8w+RejNK5eeKNPH+B3ThrSacX4aKzOq9jucEkQTUbWBJjETVtWMbnok3hA9OP92P
         5cgw7sKjvYYQiUCzE02lLppcd9GLxaIH/JprmLL0vxAl4pGQGu8sxdHMb+3V0EFcXo
         EOm6tNL+1zR9SivORyw2sGBMBmIa46D+jKDr6/j0=
Authentication-Results: vla5-7c8bfce2718b.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id hRy3xfmwbr-mKsWWbHm;
        Mon, 02 Aug 2021 16:48:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Mon, 2 Aug 2021 16:48:19 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1522228698.20210802164819@yandex.ru>
To:     Elijah Newren <newren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Ambigious messages
In-Reply-To: <CABPp-BHkhwKFb74fUMW3nOGrCD6waBPBjp-UY2fRhU6=WUxOow@mail.gmail.com>
References: <644619140.20210731114616@yandex.ru> 
  <CABPp-BHkhwKFb74fUMW3nOGrCD6waBPBjp-UY2fRhU6=WUxOow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Elijah,

Sunday, August 1, 2021, 3:27:07 AM, you wrote:

> Hi Eugen,

> On Sat, Jul 31, 2021 at 2:56 AM Eugen Konkov <kes-kes@yandex.ru> wrote:

>> $ git checkout 51c7d41b82b5b
>> error: Your local changes to the following files would be overwritten by checkout:
>>        lib/Mojo/IOLoop/Stream.pm
>> Please commit your changes or stash them before you switch branches.
>> Aborting

> The error seems quite reasonable to me...but can I ask how you got
> into this state?

> There's two ways I know of:

> 1) Setting a sparse-checkout to only have certain paths, and then
> recreating a file outside the sparsity paths anyway.
> 2) Trying to adjust your sparse-checkout to have a different set of
> paths, then hit Ctrl-C while it is in the middle of running.

> Did you do one of these?  If not, what'd you do?  If so, which one?

> I've only had confused users come to me when they did the latter; they
> apparently assumed Ctrl-C would abort the operation and return to the
> previous state, but it does not -- whatever was successfully checked
> out before they hit Ctrl-C remains written to the working copy, but
> the .git/info/sparse-checkout file is updated last so the system
> continues assuming the old checkout.  I wonder if we need to add some
> special Ctrl-C handling inside sparse-checkout adjustments or
> something.

>> $ git checkout lib/Mojo/IOLoop/Stream.pm
>> error: pathspec 'lib/Mojo/IOLoop/Stream.pm' did not match any file(s) known to git

> This error message is clearly suboptimal and should be improved.
> Alternatively, though, we could perhaps change the behavior so that
> when in a sparse-checkout and the file(s) that match are SKIP_WORKTREE
> but present anyway, we could just remove the file from the working
> copy (i.e. make it match the index).

>> $ git add lib/Mojo/IOLoop/Stream.pm
>> The following pathspecs didn't match any eligible path, but they do match index
>> entries outside the current sparse checkout:
>> lib/Mojo/IOLoop/Stream.pm
>> hint: Disable or modify the sparsity rules if you intend to update such entries.
>> hint: Disable this message with "git config advice.updateSparsePath false"

> The error message is correct, but this is the case Stolee was talking
> about recently where it'd be good to add an override to "git add" to
> allow adding it anyway and add information about using that option to
> this error message.

>> $ git --version
>> git version 2.32.0

>> Here I do not understand how to checkout to different commit
>> or how to commit the subject file

> I'll give you three different ways you should be able to do it:

> 1. Since you wanted to just restore the file to the version in the
> index (as per your `git checkout lib/Mojo/IOLoop/Stream.pm` command),
> you can simply delete the file (`rm lib/Mojo/IOLoop/Stream.pm`) and
> everything would be fine.

> 2. You could change your sparsity paths to include this file so it
> doesn't think it should be excluded from the working tree, e.g. `git
> sparse-checkout add lib/Mojo/IOLoop` or even `git sparse-checkout add
> lib/Mojo/IOLoop/Stream.pm`.  That'd be most useful if you made
> important edits to the file or want to continue editing the file and
> committing changes in it.

> 3. You could just disable the sparse-checkout entirely (`git
> sparse-checkout disable`).  That'd make it so you don't have to worry
> about this path or any other being simultaneously excluded and present
> in the working tree.  You should be able to fix things up normally.
> And, if you want, when you're done fixing things up, then set up a
> sparse-checkout again.


>> It would be nice to show hint about how to exlude this file from unindex

> Yes, we need to improve some error messages here (and perhaps tweak
> some behavior as well).  Thanks for the report.

>>Thanks for the report.
Thank you for the support!

> Did you do one of these?  If not, what'd you do?  If so, which one?
None  of  these.  I even do not remember sharp command how I fall into
this. This were two or three months ago... I just remember that I have
added this file to "ignore" it from tracking:

     git update-index --assume-unchanged lib/Mojo/IOLoop/Stream.pm

This feature is like: hide file from output.
Git  do something with this file so it is tracked in some way but just
is not displayed when `git status` command is done.

So it would be nice if I can do:

    git hide lib/Mojo/IOLoop/Stream.pm

and this file is hidden from output.
But `git status --verbose` will show it anyway. Compare:

git status

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
1       modified:   cpanfile.snapshot

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
2       modified:   ext/Auth/Mojolicious/Plugin/Auth.pm
3       modified:   front/readme.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
4       .prove


git status --verbose
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
1       modified:   cpanfile.snapshot

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
2       modified:   ext/Auth/Mojolicious/Plugin/Auth.pm
3       modified:   front/readme.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
4       .prove

Files hidden from output:
      (use "git unhide <file>...." to unhide these files)
5      lib/Mojo/IOLoop/Stream.pm


I   am   not   expert,   this  is just my user point of view. Probably
there  alredy  some exisisting interface. I just outline how it would be
handy from my point.

Also this topic seems hot: https://stackoverflow.com/questions/936249/how-to-stop-tracking-and-ignore-changes-to-a-file-in-git




-- 
Best regards,
Eugen Konkov


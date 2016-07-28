Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA76F1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbcG1Q7s (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:59:48 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35040 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581AbcG1Q7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:59:46 -0400
Received: by mail-it0-f43.google.com with SMTP id u186so173185165ita.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:59:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WrC0nHF+vVufQib/QspfVL7pdQUbA3+pcBJF7TKSZHc=;
        b=mESIc6/y0i8+bogincX1SuDJTT1qt7ZPSqv+r+OHTc6kN1b52mhZeEICWP/RMOoQ4/
         ecKj2WJb+plHhggxLqh6IxZx1hcszI19BofB/JKFxJOyPwIoXBreSi5X3PFlTO583Xos
         dKOTu18wxFPwlCR4HO9A9A+jRsMJ1Vf3zlGklwFryJTc83CrLa64o0KjBxbgUGxuxnjn
         RHFsXN3cVInxJvqSxFiyvhd6oeboB4mFSJld5Edq8ZQhXZaS2FV6Exl+yn1x/oQ6ghSv
         FfoLx9T8yKjJsQwnMNkfAVAP3ghIECRy/+qfZYUgQwS07rB6OLdeGFKPCYF8DKSs2Fw1
         SOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WrC0nHF+vVufQib/QspfVL7pdQUbA3+pcBJF7TKSZHc=;
        b=bZ7Id0hxAHG1OzYKOKLj1g1A8sXIADYJvNVAWQWXskShf+np/u/kwSthsb1qC8OOXh
         zjz9VTCcQOtMjQhcw9kry28l0TRr26LgX+l4taTQqJch1dcMnuX6OT1Wpd4WunCv4Mqb
         mO4ZGRhjkWJm7oAkIvRhT+J3U+OV+93hwH9ykHM5Ndtq9BFFD9tzyx1Bn96Ibkryg+pP
         bZfXVWFmusN7ALAByzsIRG7/4ueEhAaQROd2zAoR0HG2WIZoDeoOkobSxK3v8Fqj+YRd
         A31mfwqY/Mggwn7UmzdFLZLmqxqR9mB5yEZvnKjrkwq6qZI47riME038Sa2Lqa3zT/HA
         zyBw==
X-Gm-Message-State: ALyK8tJWjGef7yTCtQ6gUeuBmkxPJYTcpCf/qItgLLzXCCLbMjXAW2tVQPF0BgHyTyx4YIsob+dPFGJuv2ho7Q==
X-Received: by 10.36.33.197 with SMTP id e188mr92173739ita.42.1469725185885;
 Thu, 28 Jul 2016 09:59:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 28 Jul 2016 09:59:16 -0700 (PDT)
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 28 Jul 2016 18:59:16 +0200
Message-ID: <CACsJy8AW3Z+C81F6w7WiZXXvcLRv9PB4=Wjbze6eE_MPgikU8A@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/7] Add possibility to clone specific subdirectories
To:	Robin Ruede <r.ruede@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 6:02 PM, Robin Ruede <r.ruede@gmail.com> wrote:
> This patch series adds a `--sparse-prefix=` option to multiple commands,
> allowing fetching repository contents from only a subdirectory of a remote.
>
> This works along with sparse-checkout, and is especially useful for repositories
> where a subdirectory has meaning when standing alone.

Ah.. this is what I call narrow checkout [1] (but gmane is down at the moment)

[1] http://thread.gmane.org/gmane.comp.version-control.git/155427

> * Motivation (example use cases)
>
> ...

nods nods.. all good stuff

> * Open problems:
>
> 1. Currently all trees are still included. It would be possible to
> include only the trees relevant to the sparse files, which would significantly
> reduce the pack sizes for repositories containing a lot of small files changing
> often. For example package managers using git. Not sure in how many places all
> trees are presumed present.

You can limit some trees by passing a pathspec to "git rev-list" (in
your "list-objects" patch). All trees completely outside sub/dir will
be excluded. Trees leading to it (e.g. root tree and "sub") are still
included. Not having all trees open up a new set of problems.. This is
what I did in narrow clone: pass some directories (as pathspec) to
rev-list on the server side, then deal with lack of trees on client
side.

> 2. This patch set implements it as a simple single prefix check command line
> option.
> Using the exclude_list format (same as in sparse-checkout) might be useful.
> The server needs to check these patterns for all files in history, so I'm not
> sure if allowing multiple/complex patterns is a good idea.

I would go with something else than sparse-checkout, which I call
narrow checkout: instead of flattening the entire tree in index and
keep only files there, we keep trees that we don't have as trees.
Those trees have the same "sparse checkout" attributes, e.g. ignore
worktree and some of submodules e.g. don't bother checking the
associated hash. This approach [2] eliminates changes in cache-tree.c
(i.e. 3/7).

And you would need something like that, when you don't have all the
trees (from open problem 1), because you just can't flatten trees when
you don't have them.

[2] https://github.com/pclouds/git/commits/lanh/narrow-checkout (I
think core functionality is in place, but narrow operation still needs
more work)

> 3. This patch set assumes the sparse-prefix and sparse-checkout does not change.
> running clone and fetch both need to have the --sparse-prefix= option, otherwise
> complete packs will be fetched. Not sure what the best way to store the
> information is, possibly create a new file `.git/sparse` similar to
> `.git/shallow` containing the path(s).

Something like .git/shallow, yes. It's similar in nature anyway
(shallow cuts depth, you cut the side)

> 3. Bitmap indices cannot be used, because they do not contain the paths of the
> objects. So for creating packs, the whole DAG has to be walked.

And shallow clones have this same problem. Something to be sorted out :)

> 4. Fsck complains about missing blobs. Should be fairly easy to fix.

Not really. You'll have to associate path information with blobs
before you decide that a blob should exist or not. Sparse patterns are
just not designed for that (tree walking). If you narrow (heh) down to
just path prefix not full blown sparse patterns, then it's feasible to
walk tree and filter. A subset of pathspec would be good because we
can already filter by pathspec, but I would not go full pathspec at
the first step.

> 5. Tests and documentation is missing.

Personally I would go with my narrow clone approach, but the ability
to selectively exclude some large blobs is still good, I think.
However, another approach to excluding some blobs is the external
object database [3]. It gives you what you need with a lot less code
impact (but you will not be able to work offline 100% the time like
what you can now with git)

[3] https://public-inbox.org/git/20160613085546.11784-1-chriscool%40tuxfamily.org/
-- 
Duy

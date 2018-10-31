Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DED31F453
	for <e@80x24.org>; Wed, 31 Oct 2018 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeKAELh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 00:11:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37975 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAELg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 00:11:36 -0400
Received: by mail-io1-f67.google.com with SMTP id q18-v6so10529873iod.5
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/U7PklZ8SkyON3FT1HLl5FNnz8iN5N1AaXHAfGajm2c=;
        b=t2GIdPRvETZbvTnNy0ldlQkmP0HYxM7oghNT4Q2R2qt22SwC3nVL5n/fLtbM4CiSra
         qS8mLQs0ulqlZHxFWpBXUmUBqmIXim2urcIeNhoVoKBxRqzp6JK0ld1BivwNhvsERMTT
         LpCwQVqGO1e0lYrUS7oCT+dOW9goemUDEIYOeTVi1OrwjZuUayKVOIYjlKy2SHTV4aal
         AqwRgUbTnJAMguO7J9CzsLfy0k0Kli3uz7QiHkgC97bBRcKcMfpaHtu2O0Dc8zevj1T2
         0D8VOmXjFisMAVjNClvar0kLIHIzrqcj2U4p9jnvazQapK47cqPzLvdcnIII3+x3bPab
         eO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/U7PklZ8SkyON3FT1HLl5FNnz8iN5N1AaXHAfGajm2c=;
        b=LZgnkhxzsMdHhTt/C6CfCkCcgaaQFviT77S3dVTlBkJj7CwOrFyueN4N0dNHgD+HfQ
         cLjLT9oROPd1bYwqqCFH+LQy0pvrRwpKYZa7aNQoqqvB1k29wiaRq46zmGZ06v6Q2tkZ
         wdch0DE7QWK5V3UZf6EZKSmM+Zva3Sd8GGVM8QKh+a3/Do+RGRSK41sRCmeyeh3Mrk+I
         S4+ThbGwFzllfKlGWejUOy5SurpJDyQPSmk2nsyAi9tR0NA1S2O3SSUWejpRw9FulKNB
         Ib15tzvubBsEWKITQLSjkQt8tYpkXTkvTfJw5KMRBkeVvPehRJgSVVOfhB3UwxyVzXrf
         piZg==
X-Gm-Message-State: AGRZ1gLbMeSLMs0gsli8UJaC6qeZYAGfwqV/T5nBbKUdBJ4wsGcU9NyI
        rk3hJHgoCnbr+bcuyW+VMQofRIk1LVRh0CXb7OI=
X-Google-Smtp-Source: AJdET5cZxCb9F7r/m8PnkcCE/Bb2CQMkmnPaPXn9zic7ZVt0KxDfiDqtbsCUZ/sv0C9XSfB8x9MbnaBYhBASFcGxUYg=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr2536311iod.282.1541013134126;
 Wed, 31 Oct 2018 12:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181030191608.18716-1-peartben@gmail.com>
In-Reply-To: <20181030191608.18716-1-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 31 Oct 2018 20:11:47 +0100
Message-ID: <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

not really a review, just  a couple quick notes..

On Tue, Oct 30, 2018 at 9:40 PM Ben Peart <peartben@gmail.com> wrote:
>
> From: Ben Peart <benpeart@microsoft.com>
>
> On index load, clear/set the skip worktree bits based on the virtual
> file system data. Use virtual file system data to update skip-worktree
> bit in unpack-trees. Use virtual file system data to exclude files and
> folders not explicitly requested.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>
> We have taken several steps to make git perform well on very large repos.
> Some of those steps include: improving underlying algorithms, utilizing
> multi-threading where possible, and simplifying the behavior of some commands.
> These changes typically benefit all git repos to varying degrees.  While
> these optimizations all help, they are insufficient to provide adequate
> performance on the very large repos we often work with.
>
> To make git perform well on the very largest repos, we had to make more
> significant changes.  The biggest performance win by far is the work we have
> done to make git operations O(modified) instead of O(size of repo).  This
> takes advantage of the fact that the number of files a developer has modified
> is a tiny fraction of the overall repo size.
>
> We accomplished this by utilizing the existing internal logic for the skip
> worktree bit and excludes to tell git to ignore all files and folders other
> than those that have been modified.  This logic is driven by an external
> process that monitors writes to the repo and communicates the list of files
> and folders with changes to git via the virtual file system hook in this patch.
>
> The external process maintains a list of files and folders that have been
> modified.  When git runs, it requests the list of files and folders that
> have been modified via the virtual file system hook.  Git then sets/clears
> the skip-worktree bit on the cache entries and builds a hashmap of the
> modified files/folders that is used by the excludes logic to avoid scanning
> the entire repo looking for changes and untracked files.
>
> With this system, we have been able to make local git command performance on
> extremely large repos (millions of files, 1/2 million folders) entirely
> manageable (30 second checkout, 3.5 seconds status, 4 second add, 7 second
> commit, etc).
>
> Our desire is to eliminate all custom patches in our fork of git.  To that
> end, I'm submitting this as an RFC to see how much interest there is and how
> much willingness to take this type of change into git.

Most of these paragraphs (perhaps except the last one) should be part
of the commit message. You describe briefly what the patch does but
it's even more important to say why you want to do it.

> +core.virtualFilesystem::
> +       If set, the value of this variable is used as a command which
> +       will identify all files and directories that are present in
> +       the working directory.  Git will only track and update files
> +       listed in the virtual file system.  Using the virtual file system
> +       will supersede the sparse-checkout settings which will be ignored.
> +       See the "virtual file system" section of linkgit:githooks[6].

It sounds like "virtual file system" is just one of the use cases for
this feature, which is more about a dynamic source of sparse-checkout
bits. Perhaps name the config key with something along sparse checkout
instead of naming it after a use case.

This is a hook. I notice we start to avoid adding real hooks and just
add config keys instead. Eventually we should have config-based hooks,
but if we're going to add more like this, I think these should be in a
separate section, hook.virtualFileSystem or something.

I don't think the superseding makes sense. There's no reason this
could not be used in combination with $GIT_DIR/info/sparse-checkout.
If you don't want both, disable the other.

One last note. Since this is related to filesystem. Shouldn't it be
part of fsmonitor (the protocol, not the implementation)? Then
watchman user could use it to.
-- 
Duy

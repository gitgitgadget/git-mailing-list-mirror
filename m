Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BAC520988
	for <e@80x24.org>; Tue, 18 Oct 2016 21:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934275AbcJRVRm (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 17:17:42 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33830 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbcJRVRj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 17:17:39 -0400
Received: by mail-qk0-f171.google.com with SMTP id f128so8579720qkb.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GIbBIG4dwsdKO2DMQsNWWM9XYxIFGRfYbKMm7CtqPJQ=;
        b=VtVEJFve5YYN2BkJS2+BiYe/nVZi4ZyuMGH79XZcALxalliAxOtEpi2tkUCg+y57lW
         GwQPzWJVabcD5HYqjdB7csKhG9fGOsEYNUn+4r+FT5wqM2a7vaa0Wq1pzEmuVx+gCiaH
         7FwbpGGHEj6O9OGed0bumt40FH/YqZyzXZxByDZHwR8KpLrZaBYDJupNmBEfF3/s3RuM
         ihg0Vm8nNpSajS14s8kD00HbR7DbuPTXXE3UPsbsrU4L0FUT22T5RSEFXtyNKCPB4a3E
         9FoB9Hg1VZBMhxiRz/UERLEADBCABrnFGtKHt9pV1rHCpSfFJKBFHLoTlEXPbjKg7kDS
         G2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GIbBIG4dwsdKO2DMQsNWWM9XYxIFGRfYbKMm7CtqPJQ=;
        b=gAC+zwBfab3mOh1ycFXCxqUueDOBQbvrT1WvEZwsUfqx8zYa0t4tlZ6rGJ4ih56ucl
         1uNjl7Rn5zsJvLKJAQhQMihBHDYrhhm/7axs2kTIasnLcyLjxvy/+g3yItSoeTk3olkL
         lahvpduNhjDDJgxbAyuI6UzXY6aYlcerTCFyqpjk5VL6GAgivS6ghlnRmYt9FMO9WIRO
         5irVsA4/4VJMWShv0GsVZa+BTdkBt4d4nNL4DmbiX3My9pdY7dPqb0JJAduTFtLPC5g+
         wwonNHgp5dHAMdvM0DB72A2+uExmlEdS7+/yEJsCuDlzRsOUCLjUbqanIPutjJonM4j+
         K22A==
X-Gm-Message-State: AA6/9Rkux1cIo42pEtla+CVt5s+Drn1s/zyNFamz+0x64Ls7fzqtGet6A6zmc4sesoO5DBa1tTmekh6OwJeRB/1t
X-Received: by 10.55.142.130 with SMTP id q124mr2594941qkd.220.1476825457933;
 Tue, 18 Oct 2016 14:17:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 18 Oct 2016 14:17:37 -0700 (PDT)
In-Reply-To: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
References: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Oct 2016 14:17:37 -0700
Message-ID: <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com>
Subject: Re: Integrating submodules with no side effects
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 12:35 PM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> Hello git experts,
>
> I have in the past attempted to integrate submodules into my primary
> repository using the same directory name. However, this has always
> caused headache when going to and from branches that take you between
> when this integration occurred and when it didn't. It's a bit hard to
> explain. Basically, if I have a submodule "foo", and I delete that
> submodule and physically add its files under the same directory "foo",
> when I do a pull to get this change from another clone, it fails
> saying:
>
> error: The following untracked working tree files would be overwritten
> by checkout:
>         foo/somefile.txt
> Please move or remove them before you switch branches.
> Aborting
> could not detach HEAD
>
>
> Obviously, git can't delete the submodule because the files have also
> been added directly. I don't think it is built to handle this
> scenario. Here is the series of commands I ran to "integrate" the
> submodule (replace the submodule with a directory containing the exact
> contents of the submodule itself):
>
> #!/usr/bin/env bash
> mv "$1" "${1}_"
> git submodule deinit "$1"

This removes the submodule entries from .git/config
(and it would remove the contents of that submodule, but they are moved)

> git rm "$1"

Removing the git link here.

So we still have the entries in the .gitmodules file there.
Maybe add:

    name=$(git submodule-helper name $1)
    git config -f .gitmodules --unset submodule.$name.*
    git add .gitmodules

? (Could be optional)

> mv "${1}_" "$1"
> git add "$1/**"

Moving back into place and adding all files in there.

>
> The above script is named git-integrate-submodule, I run it like so:
>
> $ git integrate-submodule foo
>
> Then I do:
>
> $ git commit -m 'Integrated foo submodule'
>
> Is there any way to make this work nicely?

I think you can just remove the gitlink from the index and not from the working
tree ("git rm --cached $1")

> The only solution I've
> found is to obviously rename the directory before adding the physical
> files, for example name it foo1. Because they're different, they never
> "clash".

Also look at the difference between plumbing and porcelain commands[1],
as plumbing is more stable than the porcelain, so it will be easier to maintain
this script.

I think this would be an actually reasonable feature, which Git itself
could support via "git submodule [de]integrate", but then we'd also want
to see the reverse, i.e. take a sub directory and make it a submodule.

[1] e.g. https://www.kernel.org/pub/software/scm/git/docs/

Thanks,
Stefan

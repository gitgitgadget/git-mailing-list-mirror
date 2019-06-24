Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5701F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfFXMdu (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:33:50 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:47038 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXMdu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:33:50 -0400
Received: by mail-vk1-f194.google.com with SMTP id b64so2697105vke.13
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iJlU54RhGTp2raAnF/3iXTnCUXgAS2eNFjxg7OcUhA=;
        b=Zz8IWDmZTCULLBXUmoZ7FnUH2BvKy2X2ZUpwMxcLMKKSZptQNV/ps7NnBLI4YXc8oj
         /LKj8M0LIaDHh7jyv3IIoH6+DXC3tcGtShBnF3aNLqScfBKcFIIIGKYID4Mzl9jU78AN
         TWgPSMD78iFtXlRrj1u69fVH00OrVuFGLzW6nGUldCLlJ93H+clG+QZK5JX3EgcL+Q4Y
         MkZTC6pXq3XnjRDvc2FVs+Mpnh/1ngryvo1/VqGKB9BI2wjiTuyaysehfZj+UpoAdwGy
         pWse90wkqaUvy05oebYSufcretwS9kxGHd7v2Pyzq3bfjdZxg3/5BYddMniB7U55ifV5
         O7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iJlU54RhGTp2raAnF/3iXTnCUXgAS2eNFjxg7OcUhA=;
        b=Gn/Lb37fdDbNi4/8BIpc2VZB+Gz5bxsCuAiHsbxwDOzJHy9BOVOlprHYyYTZW1L3KN
         nWqQFyFQ3fDt52KpAvZpwMrXHRIH6cCp083pG5oDKjBP/+aOqAQVvB2FlCLmeEgGWNjT
         y9GiKPVMCD8MdW9cgSfexbaptbpgqeXUpyAKXjrMv+GRt5xhKdWwo1GJy45Ay3kbFBih
         svTaoDu4Hy0jrGhxaHiboQFq83t8TnKxD96Udx6FEby+j7oYoUgGce5nzni0RglvM41a
         MPH/FXZKs0mI1TBmeO0E8me7zeVEw78fMU6IDRrSwIqLDEoO934bVq494Tc/LVgxtp9Q
         Jixg==
X-Gm-Message-State: APjAAAV8O59bpElHMl/USQZKz8tT9yvVlBjW8haRdqXuVg9++3nE8Gzv
        DWMFbvYsWSFdxKaYxAoVjeCZP9qiDc+aYH0zY9A=
X-Google-Smtp-Source: APXvYqzSG2mrUWW6Hafd9DV76w7RqnnyPK6C3OGnCJsL15rcQn6omCyDGT2UeF2lFpORP0KdWzegpco9S2RY4pvl8oI=
X-Received: by 2002:a1f:20f:: with SMTP id 15mr13916301vkc.15.1561379629342;
 Mon, 24 Jun 2019 05:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
In-Reply-To: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jun 2019 06:33:38 -0600
Message-ID: <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
Subject: Re: [BUG] Symbolic links break "git fast-export"?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 5:05 AM Lars Schneider <larsxschneider@gmail.com> wrote:
>
> Hi folks,
>
> Is my understanding correct, that `git fast-export | git fast-import`
> should not modify the repository? If yes, then we might have a bug in
> `git fast-export` if symbolic directory links are removed and converted
> to a real directory.
>
> Consider this test case:
>
>     # Create test repo
>     git init .
>     mkdir foo
>     echo "foo" >foo/baz
>     git add .
>     git commit -m "add foo dir"
>     ln -s foo bar
>     git add .
>     git commit -m "add bar dir as link"
>     rm bar
>     mkdir bar
>     echo "bar" >bar/baz
>     git add .
>     git commit -m "remove link and make bar dir real"
>
>     printf "BEFORE: "
>     git rev-parse HEAD
>
>     # Fast export, import ... that should not change anything!
>     git fast-export --no-data --all --signed-tags=warn-strip \
>         --tag-of-filtered-object=rewrite | git fast-import --force --quiet
>
>     printf "AFTER: "
>
> I would assume that the BEFORE/AFTER hashes match. Unfortunately, with
> Git 2.22.0 they do no. The problem is this export output I think:
>
>     remove link and make bar dir real
>     from :2
>     M 100644 5716ca5987cbf97d6bb54920bea6adde242d87e6 bar/baz
>     D bar
>
> The new file in the `bar` directory is added to the repo first and
> afterwards the path `bar` is deleted. I think that deletes the entire
> directory `bar`?
>
> If you confirm that this is a bug, then I will try to provide a fix.

My first reaction was, "we regressed on this again?", but it looks
like my original fix for directory/file changes only handled one
direction.  Thus, my commit 060df6242281 ("fast-export: Fix output
order of D/F changes", 2010-07-09) probably *caused* this bug.  We
should probably just sort not based on filename, but on changetype --
send all the deletes to fast-import before we send the modifies.

We should probably also make a corresponding improvement to
fast-import; it also makes some attempts to be smart about handling
order of modifies and deletes, but misses this case.  See commit
253fb5f8897d ("fast-import: Improve robustness when D->F changes
provided in wrong order", 2010-07-09).  It'd be nice if fast-import
could go through the list of changes, apply the deletes first, then
the modifies -- although I'm not sure where renames go in the order
off the top of my head.

Thanks for flagging this and working on it.

Elijah

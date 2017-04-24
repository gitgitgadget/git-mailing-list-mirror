Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8E4207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972567AbdDXRkj (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:40:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36325 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938155AbdDXRkh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:40:37 -0400
Received: by mail-pf0-f169.google.com with SMTP id 194so15583482pfv.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=796MabSMJdzTynKGPQOctgwxuNRFBf1NkPKyzJUKVLY=;
        b=VOePuHomA0qpY7zijaxElLA8uv8OjW9Jl8FNSzQlQ9f++wgUjvIGoEMelboLisdpK9
         j+CSWQI5nqZmEH84ZVtrcu6ocixzQ2H8kLXxRocejMZRaFVD0xDG7/4eG8N42bsmQDYk
         327t6aU7uSXkvNy1+KscWiUoIuF2HbRcgKULVwjSPA6+XvVCeedH6su9rzTsthPGgBvw
         mRNlxFqyMGHe99g0CYNMz5/XoibNIoyVzmPyK1r53Z3iO99CY2hBlvYGm0FexGNN9ije
         SWNfpF8+1ZaD3dOeBpbKNsIYvJYs6gl/vPQC18LKAenRnhQKX2V/q0tHVStfZvqfWlhs
         84PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=796MabSMJdzTynKGPQOctgwxuNRFBf1NkPKyzJUKVLY=;
        b=lAhN0pSXXhT9hP2/AKQSS/lNJlKTirXTdXH7c50KqSQ8LVRWjdcfrK2CrOModYhzNh
         83sOaF59TGz3u1SNjZal1/j64NUmj9jZXyAsAsLyg1Wmby4XWkkafQUMX/ZN3ylmJhij
         tqL1ErhTpZKxtOVtU7rcfImjesiFHCigMTtujYGfJZSaV4VXPaZqNLQ3061Ku/UgoZi0
         2AyBp8RT5UN5vUjM0C5qQ9v5pX31TPLKo447WCiN31hI/rtGjTs4f4rQejkwS8U0J1Lz
         bigrIlb8yNr0yH5PNT2hLeptbgi4jZk+XYPewDuZQQg3ktwUCZZ3eIq5egASbJr50F6W
         e6jw==
X-Gm-Message-State: AN3rC/4aPo014Ki6h93QOdCRag9vEsgSfVHlCyFvRzmw3sDp8v6yf5o/
        wNjkueVBB6DCozRhcc9AD271XYgqmout
X-Received: by 10.84.222.134 with SMTP id x6mr34573036pls.52.1493055636415;
 Mon, 24 Apr 2017 10:40:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 10:40:36 -0700 (PDT)
In-Reply-To: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 10:40:36 -0700
Message-ID: <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
Subject: Re: Submodule/contents conflict
To:     Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 1:06 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> Hi,
>
> I've noticed a strange behavior with submodule/content conflict. My
> current Git version is 2.12.2, but the problem exists since I
> remember.
>
> Branch A has a submodule.
> In branch B which diverged from A, I replaced the submodule with its contents.
>
> Now, every time I merge A into B, and A had changed the submodule
> reference, all the files inside the ex-submodule directory in B are
> being "re-added".
>
> Moreover, aborting the merge prints an error, but seems to work
> nevertheless, and if I run git reset --hard all the files in that
> directory are actually written to the disk, even though they haven't
> changed at all.
>
> When the submodule is small, it might be ok. But in my project we have
> a huge submodule with ~16K files, and on each merge all the files are
> listed, and even mixed reset takes several minutes.
>

A similar bug report
https://public-inbox.org/git/CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com/

"checkout --recurse-submodules" (as mentioned in that report)
made it into Git by now, but this bug goes unfixed, still.

> The following script demonstrates this:
> #!/bin/sh
>
> rm -rf super sub
> mkdir sub
> cd sub
> git init
> touch foo
> git add foo
> git commit -m 'Initial commit'
> mkdir ../super; cd ../super
> git init
> git submodule add ../sub
> touch foo; git add foo sub
> git commit -m 'Initial commit'
> git checkout -b update-sub
> git update-index --cacheinfo 160000,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,sub
> git commit -m 'Update submodule'
> git checkout -b remove-sub HEAD^
> git rm sub
> mkdir sub
> touch sub/foo sub/bar
> git add sub
> git commit -m 'Replaced submodule with contents'
> git checkout -b remove-2 HEAD^
> git merge --no-ff remove-sub
> git merge update-sub
> # Adding sub/foo
> # Adding sub/bar
> # CONFLICT (modify/delete): sub deleted in HEAD and modified in
> update-sub. Version update-sub of sub left in tree at sub~update-sub.
> # Automatic merge failed; fix conflicts and then commit the result.
> git merge --abort
> # error: 'sub' appears as both a file and as a directory
> # error: sub: cannot drop to stage #0
>
> - Orgad

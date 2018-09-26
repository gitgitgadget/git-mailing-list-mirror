Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59E61F453
	for <e@80x24.org>; Wed, 26 Sep 2018 20:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeI0DLa (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:11:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45588 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeI0DLa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:11:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id h6-v6so1643073eds.12
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ypoeDjrPKdNb7BVZG4i/ggrJ7f8mxWuvDCtloZwRIW4=;
        b=c7lA/PVRjKvUaUICLQxJ57S1IZSBGRKOcIRgJGrmypwIqOaBQ8wiJuipEtbEHYwueg
         mSZsH05KPA6b6LkQHdlbLMLQIVXFPCJCeQMJLChiCibMfPvhBCPqGTSY8HRRK2u55vWS
         HluLx3x1OjHzK8nR6ptGPQkeNKYf1aO6r1R6NMslTlQwDaBNky7/xbuRfeDxTWLb9X7d
         qnnCeq9WbezFmkBa2+PijS+q1uxaR+Wel8yMx/QsgpMhh88crozG42RNSBy+Z5b+2YPQ
         qX+faB6iHs9slVPCsPNoQH0zXjSRufwFQyHu52AubDHu5AzrdnYXj6NNHGUplrUnlRYc
         ozhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ypoeDjrPKdNb7BVZG4i/ggrJ7f8mxWuvDCtloZwRIW4=;
        b=A+5VE6SgEt0uKio2BgQGubBOFDfdrJTZgWc6WXWKGg8WaRsoUNQFKvKT+X9wiswMcl
         eX9ZLak+ozVVum+VqM3S4U6S8adWFftg1q0eyyedknPJQkxmKcKwKD2476D7DBYjf+KF
         xoyDy8Hp3IUflNfUGO0cSKDcJpHDsIleI0QG7Bi2Kbp9opuqAJ9pKTU5V8hn/GMKxMb4
         2FAemLmIGnmJ6j8lnxw1ONi9+I7CMnBWuI8jCZeD8bcwYS8G2gkew/tX2ZyAFKH5OHcL
         su6B4JCACmlmbDN8lRw/9rjS+hrMBDfmWT8kAhlm4ADuRBOHO85mWsuulhxC6JV2hvL3
         Atfg==
X-Gm-Message-State: ABuFfog8WFAKLi4EbMyXgtNM8YU7sTKe/RMq+c1Fzei19hpm96cHctXA
        eyeZL89j8jj8PG+Sk6qq85w=
X-Google-Smtp-Source: ACcGV62VDgt7dI2rF34Z09lKRiBNwLLDVsM1FEbo0xHQKpjUBOkVLv3odCqTVavXDuLXGRkz5rKxeg==
X-Received: by 2002:a50:97c8:: with SMTP id f8-v6mr12589159edb.243.1537995401743;
        Wed, 26 Sep 2018 13:56:41 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id h19-v6sm175240edq.23.2018.09.26.13.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:56:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrea Stacchiotti <andreastacchiotti@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Triggering "BUG: wt-status.c:476: multiple renames on the same target? how?"
References: <3c11c193-a978-69be-4b8e-4b59b270338e@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <3c11c193-a978-69be-4b8e-4b59b270338e@gmail.com>
Date:   Wed, 26 Sep 2018 22:56:40 +0200
Message-ID: <877ej8j7uf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 26 2018, Andrea Stacchiotti wrote:

> Dear maintainer(s),
>
> the following script, when executed with git 2.19 triggers the bug in
> the subject line.
> The problem seems to be the interaction between add -N and rename detection.
>
> The git binary used is the one currently packaged in Debian unstable.
>
> I have searched the list for the bug text and have found nothing,
> apologies if the bug is already known.
>
> System information, script content and script output follow.
>
> Andrea Stacchiotti
>
> --------------------------
>
> andreas@trelitri:/tmp$ uname -a
> Linux trelitri 4.17.0-3-amd64 #1 SMP Debian 4.17.17-1 (2018-08-18)
> x86_64 GNU/Linux
> andreas@trelitri:/tmp$ git --version
> git version 2.19.0
>
> andreas@trelitri:/tmp$ cat bugscript.sh
> # Make a test repo
> git init testrepo
> cd testrepo
> git config user.name A
> git config user.email B
>
> # Add a file called orig
> echo 'a' > orig
> git add orig
> git commit -m'orig'
>
> # Copy orig in new and modify orig
> cp orig new
> echo 'b' > orig
>
> # add -N and then commit trigger the bug
> git add -N new
> git commit
>
> # Cleanup
> cd ..
> rm -rf testrepo
>
> andreas@trelitri:/tmp$ LANG=C ./bugscript.sh
> Initialized empty Git repository in /tmp/testrepo/.git/
> [master (root-commit) 5dedf30] orig
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 orig
> BUG: wt-status.c:476: multiple renames on the same target? how?
> ./bugscript.sh: line 18: 22762 Aborted                 git commit

I can't reproduce this on Debian AMD64 either 2.19.0 in unstable, or
2.19.0.605.g01d371f741 in experimental. I tried moving my ~/.gitconfig
out of the way, do you have some config options there that might be
contributing to this?

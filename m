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
	by dcvr.yhbt.net (Postfix) with ESMTP id 678701F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 20:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440308AbfJRUY0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 16:24:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45525 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfJRUY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 16:24:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so2553202wrs.12
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j8GQyJeD1Vw6MAnrOFlcbiHwU2froWokmqzgFFcVv3U=;
        b=mLYIQVLRPtGM7a7SLneWfEWdxm99Sm3fZkQngEYy3Fa1QYfPye4nXwYmP+VuS/JcE9
         3GPtvdfmSa1IYnveVh81Qa4Bqs09VxV4iVyOSklNLRQCykdKrmK/NdC4tS290ePk/pVh
         Q8pg+v28zUcSxD4hG7ON2VhVopALr2BSXxV86qUUzGXRkPSbJFgGcqMq4cu4I7K7pizE
         kAcruT+0TABo9agdyRTwd4P8VqrX17qJsOT9cWgoe3hEH7Ap0lGETQLfphuQLSh6fa77
         DxuvPnqaeWMYExUEbEQfDNBFA49pho1z+iyzcUMU4+tfRwVWYDFpymh8ceiA/7W6nPBh
         5Sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j8GQyJeD1Vw6MAnrOFlcbiHwU2froWokmqzgFFcVv3U=;
        b=V99kt8LYYNIACR8LW/B0/fu6/XIAwbYZ6W1wOlEeec8hKai1JCixJoQsvsBniTOSzO
         eF8UXpvt3XD9B00wDD3SWp7ghar9tFbzPYyunbVdhYCdy7SMe0lKH0clRw8is2o/x5FR
         PCCYkBb+YWq+eKV2Lrj17l6iR/aQy/jzekvai8zWVmhVWf5DB+MhnWs+W1/oUYlGtXRQ
         ttdAhR8Lnf9LAx2dLwmWcW2NPj6A9RQG5e1EnNGrhLCHFiBMkvoAGsrDAON9cL/Fa1wo
         LJnyBgPX6zklx6kw3t63Y8tNwxj1rfokwe0Tm7OqwRAzqS7pEGIXlGbPL+1YqqGC4MVj
         X4hQ==
X-Gm-Message-State: APjAAAX/hFkb6qZnKRc94E1yy+9Ih3hRLJV9/DTeivPBbllpzF4Af/22
        br3JUhzg0eUfTgHGYOxwn6o=
X-Google-Smtp-Source: APXvYqw2qDU6xSlb7wGbuNPSPTOSuJwMji9PVT01GVafyTng6SpydbjXZqz4bjU9N5c7oKNPsJOLhg==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr1738676wru.162.1571430264500;
        Fri, 18 Oct 2019 13:24:24 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id n17sm5789645wrp.37.2019.10.18.13.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 13:24:23 -0700 (PDT)
Date:   Fri, 18 Oct 2019 22:24:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/17] sparse-checkout: update working directory
 in-process
Message-ID: <20191018202421.GJ29845@szeder.dev>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <9ccec3ca9a1efe038da6d69f076f32cc407bcf9f.1571147765.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ccec3ca9a1efe038da6d69f076f32cc407bcf9f.1571147765.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 01:56:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The sparse-checkout builtin used 'git read-tree -mu HEAD' to update the
> skip-worktree bits in the index and to update the working directory.
> This extra process is overly complex, and prone to failure. It also
> requires that we write our changes to the sparse-checkout file before
> trying to update the index.
> 
> Remove this extra process call by creating a direct call to
> unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
> addition, provide an in-memory list of patterns so we can avoid
> reading from the sparse-checkout file. This allows us to test a
> proposed change to the file before writing to it.

Starting with this patch there is an issue with locking the index:

  $ git init
  Initialized empty Git repository in /home/szeder/src/git/tmp/SC/.git/
  $ >file
  $ git commit -m initial
  [master (root-commit) 5d80b9c] initial
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 file
  $ ls .git/index.lock
  ls: cannot access '.git/index.lock': No such file or directory
  $ git sparse-checkout set nope
  warning: core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect
  warning: run 'git sparse-checkout init' to enable the sparse-checkout feature
  error: Sparse checkout leaves no entry on working directory
  fatal: Unable to create '/home/szeder/src/git/tmp/SC/.git/index.lock':
  File exists.

  Another git process seems to be running in this repository, e.g.
  an editor opened by 'git commit'. Please make sure all processes
  are terminated then try again. If it still fails, a git process
  may have crashed in this repository earlier:
  remove the file manually to continue.
  $ ls .git/index.lock
  ls: cannot access '.git/index.lock': No such file or directory


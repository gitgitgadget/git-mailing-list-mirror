Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC6420248
	for <e@80x24.org>; Thu, 28 Mar 2019 22:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfC1WKx (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 18:10:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfC1WKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 18:10:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so8287032wmi.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zDKr8jOV+cXzfQwwO2be8xxzh6Z9SSRpvtZAT56AiLE=;
        b=ZsM4YttdCUH8Xe9KWPv08+M59dWIgS6ydjVcYGbuRItNHEk+e9c9ByQUQ3ctG4iuty
         rSgc5oqYYBpw0hGKMakhZFAXaz4SfYIrevMh+zXez/E5dVyr8894iLdYU3Uo/DPLDLUW
         gHjENMqIpxQDOWSod+dIg2NfDIETq1JoKLIeD0+e644tFawNsrUZfc3ast3VYsw+4Eql
         hnv8e7y9t5aym9IluUQ5tFPhENUOTB37D2OWTD/TnqpUhTMMg0E66vXOKwCdn4v/LwfP
         e9+TzgUfA6LGrPfJSvZOG3gX5fB0qUHEQR2Ys8lDaIGXIjxeKP9Uq8l8L2pCSDyQmQ+p
         HNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zDKr8jOV+cXzfQwwO2be8xxzh6Z9SSRpvtZAT56AiLE=;
        b=od/q1IZv/0mtzuEhQi4rfAh16+ylnAQqeyKfwYGZx1ogChhTfRf96n7QShbgVxlwtt
         MypdPFwVNI4OQUfA+u1kQD/SaQKLDrf/0/H+vWRylpoV5mG2M9mYxIRvXDV6ww0B45Ad
         QGvp+WXCT7dz+UwvdxYirh3pbhZ0Ia2nIkPOacudohR+gErDdgx4NajEfnzDIVkSqP6T
         PjuWAXFS1vjBdsFm5tRdVaB1FCVhhGl+QnjSk3AX0vIVn+Q8XnZzY/pzMlBTVItHD1yL
         pHJeYxK8k6KUAEHJtHnmydspoR8Ae1cCrB5WPHokghfFW5X311m/56TiFDGJNodI499Z
         7ftg==
X-Gm-Message-State: APjAAAUv9ITxfnF0Nqla20H0I2evHadxZHzRAEif3z4Pja9FPMXq5cBF
        gCy3fWPjE0clZn+mqiC6iztcjvH2
X-Google-Smtp-Source: APXvYqwrrjpU8i4wN177GgkUzVVGcSlAixFtoNl9dynE18gd5HLUY3FANRMEsGg8YYRCl1ctLiXmqg==
X-Received: by 2002:a1c:80cd:: with SMTP id b196mr1424847wmd.84.1553811051789;
        Thu, 28 Mar 2019 15:10:51 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id 4sm406721wmi.14.2019.03.28.15.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 15:10:50 -0700 (PDT)
Date:   Thu, 28 Mar 2019 22:10:49 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at
 .git/objects/
Message-ID: <20190328221049.GK32487@hank.intra.tgummerer.com>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-3-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322232237.13293-3-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/22, Matheus Tavares wrote:
> There is currently an odd behaviour when locally clonning a repository
> with symlinks at .git/objects: using --no-hardlinks all symlinks are
> dereferenced but without it Git will try to hardlink the files with the
> link() function, which has an OS-specific behaviour on symlinks. On OSX
> and NetBSD, it creates a hardlink to the file pointed by the symlink
> whilst on GNU/Linux, it creates a hardlink to the symlink itself.
> 
> On Manjaro GNU/Linux:
>     $ touch a
>     $ ln -s a b
>     $ link b c
>     $ ls -li a b c
>     155 [...] a
>     156 [...] b -> a
>     156 [...] c -> a
> 
> But on NetBSD:
>     $ ls -li a b c
>     2609160 [...] a
>     2609164 [...] b -> a
>     2609160 [...] c
> 
> It's not good to have the result of a local clone to be OS-dependent and
> since the behaviour on GNU/Linux may result in broken symlinks, let's
> re-implement it with linkat() instead of link() using a flag to always
> follow symlinks and make the hardlink be to the pointed file. With this,
> besides standardizing the behaviour, no broken symlinks will be
> produced. Also, add tests for symlinked files at .git/objects/.
> 
> Note: Git won't create symlinks at .git/objects itself, but it's better
> to handle this case and be friendly with users who manually create them.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/clone.c            |  2 +-
>  t/t5604-clone-reference.sh | 26 +++++++++++++++++++-------
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 50bde99618..b76f33c635 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -443,7 +443,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		if (unlink(dest->buf) && errno != ENOENT)
>  			die_errno(_("failed to unlink '%s'"), dest->buf);
>  		if (!option_no_hardlinks) {
> -			if (!link(src->buf, dest->buf))
> +			if (!linkat(AT_FDCWD, src->buf, AT_FDCWD, dest->buf, AT_SYMLINK_FOLLOW))

This line is starting to get a bit long, might be worth breaking it up
to keep to 80 characters per line.

I notice that we are currently not using 'linkat()' anywhere else in
our codebase.  It looks like it has been introduced in POSIX.1-2008,
which sounds fairly recent by git's standards.  So I wonder if this is
really supported on all platforms that git is being built on.

I also wonder what would need to be done on Windows if we were to
introduce this.  I see we define the 'link()' function in
'compat/mingw.c' for that currently, so I guess something similar
would be needed for 'linkat()'.  I added Dscho to Cc for Windows
expertise.

While I agree with the goal of consistency accross all platforms here,
I don't know if it's actually worth going through the pain of doing
that, especially for somewhat of an edge case in local clones.

If the test in the previous patch passes on all platforms, I'd be okay
with just calling the behaviour here undefined, especially as git
would never actually create symlinks in the .git/objects directory.

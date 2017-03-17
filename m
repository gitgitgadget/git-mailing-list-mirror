Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E5F20951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdCQVyr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:54:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34696 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdCQVyr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:54:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so9885767pfb.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n6L8qWjLAk6VStprTj14VczDFP4biPN0QqGv8W1U0k0=;
        b=D5BoPIkQkTgWIsIlWypDKyaxYP1CreDQB249mTWcop1VlP9sePdOuBfsKSkxRbT/sI
         QhtJybTP3z8S10QkA8t9z0myggQecnqMvcnBsYptrrt4jG8nCscOl9ItoKiHgpo+kl45
         EuazfZORbR6fbjMjuMYXSElbuzyjBH4iaS2lcJa52Dca8jDEU44W2wjMjf5zE9VjMKIt
         qKYVXxj9yxVf4Ubih8LDO8KvywURpBM2HhfErDLFp1iuSqZPAFOgdQl2BpVor0ep2oeJ
         7vGvdtOuDTgCdYUaOpUj8swHYLLULVquRjv8uPG8YDdFaVsWkAf+8w1nLqaSrj+EZEkO
         XW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6L8qWjLAk6VStprTj14VczDFP4biPN0QqGv8W1U0k0=;
        b=D6kGz8d2ILkjhtYC1BQnwXOjZcyQKreHDIBWQLlXkynxx/ksHQy+bLp1S2GDj4pCuH
         N6Uc69u5LiJ5K5jCcDkDWnIol+GIPhRsmkATghmf+mo5ge6qrqESo76gbBfvlb/OO/fi
         PkxJbbj7CAS8Ww6jdjFULV6PTJ1Z3/JtuWr5YqzzjcSU9uHV4Q132sU5KjSE9Z8us+1p
         AGjWa+GinhDIGtUXZtZy/teT/EkD2Eq5BOMIAoynElh0FKOlF/3LXUuAquSe/K+tK34R
         JXbtHzTh6qtp3YbGaFG+UWUSXMtdS6FKEsAF4EVttOJT6hCcOQv10qiHWNL1vbbwgJ3m
         mwOQ==
X-Gm-Message-State: AFeK/H0u9OquAfzepJF+UrYRmDYNDwGny+whvsLyRVK7Nx3JNz/NoT5aOayFkVLdWrAHgw==
X-Received: by 10.98.84.67 with SMTP id i64mr19386549pfb.44.1489787685515;
        Fri, 17 Mar 2017 14:54:45 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id w14sm18737502pgo.37.2017.03.17.14.54.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 14:54:44 -0700 (PDT)
Date:   Fri, 17 Mar 2017 14:54:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Nevada Sanchez <sanchez.nevada@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with .gitignore and branch switching
Message-ID: <20170317215442.GN26789@aiede.mtv.corp.google.com>
References: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nevada,

Nevada Sanchez wrote:

> # Commit a file that will end up in .gitignore
> echo 'original settings' > mine.conf
> git add mine.conf
> git commit -m "Unknowingly committed my settings."
>
> echo '*.conf' > .gitignore
> git add .gitignore
> git commit -m "Users shouldn't commit their settings"

Naming a file in .gitignore tells git that you do not want to track it
and are giving git permission to write over it.  This commonly happens
when people check in build products.  For example:

	git rm -f my-build-product
	echo /my-build-product >>.gitignore
	git commit -m "Remove generated my-build-product file"
	make my-build-product

	git checkout HEAD^

Without that rule, this 'git checkout' command would fail.

That said, there are some cases (e.g. the .conf file case you mention)
where a person would want git not to track a file but do not want to
give git permission to write over it.  As you've seen, .gitignore does
not work well for this. :/

Ideas for next steps:

 1. The gitignore(5) manpage does not do a good job of emphasizing
    that files named there are not precious and can be overwritten by
    git.  Do you have ideas for wording that would help with that?
    This would be especially welcome if you can phrase them in the
    form of a patch against Documentation/gitignore.txt.

 2. Occasionally people have mentioned the idea of a .gitprecious file
    listing precious files that git should not track and not overwrite
    (e.g., keys and other configuration files, IDE state, or metadata
    for another version control system being used in parallel).  Would
    you be interested in working on that?

Thanks and hope that helps,
Jonathan

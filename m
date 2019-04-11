Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3197D20248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDKUvw (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:51:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52223 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfDKUvv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:51:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so8446647wmf.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MLfHmC/veTXpsUG7mNwcsexAK+kcFTd46zXg2aDdMbU=;
        b=goyEkdyjzTx9/J/6JqiVchtHtSgJCTQuGzqfuVyDt0G9eFCHuZk3hr6G3STWh+etsK
         e2KexDiLSSXsqtHLWzcXvIj0aObqgia0M7ZJRh89yJY7h4IMHws+YG7Z6DQDrwzgUEMR
         ZnnlclU/N2ajpT8jQY6CxlBlJC1QvHLZGbf/KRNGXqKMnNGRI7WsdqE3DAWlBH+0DvEY
         YxPuYgdWPXn2ATj3vhfQA8IJ1Y+tEw1x/+TlUhWw7OuSKbFSC+uWQguqGVasNK2iXUia
         Nt7o1zmVGn28xtSKbn7kci0qcKf+TiWrAPzdstwtV9cY3k/ZtBMyAiZeigwLnxJS6NMu
         bVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MLfHmC/veTXpsUG7mNwcsexAK+kcFTd46zXg2aDdMbU=;
        b=VZx+aN62oN5iMujs6uzasV4b0zX1FuK6wmmB6SzWDsAU42XD4yAXw1lVbXmuplMCA+
         P1ocYKrmzaDJ1TScIkKDZzty52dGKD5dw74ZbAKZ59VsFsDQkj6I4uea7fqnghFyetZg
         dFxJYNuxIXmOjdXe/cX8m3nq+EYdMf1FxpLw7bU42vO1jiQvtWcSs2qU04PEnNlHteSz
         m6z6uQeZNZzqQP7rDfDCsHqAuKAuOEWZ1xITojiiP9ntMEte5L1pKjrqKmF2UUOYcaC+
         DcM141crAc1crw+Vt5pkae1F7KC2pZhF6uhwLhmdw9FTBt5JBjLDCzOQNnuE9Mzhbucd
         t7sg==
X-Gm-Message-State: APjAAAW9uWQifsenVIz7ZgbPEYPD1rDjlSTHX0rp0NB2FxCerDdBUp9U
        fbEKcnSFiZdqbj5ppQECliQ=
X-Google-Smtp-Source: APXvYqyxLcE+F1SaVrlJoVVJvVib0tqm6yN4dN03N/ddqMXd0Bazlo2+6Mip+6AYb36YJnKEMjQQCg==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr8452806wmj.22.1555015909960;
        Thu, 11 Apr 2019 13:51:49 -0700 (PDT)
Received: from szeder.dev (x4d0c7202.dyn.telefonica.de. [77.12.114.2])
        by smtp.gmail.com with ESMTPSA id k4sm57725264wro.33.2019.04.11.13.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:51:49 -0700 (PDT)
Date:   Thu, 11 Apr 2019 22:51:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
Message-ID: <20190411205146.GK8796@szeder.dev>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 10:56:52PM +0200, Johannes Schindelin wrote:
> Hi Duy,
> 
> On Sat, 6 Apr 2019, Nguyễn Thái Ngọc Duy wrote:
> 
> > 10:  68876a150f ! 11:  848456f59c commit.c: add repo_get_commit_tree()
> >     @@ -2,6 +2,11 @@
> >
> >          commit.c: add repo_get_commit_tree()
> >
> >     +    Remove the implicit dependency on the_repository in this function.
> >     +    It will be used in sha1-name.c functions when they are updated to take
> >     +    any 'struct repository'. get_commit_tree() remains as a compat wrapper,
> >     +    to be slowly replaced later.
> >     +
> >       diff --git a/commit.c b/commit.c
> >       --- a/commit.c
> >       +++ b/commit.c
> >     @@ -29,6 +34,15 @@
> >       --- a/commit.h
> >       +++ b/commit.h
> >      @@
> >     +
> >     + 	/*
> >     + 	 * If the commit is loaded from the commit-graph file, then this
> >     +-	 * member may be NULL. Only access it through get_commit_tree()
> >     ++	 * member may be NULL. Only access it through repo_get_commit_tree()
> >     + 	 * or get_commit_tree_oid().
> >     + 	 */
> >     + 	struct tree *maybe_tree;
> >     +@@
> >        */
> >       void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
> >
> >     @@ -57,3 +71,10 @@
> >         ...>}
> >
> >       @@
> >     + expression c;
> >     ++expression r;
> >     + expression s;
> >     + @@
> >     +-- get_commit_tree(c) = s
> >     ++- repo_get_commit_tree(r, c) = s
> >     + + c->maybe_tree = s
> 
> I think this is wrong, and admittedly I had the very same version
> originally.
> 
> When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)` (as
> opposed to `the_repository`), the conversion to `c->maybe_tree` is most
> likely incorrect.
> 
> Therefore, I don't think that we can do that.

So, as far as I understand, the goal of these 'c->maybe_tree'-related
semantic patches is to prevent "generic" parts of Git from accessing
this field directly, as it might not be initialized in a
commit-graph-enabled repository.

Only three functions are explicitly exempt, while this last semantic
patch in question implicitly allows a few more that assign a value to
'c->maybe_tree'.  These functions are release_commit_memory() and
parse_commit_buffer() in 'commit.c' and fill_commit_in_graph() in
'commit-graph.c', and after a quick look these functions seem to be
rather fundamenal in the life-cycle of a commit object.

I think they deserve to be explicitly exempted, too, and then we could
remove this last semantic patch altogether.



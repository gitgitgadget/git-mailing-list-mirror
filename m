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
	by dcvr.yhbt.net (Postfix) with ESMTP id D53BC20248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDKU7B (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:59:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43609 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKU7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:59:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so4461207wrx.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pW/kd9qr4OVDi4f8hxo/R3TyvhML5tm5cRLGIy3O2Oo=;
        b=J1DJZBYP6lqeOAF5xp0i1igpo8nuuvftSJlFa9u1mKkGZ3/9FubXLfaSJMYTcD41io
         Qql3Yidf4syGGPNxvrjxTFuCfwtxR8K9gm+S+KHkr644gpbyhp/Z2VvKn4EwxYkoMt0f
         2abiSUJMqKa3sm+cwAbeTBtgCPLluRmRaf6TbUVf+0iFwGeiocyVPQ6U/Dg0cm1yvCgY
         tHw5MAlF2oFOKnR09Y6bLNbZTUWLPmSGSjEhEMx/SBTMjp4osRpxrVblJEkby8QmQYLE
         T98G2KDf5TpFhvA0pknf1iuiiPzwOk7g3F+BpU2woNk8l+IOrGr+tdWT4QHN7rZxdoK3
         gTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pW/kd9qr4OVDi4f8hxo/R3TyvhML5tm5cRLGIy3O2Oo=;
        b=pozEs/LmC5aouXIaxEvk6TQkRB//QTeang7NZmmJQzepVLhknAocqIrohdjnp5PLei
         iak6dKDxGfd1Cql1TYLkNAN1l/gdqx5jq9A5YCFYejMiyUEXZ974XxRDOtFKuRUhnPMx
         VKCdI5z26xxMZnQj1Mja3PrnGAv+JnXbE9UFs3wZQI5Q+yQuCIgdVNprp6Fqh1vVtP3K
         It8/4PT9r7pFSI8CiboDLrM4A56VZCEFWwGvHf9cLLZnyQD5+p9vfUBmpGw/YpviqhcT
         dC6spdHfxVhRkuf10LId7/v+zGxBoozzz7aufAimzQT47lfDCr9JshWTeeRmSq2/TTNw
         m0JQ==
X-Gm-Message-State: APjAAAWZoe4BKTccsdjf02Om0QJQ/9Qevlf+aF9HILHYCQDDXJrJSXc6
        vOCyDGIu7H5+famLCXOWQ8M=
X-Google-Smtp-Source: APXvYqxA/o43lkSczS78+lZUaP2Ia4vR2oPYVjQlIcXBTvByRIP5wsgAOuflE4VHdkuUEp8XgWpYFQ==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr23123047wrn.270.1555016339769;
        Thu, 11 Apr 2019 13:58:59 -0700 (PDT)
Received: from szeder.dev (x4d0c7202.dyn.telefonica.de. [77.12.114.2])
        by smtp.gmail.com with ESMTPSA id b3sm40554803wrx.57.2019.04.11.13.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:58:58 -0700 (PDT)
Date:   Thu, 11 Apr 2019 22:58:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
Message-ID: <20190411205857.GL8796@szeder.dev>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
 <20190411205146.GK8796@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411205146.GK8796@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 10:51:46PM +0200, SZEDER Gábor wrote:
> On Wed, Apr 10, 2019 at 10:56:52PM +0200, Johannes Schindelin wrote:
> > >         ...>}
> > >
> > >       @@
> > >     + expression c;
> > >     ++expression r;
> > >     + expression s;
> > >     + @@
> > >     +-- get_commit_tree(c) = s
> > >     ++- repo_get_commit_tree(r, c) = s
> > >     + + c->maybe_tree = s
> > 
> > I think this is wrong, and admittedly I had the very same version
> > originally.
> > 
> > When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)` (as
> > opposed to `the_repository`), the conversion to `c->maybe_tree` is most
> > likely incorrect.
> > 
> > Therefore, I don't think that we can do that.
> 
> So, as far as I understand, the goal of these 'c->maybe_tree'-related
> semantic patches is to prevent "generic" parts of Git from accessing
> this field directly, as it might not be initialized in a
> commit-graph-enabled repository.
> 
> Only three functions are explicitly exempt, while this last semantic
> patch in question implicitly allows a few more that assign a value to
> 'c->maybe_tree'.  These functions are release_commit_memory() and
> parse_commit_buffer() in 'commit.c' and fill_commit_in_graph() in
> 'commit-graph.c', and after a quick look these functions seem to be
> rather fundamenal in the life-cycle of a commit object.

Erm, not "commit object"; I meant the life-cycle of a 'struct commit'
instance.

> I think they deserve to be explicitly exempted, too, and then we could
> remove this last semantic patch altogether.
> 
> 

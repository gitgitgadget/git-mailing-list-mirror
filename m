Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B951F829
	for <e@80x24.org>; Wed,  3 May 2017 17:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbdECREG (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 13:04:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33060 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdECREE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 13:04:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id b23so5119576pfc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOq/RvuwB0AUlS/dXOgfuFI72gACTQLj3zW3uSOAcjY=;
        b=stS+pxExeq7u4MYw5HB7/BfH/4bY11FNpCrt3qoJK2sZRf918v2jIs1kfVJC3qyPYN
         xd0qnmlhtYmRIHg7uqPaWWeMTvb5Idpp9ppkAMSpMQMlBjj7IPIitpDQ3FtXDWl8PInG
         DGEkZt5BMHk51vOHl8u+rE0hprn67Mc/ktEsQ583iL/BCQJGT35vbPrFHVofatseH2hP
         YBWjRH9boGdyQmZdXidxluZNOwCRDe2vw/0ssZSZDMPVcNvm2z2h9tHyKNv6YeFj6TLD
         YLsoeOcmT9icr68Smt945HHI51xo3hMv0kpX5k4EJu3dp/I8DafkfNofNePBRH9Hjtaz
         N+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOq/RvuwB0AUlS/dXOgfuFI72gACTQLj3zW3uSOAcjY=;
        b=IYcgkPnUwmVnyohBvMCwIO9N7vIBtsFJfy5cHaeRtXk7u8cL050n4D5Qar69+Q/Zcs
         Ff2GFgTZ+8FAuTZi2A0b9JJDCQoi60jw4b4gIzN8c9iptyFH1wRxP9GdDLRUA1c1O/7X
         2rretMvuwbFGh08Zn4SQd+QxE9qIWGXeaQaNT6/Hx549kIMk3BVZOXjZq+vEOa9fhxgD
         XFFUWCqeGZKiyznXyypPmaw2+XoyCctN0EVHsFeLOJl4D8hEhyjeHMW7gEfbiSIRokj0
         eH4fEjca0lNkaOHAtFUXEgI5QFcpurlkROloRB/009B2NqbElwPSEarynA0Sq/MkDtzP
         h8cQ==
X-Gm-Message-State: AN3rC/6dmGZHxWClGWHzuVugC4qIJk5DuVvZDzZsAYSQrtq8QRbry5cE
        J/ZAOORQ8VOeEEydMLs=
X-Received: by 10.98.71.214 with SMTP id p83mr3403596pfi.236.1493831043670;
        Wed, 03 May 2017 10:04:03 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id c77sm5059914pfe.37.2017.05.03.10.04.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 10:04:03 -0700 (PDT)
Date:   Wed, 3 May 2017 10:04:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] read-tree.c: rework UI when merging no trees
Message-ID: <20170503170401.GA28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170503162931.30721-3-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503162931.30721-3-jn.avila@free.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jean-Noel Avila wrote:

> Subject: read-tree.c: rework UI when merging no trees

nit: this is about user-facing behavior, not an implementation detail,
so the part before the colon can be the command that changed
(read-tree:).

nit: the word "rework" is dangerous in a commit message in the same
way as the word "fix" --- it stands for "make better", in a vague way
that leaves the reader guessing about how.  Usually a more specific
description can work better.

> The initial test was inherited from a previous commit, but it is no
> longer needed, given the following switch case. Moreover, the question
> sentence ending the program has been replace by an assertative one.
> 
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>

This can have a simpler, short-and-sweet motivation:

	read-tree -m: make error message for merging 0 trees less smart-alecky

	"git read-tree -m" requires a tree argument to name the tree to be
	merged in.  Git uses a cutesy error message to say so and why:

		$ git read-tree -m
		warning: read-tree: emptying the index with no arguments is deprecated; use --empty
		fatal: just how do you expect me to merge 0 trees?
		$ git read-tree -m --empty
		fatal: just how do you expect me to merge 0 trees?

	When lucky, that could produce an ah-hah moment for the user, but it's
	more likely to irritate and distract them.

	Instead, tell the user plainly that the tree argument is required. Also
	document this requirement in the git-read-tree(1) manpage where there is
	room to explain it in a more straightforward way.

Unfortunately both 'git read-tree -h' and 'git read-tree --help' say nothing about
this.  Ideas for wording there?

Thanks and hope that helps,
Jonathan

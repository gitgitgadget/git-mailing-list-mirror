Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293EB2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932168AbdCTT6Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:58:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36621 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756012AbdCTT6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:58:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so13646816pgh.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bh8gJtZrtDRYEA3XratxZPdxU93LHp55hxA+uIndAXQ=;
        b=h21Q4zEw2VQQSjo69rLMw+kjcrAfQGY7CwhRkm66u2o1TVfrhGSGU3q8zUZc0pZxI4
         ZqHqRtYvTQn2h+bWZV0zXymVKzMJ7eCB+j4Rf7z5vE0QAyrZudSOFil5ywE1vNvXE8OT
         6nrUUhMUm7iQ2yqmubfURKW5QtUTycIdGzYoeQOLDzW2NkJN1pWD/Ja7hVbpMMdF1BW1
         tmGv7ScGCcs4R4nBL07xWZaTs4sRMWmrDuzR8RmlyCmuSexhF/iOIrUTv2oKXqaX94yk
         VwUG9BNkiIHpkCw4laaXa9YGyKAnJogao/BwBQj45lqZCRScnmliQdrdQNwcMS12yGN1
         tslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bh8gJtZrtDRYEA3XratxZPdxU93LHp55hxA+uIndAXQ=;
        b=bU2KKCniltV5OniMETykHS5ELecXkp5xXac0c28SkXztf54VE1Nx+bCadCiOacsVOv
         MdZBMIYjT1gDJ+MKzAGmbn9/5ZfVeJxe/FxC2zE4aFLgDYzWWWJoWDNIY26aDSFyujK1
         z3ITzSQsyn4QgveHtgc3m/HP7UftZPip5LeR24clLF6lAtqGKj5p99nKPZwqn17U16ew
         zLyN0SBRHdinQ39vfg/nNxQV91iQEB7a7zFOFqRpVlhS+ZdBidWrLCaEablpPPZpTIiv
         BxH4F005JWpCKDN5zPbKSCnp4DWjon/59Qj2YdhRvxrBGL+riiE199HqjMQfzZ4heyn2
         YVWQ==
X-Gm-Message-State: AFeK/H3sd+4Kd/FahM5KWmG6p1Pl2qGEAx4cLnJNRuPbZ4VwKzEegQS6j8BSMSISa5f6wg==
X-Received: by 10.98.85.135 with SMTP id j129mr30461679pfb.79.1490039900779;
        Mon, 20 Mar 2017 12:58:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1478:9e4b:5dd1:a569])
        by smtp.gmail.com with ESMTPSA id 90sm34843253pfl.24.2017.03.20.12.58.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 12:58:20 -0700 (PDT)
Date:   Mon, 20 Mar 2017 12:58:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 1/2] git.c: introduce --working-tree superseding
 --work-tree
Message-ID: <20170320195818.GV26789@aiede.mtv.corp.google.com>
References: <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <20170320192225.18928-1-sbeller@google.com>
 <20170320192225.18928-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320192225.18928-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git.txt | 12 ++++++------
>  git.c                 |  5 +++--
>  2 files changed, 9 insertions(+), 8 deletions(-)

I think this is a step in the right direction.  Thanks for writing it.

Nits:

- tests are still using --work-tree --- this patch didn't add any tests
  for --working-tree.  If --working-tree is what we prefer, it may make
  sense to update tests to use --working-tree and add a test or two to
  make sure the existing --work-tree synonym still works.

- this patch updated the argv[i] == "--work-tree" case but forgot to
  update the argv[i].has_prefix("--work-tree=") case

- since this is a feature used for scripting, I don't think we can
  pretend the name change never happened.  We think we need to
  document both option names and say what version introduced the new
  one so script authors can make an informed decision about which to
  use.  Later we can make the --work-tree synonym more obscure, but in
  the short term I suspect it is what most script authors will still
  want to use.

> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
[...]
> @@ -892,7 +892,7 @@ Git so take care if using a foreign front-end.
>  
>  `GIT_WORK_TREE`::
>  	Set the path to the root of the working tree.
> -	This can also be controlled by the `--work-tree` command-line
> +	This can also be controlled by the `--working-tree` command-line
>  	option and the core.worktree configuration variable.

I suspect we don't want to rename GIT_WORK_TREE --- it's not
user-facing in the same way as --work-tree is, scripts make direct use
of it (and they unset it when appropriate!), and dealing with the
permutations of what to do if some subset of environment variables is
set seems very complicated.

For comparison, core.worktree is user-facing.  Is it also in scope for
this change?

Thanks and hope that helps,
Jonathan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0781F829
	for <e@80x24.org>; Wed,  3 May 2017 16:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbdECQwD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:52:03 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35586 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdECQwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:52:01 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so9663009pgd.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fLZN+mSV/pkgg5QsSGRJPnqpDl/vKSxeGfT4l2kr+Co=;
        b=dyauAyhEI6v/1Fe7R6FZ820hjb+7p4XmYmkTgTboeoiQoyNMTF8T43bNCvEVdEi4/p
         oADsJluVVcC7RL/Pr0fuw1m/gugvKOFZcAeTTxPpSXhIXU5T75WmQ1blnBdhuCts7pAm
         1pg+9gEMyYLnei90dihZFf5yP9MrNlnlAhmJra+La+/FfHhd0YKnQk7q0+SA8wqwUzBt
         NXDZW1dOTAYKQQq8lB0Xuts2mqgO6oxe85Kv8D+al5MeUCBI0jHTFkj453bw0pYi2EWU
         qPjK0Zv/0CCfIDtnA4/C53T7FBLPUaQIdM14pO2ZrrASTy7ypnC/ChOqf1cb65xs8vSN
         U7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fLZN+mSV/pkgg5QsSGRJPnqpDl/vKSxeGfT4l2kr+Co=;
        b=CXtBrgxKf7z0gyR2zlJ0Qh6ENhJLyAore0JbAcTQbqN/sgmHfdfjODzqJZhd9CuIan
         3CMHXXE6Bw/yRrYL9+baXlzKtW6urQiCKs/4sFGgk6FOsLmeC/OiDv4iuyBWkg22FAXS
         nyF8jlaz2PFZDiLUySP4AtZDEeFp/+Lz+MgQu4F01ioxTgM4P5awXZa3qlhkltaaUe2t
         ygZ5LMr56HTFjhh12125PErqGyJD2CgN02jckwFb8+Lc2P/i6gyd1ZraAJ9ynt2mwNed
         UZ0mJUxxMaortLiCo++twdjS+aYqmaeemW2Yi507iS0PmVgLzZTdJvqZSpFwlPz6QMQF
         Y1Rg==
X-Gm-Message-State: AN3rC/7f+2xkNUvzWIIJZvHFmvYSAu6McXrD8ZmnaKVtkSpNvcT+59MT
        p3yi4NmU943N9j7J+1M=
X-Received: by 10.99.102.7 with SMTP id a7mr37471487pgc.216.1493830321180;
        Wed, 03 May 2017 09:52:01 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id h89sm7154457pfh.45.2017.05.03.09.52.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 09:52:00 -0700 (PDT)
Date:   Wed, 3 May 2017 09:51:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] usability: fix am and checkout for nevermind
 questions
Message-ID: <20170503165158.GZ28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170503162931.30721-2-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170503162931.30721-2-jn.avila@free.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila wrote:

> Subject: usability: fix am and checkout for nevermind questions
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>

Thanks for working on improving Git's UX.  I agree with the goal in
general (we should not gratuitously surprise users) but I think I
lack context for appreciating this particular example.

This is a good place to describe the motivation behind the patch and
what effective change it would have.

[...]
> +++ b/builtin/am.c
[...]
>  	if (is_empty_file(am_path(state, "patch"))) {
> -		printf_ln(_("Patch is empty. Was it split wrong?"));
> +		printf_ln(_("Patch is empty. It may have been split wrong."));
[...]
>  	if (unmerged_cache()) {
>  		printf_ln(_("You still have unmerged paths in your index.\n"
> -			"Did you forget to use 'git add'?"));
> +			"You might want to use 'git add' on them."));
[...]
>  		if (opts.new_branch && argc == 1)
>  			die(_("Cannot update paths and switch to branch '%s' at the same time.\n"
> -			      "Did you intend to checkout '%s' which can not be resolved as commit?"),
> +			      "'%s' can not be resolved as commit, but it should."),

In the current state I think this patch makes things worse (questions
are not automatically a bad thing), which would make it especially
useful to see more about the motivation so we can find out whether
there's another way.

Thanks,
Jonathan

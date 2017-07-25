Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B911F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdGYXjG (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:39:06 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34149 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdGYXjF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:39:05 -0400
Received: by mail-pg0-f47.google.com with SMTP id 123so76323525pgj.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zIAz6pF3r0yJBSo4d+GxSx7NRn2keptszG0hVrrJzuw=;
        b=eoLgEPY9S7uFSXmfbRtrggKTRrnlD9Rnnt0Dc9An35Dr0mvydVPc/phpVMhPuPqvdB
         ECa+NeJpW+qfsks+wEx/chISi/ugzRy1skVNV8xfJu4gxlidTxNP9+S3eOl/eFLtx7SU
         tOLxlZ0ntZqB87Gsp+88YbAOjjmiTIlk322zg55AOvE3R2xVdnmIr4CBxdz+4oepDaSg
         llNI6wXp14B2MnWgPQYHUzwGkTLsxkK/O/czD+fXtp5GNR0qNiKcauFtN3DuxYDS9kg8
         2SDolPj/hsP7X7cSFJ2Kx93Cnfff8NnGCe2exX7mMxFN5hQJfIjMHEOPm03iUOOqBsoL
         VfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zIAz6pF3r0yJBSo4d+GxSx7NRn2keptszG0hVrrJzuw=;
        b=SZx5P1ILlqGhDxzb5VylERFSloCqmO491xzak/ePrPAZl2QeLNdFgztuIYuYmXm1y+
         8Y/rWPuCtq9XiS7cAPWhQHKUZyWsEXjjVu6w1sSTOFoiuXbVU8KX5mUxY5vphwOcxyVO
         tctbqX4HaXniLVgXcJX3GgC7S/3GjxSiQ16ncxICqZ2zIupOp++PDrqrTejFWbeLtgei
         XJdxoYRizfYgYlhVHvdIDQaMatHkg0QTwQX4xMOpShoDTBZ6WWfCG9O+1Q7wdFynqIIY
         LRnA4HRUzzpe70oRN5Rv81VitBAusd9yKwD/IHF+RPRXsL17Mr+sMJgp1Pv5pqPJboOW
         mydQ==
X-Gm-Message-State: AIVw112X68rGMHZx4StQX8mZUHRB6VF7yxVZb/I0mdr6jCiG0uHmtU5c
        JtYzMrZPW4lMZs8o
X-Received: by 10.99.114.73 with SMTP id c9mr21002998pgn.267.1501025945320;
        Tue, 25 Jul 2017 16:39:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cccf:9961:8336:68b3])
        by smtp.gmail.com with ESMTPSA id z8sm7226385pfk.130.2017.07.25.16.39.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 16:39:04 -0700 (PDT)
Date:   Tue, 25 Jul 2017 16:39:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/15] submodule--helper: don't overlay config in
 update-clone
Message-ID: <20170725233903.GB71799@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170725213928.125998-6-bmwill@google.com>
 <CAGZ79kacdTFVJknTx+ceT8epytXSJDRVAwZO4HyzpsmVbK5VTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kacdTFVJknTx+ceT8epytXSJDRVAwZO4HyzpsmVbK5VTQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Stefan Beller wrote:
> On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> > Don't rely on overlaying the repository's config on top of the
> > submodule-config, instead query the repository's config directly for the
> > url and the update strategy configuration.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> ...
> 
> > +struct submodule_update_strategy submodule_strategy_with_config_overlayed(struct repository *repo,
> > +                                                                         const struct submodule *sub)
> > +{
> > +       struct submodule_update_strategy strat = sub->update_strategy;
> > +       const char *update;
> > +       char *key;
> > +
> > +       key = xstrfmt("submodule.%s.update", sub->name);
> > +       if (!repo_config_get_string_const(repo, key, &update)) {
> > +               strat.command = NULL;
> > +               if (!strcmp(update, "none")) {
> > +                       strat.type = SM_UPDATE_NONE;
> > +               } else if (!strcmp(update, "checkout")) {
> > +                       strat.type = SM_UPDATE_CHECKOUT;
> > +               } else if (!strcmp(update, "rebase")) {
> > +                       strat.type = SM_UPDATE_REBASE;
> > +               } else if (!strcmp(update, "merge")) {
> > +                       strat.type = SM_UPDATE_MERGE;
> > +               } else if (skip_prefix(update, "!", &update)) {
> > +                       strat.type = SM_UPDATE_COMMAND;
> > +                       strat.command = update;
> > +               } else {
> > +                       die("invalid submodule update strategy '%s'", update);
> > +               }
> > +       }
> 
> Can this be simplified by reusing
>     parse_submodule_update_strategy(value, dest)
> ?

It would result in a memory leak if we did.  Really I'd like to just
remove this entirely. The only reason this needs to be done is for
checkout, which if we don't have respect the update config it can be
removed.

-- 
Brandon Williams

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A45351FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbdFMVIQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:08:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36607 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbdFMVIP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:08:15 -0400
Received: by mail-it0-f67.google.com with SMTP id 185so12910672itv.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jwfFeOfULbyEvZYj9fGj43fm5G/Wqzv070dMa7JDqzg=;
        b=as37XpjnDteNfl2WKk01S8JPYr21L/v/DJGr6TzQiwgmKQ9nXYXhxsEsmWgX7O0pSX
         dNfmOdO7uA9wIHQBLAa/w6LgN/so1jtENUuoW4UIyqV/qPsfiyiELAdReOoq18/cxwU7
         /lAQJrNYDudnm0CkSvEZh5gRlWtOrKJQ9K7gH5Dug+oeWlG7uQvHaEJN4xjysVkvjYS8
         7qixVK8tD0iBIh8ho4DRWB+U615gEANlQMd1pOdJSiIPnNGDHVEEgb6YQju05DP6Slbf
         fuTSaW3HlsLGc+uu2O13bwIzxdwVnENYuMD0elbb1R+em8SiKeHzRt64ibh2MSHo12TL
         3VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jwfFeOfULbyEvZYj9fGj43fm5G/Wqzv070dMa7JDqzg=;
        b=iCfDGk6vdUgi07037fc/fFs4U4vyJosSXOzL4DLVOqG9EnLjsUSewQpgwfpYVSs7+3
         Sj7wrcTemeiNfKX9hqS7bhSok5ifEsptal/HSfDDvM3GrmlRUBiZgAb4SlrrN9ri6lv3
         +FnyiJhvFehdUU2u2QixRKIwCwLdIbAGYLxVWRPsWziKPCuaPUaNmTPvzGJL7j9BCCba
         7KmNrRzAhMSddr8e3FlBVMr2X6tbLvnaWH30JAJC/SFB+GoLHXmdZnrzDmazEYZOtTEx
         F41P/MAYn5lZvhXBE9tw/SZuIvL6bnrNMGA8B4lvqeWHwgu7T4Ed5fJDMpx60Vsocoe4
         xLdA==
X-Gm-Message-State: AKS2vOwf90WQJJ3EA9x0ithNz/V4npFdYSO88YVMfTO549W2XhuBLlnO
        iYZKrcxKk6oEvQ==
X-Received: by 10.36.81.10 with SMTP id s10mr2410715ita.119.1497388089524;
        Tue, 13 Jun 2017 14:08:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id 134sm6302962itl.11.2017.06.13.14.08.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:08:08 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:08:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
Message-ID: <20170613210806.GJ133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613210321.152978-5-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> not set up) added a 'git_dir' field to the config_options struct.  Let's
> use this option field explicitly all the time instead of occasionally
> falling back to calling 'git_pathdup("config")' to get the path to the
> local repository configuration.  This allows 'do_git_config_sequence()'
> to not implicitly rely on global repository state.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/config.c | 2 ++
>  config.c         | 6 ++----
>  2 files changed, 4 insertions(+), 4 deletions(-)

The same comments as before still apply:

- this changes API to make opts->git_dir mandatory, which is error prone
  and easily avoidable, e.g. by making git_dir an argument to
  git_config_with_options

- the commit message doesn't say anything about to git dir vs common dir
  change.  It needs to, or even better, the switch to use common dir
  instead of git dir can happen as a separate patch.

Thanks,
Jonathan

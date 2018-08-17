Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272AD1F404
	for <e@80x24.org>; Fri, 17 Aug 2018 06:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeHQJtr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 05:49:47 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:43793 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeHQJtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 05:49:47 -0400
Received: by mail-pg1-f174.google.com with SMTP id v66-v6so1831742pgb.10
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 23:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jH/cOPVh1niYrD/1XQAyxkjBFqTvYCb59MSL7BI4eyo=;
        b=JYJYJoKdV/+BHNuG0i5TKG0q/bMOQhcZFdxOtQLQaxwjYanPKz1+/eOBIqTzgDdWvR
         ouF7j4cpPvM7z8QOq6SWd/kyxXn4urChuJFL3d5+ICk8RpSRj7OBlWZDSYdRU4Yke1Jx
         UBFbbQOszH1TiN55diLvlxUeOJIrXmkycO5GMD8s5W0n5b4Gwk2tz2G9SNVAqeGKz62m
         T2MZXQHJnXMQWcgn7yVimA1tarSncZAiFyDhX+LQKuQ67E5vmhIHVQSLy99eqEBfKXzR
         oASjBELYkyvhHzh9AJKNNFfPn6jZixo0HGERR4m9mAvKysjvAqwzTt5U1k/1XnjbYSbQ
         GRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jH/cOPVh1niYrD/1XQAyxkjBFqTvYCb59MSL7BI4eyo=;
        b=B3w71hwjrX/Oizr0IYGnFGrn50IdbE2gH1Eh2y8Bz4EA4f6e1PBd4fk3UuM4K3IMjK
         uC7sU9najdM4DDquOtS2LHjWfSZLc5dy+HCRtJyLRUJF9KgsqUYOPGjM8roo5fmH9PuV
         rFFvCWOJ4K1JlRDGrzOdZGWR5m38VrRdusSDFS+65pC0tr0jan8MlswVrIma9IKwtURB
         G3UyhhTap1zRomJ4CghAsYGSWNuBC/Pwfwgdih/SgQ4Trz/FIz9pRgz0uPfRjo1vuc8y
         X5M9QGD95QQFK2k+gywb5+236AsHYSshgBoJiYXOgmNrGa80pUcWpPMm1gi71IshUlS4
         mM3A==
X-Gm-Message-State: AOUpUlFS/5MHcvdMwtAe+qJEHFBFcG4yZqUmbBpMTVTTHaBBf0KDyZtp
        yaS+mgVz5wJDp2CiJAobdk8=
X-Google-Smtp-Source: AA+uWPxDG6Kqgf6rEgRNzq/t94GEq7e+o73HUyuNvJcXDx/KNA0CGIOmDhrN0zVpshR2ls3Vh7t0ww==
X-Received: by 2002:a63:b445:: with SMTP id n5-v6mr32378807pgu.104.1534488456697;
        Thu, 16 Aug 2018 23:47:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d81-v6sm1681573pfj.122.2018.08.16.23.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 23:47:36 -0700 (PDT)
Date:   Thu, 16 Aug 2018 23:47:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] commit: add short option for --amend
Message-ID: <20180817064734.GB131749@aiede.svl.corp.google.com>
References: <20180816183117.13716-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816183117.13716-1-pclouds@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1489,7 +1489,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			    STATUS_FORMAT_LONG),
>  		OPT_BOOL('z', "null", &s.null_termination,
>  			 N_("terminate entries with NUL")),
> -		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
> +		OPT_BOOL('j', "amend", &amend, N_("amend previous commit")),
[...]
> Thoughts?

I'm not a fan.  I would have trouble remembering what the short option
name means, and it matches the common --jobs option for parallelism
that many commands use.  "git commit --am" works today already and
doesn't run into those problems.

I'm sympathetic to the goal of saving typing, but I'm more sympathetic
to the goal of making user support easier, which is what makes me end
up there.

That said, I've been looking recently at Mercurial's "hg evolve"
extension[1] and I wouldn't be against a well thought out new command
(e.g. "git amend") that does the equivalent of "git commit --amend"
with some related features.  So I think there are some paths forward
that involve abbreviating.

Thanks,
Jonathan

[1] https://www.mercurial-scm.org/wiki/EvolveExtension

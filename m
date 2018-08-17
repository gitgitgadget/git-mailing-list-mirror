Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E0F1F404
	for <e@80x24.org>; Fri, 17 Aug 2018 06:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeHQJpN (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 05:45:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35780 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeHQJpM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 05:45:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so3107255pfh.2
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QWgVwbXREX6ce00vEaQf0FSRLyOdxhCWevpgYoZnOjA=;
        b=SbBnWk/zXvlCPIbfqYTalH3dBFZZIaMZFam490k/AVOt3K+PZZagTcc1pbufmC/U7h
         7thPnivWB1dUW8ssJtKHKOfrSeG9ySMEuJ6mx9AOpKzVKDfOk/z15zabroZwxsYKW3i5
         9IPyar1Jn8kSLHfW8Z8W15LIZmfFbjb24NMTJNmXo05XcxMzj49BOQrqto+z9QQ72Ep2
         /s4CdoGbQIaCxNysz8cOMG2MwJr6xQMPOLv5zYehZAgjFbBE74CdiVu5ldG8q1LRnJtb
         EDKrdq6maQkwXraF69sTit+pkC42WxIUO1t5FiECjRR9v7BtJLh4nKLwXwwkDw62+HzM
         A49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QWgVwbXREX6ce00vEaQf0FSRLyOdxhCWevpgYoZnOjA=;
        b=PPC9SJKR4jLMomLQ5XYo5aDyY+JRzon1x2tYjW4ZDkpTB0jOkjKeiQFznz7ey2FmP4
         DCIIKDNKXTGTVo6AWRT9MYoWpDponq/0kEvmEtVJbGzAUMmAwwtdNC60MJPB8Ouo0Ztw
         9NmApqKlQrFoiFxAVKHgiss44u9cxxwrx7PxqbmIM9MRbF9kb1L3YwMA0ZZ8NmDtII0a
         OGyZfYyg2rQiYpQ04Pl2HgkIvK1qDaztjVxykElyYj9cHYL7egBVB9PPaTndCXqcFUqj
         cLnfh2LgSmfg/xbtA18+BV3CZM3DIqP20dBs3q4yzoOIPWMKodTqn+NNls6pkB7TvyBx
         +WhQ==
X-Gm-Message-State: AOUpUlF1VaU9KymohBQ6BoSQ7FGDMXdkfIjsF++692YQpBDtgGT/1xhr
        C+mIZsxYKUvCA97eT/RNDLYQRKcQ
X-Google-Smtp-Source: AA+uWPwwRzPeOFnG8AZsUYQIgg/RFhi8gcKY3/qzG3gH3mwdD4lvVWCAuLU85tXtYqWG9X7aAoiyFA==
X-Received: by 2002:a63:947:: with SMTP id 68-v6mr32050902pgj.131.1534488182326;
        Thu, 16 Aug 2018 23:43:02 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r23-v6sm1838043pfd.144.2018.08.16.23.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 23:43:01 -0700 (PDT)
Date:   Thu, 16 Aug 2018 23:42:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eygene Ryabinkin <rea-git@codelabs.ru>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] Makefile: extend NO_TCLTK=NoThanks to cover docs
Message-ID: <20180817064259.GA131749@aiede.svl.corp.google.com>
References: <20180815151505.12011-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180815151505.12011-1-avarab@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Extend the NO_TCLTK=NoThanks flag to be understood by the
> Documentation Makefile.
>
> Before this change compiling and installing with NO_TCLTK would result
> in no git-gui, gitk or git-citool being installed, but their
> respective manual pages would still be installed.

Like Junio mentioned, what this commit message is missing is a
description of why that is a bad thing.

E.g. is this affecting some distro or some end user?  Are the docs
taking up too much space?  What is the motivation that leads to this
patch?

(I may be a little more sympathetic to the goal than Junio was if I
understood correctly, but I think it's useful and important to spell
that goal out.  When building for a distro with NO_PYTHON=YesPlease,
my strategy was to simply rm the unwanted man pages after the fact in
the packaging rules and that worked fine.)

[...]
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -1,5 +1,7 @@
>  # Guard against environment variables
>  MAN1_TXT =
> +MAN1_TXT_WIP =

It took me a while to understand this MAN1_TXT_WIP.

Could this just use MAN1_TXT and have the filtered one be
MAN1_TXT_FILTERED?  Since the latter gets a value using =, it doesn't
need to be cleared up front.

It seems a little odd to see this specific to Tcl/Tk.  Do other
languages with NO_x options need the same treatment?

Curious,
Jonathan

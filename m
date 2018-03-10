Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26601F404
	for <e@80x24.org>; Sat, 10 Mar 2018 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeCJQu1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 11:50:27 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:38744 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeCJQu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 11:50:26 -0500
Received: by mail-pf0-f182.google.com with SMTP id d26so2566546pfn.5
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g6ySfheXUaIDE5J/lvzrEjr8Ok7W2KOTAXxSDjuv/U0=;
        b=ZQGSRrdiCMs4BCWmK/9ayQmf6QX/LSUceLDzds0SQq8sONioWMhBOCOGxJq+dZ5LIr
         dvdxf8UUh/H8qlEr232wGed+MKojMSw7pYGbcKqVrnuF2DOApV+lgnUuUq2cKvK9AWnz
         kMgly/DLEjD96O+xd/bdS/F2s44iE+9+MAfVCXoQPUaSg/0L/r4mtdOOfpC3K/caqIIh
         WQegBqB10zI5K74Sv7jsM/DnMZpHY6L7v3jg5jhBoySJY1+IsN0zuukCPhj7C5PkeD6L
         9fUJJkc28FK7HB7kv1fylDFbNZuS7O4W2EMMok6pcxO2POnp2UhTX8E6ze1IbryEu7sK
         QqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g6ySfheXUaIDE5J/lvzrEjr8Ok7W2KOTAXxSDjuv/U0=;
        b=ouEV8IvoOjuyT7Icv+hmp/c7C10XCdgLdz/EUobtjF52AXkUpwI9NwIP64Z6bLqKMp
         TGxbyaeFTA70KB9kDq/FtE+crBgMBV1ua05QY606fXg5vTVXCncDAhioYs5FaFwD8xVE
         MPFwPS/RkAiZI2HxmIOsOwXoUGC89JITLMC+i2wCl4OAKQylXDjA40cPpeIRKZfedQnw
         sGW2pykg2eBFzmG9WLoekYYEjwu0JmaRw+I6sPU6k/q2a8V/RA6N7MVB3qymyxu/pJCE
         ZYM1JDUUS3YRvC5AKhByNlWVisY6rLjiamCIvtnbcYc0Hag9FYpzXp/dBVYO2ZOaBUnu
         qi0Q==
X-Gm-Message-State: AElRT7FiP9EcFMTKdzsTm3Dy6jyDN7jmwXoLYMs6YPGRZDRd0zQKq9uK
        TqQ1V/fPPJw6L/omG2tgGNvW/9Z38E30fUJn5dOdirNU
X-Google-Smtp-Source: AG47ELv79z9k8+wgS9xKAAYO30jsgc8p+f7NXtrpUMswp0p1jUWn5MseQ+dI82D1+mVy5nIXTxxX+6YsG3XcaC1NQ98=
X-Received: by 10.98.194.219 with SMTP id w88mr2500128pfk.26.1520700625611;
 Sat, 10 Mar 2018 08:50:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Sat, 10 Mar 2018 08:50:25 -0800 (PST)
In-Reply-To: <20180310123058.31211-1-avarab@gmail.com>
References: <xmqq7eqmxysm.fsf@gitster-ct.c.googlers.com> <20180310123058.31211-1-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 10 Mar 2018 17:50:25 +0100
Message-ID: <CAN0heSp9UMd=t2ssCa7Ln2Gtm2b=EKzyQbDEJGG4Lm5YboF8xg@mail.gmail.com>
Subject: Re: [PATCH v2] git{,-blame}.el: remove old bitrotting Emacs code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 March 2018 at 13:30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
> diff --git a/contrib/emacs/README b/contrib/emacs/README
> index 82368bdbff..5a63109458 100644
> --- a/contrib/emacs/README
> +++ b/contrib/emacs/README
> @@ -1,30 +1,24 @@
> -This directory contains various modules for Emacs support.
> +This directory used to contain various modules for Emacs support.
>
> -To make the modules available to Emacs, you should add this directory
> -to your load-path, and then require the modules you want. This can be
> -done by adding to your .emacs something like this:
> +These were added shortly after Git was first released, since then

s/, since/. Since/ ?

> +Emacs's own support for Git got better than what was offered by these
> +modules, or was superseded by popular 3rd-party Git modes such as
> +Magit.

This somehow reads like "Emacs's own support ... was superseded ...".
Maybe that's what you mean, but i'm not sure. Perhaps s/, was superseded
by/. There are also/.

>  * git.el:
>
> -  Status manager that displays the state of all the files of the
> -  project, and provides easy access to the most frequently used git
> -  commands. The user interface is as far as possible compatible with
> -  the pcl-cvs mode. It can be started with `M-x git-status'.
> +  Wrapper for "git status" that provided access to other git commands.
> +
> +  Modern alternatives to this are Magit, or the VC mode that ships
> +  with Emacs.

s/, or/ and/ ? My thinking: "A and B are modern alternatives", not "A or
B are modern alternatives.".

>  * git-blame.el:
>
> -  Emacs implementation of incremental git-blame.  When you turn it on
> -  while viewing a file, the editor buffer will be updated by setting
> -  the background of individual lines to a color that reflects which
> -  commit it comes from.  And when you move around the buffer, a
> -  one-line summary will be shown in the echo area.
> +  A wrapper for "git blame" written before Emacs's own vc-annotate
> +  mode learned to invoke git-blame, which can be done via C-x v g.

Thanks for giving constructive hints. :-)

Martin

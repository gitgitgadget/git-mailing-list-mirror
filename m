Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96AE20D0A
	for <e@80x24.org>; Mon, 29 May 2017 13:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdE2NBd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 09:01:33 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36647 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdE2NBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 09:01:32 -0400
Received: by mail-it0-f41.google.com with SMTP id o5so26585458ith.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QyrgE0UumM7kP2rh56l76MCeBC/Gtm4OppE/22o4TJM=;
        b=IxytJ66Qw9eAO7wPg2/hT0CoSuLHyt4DsYK5+krXe04LaHuUDPVDDGGYSMzUFssHTn
         UrlxpS+RgbalqPmk9+sI3CdqDVUOAryrnD1geyyduzMv4W/zvnavmSXjDLwN0qxM+MBG
         VEw0yspr3mH5bUhLYPim2zAVLOZa7UfDlsc4FmgOOpYTfNXCggu/42hm8Co/3RAzSbKr
         AMXeNO8WJxrTIvYFFKLYQpsSZogcrBzmy6SKnlyOL8CB/3g3uYLvo80QfY4KklgUjjq9
         sgv6W+kfB9XdWxoAyE+NmGlBt/Y2/LE756Ls0MZ1wPJQWip8z7PRUOD246hje9MbzDCS
         dgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QyrgE0UumM7kP2rh56l76MCeBC/Gtm4OppE/22o4TJM=;
        b=KvSi1PInGVlrY3J2DyqSQfGFZs64qkbFgI5osodNWhGSxvWQjwPwA+e5SnyVQSCuoL
         h/+vy35Hcu9vuVqLbl9+2PziuWhpw7D4yVCpzc3q63898OT2Yfw8cLUTackWcEI+a2d2
         OcjCqkxvUuRzaOQDP8Q6J+1TLJkHL3QY8mpeLT/KPVexoliMlE25/tSq4nUkS0p4q8N4
         ajhYn/kX9FjeKB06zZU9hrElQUlDQf59reXsWEk4kyWPXmlyMgFRC6QYQtwY16/sr8Eg
         Ho2B6NpWioI7PrjydO0P4gyrPBlx+DqeSV+Q9MM3QV/q9svR5ubfG6vWuQe8Ha3jcPT9
         xrFw==
X-Gm-Message-State: AODbwcCx6Yi+X2uDrSE1JMK/uRAyapPVoFqdhMOx9guiQ/MYt4o5HKhL
        wcuE+Ew5KxHlcBjUHtUP0uObtpHC6i1wgys=
X-Received: by 10.36.29.150 with SMTP id 144mr7555049itj.71.1496062891963;
 Mon, 29 May 2017 06:01:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 06:01:11 -0700 (PDT)
In-Reply-To: <20170529114518.dwlyayg5kfjjwtpx@macports.org>
References: <20170529114518.dwlyayg5kfjjwtpx@macports.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 15:01:11 +0200
Message-ID: <CACBZZX4kfNhEOtgpFkWtuTZshJX+tX_Dogd6tk6qEuGX07JqiA@mail.gmail.com>
Subject: Re: [Bug] setup_git_env called without repository
To:     Zero King <l2dy@macports.org>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 1:45 PM, Zero King <l2dy@macports.org> wrote:
> After upgrading to Git 2.13.0, I'm seeing the following error message
> when running `git am -h`.
>
>    $ git am -h
>    fatal: BUG: setup_git_env called without repository
>
> And with Git built from the next branch:
>
>    $ git am -h
>    BUG: environment.c:172: setup_git_env called without repository
>    Abort trap: 6

Jeff, bisects to your b1ef400eec ("setup_git_env: avoid blind
fall-back to ".git"", 2016-10-20).

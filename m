Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE41B1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 18:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbeKGDyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 22:54:05 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39801 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388295AbeKGDyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 22:54:04 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so19009501itl.4
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6buOqlcLOEQ3UaeOxPeAppwo5UC+bUPEkEqJMH/4gk=;
        b=hufwzxHMGCFeOh//qOtTWWrfe1lyLyv3PLEoZJBJSs0cogYFI6iiDG9gpgGcAtkmLQ
         b4Rcj39Lpggl83Jg8PK0GHhf+bV+wGVdsel8qmLVxRa7HTJFsJdLhIklbqLWumwCDnLh
         5V5GAUWdXWITfTvZ8x+8a3wXC3G3SYFZlbdNOXkbDoU1I+tJoj66QhCiqTa9E8jALh/1
         MIFmqRfNonAnMx2+MMEJJtcGjLCb2x1MMxAQsfOFOwTBxqDHKZBCHCE8kq9W2HbaoUK1
         bRdPvpZrymuLV07EwY8oacH1XDgTeo7NgIf2UsvrxAr4Ogy+9lVMLZh/J8fPunMn543V
         PFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6buOqlcLOEQ3UaeOxPeAppwo5UC+bUPEkEqJMH/4gk=;
        b=kdLArdCXbvup/YsimTvd4CH36qxRa2R0QqJZd8vmiuBqYQC+g3HYIbdhOoadtNQpCS
         sUO5lB+CtyaKsnm23eUtCAd78+3ZNHbKVlNlOG4cKFNyg8NK1FOvaccD0LxbCfjgZ5B9
         hk9MYNx/jZPJ4yIME9UVDsk/N1X1hf8XI5wI/uZLLf1OeCnE3CqzNzD3Zh0HWV7/WFdA
         jFrmAQ3dSiIt4w4M+1clb6tuC9isfnk42GhhrXZAfBRsNiMRmY2cvyALxwYnHmAftBO3
         t+cixxaS/y8HEW6AGPJHepOkCQoq4Wvq5thvkpmjGUAMU05ADFFFsYJVJcDT9P1pAnvW
         7YAQ==
X-Gm-Message-State: AGRZ1gLtr4CXJmeENo1R1wHndm3Xbryw+WY9ScTkSb0ct6KLPXGX0Sid
        7ZJMyvSXknFD2E6fZsYyk7GSBhZJj5YLV2vd9MQ=
X-Google-Smtp-Source: AJdET5cmx0BfuksbrBYwaHsHQqo29RrdQfHB4/Wd4FgeR3cVXEWtqqvR/r3miYLNmEbJo6Cnszr5D1Kv87yn8zq5Es4=
X-Received: by 2002:a24:ac5c:: with SMTP id m28-v6mr2878636iti.123.1541528852748;
 Tue, 06 Nov 2018 10:27:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com> <48e90389-399e-a727-a1f3-965bf0f32f18@ramsayjones.plus.com>
In-Reply-To: <48e90389-399e-a727-a1f3-965bf0f32f18@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 19:27:06 +0100
Message-ID: <CACsJy8DmyU_Kn4yytu_PQdpppXO8wLcuuzQ-fjwnyjA0ntB2Dw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 7:15 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> >> @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
> >>
> >>      if (path == NULL)
> >>              goto return_null;
> >> +#ifdef __MINGW32__
> >> +    if (path[0] == '/')
> >> +            return system_path(path + 1);
> >> +#endif
> >
> > Hmm, this doesn't quite fit with the intended use of this
> > function! ;-) (even on windows!)
> >
> > I haven't looked very deeply, but doesn't this affect all
> > absolute paths in the config read by git_config_pathname(),
> > along with all 'included config' files?
> >
> > I am pretty sure that I would not want the absolute paths
> > in my config file(s) magically 'moved' depending on whether
> > git has been compiled with 'runtime prefix' support or not!
>
> So, I hit 'send' before finishing my thought ...
>
> I can't think of a non-backwards compatible way of doing
> what you want. If backward compatibility wasn't an issue,
> then we could (maybe) have used some kind of pathname prefix
> like 'system:/path/relative/to/git/executable', or somesuch.

A pseudo variable might work, like $ROOT/path/relative/to/somewhere
-- 
Duy

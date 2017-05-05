Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8458B207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbdEEXiM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:38:12 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33613 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdEEXiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:38:11 -0400
Received: by mail-lf0-f50.google.com with SMTP id r17so10916654lfg.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+74SOK+GPe3Vs6L8wGZ7YUf/GnOCvNPxJtqMOpRcPho=;
        b=HD9Z5sLdzyff49/H+I8btmFyqoUFytala3XpiAHM0CpDYUTo1qk/5KChIEwloa5vLe
         1etDGjX1L3m7GZwHI/Moh+Ky6LFomn9xovVCHIrGcOG0R12sYxFClOKYyNweyNhE5RD7
         iBiPFHjam9e0UMyUqNFKe//FC31CvwVerUO6sAV9wX9ACYeeNcHWRdjLs2sNQJQS6rcj
         LcwlmtU7GpFINXACQ6fjGBh5J7ohQFe5uU+u20yxf5ikQE5XrD832U3TBoInya9fn7Hp
         oGScLalwNbSW+hG31m7Epg2CR5y2xsCqjh3BCvmojXIWGDP9M6iIw/1xG0qGlchA7rsv
         uqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+74SOK+GPe3Vs6L8wGZ7YUf/GnOCvNPxJtqMOpRcPho=;
        b=o53JeZdcNhoLkqGLSnhF0plwSF4IS80EHpkA8cH6RV/856FhT4bpojpQWSZogT12aQ
         CgFJW++VhAMDQGrIxGSr00syRkQj5jo2fnYwddSocnyEIsvqp5l95fXDhrD2ENAbmjRQ
         7ZKHRuvZNEA8ZuY8XANGhjWhsSX2UQNKwTV0il3V1TqEvRBvxlX1LnK5F3y6CmJwBnDD
         /r8Sc3CgmcsvppHpPxE/qXbmC3pcthDXY7QbyXcObRykQE0CGiJzAHwG1Sn5mIuIxpWs
         x1hHT4ARwvqmKIUYVkq/JFjI51ffU/QRDj8cMN5zDCQf2OXq3yhwH1yxbq9AJgBPEsTq
         kvjA==
X-Gm-Message-State: AODbwcDSiZaFDTgG/8A89ZSO7iaGi11F1P1C9+s0FJvFkfWN7asW9vC5
        uo1iJleQJ4lrabWFIKUQFClH6wpwUA==
X-Received: by 10.46.92.67 with SMTP id q64mr507656ljb.37.1494027490053; Fri,
 05 May 2017 16:38:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.229.213 with HTTP; Fri, 5 May 2017 16:37:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705052316250.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <alpine.DEB.2.21.1.1705052316250.146734@virtualbox>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Fri, 5 May 2017 20:37:39 -0300
Message-ID: <CAEA2_RJFPZ6-ZMQCjX5pXoA8RL6qscLO4QWP3gi46uWXYyD44Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Port git-add--interactive.perl:status_cmd to C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 7:38 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> But maybe you want to keep the naming a little more consistent with the
> Perl script, e.g. instead of calling the function `print_modified()` call
> it already `list()` (and rename it later to `list_and_choose()` once you
> have taught it to ask for a choice)?

Actually, I named it print_modified() because I anticipated there
would be no list_and_choose() equivalent in C. I don't think the
builtin should have the interactive menu + modified list + untracked
list being handled by one function. Rather, I think a saner way to go
on with it would be to create functions like print_untracked();
choose_from_input(); print_menu() etc.

This is still pure speculation from what I've written until now and
from the roadmap I have in my head (I do not know how writing code
from now on will actually be), but I have a hunch that
list_and_choose() is already convoluted enough in Perl; in C it might
become a monster.

> Thank you for this pleasant read!

Thank *you* for the quick and thorough review :)

-- Daniel.

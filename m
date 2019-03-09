Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9680720248
	for <e@80x24.org>; Sat,  9 Mar 2019 12:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCIMT2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 07:19:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34944 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfCIMT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 07:19:27 -0500
Received: by mail-it1-f193.google.com with SMTP id 188so412463itb.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 04:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PImI9CQ/9+IoEFcSLu9GMJp/+i/4TiMqmL/Q62HCnAc=;
        b=AKWKHcJZNt8cup6lt4PbeKjir32l5Ca6ANhzexDpgRswG3wym6JoVf45KUz7mWUaov
         7uvGI5K5K/KCgo4ZwlGXomCvp2K1fTtud0V3MA1FeaYTDrRnHLL+OYAm49car+y5tofL
         aGz/pLGFHtXIYFosCFwV/48PMmPkJSwHJAe/myqtzvgy7bdgc1xuadnYfpdzVdC4xQH5
         KXwhkkNYdV/lsuzKxDHpauKPeBc1HVIWOOHRkJYaOEwbMYuSK+iX0cdCTdxEeP0kaFKH
         0u6xdlFrvLpuGwqxhLKmVUzl1Uvvj8FACKLMlg0WYNQQia4tVfQNnhZIpZC7eey2O2/+
         Nsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PImI9CQ/9+IoEFcSLu9GMJp/+i/4TiMqmL/Q62HCnAc=;
        b=SfnIJbi7KChh4Qhpm5miGxrWU+j7Vj0YNPHTBdahG9DfYahStOCeMk0ArKxM215WNP
         fmSuMv5BfM3oA7zFbH4q68poPmLH28voyF1+cvbKaM5cnXvobIz320sBwKuu9dk/rL7h
         1aejvx8RAOmkP3of0zPXb/AUtwU5rVwKfcyzhSwUlkYzd4NVNW78g+mpkuZlT2ARoupp
         LCRsd8JIDSjNjB08iqZI3cy1M5zUmUUUMPJdwSMAEXJ+BMyoFNKLK7zvgzQYMuC5RZHp
         oT5FwMBMOr3PezALYpb+HSqzGoWz1sxoEBDpMQOCWwi2As36cb18lmVBMSiaTwER2ZYf
         SSkA==
X-Gm-Message-State: APjAAAXc9PLqwFo0/XmOApRzjZx2qzfv9yMJgv/MO1owIGIr7DEaec1D
        2lddC66F5ZSz8lj5mqICOa9HqeRZJZOmLiM1lD4oss0S
X-Google-Smtp-Source: APXvYqx2jv6tREdY1WC9QCyj53hEV8bU1ifugTCaH/Ad0HyfgMpZmgb0iGrXb7dxBuSIUSEcH6hCjT3LAxzHwOg/+W0=
X-Received: by 2002:a02:568a:: with SMTP id u10mr13357056jad.130.1552133966877;
 Sat, 09 Mar 2019 04:19:26 -0800 (PST)
MIME-Version: 1.0
References: <SYXPR01MB09577F5C4555C9068B606E11DD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
 <20190309104812.GA3403@alpha>
In-Reply-To: <20190309104812.GA3403@alpha>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Mar 2019 19:19:00 +0700
Message-ID: <CACsJy8CH7Q532cq2KAqKaJJBUz6B9N-f6OteOAusURSrYeoRow@mail.gmail.com>
Subject: Re: git MUST notify user when files will be deleted or overwritten by command
To:     Kevin Daudt <me@ikke.info>,
        Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 9, 2019 at 5:50 PM Kevin Daudt <me@ikke.info> wrote:
> I know this has come up on the git mailing list more often, but I cannot
> find a relevant thread at this moment.

The last discussion is probably this one

https://public-inbox.org/git/87wolzo7a1.fsf@evledraar.gmail.com/
-- 
Duy

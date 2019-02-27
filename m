Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADF720248
	for <e@80x24.org>; Wed, 27 Feb 2019 05:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfB0Ft4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 00:49:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41026 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfB0Ft4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 00:49:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so7386166pgq.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 21:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ciXOHfleGNIBjeRs6/JyD2RiGzK6OAe29YfhWpEqTvw=;
        b=pQkOEEiX9pYF16EVo0d7RRCQmtC3AuOfb1Pvu6AK1zwnBKI7rQ84Ok2veNxv0F+lyO
         UkVB0FD2Tv/Bzs03XsGddDb5gevfCxmd+ScCbOwKRRfhtqElI6eiDbmPbAIka+WwBEWq
         fshZhD0nWRVz2qfMjJadPAzhesZLHjuf7sNgvll14b9o8132CyJnxMfc5IobFkD4ZZjH
         d1LGI3RxR5ip8zKod/c4mWdpx1Av7MrVcJDahE5l6ok+vyWWzdvmLlipv+djC2PJ3Q5J
         ofR5SnnnW4CsLs4M86x8kt3FR7cuO5XZFj1bB9BhrnlxrVP6Uv1ZlfjkLqwCmK5OKZ8H
         F48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciXOHfleGNIBjeRs6/JyD2RiGzK6OAe29YfhWpEqTvw=;
        b=nsATb84LpE9ysdcZPWFcyzg2xeGX/Dxo3uiGV+u6rQbo0cesciWK//EzvD64uoO02F
         lD3bjRgeUsx+exbqgzXv1AAx2Hd3zaLza07wjuvf2X35ovqOg1bXA7JrZidW5ZuAPn2k
         FLds5vRfIWf3bm4z3tMUPW/RocsaakuR1ZeKvnFW/JZm6W4MDaQVUHhijw9WpEPY0FoL
         3ZBDHkjQSx+eWie0aan+7x7UgFNyNlffeMacHcTkg1MHNuco9lfvnaIVahxtcDNMWV8F
         I37+OcCYyoE/Dnuqm+UZv+BwGrHfA/jf3f1LiluuV16/A2P54q9IzzGXHyvf5ekp/B8K
         oBYw==
X-Gm-Message-State: AHQUAub4Qq0zCG7eMoASpAnqs7dPDzEy7KqpfXCG11YNWjmTwsE29g6g
        sRIobM2A5QyGyX6vboaJoM+Y2uCKXjrwT7EAMsg=
X-Google-Smtp-Source: AHgI3IbXhfvgox6brfwkuc2b5Q70KqpAWVlBufHAcdnUA4O4x+5Mbbz/tF3DOJyQpw+jj8EoPZ+ltP0GD87+Qo21TrM=
X-Received: by 2002:a63:1616:: with SMTP id w22mr1314978pgl.200.1551246595486;
 Tue, 26 Feb 2019 21:49:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CAN0heSqSp-a0zUKT5EaGLBYnRtESTnu9GKWtGARz2kaOAhc1HQ@mail.gmail.com>
 <CAL7ArXoau1ZfBsV9JaUDprwjSijyo6K5d9JyC1mdfc=KEvgJxw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1902262051080.41@tvgsbejvaqbjf.bet> <CAL7ArXq37k2qmjLSB6DROq3K_wd0YaD9a-thNXgVwcxX7BEUMg@mail.gmail.com>
In-Reply-To: <CAL7ArXq37k2qmjLSB6DROq3K_wd0YaD9a-thNXgVwcxX7BEUMg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 27 Feb 2019 06:49:41 +0100
Message-ID: <CAN0heSpebSEMo_OFrVFRXssVqRwnq8m=_b9E6b1oj1GNiPrqDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests: replace `test -(d|f)` with test_path_is_(dir|file)
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Feb 2019 at 21:02, Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
>
> Hey!
>
> On Wed, Feb 27, 2019 at 1:22 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > We already have `test_path_is_missing`. Why not use that instead of `!
> > test -d` or `! test -f`?
> >
>
> Yes, I think this is better. It will satisfy all the requirements I guess.

Good suggestion, Johannes. That is probably what most (all) of these
wanted to express.

Martin

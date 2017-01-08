Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A08205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 15:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756368AbdAHPMM (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 10:12:12 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33051 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752393AbdAHPML (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 10:12:11 -0500
Received: by mail-qk0-f194.google.com with SMTP id 11so3170888qkl.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JtBEHL9YqV5CsYhxaudA0rwBS7XsctBEvC8WYuCE/as=;
        b=k9jtRlvf4BusTD5E319+u9mZjGApREDsJfde/Jj2o7/I24yRptXXKmu2PE3B4L+k+N
         B4qSvooulZwMB8/y7hU/HfZTBWQFpQ1woiQ4tIZMBCGtb3nDVWynsRhrguxnpoP8ycWv
         ICvRAi6DrOR0NZB2BB08M/cKw684qhqZ7Hr+KAv51wmEJRWVqAb8IHf8Sq/EkJ5UWPqu
         WhesPSKRWkXXPjeWUY/RZDkg824ft+ddB4K2/H/YIk75URturqhhMvJO8qCow2n0Rrz8
         p5fECELfYJCzZWH0ztnFNTMxGTHeMZVu6xqwjnJjUpbGONhYtdqazroanBMRiUmPQ8Eu
         /wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JtBEHL9YqV5CsYhxaudA0rwBS7XsctBEvC8WYuCE/as=;
        b=VdWKcPpQblDeTnF7GJdgXQT1HVlIP5cdeMOhSXlJIm6WqiCokVVBFwU9yoWnvcdj7f
         pxX4mN1r2bLh5nxx7i6UfRqPA7NLLpJ+knpDLmW10g0HGoWlrVKb/7Q63rneu242d1Je
         HnjWQpPRFanUWciGAhlhFUxwM9i88MiTTDHalRA8eMtvSQTcScmyJTXSrKwyJfEY70On
         IJIj7N1nOBg6XqdhPmqSLWwaISI/OCOjOGq23POTo8MqaJHl97WRCxUMpCOwjd2KJq6Y
         XoLgJHOCpDq9Lb739JkwYGk5yQre5zQQ+S1Zo6wjz6xWBfuEW3CDmboeTgDpkFTL4SEN
         97zA==
X-Gm-Message-State: AIkVDXIMe78NqEuZNHP+sHzT6WBcrk2eO8u6lOuwK+BpatPAu5cKtgERvBVogcemEbGAtg2RN7Wvct0qAaH9BA==
X-Received: by 10.55.83.7 with SMTP id h7mr93689831qkb.104.1483888329697; Sun,
 08 Jan 2017 07:12:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.164.69 with HTTP; Sun, 8 Jan 2017 07:12:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701081250580.3469@virtualbox>
References: <20170108061238.2604-1-svnpenn@gmail.com> <alpine.DEB.2.20.1701081250580.3469@virtualbox>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Sun, 8 Jan 2017 09:12:09 -0600
Message-ID: <CAAXzdLVXUdCAcJL6DratNwLFUSN4UAV+TmALSZe-zSSTAJcWWw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 5:54 AM, Johannes Schindelin wrote:
> I am curious: how do you build Git? I ask because I build Git on Windows
> many times a day, and I did not encounter any link problems.

My end goal is to build static native Windows Git via Cygwin and the
mingw64-x86_64-gcc-core package. This is certainly possible but definitely not
considered in the current Git codebase. I have a patch to config.mak.uname
coming as well.

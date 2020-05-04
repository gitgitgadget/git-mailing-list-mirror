Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726D5C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A66C20707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgEDTTt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 4 May 2020 15:19:49 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40332 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgEDTTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 15:19:49 -0400
Received: by mail-wr1-f49.google.com with SMTP id e16so438174wra.7
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q4kITd3aoUH6N8zOnHQYNBVZi8J9QCEjaC73JFjxkd0=;
        b=kluunAO174giJkBvwj4WzlGAaW8ckHR+8svnlQOVY8Kb3RErE/Mf5tCY2AgkVy8BIj
         kcpuEYCRUqgdYQjfdC4Soer9H3f08kGw+dnMeVR6XPwofvinHhqdUnMz/1aRIQ1mU/8K
         ZGr4xX8F+qhEOTOx2sdRn9OMFAFV+/+LK86Vx38busLBTcvEwp2G0fEmaCwCa7QANCPe
         RpdYmeHVUfhJD/h5VjGCmicOIpsk9sWCWCyMZNaXTAGXmHMW5Jdx2/CrK7Do8iEoTu97
         O0S1mRVDlE9QqE32PO0dHUEGsSXUb1BzFJfqrv3mIVaZBmKSeNgo4+1qx8O9wP/WL89U
         CJyg==
X-Gm-Message-State: AGi0PuaIZ4mSkHzblXx2xspV6hHxO0HuYmbGpVeP4u26Dfx1JzWEMUIJ
        Mb16Jtpj6/Hz1Z6uQByWuc9l7ykvvY3irZBzdPM=
X-Google-Smtp-Source: APiQypJ/vP5eOgeD/z99ADF6/FnXNAyh4TTp7wN3VFrsaKr7tPbUdciHFfE/40T4OgXgG6GZzkcnEqtdAm4/ZobEJl4=
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr968697wrx.226.1588619987334;
 Mon, 04 May 2020 12:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP> <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
 <20200504190830.g2tlrognjw6ddipo@tb-raspi4>
In-Reply-To: <20200504190830.g2tlrognjw6ddipo@tb-raspi4>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 May 2020 15:19:36 -0400
Message-ID: <CAPig+cS-zZGGwaX3wKyagnr+9=SSAcECi6GaO2+5T4OVR3vohA@mail.gmail.com>
Subject: Re: Git 2.26.2 and failed self tests on OS X
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 3:08 PM Torsten Bögershausen <tboegi@web.de> wrote:
> On Mon, May 04, 2020 at 01:18:06PM -0400, Eric Sunshine wrote:
> > My OS X 10.13.6 has Bash 3.2.57, as well, and I'm unable to reproduce
> > these failures, so it seems fairly unlikely that the problem Jeffrey
> > is seeing isn't tied to Bash.
>
> Should I read this as
> ".. seems fairly likely that the problem Jeffrey is seeing is tied to bash" ?

Yes, applying s/unlikely/likely/ to my statement is the correct
interpretation. (Last-second editing strikes again.)

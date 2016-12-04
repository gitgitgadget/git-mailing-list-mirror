Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9318B1FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 20:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbcLDUlp (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 15:41:45 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35848 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbcLDUlo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 15:41:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so11729697wma.3
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 12:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RPlbMeXdgDktAZG8UZg7A5dA3QmvJDm922wttWsO9sE=;
        b=PjP/fD3dI+X4EYIZIyiAfqGDmfIXJjosZGMfx5WISLPmpW8tQe39egGB0MxmOR4YSK
         zLGSkWZqJ8mSHAJpp+OITV6d8IqKmEOoGbmBGb4orQGr5OFgowJY6fsJCqun3UGXcQ/q
         p5zJIvffMD91y0hqt4NqkYWHnfWjm6wiHGj60gzu5uSEfd/3rj/sPMlD2ycTF8uKYz/7
         JJr6f3zrbBkoS/LMT0gwtQWGXt5wQ9kmHpkT08jV2QkyAWym6fBx/KNimOI5aTLBg7XX
         tYuaaMCPnROilj8bW5uRTPu84roUdcvJ8RB6GgnAJV9dwy2Kv/CZQYndUQ5ZdtGh6YuG
         WeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPlbMeXdgDktAZG8UZg7A5dA3QmvJDm922wttWsO9sE=;
        b=K13Opgse8gpWa+WimNEGiT8qMpyLfmGWvHhYn4yQaTdayzUVHRJBmAhl52KcDGt6ZN
         TKswDoXuP1dswhzBDy2gPx5IBIfR3LkMlS5LdDneSZ/BAcgwUP44KPF1FdI/vlh2pVO4
         3V9WN2DnyICL76MxgMSaFHmNV0F5Bq45GA1i3UufvzArAbpy4WRMLVZPVaVZfGVz7MVa
         13F5Kz9O4uX5SzYCopjG4hBURzG32l4mLgA0mII4lT69Pj+0GrcSVK9ri9cCt5nzx1xO
         V8SswxZ2ckbKogQ2D5orbYQz4sQieaMAOTz57pNl5iyj1tziPVu3LWTl/jLFKTdbaYZv
         Mweg==
X-Gm-Message-State: AKaTC01Kg2r6PaDfhEXFI0bJ1XqoWq4kQK5bO6VrxOOugr156IQi7bw2luOOabd4G7Mnfg==
X-Received: by 10.28.181.197 with SMTP id e188mr6119456wmf.32.1480884062923;
        Sun, 04 Dec 2016 12:41:02 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id r7sm16922582wjp.43.2016.12.04.12.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Dec 2016 12:41:01 -0800 (PST)
Date:   Sun, 4 Dec 2016 12:40:57 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Timon <timon37@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git gui can't commit multiple files
Message-ID: <20161204204057.32dnkjx6ixv3swez@gmail.com>
References: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 04, 2016 at 05:36:46PM +0100, Timon wrote:
> This is a regression in git 2.11.0 (version 2.10.2 is fine).
> 
> In git-gui I select multiple files in the Unstaged Changes (using
> shift+click) and press ctrl+t to stage them. Then only one files gets
> staged instead of all of the selected files.
> The same happens when unstaging files.
> 
> Git-cola also exhibits the same behavior. Although there I could stage
> multiple files if I used a popup menu instead of the keyboard shortcut
> (I'm guessing it goes through a different code path?).

Can you elaborate a bit?

I just tested git-cola with Git 2.11 and it worked fine for me.
I selected several files and used the Ctrl+s hotkey to stage the
selected files.  They all got staged.

If you have a test repo, or reproduction recipe, I'd be curious
to try it out.
-- 
David

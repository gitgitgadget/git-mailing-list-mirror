Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B03F1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeACAjv (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:39:51 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:32933 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeACAju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:39:50 -0500
Received: by mail-qt0-f180.google.com with SMTP id e2so340202qti.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RYXZ9VX8pPVbdQx6lFFHXLsbOnpkudgvIaTzU5pXMGY=;
        b=Fxk8ReLKSYNS4qFFOcDB4C0F9I8jqg0ru34BS9ZS4+nPjH9/GwxvT3SYAXJOPQ8Rf1
         H8T5OOEYwHcqWT8OB7QlTIGInXzjIRGroEtD2L6vDkUmRsAsR3Rr/rbftYkVDYKOifBW
         f7WQeanyIcNLljnX/OY9jIk6JoYo1YxAXpSCc3UYXoGEzdDfJXXmLUBt8/Ucj6WBRl88
         H1R3EMRSgDA2EmXcKcFIEIujnt52jNl4n3Wgsf61nMa1FTSC7LjePDcg8ZLpMd8dCIby
         Gn+MvwsaTBw3yuGuNUGVIOVs383ynD4SVj2zJau5GVFwDWv8F7bY0sp4zeGpSRjsUaul
         Xd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RYXZ9VX8pPVbdQx6lFFHXLsbOnpkudgvIaTzU5pXMGY=;
        b=j2XY65uPuSPX1IIDbUc0E/XIZHqICTbc7+E75iZ2L/tWJ9idkLOonTd2PRVMmFKMkM
         xD1duRvxvhwCgMsmKhzE2hxhee5FJeL6UelyLo4Bg8ztvNKYR27MdiVjR2ldzpaq7Zqe
         PpuSnXUiDxsw1uDU3HhKHX8Js7bUXY4ynH+7NcEzLhZYcP5VtdAtbBX11jM+uhS5bUYj
         EfplYh/XiMAmuTepRCYdF7anCmAObNFEqE1AUtyuV8X4SBEQ+UA7U9DqCaIV7ol5nGaG
         6IR2WGlURqVNSV1uvpVt1al+HY9A0ryXl0a9xY7wtquzBvc5PEmf5hZ6Fb4TYx9gizmp
         J20Q==
X-Gm-Message-State: AKGB3mK8+Me+4Xz7+m2NueymNoww30rjXojb8Vp3l5zsEExAxK5f/QJa
        0nT3uHlutsT2Z+8Oh2QYhj4=
X-Google-Smtp-Source: ACJfBoupJgZMKxgnbcRKVbUeVnyLRiqKWY4mCvZjz9mAmePL4lGEDBPULTZ5DbNkok1x6JKkBKpyrw==
X-Received: by 10.55.6.2 with SMTP id 2mr59156006qkg.178.1514939989135;
        Tue, 02 Jan 2018 16:39:49 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id m77sm18425467qke.76.2018.01.02.16.39.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:39:48 -0800 (PST)
Date:   Tue, 2 Jan 2018 19:39:46 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: fix v1 protocol tests with apache httpd < 2.4
Message-ID: <20180103003946.GC12108@zaya.teonanacatl.net>
References: <20171231023234.21215-1-tmz@pobox.com>
 <20180103002145.GA242551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103002145.GA242551@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> Seems good to me.  I think I was just being overly cautious when i was
> implementing those patches.  Thanks!

Cool, thanks for taking a look.

In this case, the test isn't dependent on apache > 2.4, but
before I checked that I wondered if we had any way to run a
test only if the apache version was greater or lesser than
some release.  Luckily, I didn't have to work out such a
method. :)

I don't know if there's a clean way to do that
automatically, short of parsing the output of 'httpd -v'
should we ever need to add such a prereq.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Sometimes you get the blues because your baby leaves you. Sometimes
you get'em 'cause she comes back.
    -- B.B. King


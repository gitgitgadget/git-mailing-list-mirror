Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7408F20986
	for <e@80x24.org>; Thu, 29 Sep 2016 09:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933661AbcI2JxV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 05:53:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34081 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932223AbcI2JxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 05:53:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id w72so1233354wmf.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YuAwCLPvXFQ/y4gDsRUQrKpPSXVL3S2BhcfGfH9kZRE=;
        b=OF64nOAOtjkQIcg6mMVYccJVXwmKTCvL4rCkgdG/smQNVh5YiLiObxDV9NElhEM7e2
         eddtdYdb68o23FzoKUR1VYhT8pgDDmYcpviU/eF0mkJq53B9z9RanT2sZN3Ioy1RvWLw
         jLHQX8Kz+WLrE6l9nGcr8WgPUIfy4I/kRtC7RQQ9gMoltrVPPnJUyBNf8UgfzhS4Hfbd
         2lYIp2lhPQ5f2UUxW7sF9bhPo7GVDhR0Dnz7pyytmbHw2z+q/Fn2NOCzTQtLtJS+03Kh
         b4gcFJobremmw5xgfJOubeAUtw3fMQ1sYFoPkAiKQRa6kyYKot21s0rhx/d9SPe6cxQh
         mPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YuAwCLPvXFQ/y4gDsRUQrKpPSXVL3S2BhcfGfH9kZRE=;
        b=kgLGI8NKSR3CQLzqTbzu2dMRjSZEeVm+XDJTu/vszR6GzDptXuD7Em5zgP1Ipi2sAK
         zejHDHwhU1AJNkueAdFCu3VQO8eIJKfvdFoEFB4C3/pIUVbJnaQhdSGGjXREBMmELM0B
         lS3gOCbdE03hv4mvF03ykxGzmpSv9KdthJ0TPaxLeofKlOMS6kZi8uxk9Md31TMoi/wG
         I30mzX7nV5pzpRhSBxJEuFyQ+HcbcYLEowmFkUL/aT+k7rBL9F56GmZuqUX2H0HFSwrw
         MefWZEEYH9ZXWvROe2V8xKErDoDZTpOt1tFStc0yXGPOshgWFqFNT1xwI1rKyZPIbH3o
         ueLw==
X-Gm-Message-State: AA6/9Rk5F8bJSIvX8eZlHJVbt/BisYEq2hzR0kzmhOpZH5Z00EbbXp2Is2Q1Iyj/TIZjNw==
X-Received: by 10.194.240.71 with SMTP id vy7mr297356wjc.90.1475142797810;
        Thu, 29 Sep 2016 02:53:17 -0700 (PDT)
Received: from [192.168.1.26] (eln216.neoplus.adsl.tpnet.pl. [83.21.207.216])
        by smtp.googlemail.com with ESMTPSA id a5sm13209591wjd.9.2016.09.29.02.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Sep 2016 02:53:16 -0700 (PDT)
Subject: Re: [PATCH 1/4] config: allow customizing /etc/gitconfig location
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-2-gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f239b2eb-d122-9c4b-187b-fbd40a94bcf4@gmail.com>
Date:   Thu, 29 Sep 2016 11:53:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160928233047.14313-2-gitster@pobox.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.09.2016 o 01:30, Junio C Hamano pisze:
> With a new environment variable GIT_ETC_GITCONFIG, the users can
> specify a file that is used instead of /etc/gitconfig to read (and
> write) the system-wide configuration.

Why it is named GIT_ETC_GITCONFIG (which is Unix-ism), and not
GIT_CONFIG_SYSTEM / GIT_CONFIG_SYSTEM_PATH, that is something
OS-neutral?

-- 
Jakub Narębski


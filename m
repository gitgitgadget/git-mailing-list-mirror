Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CDE12023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbdCBAFw (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:05:52 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:33543 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbdCBAFs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:05:48 -0500
Received: by mail-ot0-f182.google.com with SMTP id k4so41601428otc.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MLIfZzUDhgBIw712w8tWTEAvQX63sxuoSq1z103SL8M=;
        b=Vn857tv1djd8qYPIp/1PIreMWhlrOC3OahUs2cj2pTWq3xvDbt6wcgE0ZmfFUODcS4
         cAocRDS2Rl4+t85mLgHpeVkLeuCzTSSoHMvYIhOiey9yqU3iC9tP0Qip6mq6AfUD7Mef
         20nzLddTi4gMvkjLUscGU0GArnfCy+HJL8fWsrNjz7zIUGJ1eV2Axys6U6O9nf4Cj7aI
         fanXnlvsNoGGqEn7IOXorJLfc/dPtCmkj4XHdUe1zTd5Ww3xQkFBRkaPKr1LiDz6AUyB
         SyX3hXAg5tpQU/0yabDR+BDwz23mdHs2E0xUmHT+fUL5fBhg2XRUefxJx0gYFpVbLgm/
         ECFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MLIfZzUDhgBIw712w8tWTEAvQX63sxuoSq1z103SL8M=;
        b=st5SstQHkuVr0b5+3uHkJeorBbtBmgizaVibvOrmK5tLvWpeEkiBMcFV/lKZJ0Y7PM
         aUgkQNuvLXTLKDRFq3eGcBiXR93LFRc32auUec+Cm5mkfaS7/aWrOcPVPd/CxIjpCmai
         osLzTVQdvaVby08Asv9sMGSk2p5gMaqfyToHFN9sScGSEbdfoh3WvWfD/YyrkwNw8WgO
         Yd52RoIn7+Gr9AxVkPSdfUzNdT/o/mDCWY8b28fEU03Nprda5vjUPnDuPojWCWfU135o
         PAmq4E5m1ahfRCvsHxHp/zDuLWi2E5uETUIvewwS6TwBX/89LFr0825sA2rnXP2i6BXj
         /I6w==
X-Gm-Message-State: AMke39nFAiwcweiPsL5zFTjZ75j8avVD0daA+II0uyzB/911Qn7QrUl9mW48R09zBwM06Q==
X-Received: by 10.157.80.30 with SMTP id a30mr6565743oth.219.1488412767497;
        Wed, 01 Mar 2017 15:59:27 -0800 (PST)
Received: from [172.31.98.12] (96-83-49-155-static.hfc.comcastbusiness.net. [96.83.49.155])
        by smtp.gmail.com with ESMTPSA id 88sm2667341ott.19.2017.03.01.15.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 15:59:26 -0800 (PST)
Subject: Re: Delta compression not so effective
To:     Martin Langhoff <martin.langhoff@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CACPiFC+=ZpHT=xh7Y8f68BcXxNYx8EFJfzqqG2ub4NL=uREu7g@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Marius Storm-Olsen <mstormo@gmail.com>
Message-ID: <6a72bfd4-5032-5e40-5c6d-8b77ca5ae775@gmail.com>
Date:   Wed, 1 Mar 2017 17:59:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CACPiFC+=ZpHT=xh7Y8f68BcXxNYx8EFJfzqqG2ub4NL=uREu7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2017 14:19, Martin Langhoff wrote:
> On Wed, Mar 1, 2017 at 8:51 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>> BUT, even still, I would expect Git's delta compression to be quite effective, compared to the compression present in SVN.
>
> jar files are zipfiles. They don't delta in any useful form, and in
> fact they differ even if they contain identical binary files inside.

If you look through the initial post, you'll see that the jar in 
question is in fact a tool (BFG) by Roberto Tyley, which is basically 
git filter-branch on steroids. I used it to quickly filter out the 
extern/ folder, just to prove most of the original size stems from that 
particular folder. That's all.

The repo does not contain zip or jar files. A few images and other 
compressed formats (except a few 100MBs of proprietary files, which 
never change), but nothing unusual.


>>     Commits: 32988
>>     DB (server) size: 139GB
>
> Are you certain of the on-disk storage at the SVN server? Ideally,
> you've taken the size with a low-level tool like `du -sh
> /path/to/SVNRoot`.

139GB is from 'du -sh' on the SVN server. I imported (via SubGit) 
directly from the (hotcopied) SVN folder on the server. So true SVN size.


> Even with no delta compression (as per Junio and Linus' discussion),
> based on past experience importing jar/wars/binaries from SVN into
> git... I'd expect git's worst case to be on-par with SVN, perhaps ~5%
> larger due to compression headers on uncompressible data.

Yes, I was expecting a Git repo <139GB, but like Linus mentioned, 
something must be knocking the delta search off its feet, so it bails 
out. Loose object -> 'hard' repack didn't show that much difference.


Thanks!

-- 
.marius

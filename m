Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4E81F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDFSsL (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:48:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35125 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDFSsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:48:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id r82so5055108wme.0
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=froIYzWRoCr5pArXvnHbgxm30IWH73jE+Ax+WBKvnpM=;
        b=qIBo6HHcsQH9fsEwOORZC2dDTM3nIrtWIWWMUBS8tVh/Ph02EBLVSICgcO0vOQB3yO
         C3SeJE/1G/4y2xdLng3r3wMzUZRmay3jlq8nw385caE9X+/b62niD6YzYHP7R47RuhJS
         ZHQdrCVFnIUlzmaE+dsjzriUayEwSIMLg7ARdeTrs/nKsUumotWHc4AtWOwbsRkNdjq6
         aF+IoHJsg5SOyB3NvOK70I5d2rM2dTxh+HPAz+XMZKtow4tvQ6wx0KYamDc5WSsglspw
         2r5G8DTFqgbxDlLvWMB8WSrOL83sYtzUzzfzbeqsaQSL4e+A7tplZquy1GotxN+ZuQ7y
         bZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=froIYzWRoCr5pArXvnHbgxm30IWH73jE+Ax+WBKvnpM=;
        b=NrA1cyxqWO3dBDRhVZ4SolzR+SPt5yL8xzdfhQ21YKVaKZdaL1uPJQsZo0X3pYRtUy
         WLuGeDwGDvrh2an5Ym4FVJa0HINZPYYd0z0lBSIGmSX848ArQ9p/t86DBnFc2SV61QJ4
         uzpJIya/keIDcbzs/9U1zMCwEe9Bi+2wuzYXcnB2zTuZNFROpKCQXaH/bFSLx5OOcJ9g
         xPH0bJMCW4XGVODLkntYFVRsp4Xg7YUR21AvfdMD7ssmabVcg1tznQ8yQz9BqYTpX2IT
         lYODGT37QxJEBrtK0z+/yKSHBekXVgB15hVgOjs/4s1fIvxOuvYbEf3LL2DthwUR7cwl
         ezEQ==
X-Gm-Message-State: ALQs6tA2yy5ZBPC51ZJWwwiP8Un7BuBl7p5Z1/EOfSsByE6VI8mc7mwM
        LrN7pnAdI7Q18c+Mubv6Dy5M73TN
X-Google-Smtp-Source: AIpwx49dqtK9nQeSqmFB2U3fHbhVTgbRNOZhX3oZZfgWMTieUZp/xTjvGXCFfZ65U9Be/CQEOecoSw==
X-Received: by 10.80.186.14 with SMTP id g14mr8219452edc.302.1523040490109;
        Fri, 06 Apr 2018 11:48:10 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o61sm6422562edb.88.2018.04.06.11.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 11:48:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Colorize some errors on stderr
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <cover.1518783709.git.johannes.schindelin@gmx.de>
Date:   Fri, 06 Apr 2018 20:48:08 +0200
Message-ID: <87vad4yxw7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 16 2018, Johannes Schindelin wrote:

> This is an RFC because it tries to introduce a fundamental new color feature:
> Coloring messages *on stderr*.

I missed this the first time around, and don't have anything to add that
others haven't covered. Just wanted to say I'd love to get this into
git, it's a great UI improvement.

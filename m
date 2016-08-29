Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0E21FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcH2Ucx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:32:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33180 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbcH2Ucw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:32:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so304436wme.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=n1qKMabGRxC3pWTu5AuMOTJl+Ipzz0dtZgWHHmDOWOk=;
        b=Z9Aj8B29h/gfbbU17q6F5SX5SRqyP9EyxpD6imprmItsdb/amcBtVczGr72ZmyXBgu
         wUBkuu9ezZrZnrjYNfUAN+dp0Md667DzqQl9QBb2ekEqgAnPic4tiHXY6fMFrnlgIrYC
         H7zovy4sik/TZElJsoimWYL4xCoihfDKW5sPx5+2u8lSZCeYN5Wf8UEMWyOoKOBN5NZW
         7JB/lOwhxlxJYiXOuxjgGO3weFOwYoA2N758ore3IF1lQGFIKmuspz1UONVJWx9QOsUr
         5yFd4YMb+eq9DvHR9Ww1xQcX3y3jDZ7PEL8ZkWuCRc13aIjXTpYxpLWLLhl0NaDH5QPD
         Cmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=n1qKMabGRxC3pWTu5AuMOTJl+Ipzz0dtZgWHHmDOWOk=;
        b=VTfGp5ayEvpoMevzrjkxEf74B3TFbMdbMoQ2qg0G4GyXug2rGJftA6NaWncoVnwxyX
         ykmv0mEGHzMTPRG66NtsGyR0rCWKruKW/UjGhfa+KJzQ63bEpb8Qkanb5YhbuYOXvT6o
         d5OjzkRDDsIGfFFai9rvdTKn0mLPGtQGjWLBLeOGjDY5Bjfiu3NaDxmSBc4Hlbko69uf
         ts8uB1TWsnCpvohhg5bAHcnE8eXHjuCk+JjOgm+W0Kt1JxTJmnq/+6+UtkQxZJd/eAzj
         iYbjOgNWzTEl1PodaNdVIYK5uLAqK/WGIqeA2GBzZCkJJiBui5bChkK3zEUH68fz2o/Y
         dMaw==
X-Gm-Message-State: AE9vXwMRjzwfAMj7/AfWbSo9ca4aYpxYMJJypFK3ZaNqC7yDiftj4Kp1hpYWMGUyoRUO3g==
X-Received: by 10.28.32.77 with SMTP id g74mr351917wmg.45.1472502771030;
        Mon, 29 Aug 2016 13:32:51 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id 4sm15165545wmu.2.2016.08.29.13.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 13:32:50 -0700 (PDT)
Subject: Re: [PATCH 20/22] sequencer: remember do_recursive_merge()'s return
 value
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <1f79d41e3417a0b1f0cffccc40e97f1a2c5ef987.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <99fd1126-53d1-36e4-facd-7e18ba06e3c0@gmail.com>
Date:   Mon, 29 Aug 2016 22:32:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1f79d41e3417a0b1f0cffccc40e97f1a2c5ef987.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:

> diff --git a/sequencer.c b/sequencer.c
> index 5ec956f..0614b90 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -623,7 +623,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	const char *base_label, *next_label;
>  	struct commit_message msg = { NULL, NULL, NULL, NULL };
>  	struct strbuf msgbuf = STRBUF_INIT;
> -	int res, unborn = 0, allow;
> +	int res = 0, unborn = 0, allow;

Not that I am against this part of change, making initialization
explicit, but why we are initializing automatic variables with 0,
which would be the default value anyway?  I thought our coding
guidelines discourage initializing with 0 or NULL...

Puzzled,
-- 
Jakub Narębski


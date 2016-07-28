Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09B81F859
	for <e@80x24.org>; Thu, 28 Jul 2016 08:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbcG1IXp (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 04:23:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34957 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbcG1IXm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 04:23:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so9968918wmg.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 01:23:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tmHqmB9VAGHm+LzwfxqvE390wQRiQ8XFU97MP0vQvuc=;
        b=dud/JyjaEpcPMD5beNvabJ5RDB6wgHlMs7xMMF8uqR55ZTKGjDCBjeXeeGfNg7B2BM
         fS8Hq+vE1TbphT7eIs9vTE2KLc4H09tUdoaeOZeJhvyfPySZAukV95ldIFJJxsQHUt10
         98iJtmk2tT6SPlTrilLnLXy3ruUpJZae6y/y9hEUDJhDBwx71GSgmpj7YBScHT9dnH7g
         6YuiZebsIBHeB7w9bHzB+KUPUiGklFF9hDkVXINfqWuCUkMfWHbE3CHdCICPpjDC/BdK
         CbBrN4awNWE3AzCzYeRrO2sx0s79lx9+kIaWgiUVlXzfwJq6gdJieINlIu3Gc/yksq6g
         d3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tmHqmB9VAGHm+LzwfxqvE390wQRiQ8XFU97MP0vQvuc=;
        b=l7RCKMtQUqmJAsvWfdygmz81cA/3RPuXMXD+NGkOThj3HlTTGz1A8yFcsv+/i69nY/
         nlD+yRbHvkNRh4mYfJIG2F96/Hn087TSpaIFCZERHMsK+CRT9yMJ8HI7y9CICu5MrQsu
         RwwMQRZpFDSmDXd7HszmFXeZR6piD7RAWo/AXb5CZl0MytWhPvc5Wy/+2TLnsx7N80RW
         izIHdCM3e++jIr5quyngWdO/MA3LuckLU1uiQkvoiM72MXtWMC11ZUsBWuqDGPTPE2Mk
         RqYgGCj2ciMop3EdzhYjQ+Xg2S2YllRWcvpoG5rQccg1KPvgwJeNhSLE949u5Y/guFyS
         zByg==
X-Gm-Message-State: AEkoous25qk73C7bx2NOO1qt6j6/0Sn+ybuR56WUK6AIiX+8RImjCdNZW/l68WvtxuZnpg==
X-Received: by 10.28.99.86 with SMTP id x83mr22875549wmb.95.1469694220774;
        Thu, 28 Jul 2016 01:23:40 -0700 (PDT)
Received: from [10.146.248.63] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v134sm42329304wmf.10.2016.07.28.01.23.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 01:23:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/5] convert: quote filter names in error messages
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <57991329.1000709@gmail.com>
Date:	Thu, 28 Jul 2016 10:23:39 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, e@80x24.org, ramsay@ramsayjones.plus.com,
	peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <DAD9422F-43EF-4F98-A373-87BCF5C1FCD1@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-2-larsxschneider@gmail.com> <57991329.1000709@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jul 2016, at 22:01, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 2016-07-27 o 02:06, larsxschneider@gmail.com pisze:
> 
>> Git filter with spaces (e.g. `filter.sh foo`) are hard to read in
>> error messages. Quote them to improve the readability.
> 
> This is not something very important, but the above commit message
> feels a bit clunky to me.  The change is easy to understand, though,
> so the commit message style is not that important.
> 
> Perhaps "Git filter driver command with spaces"?
> 
> Well, nevermind; if you have a better idea, good.  If not, it is
> good enough, IMHO.

Agreed. I will fix this with the next roll.

Thanks,
Lars
Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBB31F935
	for <e@80x24.org>; Sat, 24 Sep 2016 22:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965077AbcIXW2K (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 18:28:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34028 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbcIXW2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 18:28:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id l132so8251572wmf.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=exmsyWX7hLiowmbfWNZIPYk457l4Oz6I2urUbsf4DiM=;
        b=tTAw0djuAVETvjipzUJKqBV47NbaPgdGRBq9cTuab3BYge4oWa23qWA/XSkHuMEm+B
         Do+5SHOEK18EwwgCFVcCJdso1t8frHluxTyD0o/mm03uz+pm18Poz43gfNnV/HC50CjU
         d7VBUz+8ouycG5GZA4h4OCiQxIQ7ObuB0MIo39S7J8/xdW6sIXg/7sqGe7D0kIecHGt3
         QRakcY1rJMiOYy9Z2j/YxJgluLfOlqckapuslCu8LV4rYDf//2qctoQiwSxmKXA9qNA9
         V/7SKvd1IjZiXmhn1XNt8TVte9kzS7Us4SLA4BS2nTF0WX6XL5M5GkZKPPChC07YxYsy
         UYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=exmsyWX7hLiowmbfWNZIPYk457l4Oz6I2urUbsf4DiM=;
        b=fcJ7HBSgx5kjxPPzTXjTjzp2N9lWEYwHrZ6QevlsKq9cZOh1kvue3wN0ci9ryKwPNU
         KvYP8HEXZNI7YTbn1hD6Ffy+m7n5hz71MHDlKYOiZsVqu1p2/T1534mw2UsEOMOOa83B
         j/v7fetGY7CwghmOrjwuRSkzIezZPkzi3LwS2+vOkTo1314fKHQrEzf3HtQI3jSToDmA
         mdXl4DlroIhZF1uGVFQUPX4GX+oY+rqJJal7m/fLG4Imt1K2Tk+IWqYBRnB29mqATSUz
         A4bl7Dxx0pMu346oqWqb6HJIKPccL4ytcWrCgDziQ2kDKffFJBohy05HgFge39fLSZTt
         hLtg==
X-Gm-Message-State: AE9vXwMoENMuy7Vw/1EV2lDwnRGnW0L1k+t+O/cvEY4OVGDUhygUtSzNXSdPS8XqpQqghQ==
X-Received: by 10.194.169.194 with SMTP id ag2mr11972781wjc.164.1474756087901;
        Sat, 24 Sep 2016 15:28:07 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id xb6sm14167155wjb.30.2016.09.24.15.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 15:28:07 -0700 (PDT)
Subject: Re: [PATCH v8 04/11] pkt-line: add packet_write_fmt_gently()
To:     larsxschneider@gmail.com, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-5-larsxschneider@gmail.com>
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        mlbright@gmail.com, tboegi@web.de, ramsay@ramsayjones.plus.com
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <23f1ba98-c045-d514-ac99-5cbb2727bfb9@gmail.com>
Date:   Sun, 25 Sep 2016 00:27:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-5-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_write_fmt() would die in case of a write error even though for
> some callers an error would be acceptable. Add packet_write_fmt_gently()
> which writes a formatted pkt-line like packet_write_fmt() but does not
> die in case of an error. The function is used in a subsequent patch.

Looks good.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 34 ++++++++++++++++++++++++++++++----
>  pkt-line.h |  1 +
>  2 files changed, 31 insertions(+), 4 deletions(-)


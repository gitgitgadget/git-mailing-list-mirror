Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A0A1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934585AbcIXVPA (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 17:15:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35700 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933980AbcIXVO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 17:14:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id 133so8109098wmq.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NS29dxpKql9usSn1HsBFdU+vXy9Qfnl/WJJTwfHntDc=;
        b=Ah23GwdvP4BEYnJC8rjgxfNAfUn5BUstv9PujM/xX6PpBLa0HBJgmco34bXhXH/wKZ
         /Ya6EltCQde/6SQjPAhnLIAHpXxQPMf/2GE9JiSx1U4/b/jIu+Ve96MRPSWnWJUVMN8Z
         1OOIh6vUPERaRjBUyHdzPN3ParoJBpA0FpVSZmrK/avJiZGtLjcrwlfZs4XPiBL6xj5O
         UD8TsEnDjm4sO4GkI1a+v2ENlzhc+BTbRejHl/7Oj47NXAawSZZoNv5rbbBx3vg7nDPW
         yJgj/tCrFxdS1khnflJ2TQHMUrA6PgafN/b4A+xhc6iV1imjiyWuQDsWKym54lkK2DqD
         Ttcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NS29dxpKql9usSn1HsBFdU+vXy9Qfnl/WJJTwfHntDc=;
        b=eYjF7ZiAbablEmYYyG3fTJPefVNZ1kveCGgprEvqfDuqFB6nCcaX9YCgmmfopyICLq
         oF1OS/JF4Po9NxQy7uhRTDj7Ne91prkcqaYk0u5Qj0OEHmjNV9xj7KNW/Bx3Exf2gCmW
         AqolU5AP22b/F0Tiw08Jsnr49DawshEdpPQRAnOHttQcxjQixRCp7igE5MGp9wPKcOC9
         p2mXrp3J2hcBTzYGygXQw9WUcWEVZthLgxozMZ5tz+Pspcn63M9BGYyyf1E3hiwuOOZp
         1r5DPasu50CsGDoEOSlOaIeI0gfyEq8IP6e9LXpQlWERQRZfBXkDi8QAdDoHD8jW+56d
         z4Lw==
X-Gm-Message-State: AA6/9Rn00PFp38vAjSxk3EGXtodQTfxJilbphO+ulafAWmOIz87DaRn7C7pExzlUo42P1A==
X-Received: by 10.28.127.209 with SMTP id a200mr7511884wmd.99.1474751698254;
        Sat, 24 Sep 2016 14:14:58 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id lj2sm13871598wjc.38.2016.09.24.14.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 14:14:57 -0700 (PDT)
Subject: Re: [PATCH v8 01/11] pkt-line: rename packet_write() to
 packet_write_fmt()
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-2-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <592e18b7-ac2e-ed23-0321-57eb418d5172@gmail.com>
Date:   Sat, 24 Sep 2016 23:14:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-2-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Lars,

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_write() should be called packet_write_fmt() as the string
> parameter can be formatted.

I would say:

  packet_write() should be called packet_write_fmt() because it
  is printf-like function where first parameter is format string.
  
Or something like that.  But such minor change might be not worth
yet another reroll of this patch series.

Perhaps it would be a good idea to explain the reasoning behind
this change:

  This is important distinction to know from the name if the
  function accepts arbitrary binary data and/or arbitrary
  strings to be written - packet_write[_fmt()] do not.

> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>

Just so nobody wonders later why this patch was needed/suggested.

> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  builtin/archive.c        |  4 ++--
>  builtin/receive-pack.c   |  4 ++--
>  builtin/remote-ext.c     |  4 ++--
>  builtin/upload-archive.c |  4 ++--
>  connect.c                |  2 +-
>  daemon.c                 |  2 +-
>  http-backend.c           |  2 +-
>  pkt-line.c               |  2 +-

The header of the renamed function looks now very nice:

 void packet_write_fmt(int fd, const char *fmt, ...)
                   ^^^                     ^^^

>  pkt-line.h               |  2 +-
>  shallow.c                |  2 +-
>  upload-pack.c            | 30 +++++++++++++++---------------
>  11 files changed, 29 insertions(+), 29 deletions(-)

Diffstat looks correct.  Was the patch generated by doing search
and replace?

Best,
-- 
Jakub Narębski

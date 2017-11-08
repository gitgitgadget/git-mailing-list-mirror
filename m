Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA5A1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 16:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbdKHQPH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 11:15:07 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:46949 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbdKHQPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 11:15:06 -0500
Received: by mail-it0-f49.google.com with SMTP id f187so7466070itb.1
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=24AhQQxYh3HFkhNL8ijUTy7glL93T/YoHacSIvZEViY=;
        b=MP+vcZxy0pnQpmXI7ONDlOmL4LRDd1G5leCaDedyHJfROd5fFeJjvy04RIHftUkTky
         aOfFgeMxGY0ZMobcZWc4mtqPHVuJf15OmCEnPck7JyIMpCU7MTkwxXsXfdrIVUkgiIn6
         t6++4pjbvaQCqXODNviACiLkyFf91a0QyOg2z8MCOheDxUQMrvmKBWT9LQxz6sXftYuc
         mOCCpCqpWebDBGC034PbgBNl2qKNau0c6Rxk78SFvAGqvGz387eeWNUfvhyKkHn1owMU
         /mWR5GPXy/f6Rtw8LBAhcL0TEivzsb4ebw08RqgFLDwQqZxl02JW6K7oH+6TlRd8hwk2
         SQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=24AhQQxYh3HFkhNL8ijUTy7glL93T/YoHacSIvZEViY=;
        b=mb8zddTTUy3Iy2p3Mp6vzt+E0d9p8QG40GmratECbT4uNjt/iLsjCc8KEGzGoFFZEt
         QDOoKrsc5NEaGm51+MXwWpoW22fGzJtWlz7m43n3pJrmnYcUhbkVvWyFPkvWNnzJV/rN
         z/8n4/JQCLQnX1Lpvt++AHIbbFmavV6xBqHjYsFr2spdWIXe4Xo6sDRdqhLYUTvKbjgS
         AukVTosm7bSlAyFGEBllRObCd5wymNdHfV4CAOIh5XDqWkuf5KyENXz1n0VHjxR4TOco
         0HZoxYQmhWGxF9bibDZ5xLvckdymm/x3jkdxzvX6rVl1Ct23cd+gI4NvMTQ4B00M5mQs
         d7fw==
X-Gm-Message-State: AJaThX7S5jz8sdpHWZlMWnGg4gXpqqbLMjCX//jzC6XQz26/simUYCr7
        PP+w4yR2sg3WyQEFE7fSNxYzzws4CTQawA7V+fVrUQ==
X-Google-Smtp-Source: ABhQp+Q5SyfxD4ibRjny2raRLATo/Clt0M3TYGNzvqMMW0kLveNUCVBjYXgXCUaRao4cS3lH4jIkXxf2tD6tzEHgHIU=
X-Received: by 10.36.69.209 with SMTP id c78mr1359320itd.119.1510157706129;
 Wed, 08 Nov 2017 08:15:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Wed, 8 Nov 2017 08:15:05 -0800 (PST)
In-Reply-To: <CAP8UFD015i76L4BgSZdr2k2TZk+C0vRAqOsj4DaqtNYuJjtNxQ@mail.gmail.com>
References: <20171108135931.166880-1-adam@dinwoodie.org> <CAP8UFD015i76L4BgSZdr2k2TZk+C0vRAqOsj4DaqtNYuJjtNxQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 8 Nov 2017 17:15:05 +0100
Message-ID: <CAP8UFD35yFTB5_D6=WyXN47Lgo3PvLJi3yWfzTAK5aYjE9YjNg@mail.gmail.com>
Subject: Re: [RFC PATCH] rebisect: add script for easier bisect log editing
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +git bisect replay "$GIT_BISECT_LOG_TMP"
>> +rm -f "$GIT_BISECT_LOG_TMP"

While at it, is there a reason for the -f option above?

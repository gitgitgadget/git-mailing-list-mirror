Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7BC1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 18:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeA3Sb6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 13:31:58 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35733 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeA3Sb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 13:31:57 -0500
Received: by mail-yw0-f180.google.com with SMTP id u21so5480842ywc.2
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VSqPVHV5UGTh722MxR2Sk9tzqPVhxxyhlWnDjPvDt0Q=;
        b=gYoSL84pZLTmaA4k2YIvFPI62UujZSV9DP3tZmGds9V3kC5yd9/UT7YkBm/L5jWpJG
         pTb0PKjcQR4sLuBYWdaWnYMDD75ObYKj5noz+xpmXKVMjNrBS+YX4Qi7l6RMLuG0VxYF
         Zts+9vZCFkLYVexJ0okQpyzzfY90LkfO90JEfFFHp+CvfFJDykgHRm5BAiS3v+AqQ88J
         ZL0PLtHclLUJ5MIlD+g1T4x/V2ZSm/aq0EwoBgLkHZqu75vliWteEIRLihVPrr52KTrN
         dRAJZDimxCf/PM0dPl7dppBiaer6bIPuReyJAJQxtoJzJlIJ3t8DfLwY3nu7S1ylzRqi
         6F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VSqPVHV5UGTh722MxR2Sk9tzqPVhxxyhlWnDjPvDt0Q=;
        b=UXAV9vtOxV9uWe115cAGbz2poCWSGoZauAL1aucEj52vRAI5hz4bbgbJPMgjqMkgcD
         YX6IeslJXQRgt8DKNARjsVcJM5SgxBVukgjFwnmzR+iEEYwhea2ShX9qdBSlLQVNck2K
         d8xKAWRunquJ/QYxrL3aqOIW5onSFlIeUa4QlmfslFYErZcwYSkypy4Hi+29vGh3l7Fk
         yhIHcywYjUbkd233nD9hWTGofqNeq5YGOqqj8cX7Kdnafhv7bg9EYh1UeM0fu2C7pPhz
         LlaDly6yZi0mxKpmMRjUaASJTxnvJB6B2ZguArkbCWzgQdnElqwM4RMKQ570mcu0Hplv
         bt/g==
X-Gm-Message-State: AKwxytf/4sJWrWksZPjM7s3FBsFDOSOZfkWZ51GML7TvKVAFL8tYEs+f
        1poNKxWq4JoPjtdSlV+cmjgrRP9bqyEkXBRs3C8=
X-Google-Smtp-Source: AH8x224FGQWVegATj3aDiIdbJ3EZ2qXMPUBbtzBbpU12IRVe9TBrQne+1tddb4DVg1/DLxyCl93OeLW6pNRaPBTBYbg=
X-Received: by 10.37.39.70 with SMTP id n67mr21186450ybn.498.1517337116577;
 Tue, 30 Jan 2018 10:31:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.165.143 with HTTP; Tue, 30 Jan 2018 10:31:55 -0800 (PST)
In-Reply-To: <CAP8UFD0aKqT5YXJx9-MqeKCKhOVGxninRf8tv30=hKgVmHgmQQ@mail.gmail.com>
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180129172107.GA4185@sigill.intra.peff.net> <CAP8UFD0aKqT5YXJx9-MqeKCKhOVGxninRf8tv30=hKgVmHgmQQ@mail.gmail.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Tue, 30 Jan 2018 10:31:55 -0800
Message-ID: <CA+sFfMdM9S0h0=G2rXscvakmUTPT6Ceh2fW+M=9nctAv2uDuTQ@mail.gmail.com>
Subject: Re: Shawn Pearce has died
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 2:55 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Jan 29, 2018 at 6:21 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Jan 29, 2018 at 10:33:08AM +0100, Johannes Schindelin wrote:
>>
>>> I found these sad news in my timeline today:
>>>
>>> https://twitter.com/cdibona/status/957822400518696960
>>
>> Thanks for posting this.
>
> Yeah, thanks.

This is truly sad news.  Just wanted to voice my surprise, sadness,
and sympathy.

-Brandon

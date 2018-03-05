Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8169B1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 12:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933902AbeCEMcY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 07:32:24 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:42035 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933540AbeCEMcX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 07:32:23 -0500
Received: by mail-vk0-f44.google.com with SMTP id y127so9640894vky.9
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 04:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Sw+AY40Mx2oVRrEk36GSrYn1pHHkoeamOLzFnZTyC8=;
        b=b0ZNUJHui0Jmaj65k3yM64Lv29DIrBUICsZ6JNrkkZdvbBkOi5n7sWj7tdebQo2T6g
         n8rkrkzbcpoi/IIWXntENUzuLpklImRZ9m2srJjtgO57l8vZBpLHqHxQuBXfWYB9tSkF
         qmwlm3nVMQQiPdY4tt7A6vEfEWmPwKVfDrQQFpsMAUqLK4AkZLRDK/pS0H39X8TQWoTQ
         AzTNdju2d3adPjE2mEME8C36rhh+nh1tM0GxwYJf6KfaUS0lFRAy0/WqnAfSHEyHAe4m
         akCAowM9OD4RauhZZM5RPX8JUAD5YDkJqtSE2sQy1kByAM6FavqEVGylyNxhOs2V/G75
         ldhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Sw+AY40Mx2oVRrEk36GSrYn1pHHkoeamOLzFnZTyC8=;
        b=nlCd/d573/r1Bn2qaW/DHUdO8b0exFZxvttGv2LvsAhl6WfaTZjoYqOG8dUc2OPdUG
         sZXvZQKMobfO96osI/NIg73TcYtGp1hgqRpzXoagC/8672sEMVrFN8I5qNJwoIi+R2yk
         loRfX+cjG+KIy2+qCz3S69QP8rw1LCy+2H7HjHOlSwdTk7fZopE/bK7YtrF3Cv5+9bTL
         e3CaznY8xXg/dxAOJc/iVPdyPOpxjuY5ux/2RsNMX8G3l+8xSu9p7piK6gYVouoFinVI
         asVfCFTMX7/3UXpkvpm8n4oMfM1GLqXMW2yee8VbpX1HWDaqIUffkEYGBkzD03e673yR
         XjFw==
X-Gm-Message-State: APf1xPD5YeUTjycUNyEiXZekvbEmBazDUVG2I2yZ70Z0JMDXartP8Pb3
        YjwY2YDYBhtQPx676O0VCOTGhiK4Dvz4DQgF6cs=
X-Google-Smtp-Source: AG47ELuI2BvmQhchOcVCHW4MCPxsNtCHlR5JB/T3Mac1w3Iw7QMZBN4yCYAX0jt9g9VHIb4OgOtIHGZbizRw0DfsZ3s=
X-Received: by 10.31.51.73 with SMTP id z70mr9646454vkz.2.1520253142729; Mon,
 05 Mar 2018 04:32:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Mon, 5 Mar 2018 04:32:22 -0800 (PST)
In-Reply-To: <bb6be000-7a62-7ad5-0b59-90a75fd6dca9@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net> <20180301105103.24268-5-phillip.wood@talktalk.net>
 <20180302155528.12106-1-szeder.dev@gmail.com> <xmqqa7vqe9xn.fsf@gitster-ct.c.googlers.com>
 <bb6be000-7a62-7ad5-0b59-90a75fd6dca9@talktalk.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 5 Mar 2018 13:32:22 +0100
Message-ID: <CAM0VKjkNqMrQKXh4KgtvhSzdENDoDOQwGqxLtsYhbm3SMnPLRw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] t3701: don't hard code sha1 hash values
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 11:59 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> I did wonder about putting this function in a library when I first wrote
> it but decided to wait and see if it is useful instead. As Junio points
> out it would need to be improved to act as a generic filter, so I'll
> take the easy option and leave it where it is at the moment.

Makes sense.  I just pointed it out, because I could have used it
already in its current form for a test I was working on last week.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542161F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeIBMMJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 08:12:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37006 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeIBMMI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 08:12:08 -0400
Received: by mail-io0-f195.google.com with SMTP id v14-v6so13652170iob.4
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Go9DtG4BIta9PPysur/wd2HFkt5+snEPVESLtxt4VlY=;
        b=kHX9ah9qMec3EGcGVolUKcxfvcQ8DCBNrwXUl6REWNHOLFAK1MaaQycPLP8rXHt7O6
         NKuhenTvQc7OqDBdZkFWomNlu87OeomgHFk1w9I4pOZbCiTNErko1t578XmEjopOYT8x
         e4Ow0Pbf6hqRc+VqSDkNsO5xhTJLVqBx03ULpC/Q1B0AHvLInOWmBCqvcU8tnaikuqgQ
         wDFRmS5SczFxlLlhwhVFfWLk7w7CNNjmcr2Dr2G0veZw2xLfADuGR8OAntOTKle21AM3
         BdMeNBnLBh4WAPnws7vjwpeBa7xSP/2IigKiuhMMsBFW2yyKtHuK2nfufN7amTm3tCkP
         gYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Go9DtG4BIta9PPysur/wd2HFkt5+snEPVESLtxt4VlY=;
        b=WUWR7ZEyl3GewHDwTOx7LQIOktqFIaedYqqhe3q4R1p2he28cPbb9HQHtSTVZYeDp3
         gz7/AmqNUVdSOY9qcOW5HwE6aRDZ3lYD5iKbcWbkhnKrbeSoGge5KFjYqQOdmhusYlAb
         Oy4SEoskCywIyEtYBhU+WkRizh0FINAlXI1OCtzoNx013a4inXKKpoy/UuHKPZr1OYYf
         MDZguydecEh27R5mYjVsLXSC9N//1f/4xk219LJkM5WUyd//v3wkZpbM/TsyyY0QLE6Q
         kjaeRgGdEgjGpOFgTI7yEBjeUjrGDSn1GYYmpUgTw20KHqsCgLrktptwCIrifa2VOPWv
         ofNQ==
X-Gm-Message-State: APzg51BMJ5WIALnVsdGoXjWIY2zNcNxS6M2uWccxaLb9cdAQ+ErAooHO
        ZVgSzsl38Rj5c3bIr7CkcqJexHzN8sc4zA8rMsw=
X-Google-Smtp-Source: ANB0VdaIL5mRzPjFBwanTHZGqig+AVZ1iHbEXQpl7T0wLg+E15s92jkcUbRjCYXDzYZIQjIxKaPc+iyW0PTRKCRQktw=
X-Received: by 2002:a6b:3084:: with SMTP id w126-v6mr15946904iow.223.1535875035846;
 Sun, 02 Sep 2018 00:57:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 00:57:15 -0700 (PDT)
In-Reply-To: <20180902074250.6802-1-pclouds@gmail.com>
References: <CACsJy8AFo+mb8R-O-JKRPZk__csq6mbVXbnZhSd-nZ08zWfSeg@mail.gmail.com>
 <20180902074250.6802-1-pclouds@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 2 Sep 2018 09:57:15 +0200
Message-ID: <CAP8UFD0MHUN=auZW9Zu+hnx6oAxjNsZUfQGeJ0HfBCh5RPv6jg@mail.gmail.com>
Subject: Re: [PATCH] bisect.c: make show_list() build again
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 2, 2018 at 9:42 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:

> In order to stop this from happening again, the function is now
> compiled unconditionally but exits early unless DEBUG_BISECT is
> non-zero.

Thanks for going the extra mile and doing this!

I wonder if we should also try to make the show_list() function part
of the trace_*() functions to make it even more regular. This can be a
separate patch or topic though.

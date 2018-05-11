Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5991F406
	for <e@80x24.org>; Fri, 11 May 2018 14:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeEKOc0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 10:32:26 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:46155 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeEKOcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 10:32:25 -0400
Received: by mail-ua0-f172.google.com with SMTP id e8-v6so3713561uam.13
        for <git@vger.kernel.org>; Fri, 11 May 2018 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFIBk1j6IKpYJfbaNpIHEwoVbbXh9LI5F7SZAWoEbdY=;
        b=Gd9l4/NRZhvVi8I/PuVr9DL8SChZ9cEDw8TQB9pDb8C6biVr8fBODTPrRpKWpNcVsX
         DfGaW//jer0K7OsQGAZyodHCA0Sv/WnASlnfqA1eZuV1BJI09RtaTqkETaddM6o+9EKU
         FKn77NH2lYjheEXNi607y5jsA3e87CFrV7zTszD60ndylpCWXNyjacrzP2mB1vrvpPO9
         fSpFKz9LtfMnNoKfMnGSawBMcAajY5lQ4G9POYC/4TOw3psmJd9xA/w5/jenYkJ2Nulf
         7XYabVQ5LiFkAIfrjG8+MUj5KSlR4Fpi5O76MSXSqbtEcK3raB6GHN9/1RJSw+hkhRta
         wVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFIBk1j6IKpYJfbaNpIHEwoVbbXh9LI5F7SZAWoEbdY=;
        b=gPXY+6/UNoE/PyywPnTiNDfLbJnpPQDWD9I69ltv3/4G1b02gCC5II81+76smCqySk
         hsMGLOQ+eTFBdlzs1VaCKgtXosaeflda1Nbu94Dw9sYCzKjLqYuQzZ2jzvH8HuuzZFBg
         0tO9oHKzoHCt1osJ1oQvJYrO0CBhxTcDRRhXDywN4m5KfguzW35/F5skVgmO0o58QtRZ
         W3p0d6YNVO6mC1g21RqDP5YOBz/GYI/68MGa2nYW7OpOJyLK2oHOH+P5WbEmukC2ZfOW
         bMnMLUdajrg4DVjGQGQCHqAco1IBj5KwhzuLAqUoFSQIssMVysb4pYbhO3rjTMAuC7QA
         yJsA==
X-Gm-Message-State: ALKqPwciljh9H5FR4PeEn04j7i5MCQfCSZV1Do2cMIF8aMe4h64Tq75+
        Spv6JdL0SxB8wPVYHxN/PwT6rdx2TBcqqxEuktY=
X-Google-Smtp-Source: AB8JxZrDWtgJpvdRCeloKsdrL/hM3QuMu66jQ4eWIsAs/k3W3YFcbtQ3sU4Aiv3M/xHGAF6e1Vq9eHl+CpmkIu1ZUvw=
X-Received: by 2002:ab0:1c16:: with SMTP id a22-v6mr1535210uaj.27.1526049144831;
 Fri, 11 May 2018 07:32:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Fri, 11 May 2018 07:32:24 -0700 (PDT)
In-Reply-To: <CAM0VKjk3kqKpVz0ZjX58REwP8rz08kLsiVR4NWDO6-9iPGPe9g@mail.gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com> <20180510084652.25880-1-pclouds@gmail.com>
 <20180510084652.25880-8-pclouds@gmail.com> <CAM0VKjk3kqKpVz0ZjX58REwP8rz08kLsiVR4NWDO6-9iPGPe9g@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 11 May 2018 16:32:24 +0200
Message-ID: <CAM0VKjnvLV-QPUGtGZUPc4A2nxL2SzWzg7SPWc76hOfQ--2sYQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/13] completion: implement and use --list-cmds=main,others
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 4:06 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> OTOH you don't mention the most important reason, namely that the
> completion script contains a long hard-coded list of the names of all
> known plumbing commands to filter out, which is redundant with the
> categorization in 'command-list.txt', is a maintenance burden, and
> tends to get out-of-sync when new plumbing commands are added.

Oops, sorry, got lost among the many patches, please just forget this
paragraph.

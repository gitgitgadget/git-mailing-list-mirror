Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA4E203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 15:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbcGYPt0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 11:49:26 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35111 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbcGYPtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 11:49:25 -0400
Received: by mail-io0-f170.google.com with SMTP id m101so165028929ioi.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 08:49:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R56iGuxYPZyYTpDf5ojDK5+fmALZ2uGqEEVucMUCpXM=;
        b=Mi2eYaz1VFsQLqETHFZyY/+uopf0hxB27jx0dGV1uReQLQ22vdnCOgHFd7ghTdSqcv
         OsNXdhjWmLNbWQwvd4siAdz5cEk+y8a7ihgdgh8Uzr6LKQFJE5J1XEi7vHWBUnQEmpX9
         UuP9e6DzH8X4rp4bs8L0KcF4rv3Je8O9F95TC6B1598wAXIV3psPexI3T65oVvWaI3QB
         F6DxXXvUmLWnpHOyMgh1j3PC0PmsaK1o/N0M9vuCWL5zw/2xDv9Hrf84s1/CJneYVjxM
         9AshWuvGp5yOyLnx9RBmSCB1THKkuxTp2gCLbwvNg6nFZCapTFoq4HVj4llWQjUURM1d
         RGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R56iGuxYPZyYTpDf5ojDK5+fmALZ2uGqEEVucMUCpXM=;
        b=jVQKiDxHdIDbL02qhGI+z3cPpgn10Wj2Z7s1mVi9y6uOB5IFLkPJZMYB1E+0fZOQ48
         7DTSHYUxKIXd0zkh0lNhAaVwTe1G5tsjKB12GJGiPaC9YZcOnmmLioHHc1DzsAO0vA2s
         K64Yh7XejGQtMRMY5FdulbfGrrS+Bxshh6rMIs05OQS/cGfJLnOusdl99TQw1v+9lMXD
         rSzwlZ+Y36gnN2tkM6wqrb6Tzpk39nqKxSt/SvZIkfim5ISTyOq7gVYEiSvjLeKHgORQ
         4/A2IkUlbcZxPRzVKxGRiGQCG3pLa05jjPiZfVQNvycFIYz4fCRH6s8dU5WOaelu9+Co
         0ZNQ==
X-Gm-Message-State: AEkooutjNLYvGt5wYZp8Da6zDiGso0sJoPWFIsQ6J6V9Pdg5E4mujRm/5aObyi8c6T6AWmMjVlaS+liV3+FydA==
X-Received: by 10.107.159.147 with SMTP id i141mr20182115ioe.29.1469461764536;
 Mon, 25 Jul 2016 08:49:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 25 Jul 2016 08:48:55 -0700 (PDT)
In-Reply-To: <121F8453-3A12-47AE-AE10-021EADC4D995@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-4-larsxschneider@gmail.com> <20160723081447.GA24318@starla>
 <121F8453-3A12-47AE-AE10-021EADC4D995@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 25 Jul 2016 17:48:55 +0200
Message-ID: <CACsJy8D_21pY5FRs4VCpDUuUJ56OZT8DZ1ZKMiwWKeeSMiLSdA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] convert: add filter.<driver>.useProtocol option
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 24, 2016 at 9:11 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 23 Jul 2016, at 10:14, Eric Wong <e@80x24.org> wrote:
>
>> larsxschneider@gmail.com wrote:
>>> Please note that the protocol filters do not support stream processing
>>> with this implemenatation because the filter needs to know the length of
>>> the result in advance. A protocol version 2 could address this in a
>>> future patch.
>>
>> Would it be prudent to reuse pkt-line for this?
>
> Peff suggested that, too, in $gmane/299902.

And I was about to suggest the same too, until I saw his patch then
stopped. Having a common way to split a byte stream to a packet stream
could be a good thing.

> However, this would make the protocol a bit more complicated

For high level scripting languages, pkt-line is dead simple. If your
scripts are in sh then it could get a bit ugly, but I'm thinking of a
small utility to make shell scripting pkt-line easier anyway (it goes
back to the idea of rewriting index-helper as a script, which I might
do).

> and it wouldn't buy us anything for Git
> large file processing filters (my main motivation for this patch) as these
> filters can't leverage streaming anyways.

This is a good point. How are you planning to do it? Unless streaming
is done entirely in kernel (sendfie() and friends, which is not all
positive), I think you can still stream and wrap/unwrap pkt-line just
fine.
-- 
Duy

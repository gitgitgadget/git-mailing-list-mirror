Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A09201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 17:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754439AbdBUR5m (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 12:57:42 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:36520 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754426AbdBUR5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 12:57:37 -0500
Received: by mail-it0-f48.google.com with SMTP id h10so113156151ith.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+78MqEjFhFeOaEy1wEJVLjd9qaVDGUfeiNZT3U8TxEc=;
        b=IRxlHjBorBaGSGmR5v/YL31DZxAqvRm9dyXfC1E1+6PT1zBeudUE5ZuFrvWq3af9Ff
         E+/SDuIZHQgKHHhvLtUsrJkMzMSNrehwpvFqnaf4lqr9q6aw7sb3rJsE54ZlOtXYcbS5
         WNg5WaxSXhTWg6kLGWA1ACvFKp3otQJCizDXjnrsTsaFxWloEjRK4IwbAGOqJ6QPp/HH
         wUi3iEHXX50MxWdVlfbUGkSL6XD90pLK/VgfGiy7NAXAcUh+0Kv6x2GKpA0Eh5g6tKWr
         OJAbVdw/NH1fb/+GSeUjiJAG5RXLcditajHjBuhMJUAqV4zqJt8bBTRnBcd7+f6CdH/R
         wrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+78MqEjFhFeOaEy1wEJVLjd9qaVDGUfeiNZT3U8TxEc=;
        b=nNNBzK6Bk0s7cgqg23YeCOFkbzqFRY4qHtGYB4F2ZoEsFsA6upnYyBPFlwprD/maeU
         pfXilPZBNIFhpoI6cUB3MoqfiOfusUBRGido43MKPIh1/yDWePMj6FKl5eHOusNSCBp3
         +NPnX9Mxlfv1oBiNif0BxdVYzdvWFDB3V61qaNMLtTcRny1dugaHt3x2g7WYWUQFsqiH
         jjsCkWOXXBJPjNCePxhnnFMR9Vpgm3D+BqoAcdQj7wJqPrqJnNfys2oIipSmRt+RzsQ/
         /AYjzs8LUdE1naKJhRfXiOktHyBgxClZUeXrdxMqa8pMDv1iC41AScxLvH9o5y2kvShz
         DFtw==
X-Gm-Message-State: AMke39kKPmI7ScWoSOOfq8W9L3W/f9HSOSZDrjOfUCbG8z0B10Nj2Q1hRWF/CAJsfDRL4d0A1AWQZakoE+//lzl3
X-Received: by 10.36.40.198 with SMTP id h189mr28534012ith.114.1487699853001;
 Tue, 21 Feb 2017 09:57:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 09:57:32 -0800 (PST)
In-Reply-To: <20170221175021.znvpfvnlfjh4jsrf@sigill.intra.peff.net>
References: <xmqqy3x712if.fsf@gitster.mtv.corp.google.com> <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com> <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
 <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net> <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
 <xmqqino5jia8.fsf@gitster.mtv.corp.google.com> <20170221073813.w4zrkky2d4drnwbs@sigill.intra.peff.net>
 <xmqqino3h3zv.fsf@gitster.mtv.corp.google.com> <xmqqd1ebh3ak.fsf_-_@gitster.mtv.corp.google.com>
 <20170221175021.znvpfvnlfjh4jsrf@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 09:57:32 -0800
Message-ID: <CAGZ79kb-fbm9N9ocVpW43nd_S9JMvcBiU8eiA7AoPVg6W1Sodw@mail.gmail.com>
Subject: Re: [PATCH v2] config: preserve <subsection> case for one-shot config
 on the command line
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 9:50 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 21, 2017 at 09:17:07AM -0800, Junio C Hamano wrote:
>
>>  * Changes from v1:
>>
>>    - update the comment before the second loop to find the last
>>      dot.
>>
>>    - move two new tests into existing t1300 (at least for now).
>>
>>    - make it clear that the second of the new tests check two
>>      aspects of "three level vars" by setting up the expectation for
>>      the first half near the actual tests and adding comments on
>>      what it tests before the second half.
>
> Thanks, this addresses all of my (admittedly minor) concerns.
>
> -Peff

This patch looks different than what I last looked at. I like it.
Though the manual search of the last dot instead of using
strrchr seems to be over-optimizing to me.
Anyway it is still very understandable.

Thanks,
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C6C2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 08:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934745AbcHEIBP (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 04:01:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34841 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161027AbcHEH7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 03:59:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so2652357wmg.2
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 00:59:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UFPPhONpyPs2AQgGOB6gZt5iMxor/SUso2UYkjOlBCs=;
        b=x1uK7uw8IZwBKxalZ50K6QDu0/l1lYy0ShJnbGaXANoqcy4HSi/r4T4PNtcA00byjj
         +gRYUAraxZDSscmhuFUGR6Gx8/pd9H9nYKERyfbBltG2f7RRiI4LV1ZZy9YZlCtGYAR5
         MZJPMsFRB3EGKR5LmWqI+naNXG7JPpfyzh0UU3XRAiTgiflSMKhVDPxQxJFBVdr4xSH3
         gvgNs7Y5nt6E21jzW6KbMXbcpk6k4qW8jdSRwDjInySfsc1zhqPSYlq+hc0Fb3RFbzz3
         Tns3EWJYBzTOgReJhBFC4HIyWIfJ+n2DFHpnqXYnx3XjTDU9YAaVQ9bDBAjOeQcDlw82
         /A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UFPPhONpyPs2AQgGOB6gZt5iMxor/SUso2UYkjOlBCs=;
        b=LCzFy8GyRWXIGaBy1QB46S5fIDNwdUNdkkT6y7+F4XotJB5YRgeVS5pHcFsgeGlrc1
         yfUxp/AJrz75S6r1lHWhkjpp6WkNO8P29cgAwJnIAWUVcmtK5ygEOOYtUGJfQE47cNkG
         NMJz95ceeT5HiXR10nXc+5FD9XNvE173lqkoJmdbh+FC+pI9RKwUnAKVigEsR1tidC/q
         UhRxaVoBlFrSrB6Z05tKcf3829hzd/hq3EuTnjNw9F14AIGFGce/U8csi+1YLgfoJb60
         d0O0LrhvfE9nz3F8n+3k3L8npM+pJV+8qKcVMx9O/1ygBIQp+j0mYnRuj7/rzDzGtx/D
         k0mg==
X-Gm-Message-State: AEkoouty2cT4skbRieBO6OBgUw0Z0u4tSU/LZZjQ+4XciTxr5tX166NjFglCmdWu9aM6guZD9xYz+F556mbamQ==
X-Received: by 10.28.153.202 with SMTP id b193mr2099864wme.62.1470383963504;
 Fri, 05 Aug 2016 00:59:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Fri, 5 Aug 2016 00:59:22 -0700 (PDT)
In-Reply-To: <xmqqy44cz0k6.fsf@gitster.mtv.corp.google.com>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
 <20160803225826.hlr273h4cy2hcfyk@sigill.intra.peff.net> <xmqqk2fw1d41.fsf@gitster.mtv.corp.google.com>
 <20160804212157.cn7ecyxcbyf4okd7@sigill.intra.peff.net> <xmqqy44cz0k6.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 5 Aug 2016 09:59:22 +0200
Message-ID: <CAP8UFD3hvrrwmnyF0PLreAos62hN_1W4bwYV9toMQ-vQQ6rgog@mail.gmail.com>
Subject: Re: [PATCH 3/7] trace: use warning() for printing trace errors
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 4, 2016 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I wondered if that would then let us drop set_warn_routine(), but it
>> looks like there are other warning() calls it cares about. So that would
>> invalidate the last paragraph here, though I still think converting the
>> trace errors to warning() is a reasonable thing to do.
>
> Yes.  That is why tonight's pushout will have this series in 'jch'
> (that is a point on a linear history between 'master' and 'pu') and
> tentatively ejects cc/apply-am topic out of 'pu', expecting it to be
> rerolled.

Ok, I will reroll soon with Peff's suggested changes.

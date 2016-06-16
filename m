Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CB01FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 18:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbcFPS4Q (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 14:56:16 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:33349 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbcFPS4P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 14:56:15 -0400
Received: by mail-qg0-f67.google.com with SMTP id 34so4468230qgf.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 11:56:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sF5YHZw6UoTPI5B4LHlr/U4Yu96rfF0yDDUeQU+LpXo=;
        b=aWQSYOaa8mDLDTwoOkEhgIYzPORZp6ZAUQdF+45pS8Se52kcOXNQ+wF643W77KbZu/
         Y5iVcs74oHpzoaet779mHkv8R1S4uWoXZOEo79XIOhFvjYSpTviYjmBX5CBJvtK43tIB
         Ci8rFNIwEP7H5+cWTjc4q6irXeZEjuLbuGUcqee9CP+71D3oih6hlFDO1kLiJKE5KOBY
         ScZbwP8ZoezwwdX/g/OpM+uYmIcKLaOWs6BlzXc/4PKpyEF8WHsPpGX3VpL7vi3SGAb9
         xuhzyApxgKZ+jeSh34k/oDEgTdseXLXqhrYF1JW1CccRT4zSYBSYXxpycqf5tUU9BW3E
         d5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sF5YHZw6UoTPI5B4LHlr/U4Yu96rfF0yDDUeQU+LpXo=;
        b=EMQNu/JGK/FbI7Ae4Ome/xLyP+9I6vWllB7UK9Imlr7SwrHtliVEMBG3AW7mTPBVlB
         fpWaue1m11Vexm1e0UnRdJT59He1sN3t5D5pMkhvqAGUy8XYD8uWK66Su5dcWjZARvj3
         uU+XBRqq/rHFWVTCG5TOR0LT0kga/91qHn2tjkuWL+oUKyZBtGSzzoKrjkJ1F0ku9j57
         eS0Ag/AkMhKEYdHMK982IBwkCG1d1+HiPpUodAfX2YuveuGcvNL3eGp6HbRiq/Dym8XV
         tIk4Z8dqaxlRw+hYvlVLu3ZjlnB9GoV29BZVa04f0y050SyKaJ7fTWipaWqWjmHR1H5d
         M6xw==
X-Gm-Message-State: ALyK8tIPvycnnMGeQVvcScRFZB0Up+GzhKAV+lNf7DAnOsPtt9TJGNJoDbSwbIFlYV8pdGOQGzLHsLPDr8zmyQ==
X-Received: by 10.140.16.35 with SMTP id 32mr6480555qga.47.1466103374347; Thu,
 16 Jun 2016 11:56:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.39.74 with HTTP; Thu, 16 Jun 2016 11:56:13 -0700 (PDT)
In-Reply-To: <20160616095001.GI15851@sigill.intra.peff.net>
References: <20160614112705.7162-1-heirecka@exherbo.org> <20160616095001.GI15851@sigill.intra.peff.net>
From:	Brandon Casey <drafnel@gmail.com>
Date:	Thu, 16 Jun 2016 11:56:13 -0700
Message-ID: <CA+sFfMf_NQSqrz0FRPyTcD7zgfe7VbeHUoFccVCJzW3Bon3j5g@mail.gmail.com>
Subject: Re: [PATCH] gnome-keyring: Don't hard-code pkg-config executable
To:	Jeff King <peff@peff.net>
Cc:	Heiko Becker <heirecka@exherbo.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 2:50 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 14, 2016 at 01:27:05PM +0200, Heiko Becker wrote:
>
>> Helpful if your pkg-config executable has a prefix based on the
>> architecture, for example.
>>
>> Signed-off-by: Heiko Becker <heirecka@exherbo.org>
>
> Sounds like a reasonable thing to want to do...

ditto.

> ...and the implementation looks obviously correct.

ditto.

> Thanks.

ditto.

See I'm still alive, really!

-Brandon

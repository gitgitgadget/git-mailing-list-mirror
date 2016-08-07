Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7891FD99
	for <e@80x24.org>; Sun,  7 Aug 2016 16:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbcHGQhG (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 12:37:06 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35480 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcHGQhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 12:37:05 -0400
Received: by mail-wm0-f47.google.com with SMTP id f65so85409550wmi.0
        for <git@vger.kernel.org>; Sun, 07 Aug 2016 09:37:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t50ifWjPm6szYzyJNR1BsimtlZ9CxW9ChVfgOex8EKA=;
        b=n6UACFfPjcEB6zfY8V2h+yVdTrGuv6EQjOB8JAhXn1/LuUxEK6/i6Ba0oxAe1tbKzq
         o1WiwlaH+g5nR3gc4ajydoHOTOs23SdAvm4Rtd+pD9crlfFEHAJ8dnbuSQ5I8AI0Xa+U
         L4Vng5LpcL9tCnQ5SOqn430AnMOIHwa/Rxa7q3bsMp6dTBPnm+jTGnQt12h9MeCIAsFB
         JD98jDHhcapR3feKgonwpHb8uIyxDH/Vd2GkdKL7rZlKkpmLD+ShzIiXAipRhtwlf959
         P7loPVvicqDAa0x0k4FYvp3EvNIUonHzeSa8/I6qpXtfXSFTNDJPh/BltqQTzQwLwUWl
         g7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t50ifWjPm6szYzyJNR1BsimtlZ9CxW9ChVfgOex8EKA=;
        b=nIF8LRvDWUykZhIbeOIYB1TgwOUprRQQEZjnsIHixbv6P0vYzTYHFbVUdyV5+X/XbC
         eFmKGb1OrasKMRMN44e4KNzc3peRQFGulDD0mnXL80kuJB0qQWDb0G7uu8XQfOMH2t6P
         ysNG5M/KPBaYW0Aic8j10WS83x8vwriITb+4eb7d3drUUdGEfmLUPk/6gQ/W8tT2Lfll
         dqsHMnip6EA/pt1MWGn6O2yp8mCdlvwgv2P/b3x0WPqV870NVootJ+npXYB1r4faSh9Q
         wtdWayN5wssIbdtrCAEK/30pZwqjyXOwueyl4uN4jMxQiRFAc+iqZRLE5eFpmB93pXu1
         HC+w==
X-Gm-Message-State: AEkooutze/C657L8zjZy6HRjtNAQcT/qjx2yilMmrKHjU3ggD20G6p1TxhL0U0P69F1uX0VQ7p93/8VTpZpZsg==
X-Received: by 10.28.153.202 with SMTP id b193mr12613737wme.62.1470587823853;
 Sun, 07 Aug 2016 09:37:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sun, 7 Aug 2016 09:37:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608031635570.107993@virtualbox>
References: <a2b34209-2244-d498-6ed2-4f9fbf9f7ed1@ramsayjones.plus.com>
 <CAPc5daVo2o7zxTGVARoZc8AmX2WAJC1cWB4R=9sG8TH8ddKkuA@mail.gmail.com>
 <CAP8UFD2NFZCAF=ZWNf4YF+F2L7A4ZM0XS98o-cR_MjuLLR8pfg@mail.gmail.com> <alpine.DEB.2.20.1608031635570.107993@virtualbox>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sun, 7 Aug 2016 18:37:03 +0200
Message-ID: <CAP8UFD3MN0-Eq+BRrJaFBWX7YjgVPiEmPMU=BL0K_FVtaZppTw@mail.gmail.com>
Subject: Re: [PATCH] apply: mark some file-local symbols static
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Dscho,

On Wed, Aug 3, 2016 at 4:37 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Christian,
>
> On Wed, 3 Aug 2016, Christian Couder wrote:
>
>> Now there are different options to fix this:
>>
>> 1) remove the symbols in 9f87c22 ("apply: refactor `git apply` option
>> parsing") at the end of the series, or
>> 2) move 4820e13 (apply: make some parsing functions static again) at
>> the end of the series and make it also remove them, or:
>> 3) add another patch to remove them after 9f87c22 ("apply: refactor
>> `git apply` option parsing")
>
> You forgot 4) provide fixup patches that fix the patch series.
>
> And 5) fix the patch series, push the branch to GitHub and provide a
> pointer, but not sending a new iteration unless needed otherwise.

Unfortunately there are other changes, especially those suggested by
Peff, I have to make in the patch series, so I will resend everything.

Thanks,
Christian.

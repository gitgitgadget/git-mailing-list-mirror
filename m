Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7F42022F
	for <e@80x24.org>; Fri, 24 Feb 2017 17:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdBXRta (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:49:30 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35592 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdBXRt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:49:28 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so3787652pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NsefYVHNik7hPBWohgfueFqQ0gRk5vhbEac3Vx1n4UA=;
        b=ZXQgEUOdNvrlomRsehFLcauzD1P/GW9S8o/cDW3MHo6RcOZR56Q6e4GML4zZmRY97n
         acceVkczUDijBEz/WNCOeYMmKzGj4RXf/Qud361ey3ROYcraxNRKbjCMIasEpV9POcaP
         DQuGP7fPaCZ7R8TaAr1W/wCD6yoIasZlg64E+gt2HSi5Oix/XAS5aHJk8fUm/HQnhoA3
         FUQ70qLsIebG7liSQaI2g92l5VylHV2DnLPX86zPZOXZ08Pr9ka8TgxETCeWmdHvKzc9
         Na/xNf5Q4lYVks7AT96FdgAtAGVWF2Xh09xNeE1zAhztbVyOFjZQHVuKc9+3/BEfy33P
         rfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NsefYVHNik7hPBWohgfueFqQ0gRk5vhbEac3Vx1n4UA=;
        b=BVtOo3tvCSAneGEWgUH0JndWcMOLZubfDhhSw9wdTLdLo1Cq08upoPq3/XeY7EbDeo
         fKMdU4vBwbHzlwbz+RHvjxUCGEBhTfn6drStSYNFeykXvFfyD5IXDOpIqCTeD+/sAVrT
         xf0MDpe/vcF/PKnwvlyB2zNEexKEB3U+5lvTAsvCCBbJuxk5FD4SA1V9Wph/7D6TCS92
         8vnomLNWq6YHcHog9/4p/e+xu2Lg10HyGez2B/ZnE4jqQoUSENFcUv+OmiQCjRp0VJrX
         Lp1VV6F4Gp5jdidNo72hd3AGL2zsKuAgbm0CH8DYvgBvIuaHFF15gApgI0h/CxHtssNK
         dZXQ==
X-Gm-Message-State: AMke39l6IKVd76te2qGT9d8GR3/Woj5ksQ6E01y4tB4Og7NHr9uQ4QEiZEgoeFmTAFjShg==
X-Received: by 10.99.143.13 with SMTP id n13mr4907087pgd.10.1487958547721;
        Fri, 24 Feb 2017 09:49:07 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id x15sm16332900pgo.56.2017.02.24.09.49.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 09:49:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] docs/git-gc: fix default value for `--aggressiveDepth`
References: <952cf1f2cb37b746d823f3b917bfb44171cbc465.1487925983.git.ps@pks.im>
        <20170224090035.ju7evvro7mixc52w@sigill.intra.peff.net>
Date:   Fri, 24 Feb 2017 09:49:06 -0800
In-Reply-To: <20170224090035.ju7evvro7mixc52w@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Feb 2017 04:00:35 -0500")
Message-ID: <xmqqwpcf4gz1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 24, 2017 at 09:46:45AM +0100, Patrick Steinhardt wrote:
>
>> In commit 07e7dbf0d (gc: default aggressive depth to 50, 2016-08-11),
>> the default aggressive depth of git-gc has been changed to 50. While
>> git-config(1) has been updated to represent the new default value,
>> git-gc(1) still mentions the old value. This patch fixes it.
>
> Thanks, this is obviously an improvement.
>
> (I also grepped for "250" in Documentation; the results are thankfully
> short, and the only other mentions I saw were referring to the window
> size).

Thanks, both.  Will queue.

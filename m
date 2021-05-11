Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC71C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52571616EA
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEKWTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 18:19:38 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35897 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 18:19:38 -0400
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 97D15200004;
        Tue, 11 May 2021 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620771510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQ+0UHuoUB1aKr2ZnXFDa9JQVDAN2zY7sgFi4laK5SA=;
        b=AHGH4e8fjPDEUlXXgnOfZepC24FneQroQCv++WZvWnCkt5nPliXckSR2q0sjbGo1AOk56E
        vivEmGRelYS9xSYaIp/nJGEq5bOeiHRa8x4HbfrDg1kSNfoabTQSU3j+Mp98XlaA6rx4tc
        TpA+IFMfsHlK8a/yDanV6yWyLtdJcN5KuhITG9oH3vB+yzXTCld3tPB5fz0I3q989EmyeD
        WJRdhTME+mLwj4z5TpQHxlkutCR83wVvAsO5SBfWA87Kl3ySJgxxpNBpuzQzh15T8LdAsk
        I7W54ZgdITTwX47QI94JxBVULmE51cSdJYET0X/FaKo09jCxP5AhWbov5+NKhA==
Date:   Tue, 11 May 2021 16:18:26 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJsCslVJhcGANb13@gpanders.com>
References: <YJrZ7Hho6jrVyM7f@coredump.intra.peff.net>
 <20210511204044.69047-1-greg@gpanders.com>
 <YJr5rHnQOve1DD6+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YJr5rHnQOve1DD6+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 17:39 -0400, Jeff King wrote:
>It also seems to fail for me. I think $patches isn't valid at this 
>point in the script, as the patch files have been removed. Switching to 
>just HEAD~2 doesn't seem to work either, as earlier tests set up a hook 
>which rejects it. I think we could pass HEAD^ to send just one path, 
>but I thought it would be nice to confirm that sending multiple works 
>(i.e., avoiding the bug we discussed earlier).

I had to play around with this too (being unfamiliar with how this test 
harness worked). It would pass if I ran the first ~20 tests (20 is not 
significant, it's just a number I chose to ensure that whatever 
necessary setup needed to happen was done), but would fail otherwise. 
Moving the test up seems fine, I put it at the bottom simply because I 
wasn't sure where else to put it.

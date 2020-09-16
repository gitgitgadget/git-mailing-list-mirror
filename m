Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98209C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 07:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EABD2076C
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 07:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIPH14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 03:27:56 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIPH1y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 03:27:54 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOAFl-1k7DYw2ZOD-00OWBE; Wed, 16 Sep 2020 09:27:39 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 3A5DB1E01E7;
        Wed, 16 Sep 2020 07:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1OiA4Y9E048a; Wed, 16 Sep 2020 09:27:39 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 009301E01E6;
        Wed, 16 Sep 2020 09:27:38 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id CCC748051F; Wed, 16 Sep 2020 09:27:38 +0200 (CEST)
Date:   Wed, 16 Sep 2020 09:27:38 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Pass --ipv4 and --ipv6 options to sub-fetches when
 fetching multiple remotes and submodules
Message-ID: <20200916072738.GB15595@pflmari>
References: <20200915115025.GA18984@pflmari>
 <20200915115407.GA31786@pflmari>
 <20200915130606.GB2839276@coredump.intra.peff.net>
 <xmqqimcexsm2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimcexsm2.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:4QM1vKZqkNgRqenZ3NL2EFMB8BQ2bSwzy0318+phXKhJr4MWGs8
 pVC7/j2V0Mi5Ui3zuBJxjZdPTZaBs1CcoiqA81WvCjS4mK7wQGgOpGYE5BvqOuoHXaXplrw
 e26VjnWV/oTs7xdA6daGUXr3vXpB+DnpDxlyT1wsXcy4Q0B81DNCXXmNP/NXZYxzaKfw/NE
 7ATy9y5Hy+AE/17MDjRyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AW4KJjKgtK8=:xRMokQ7h/7rxPkx1vlzQP5
 r09RACqSGpKBa/T4cejva2S1ZqgthlpmrG1L7rLdLvMMnrxUeo1ffeFRI+LWA5ZuPkjK+qpic
 juk/B6zEV2s3CzGLyr3BHW7BwXwxzSC94BGdtcTEkZl76u4iXc8gOoKPEzec//JoejOIYegcc
 6swFHayM/3iCNlJodV6IvCKcPXdj8UI+ALxHv9DmMQKcMdejUB2vyD7JRF5P5Op5gvGbKRbnF
 7Xb0BfZcOnNdp05xLrJGfThm4mtBxbmpycZYsfCqrqZqNIu2wnQ/5MYggqbwDDpWVTvvfVLnZ
 DvCUgCCEOOavdhstohWVEgmMQnxP4k5YfuK210KX1NRQcibZFRpBQJLOawttwCilvNO+TIU3K
 LfkRWPdlClLx9SJncWYx+Q7O91f/TW0ka9Ye8ToG9j/CeqOTyCnxLGlr6h7XJWUYNg9YRwR3Z
 Q4mwrC/QjQyy88uRe1Vsp271yA7beffPM670BmlHBbQH6fpTs2VEyntutJY+zWeB3xbucm9XJ
 NMOThxkr53bl/rWPkiyaund+4meLYt5JUo/4Vi24E0FhDpDHzNUMTzAd0JLL0HdI/i3PDT7xV
 YejABfPxbRbxpeG4+KL4Xj1ppbZ1D4+x/Ig11jCn3wCSyVAGL/fqX8T5XbRvSeeWG+bpnMrvd
 QQftn1sSE5L4CSBlA4YQqZVYbPASxO14fVzbEpgCEsy5E7VjMFSXUmzHrdHqzuaRgiXDQg1iT
 deHYS8hZUONH+f3QEgY+qCppr2hqpofe3eAAt4ZHB49erxISyudG2IpLtGa7D7oF606R0R+1t
 UCY75umGq74j7Wrb8ZYOvGLVy2O5EwagPTKp3UqSqIWSqeBsKKg3kGz1szt0NqkAZBfq7MmZ+
 o/0zFfxu35yUCQPpLusg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Wed, Sep 16, 2020 06:17:41 +0200:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Sep 15, 2020 at 01:54:07PM +0200, Alex Riesen wrote:
> >
> >> The options indicate user intent for the whole fetch operation, and
> >> ignoring them in sub-fetches is quite unexpected when, for instance,
> >> it is intended to limit all of the communication to a specific transport
> >> protocol for some reason.
> >> 
> >> Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
> >> ---
> >
> > Regardless of whether we move forward with the parse-options flag or
> > config discussed in the other thread, I think this is an obvious
> > improvement that we should take in the meantime.
> 
> Yes.  Others can wait.  ipversion configuration variable is probably
> easier to sell; ...

Is its choice of namespace (transfer.) alright, too?

> ... parse_options thing deserves a longer and deeper
> thought as it will affect the API future codebase would rely on.

Of course.

Regards,
Alex


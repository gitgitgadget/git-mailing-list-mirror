Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91EC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C964D64F07
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhCQWv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:51:27 -0400
Received: from avasout01.plus.net ([84.93.230.227]:38058 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQWu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 18:50:59 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 18:50:58 EDT
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id MesvljwfE1iLSMeswlCzZ8; Wed, 17 Mar 2021 22:43:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1616021006; bh=f0W65uxLnnLh2EG6vmfeC3FayRcJHRsvEi3Zj4RlTFE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=BsjOJDJ/kEHayij6pCgr0DGPUry3AW0whi3bFlV4/jpL+QWCvWB9Vb5m9f2fJb/yQ
         J1Q/MpwJ3KOgfiJrrP02bFoR2m8J9RH3e8vsl7Uqyk+yNjqmmPbENmDi8W1h5W9V4b
         iLxeAskVv7KI2O7zcblRl9emuJ2dXo3mBQSxdF+HTkga/yedwuBctBgss+TZHh/6Bn
         TYdMfEOmMV2CY30L1AKzuXBY5S6dpn/iVQ+aP6VP560v8RGmmICAidYsFQBO5vt7y3
         QoPVPPMnOkR9ZwloMcTdxUeI6wd4gIa59+DPF9cNcGtBKDICNyfdrmys2SAwU80Ii3
         zCCQosjVVRioQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IYUcpVia c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=Oh2cFVv5AAAA:8 a=UlqV6C1OAAAA:20
 a=C8lbFo3dAAAA:20 a=K6LVqLdWAAAA:20 a=1i1UBQkp0uoN2HncmwYA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=7KeoIwV6GZqOttXkcoxL:22
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Mar 2021, #05; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqblbhtoa6.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9047c32c-de07-fae0-263a-0070b2a94ad8@ramsayjones.plus.com>
Date:   Wed, 17 Mar 2021 22:43:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqblbhtoa6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHMi9uMm7jrYqgH5MaSYqOSwTveegfr6yVtL1hb1WxkUkzyEbzT1eaH9CIfu+vEyvg5iUUTjmeKLu1k6uK8aBSW9er4ARs1a/ekGvhQZE019NyPi/DPe
 F0CYghuIVJFh7LDifwryOAwjczslvKK1Pm+U8I3/NFb1xWylOGK6bWnQd9CNiS0lEs4t66zB1mM2qg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/03/2021 22:21, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
> with '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> Git 2.31 has been tagged.  We will hopefully either (1) not see
> brown-paper-bag breakages at all, or (2) will see some but can
> immediately deal with them, in coming couple of days.  After that,
> the 2.32 cycle will gain steam, starting next week.  Let's see.
> 
> Many topics marked as "Will cook in 'next'" should be marked for
> merging to 'master' now, but that hasn't happened yet.  Please
> nominate those that should be kicked back from 'next' to 'seen', if
> there are any.  Please also nominate those that should be among the
> first batch of topics to be in 'master' (after a handful of 2.31
> regression fixes go through 'next' down to 'master', that is).
> 
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.
> 
> With maint, master, next, seen, todo:
> 
> 	git://git.kernel.org/pub/scm/git/git.git/
> 	git://repo.or.cz/alt-git.git/
> 	https://kernel.googlesource.com/pub/scm/git/git/
> 	https://github.com/git/git/
> 	https://gitlab.com/git-vcs/git/
> 
> With all the integration branches and topics broken out:
> 
> 	https://github.com/gitster/git/
> 
> Even though the preformatted documentation in HTML and man format
> are not sources, they are published in these repositories for
> convenience (replace "htmldocs" with "manpages" for the manual
> pages):
> 
> 	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
> 	https://github.com/gitster/git-htmldocs.git/

Just FYI, the docs repos are still @ v2.31.0-rc2. (I built the
docs locally for this release).

ATB,
Ramsay Jones


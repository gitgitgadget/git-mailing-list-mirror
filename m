Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2DBC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ED0611EE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhIJPrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhIJPrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:47:09 -0400
X-Greylist: delayed 1530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Sep 2021 08:45:58 PDT
Received: from silly.haxx.se (silly.haxx.se [IPv6:2a02:750:7:3305::2aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B6C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:45:57 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 5AB335F744; Fri, 10 Sep 2021 17:45:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 5889D7DA35;
        Fri, 10 Sep 2021 17:45:56 +0200 (CEST)
Date:   Fri, 10 Sep 2021 17:45:56 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@silly
To:     Jeff King <peff@peff.net>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
In-Reply-To: <YTt5nhXfZ8CRYayk@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.2109101740380.2614@fvyyl>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com> <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com> <YTkNdGk28UJnSDVt@coredump.intra.peff.net> <xmqqv939wdgl.fsf@gitster.g>
 <YTtpWADzTJEAIvk+@coredump.intra.peff.net> <87tuiscwso.fsf@evledraar.gmail.com> <YTt5nhXfZ8CRYayk@coredump.intra.peff.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Sep 2021, Jeff King wrote:

>> 1. protip: curl.git git tags are rather useless, since (at least for old
>>    versions) the embedded version number is bumped sometime *after* the
>>    release).

(double-level quote since I miseed the original email saying this)

This is simply not true and it makes me really curious why you would think 
this.

We (in the curl project) tag the git repository exactly at the point we 
generate the release from. The release is however the generated tarball, and 
the tag is the moment in the git history where the release was done. That's 
why the release number at the time of the tag will always say "blabla-DEV" 
something.

I know this, becasue I've done every single curl release personally, since the 
dawn of time. Of course we've only used git since about 2010 but I can't 
remember that we ever did it differently.

The exact step-by-step to do a release is also documented since years back:
   https://curl.se/dev/release-procedure.html

-- 

  / daniel.haxx.se

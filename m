Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02990C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 08:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCYIGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCYIGG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 04:06:06 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1EF12841
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:06:04 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id CB0B124330
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 04:05:48 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfyuK-Yh6-00
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 09:05:48 +0100
Date:   Sat, 25 Mar 2023 09:05:48 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <ZB6rXKOjOI40khj1@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
 <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
 <ZB3z3e5G3Lrv9g3Y@ugly>
 <20230324191302.GB536967@coredump.intra.peff.net>
 <ZB4A7+LMY+NSaPYE@ugly>
 <20230324204504.GB549549@coredump.intra.peff.net>
 <ZB4e/yE+25W66z6S@ugly>
 <20230325063035.GA562387@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230325063035.GA562387@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 02:30:35AM -0400, Jeff King wrote:
> Nobody has yet; you could be that someone. ;)
>
damn ;)

>I do think there might be some complications, though. I think we may
>build commit graphs by default these days during "gc" and even
>incrementally after "fetch". If we warned when the graphs are disabled,
>it basically means that every command in a repo with replace refs would
>issue the warning.
>
yeah, i thought about that, too ...

it would be easy enough to squelch the warning by manually disabling 
writing or using the graph. the downside is that if the root cause gets 
fixed, the user would be still missing out (unless they read the 
changelog and remembered to reconfigure all affected repos).

one could make it an advisory message which can be explictly squelched.

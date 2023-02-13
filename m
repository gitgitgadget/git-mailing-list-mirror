Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53DC636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBMXal (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBMXaj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 18:30:39 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B88572B0
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 15:30:38 -0800 (PST)
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pRiHM-0005gf-DU;
        Mon, 13 Feb 2023 23:30:36 +0000
Message-ID: <13cef8e7-71af-27a5-77a3-a08f75720d1a@iee.email>
Date:   Mon, 13 Feb 2023 23:30:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] fetch: support hideRefs to speed up connectivity
 checks
Content-Language: en-GB
To:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20230209122857.M669733@dcvr> <20230212090426.M558990@dcvr>
 <Y+qjRZTn7DNib1uB@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y+qjRZTn7DNib1uB@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/02/2023 20:53, Jeff King wrote:
> On Sun, Feb 12, 2023 at 09:04:26AM +0000, Eric Wong wrote:
>
>>  Sidenote: I'm curious about the reason $(pwd) is used in some
>>  places while $PWD seems fine in others, so it doesn't seem to be
>>  a portability problem.  I chose $PWD since it's faster.
> It sometimes matters; one is a Windows path (with "C:\", etc) and one is
> a Unix-style path. Many spots are happy with either type, but it
> sometimes bites us when doing string comparisons, or in a few specific
> cases. See
>
>   https://lore.kernel.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/
>
> for an example.
>
There is guidance in t/README L680-684 though it maybe not that easy to
spot.

A more recent patch was
https://lore.kernel.org/git/4f5c5633-f5a2-3c99-329e-3057b8d447d2@kdbg.org/
with slightly more details.

Philip



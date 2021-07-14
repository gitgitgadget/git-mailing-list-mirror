Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8EC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B41960200
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhGNLK2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 14 Jul 2021 07:10:28 -0400
Received: from mail02.x-net.at ([83.65.141.138]:50262 "EHLO mail02.x-net.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhGNLK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:10:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail02.x-net.at (Postfix) with ESMTP id 7286638057B;
        Wed, 14 Jul 2021 13:07:34 +0200 (CEST)
Received: from mail02.x-net.at ([127.0.0.1])
        by localhost (mail02.x-net.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2MpmK5cUCf3K; Wed, 14 Jul 2021 13:07:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail02.x-net.at (Postfix) with ESMTP id E028D380579;
        Wed, 14 Jul 2021 13:07:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at x-t.at
Received: from mail02.x-net.at ([127.0.0.1])
        by localhost (mail02.x-net.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hupoNcummilC; Wed, 14 Jul 2021 13:07:33 +0200 (CEST)
Received: from [127.0.0.1] (178.165.190.225.wireless.dyn.drei.com [178.165.190.225])
        by mail02.x-net.at (Postfix) with ESMTPSA id 92BBF3804E0;
        Wed, 14 Jul 2021 13:07:33 +0200 (CEST)
Date:   Wed, 14 Jul 2021 13:07:37 +0200
From:   Mel Dafert <mel@dafert.at>
To:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
CC:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ping Yin <pkufranky@gmail.com>
Subject: Re: Bug with branches/merges in submodules
User-Agent: K-9 Mail for Android
In-Reply-To: <b519a79a-5e35-bb40-71d3-0fb3c65320d7@gmail.com>
References: <E9E32A45-DA88-47CB-B7F9-F01F9BEC394C@dafert.at> <b519a79a-5e35-bb40-71d3-0fb3c65320d7@gmail.com>
Message-ID: <6502FFC0-E19B-41FA-B152-885B339360F0@dafert.at>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philippe,
Thank you for your reply, and the points to the mailing list.

>Thanks for the reproducer. The behaviour for 'git log/show/diff' is due this line
>and the behaviour for 'git submodule summary' to these lines.
>
>For 'git diff' and friends, it goes back to the addition of the '--submodule=log'
>option in 752c0c2492 (Add the --submodule option to the diff option family, 2009-10-19).
>(authored CC'ed). The use of '--first-parent' was discussed on the list
>when this was implemented. I did not read the whole thing.
>
>For 'git submodule summary', it goes back to the addition of the subcommand
>in 1cb639e6b0 (git-submodule summary: show commit summary, 2008-03-11). (author also CC'ed).
>The justification of the use of '--first-parent' was not really discussed
>as far as I could tell.
>
>
>I personnally think it would be a good addition to be able to choose
>if yes or no '--first-parent' should be used

The discussion you found [1] also suggested that as a future option.

In the original implementation, the first mention is [2], where the length of the
message is discussed - I (and later discussions) assume that this just
happened to be the preference of the author.

I would thus like to correct myself, and refile this as a feature request - it would
be very helpful to me to have this as an option, possibly even with one that can be set in the config, similar to
'diff.submodule=log'.

I would be open to implementing this - I might need some mentoring, however, as
this would be my first time contributing (and reading the git codebase).

Regards,
Mel

[1] https://lore.kernel.org/git/67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de/t/#u
[2] https://lore.kernel.org/git/46dff0320803061750x70d059a2yaf1e5751e9c62150@mail.gmail.com/

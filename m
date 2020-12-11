Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B99C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 23:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFCE20DD4
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 23:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406532AbgLKWLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 17:11:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45737 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392187AbgLKWKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 17:10:32 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BBM9cNd012030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 17:09:39 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6C468420136; Fri, 11 Dec 2020 17:09:38 -0500 (EST)
Date:   Fri, 11 Dec 2020 17:09:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
Message-ID: <20201211220938.GB575698@mit.edu>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
 <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
 <20201210152715.GQ52960@mit.edu>
 <xmqqim99wm61.fsf@gitster.c.googlers.com>
 <CAMP44s2Po25VyHs-xQG0_oKhAOvPK_PNu5edQkYYsScZeBw1nw@mail.gmail.com>
 <xmqqim98inml.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqim98inml.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 11:17:24PM -0800, Junio C Hamano wrote:
> 
> The approach to hold the "future" patch of and keep giving a
> "warning" is still likely to cause damage to people like Ted and
> Dscho (both gave examples of workflowsand automation that currently
> happily creating merges as the user expects, while the user just
> ignores the warning, without being configured at all), when finally
> the "future" patch (after fixing the test breakages, of course)
> lands.  They just ignored the current loud messages---I do not see
> any reason to expect the updated "warning" would have any effect on
> them and help them to prepare for the future default change.

At least for me, it won't break me.  I'm not using an automation, and
in general, if I'm not going to use "git fetch", what I use is "git
pull --ff-only".  If that fails, then I'll fall back to an explicit
"git rebase" or "git merge".

Should I have just set pull.ff=only?  Probably, but I've been typing
"git pull --ff-only" as a finger macro for a long time, and I've been
too lazy to get around to update pull.ff in my ~/.gitconfig.

Even if it did break me, compared to, say, changes to how systemd and
journald work compared to syslog and init scripts, or extra gcc/clang
warnings when I update to a newer version of a Linux distribution, the
changes being discussed here are positively picayune.  :-)

So if we think it is going to make things better going forward, I for
one am very willing to deal with any short-term pain associated with
changes here.

Cheers,

						- Ted

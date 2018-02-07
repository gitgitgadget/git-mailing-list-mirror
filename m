Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC291F404
	for <e@80x24.org>; Wed,  7 Feb 2018 21:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932146AbeBGVSf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 16:18:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63080 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755093AbeBGVSd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 16:18:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 574B8C5001;
        Wed,  7 Feb 2018 16:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=Fdp26Y+QGuHQqzkmq56hiGmv4kQ=; b=NXc7+mc
        +2YT/ywVee0sfbd8qplHdKMinSh4b8mkv7iGfjaRE0A6Pte+cDqnkOA/3kTGI5tr
        lKpV/GM6Eqn1aMxh4VYmntQycxfpTYW1TtOSPzOcPQU22iCrBo4IhbIRSndHXOyV
        OheH63Pt5GhtwW3Ph5UQrQwutnPgbOfVWneQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=EkX6OkfMQfCujU1fha39F5SajLSJdRI8R
        CQf31VYpUAnOuPTBLMPpiI/rufUCeSZKyzx+8dN4+LjBqq2ppmcsx8FhC8H7DCGo
        TnK659QBg2/cJmkSNI5IIg6CqIhFCSgjbyygIuggVuSm6u3buvBO/bShBA05Emjx
        YoAlSYzUBI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FDCDC5000;
        Wed,  7 Feb 2018 16:18:32 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0750C4FFF;
        Wed,  7 Feb 2018 16:18:31 -0500 (EST)
Date:   Wed, 7 Feb 2018 16:18:30 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
Message-ID: <20180207211830.GO1427@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41>
 <20180207172902.GL1427@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1802071529080.14481@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1802071529080.14481@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: 72DD347A-0C4C-11E8-8225-D3940C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:
> not to belabour this (and i'm sure it's *way* too late for that),
> but fedora has the following packaging scheme.  first, there's a bunch
> of stuff in "git-core", which has no dependencies on any other
> git-related packages.

The split in Fedora between git and git-core is done to
minimize the dependencies required for a minimal git
install.  The initial reason was to to allow installing the
git-core package on systems, in containers, etc. without
requiring perl and its various dependencies to be installed.

The name git-core was not chosen to imply any official
status as core versus contrib from upstream.

(Farther back in the past, the main git package (and the
upstream tarball, IIRC) was named git-core due to conflicts
with another tool named git (GNU interactive tools).)

> so with fedora, "git" drags in "git-core" and a small number of
> additional git utilities. all of this leads one to wonder -- is there
> any comprehensible relationship between:
> 
>   1) commands that claim to be in the "git suite"
>   2) commands that come from contrib/
>   3) commands listed at
>      https://www.kernel.org/pub/software/scm/git/docs/
>   4) how different distros package all of the above
> 
> as i think we've noticed, it's not at all clear how git decides what
> is and isn't part of the "official" git suite.

I don't think there's any good reason to use the packaging
of any distribution as the source for what the git project
considers officially part of the suite.  For that, you
should look at the git source and particularly
contrib/README.  The first paragraph says:

    Although these pieces are available as part of the official git
    source tree, they are in somewhat different status.  The
    intention is to keep interesting tools around git here, maybe
    even experimental ones, to give users an easier access to them,
    and to give tools wider exposure, so that they can be improved
    faster.

If anything the Fedora packging does in the splitting or
naming of the git packages is something the git project
feels is incorrect or needlessly confusing, I (with my
Fedora maintainer hat on) would be happy to make any changes
I can to improve things.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some god must protect drunkards and fools, there are so many of them
still around.


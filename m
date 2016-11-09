Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68BD52035F
	for <e@80x24.org>; Wed,  9 Nov 2016 01:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbcKIBlF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 20:41:05 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:57015 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbcKIBlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 20:41:03 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c4Hsq-0001mC-C9; Wed, 09 Nov 2016 01:41:00 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22562.32428.287354.214659@chiark.greenend.org.uk>
Date:   Wed, 9 Nov 2016 01:41:00 +0000
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not
 to abbreviate
Newsgroups: chiark.mail.linux-rutgers.git
In-Reply-To: <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
        <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
        <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
        <22561.44597.59852.574831@chiark.greenend.org.uk>
        <20161108215709.rvmsnz4fvhizbocl@sigill.intra.peff.net>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King writes ("Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate"):
> Yeah, I think git's config system was always designed to carry options
> for porcelains outside of git-core itself. So your new option fits into
> that.

Good, thanks.

> I think the two things I found weird were:
> 
>   - it's in the "log" section, which makes me think it's an option for
>     git-log. But it's not. I'm not sure what the _right_ section is, but
>     hopefully it would make it clear that this is command-agnostic.
> 
>     Something like "gui.abbrevTags" might be OK (and as you note, has
>     precedence). But of course it's possible that a command like "tig"
>     could learn to support it.  I'm not sure if that counts as a GUI or
>     not. :)

I don't really have an opinion about the name.  gui.abbrevTags would
be a possibility.  (It's a bit odd that implicitly, the default would
be `*'.)

>   - The description talks about tag abbreviation, but doesn't really
>     define it. Not being a gitk user, it was hard for me to figure out
>     whether this was even relevant. Does it mean turning
>     "refs/tags/v1.0" into "1.0"? From the rest of the series, it sounds
>     like no. That should be more clear from the documentation.

I can do that, sure.

By default, gitk doesn't like to use much screen real estate for tags.
If there are long tag names, or many tags, it shows them all as a
single small indication saying just `<tag...|' or whatever with the
literal `tag...', not with the tag value.

Maybe a better name would be
   gui.alwaysShowTags
?

I'm happy to be just told what the name ought to be, if the gitk and
git maintainers can agree.  It seems largely a matter of taste.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.

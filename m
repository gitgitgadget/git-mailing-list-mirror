Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11B12021E
	for <e@80x24.org>; Tue,  8 Nov 2016 10:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbcKHKwF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 05:52:05 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:42546 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbcKHKwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 05:52:02 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c4405-0002Al-4S; Tue, 08 Nov 2016 10:51:33 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22561.44597.59852.574831@chiark.greenend.org.uk>
Date:   Tue, 8 Nov 2016 10:51:33 +0000
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] config docs: Provide for config to specify tags not
 to abbreviate
In-Reply-To: <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
        <20161108005241.19888-6-ijackson@chiark.greenend.org.uk>
        <CA+P7+xoQFsN1tPvKCA6+aRMChFwpMs73D=2kwvVRcxALWK0mZQ@mail.gmail.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller writes ("Re: [PATCH 5/6] config docs: Provide for config to specify tags not to abbreviate"):
> On Mon, Nov 7, 2016 at 4:52 PM, Ian Jackson
> <ijackson@chiark.greenend.org.uk> wrote:
> > +log.noAbbrevTags::
> > +       Each value is a glob pattern, specifying tag nammes which
> > +       should always be displayed in full, even when other tags may
> > +       be omitted or abbreviated (for example, by linkgit:gitk[1]).
> > +       Values starting with `^` specify tags which should be
> > +       abbreviated.  The order is important: the last match, in the
> > +       most-local configuration, wins.
> > +
> 
> It seems weird that this description implies some sort of behavior
> change in core git itself, but in fact is only used as a reference for
> other tools that may or may not honor it. I guess the reasoning here
> is to try to get other external tools that abbreviate tags to also
> honor this? But it still seems pretty weird to have a documented
> config that has no code in core git to honor it...

Thanks for your attention.

Yes, I agree that it does seem weird.  But the alternatives seem
worse.  I think it's probably best if options like this (currently
only honoured by out-of-core tools but of general usefulness) are
collected together here.

There is a precedent: `git config gui.encoding' is, according to the
documentation, honoured only by git-gui and gitk.

Calling the config option `gitk.noAbbrevTags' would be possible but
that would invite everyone else to invent their own, which would be
quite annoying.  (Also, gitk does not have any gitk-specific git
config options right now, AIUI.  It does honour `git config
gui.encoding'.)

Would it help to add a sentence to the documentation saying that this
is currently only honoured by gitk ?  (The paragraph for gui.encoding
says something similar.)  Of course I don't know who else abbreviates
tags, but as they gain support they could be added to the docs.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.

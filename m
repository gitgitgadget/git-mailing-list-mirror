From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Tue, 28 Mar 2006 23:21:54 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne2jh8i.s3g.mdw@metalzone.distorted.org.uk>
References: <15693.1143575188@lotus.CS.Berkeley.EDU> <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603281500280.15714@g5.osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 29 01:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FONVt-0004U8-Ck
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 01:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWC1XV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 18:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWC1XV5
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 18:21:57 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:34146 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S964820AbWC1XV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 18:21:56 -0500
Received: (qmail 16211 invoked by uid 110); 28 Mar 2006 23:21:54 -0000
To: git@vger.kernel.org
Received: (qmail 16195 invoked by uid 9); 28 Mar 2006 23:21:54 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143588114 16193 172.29.199.2 (28 Mar 2006 23:21:54 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Tue, 28 Mar 2006 23:21:54 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18140>

Linus Torvalds <torvalds@osdl.org> wrote:

> I'd really just prefer to make the "-p" switch configurable, the way
> it was before. No regexps, just the same rules as for GNU diff,

The rules for GNU diff aren't actually good enough if you can't
configure them.  We used to be able to put runes in GIT_DIFF_OPTS.

> perhaps with the difference being that it would be on by default.

I thought it /was/ on by default:

: static const char *diff_opts = "-pu";

(killed in cebff98db).

> Another possible approach is to say
>  - if the first line of the real diff matches the rules, do NOT add 
>    another line that matches the rule at the @@-line.
>
> since the simple @@-line rule really doesn't make sense for any file that 
> is "dense" (ie where most lines start with non-whitespace).

It's true, and that's an easy fix.  But it doesn't do any actual harm.

-- [mdw]

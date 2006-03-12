From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 18:01:09 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne18of5.fr9.mdw@metalzone.distorted.org.uk>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org>
X-From: git-owner@vger.kernel.org Sun Mar 12 19:01:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIUsV-0004Na-C8
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 19:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWCLSBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 13:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWCLSBM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 13:01:12 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:42696 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751581AbWCLSBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 13:01:11 -0500
Received: (qmail 22296 invoked by uid 110); 12 Mar 2006 18:01:09 -0000
To: git@vger.kernel.org
Received: (qmail 22283 invoked by uid 9); 12 Mar 2006 18:01:09 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1142186469 22281 172.29.199.2 (12 Mar 2006 18:01:09 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sun, 12 Mar 2006 18:01:09 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17521>

Linus Torvalds <torvalds@osdl.org> wrote:

> So in modern C, using NULL at the end of a varargs array as a pointer is 
> perfectly sane, and the extra cast is just ugly and bowing to bad 
> programming practices and makes no sense to anybody who never saw the 
> horror that is K&R.

No!  You can still get bitten.  You're lucky that on common platforms
all pointers look the same, but if you find one where `char *' (and
hence `void *') isn't the same as `struct foo *' then, under appropriate
circumstances you /will/ unless you put the casts in.

Now, maybe we don't care for GIT.  That's your (and Junio's) call.  My
natural approach is to work as closely as I can to the specs (and then
throw in hacks for platforms which /still/ don't work), though, which is
why I brought the subject up.

-- [mdw]

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sat, 24 Jun 2006 11:55:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
 <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
 <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 20:56:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuDIX-00045w-4L
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 20:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWFXSzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 14:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWFXSzw
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 14:55:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751039AbWFXSzv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 14:55:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5OItlUT027327
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Jun 2006 11:55:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5OItkE4001061;
	Sat, 24 Jun 2006 11:55:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22536>



On Sat, 24 Jun 2006, Junio C Hamano wrote:
> 
> If somebody has time and inclination, please try updated PPC SHA-1
> from linux@horizon.com that is in "pu" (say make check-sha1) and
> report impressions.

"make check-sha1" passes.

Before:
	[torvalds@g5 linux]$ /usr/bin/time git-fsck-objects --full
	101.90user 4.66system 1:46.72elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+1787158minor)pagefaults 0swaps

After:
	[torvalds@g5 linux]$ /usr/bin/time ~/git/git-fsck-objects --full
	101.16user 4.32system 1:45.56elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+1787127minor)pagefaults 0swaps

which doesn't seem to really imply anything seriously changed (in fact, 
rerunning it made the numbers even closer).

This is on a G5 powerpc.

Also, "pu" in general is totally unusable. It doesn't even compile.

I think that "Git.xs" thing is fine for random hacks, but please please 
PLEASE don't make any central program depend on it.

		Linus

From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: SIGSEGV in merge recursive
Date: Fri, 29 Dec 2006 12:24:52 -0800 (PST)
Message-ID: <898450.11823.qm@web31804.mail.mud.yahoo.com>
References: <7v7iwampi4.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 21:25:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0OHk-0007aQ-9X
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 21:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbWL2UYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 15:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWL2UYy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 15:24:54 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:37938 "HELO
	web31804.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965141AbWL2UYx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Dec 2006 15:24:53 -0500
Received: (qmail 12025 invoked by uid 60001); 29 Dec 2006 20:24:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=v17Yz1ONpy8kQKoYPqKQn2fvDLZBTn9np3siAxnvZxFe5owgbsjq+AHicBfX1hcDtzgCCrx+radJsQcZalvXHqbwYDZ9OFm9bxq5rxKxg4XjGYMAYK4Xtw6zwM9HHwuCKsBm44l8yG8MEqqrl870Sm0KTfQFt0orwCXuuUOrkkE=;
X-YMail-OSG: 3jrJZfoVM1kVTMZroiwQX1nsV_Vr7A_bWaswa.JZ6tLm4aVwslyX7Ha3IQ.D.neUT.i6S9WEqKxTfrhXRhZ7l3cs8OviJYSn3nU7974F55Q4LcdkW.Ailyar8zDUacYZ9IGlMMR1Ye4-
Received: from [71.84.31.238] by web31804.mail.mud.yahoo.com via HTTP; Fri, 29 Dec 2006 12:24:52 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7iwampi4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35608>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > This time it happens when merging one of my git trees into another:
> > ...
> > And here is the backtrace:
> >
> > $gdb ~/bin/git-merge-recursive
> > GNU gdb 6.5
> > Copyright (C) 2006 Free Software Foundation, Inc.
> > GDB is free software, covered by the GNU General Public License, and you are
> > welcome to change it and/or distribute copies of it under certain conditions.
> > Type "show copying" to see the conditions.
> > There is absolutely no warranty for GDB.  Type "show warranty" for details.
> > This GDB was configured as "i686-pc-linux-gnu"...Using host libthread_db library
> > "/lib/libthread_db.so.1".
> >
> > (gdb) run 777f68432f1db967573e5722bf0fd08af05e748f -- HEAD
> > d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
> > Starting program: /home/luben/bin/git-merge-recursive 777f68432f1db967573e5722bf0fd08af05e748f
> --
> > HEAD d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
> > Failed to read a valid object file image from memory.
> 
> Who says this?
> 
> > Merging HEAD with d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
> > Merging:
> > 52d5052 Merge branch 'git-upstream' into git-lt-work
> > d985fda Merge branch 'next' into git-upstream
> > found 1 common ancestor(s):
> > 777f684 Merge branch 'next' into git-upstream
> > Auto-merging .gitignore
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x08070469 in xdl_merge (orig=0xbff3aae0, mf1=0xbff3aad8, 
> >     name1=0x80f5208 "HEAD:.gitignore", mf2=0xbff3aad0, 
> >     name2=0x80f59a8 "d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7:.gitignore", 
> >     xpp=0xbff3aae8, level=2, result=0xbff3aac8) at xdiff/xmerge.c:200
> > warning: Source file is more recent than executable.
> > 200                      */
> 
> What local mods are you running with?

Not much -- the one-offs you've sent to git and me to fix various
problems I've complained about, some scripts of mine which have nothing
to do with merging.  The log of the commits diff between next and
git-lt-work doesn't show anything in the merge area -- only things
I've been active in like gitweb, etc.

     Luben

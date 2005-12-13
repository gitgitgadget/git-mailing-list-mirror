From: Paul Dickson <paul@permanentmail.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9m aka 1.0rc5
Date: Tue, 13 Dec 2005 10:49:03 -0700
Message-ID: <20051213104903.3f6f7c17.paul@permanentmail.com>
References: <7vbqznm4b7.fsf@assigned-by-dhcp.cox.net>
	<20051212183723.c4b09964.paul@permanentmail.com>
	<7vd5k1dax6.fsf@assigned-by-dhcp.cox.net>
	<20051212192013.9ef4c8b2.paul@permanentmail.com>
	<20051212195408.40af06f1.paul@permanentmail.com>
	<7vslsxbl1p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 18:52:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmEH4-0004K3-8q
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 18:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVLMRtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 12:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVLMRtK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 12:49:10 -0500
Received: from vds.fauxbox.com ([208.210.124.75]:21937 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751277AbVLMRtI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 12:49:08 -0500
Received: from thorn (localhost [127.0.0.1])
	by thorn.pobox.com (Postfix) with ESMTP id 3B229E8;
	Tue, 13 Dec 2005 12:49:30 -0500 (EST)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by thorn.sasl.smtp.pobox.com (Postfix) with ESMTP id E0DF31C27;
	Tue, 13 Dec 2005 12:49:28 -0500 (EST)
Received: from white.pwd.internal ([192.168.1.9])
	by red.pwd.internal (8.13.5/8.13.4) with SMTP id jBDHn4hq009890;
	Tue, 13 Dec 2005 10:49:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslsxbl1p.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.8; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13581>

On Mon, 12 Dec 2005 21:52:50 -0800, Junio C Hamano wrote:

> Paul Dickson <paul@permanentmail.com> writes:
> 
> >> I would suspect groff (as used by man).
> >> 
> >>   $ zcat /usr/share/man/man1/git-repack.1.gz|grep '^[A-Z][a-z]* by'
> >
> > I think it's up one level to the creator of the man files:
> >
> > .SH "DESCRIPTION"
> > This script is used to combine all objects that do not currently reside in a "pack", into a pack..sp
> 
> Hmph.  In the same environment as before:
> 
> $ rm -f git-repack.1
> $ make git-repack.1
> rm -f doc.dep+ doc.dep
> perl ./build-docdep.perl >doc.dep+
> mv doc.dep+ doc.dep
> asciidoc -b docbook -d manpage -f asciidoc.conf git-repack.txt
> xmlto man git-repack.xml
> Writing git-repack.1 for refentry
> rm git-repack.xml
> $ make git-repack.xml
> asciidoc -b docbook -d manpage -f asciidoc.conf git-repack.txt
> $ grep osdl git-repack.1 git-repack.xml
> git-repack.1:Written by Linus Torvalds <torvalds@osdl\&.org>
> git-repack.xml:<simpara>Written by Linus Torvalds &lt;torvalds@osdl.org&gt;</simpara>
> $ exit
> 
> And it is the same on kernel.org machine I have account on.
> 

I filed:  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175592

Apparently, it's a docbook style issue.

	-Paul

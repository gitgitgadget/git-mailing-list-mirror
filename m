From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 23 Apr 2007 23:16:58 +0200
Message-ID: <20070423211658.GA21404@steel.home>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net> <7v647tcjr6.fsf@assigned-by-dhcp.cox.net> <7vejmdq63w.fsf@assigned-by-dhcp.cox.net> <7v647ninbq.fsf@assigned-by-dhcp.cox.net> <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com> <7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:17:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg5uI-0002lG-Ba
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 23:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbXDWVRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 17:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbXDWVRF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 17:17:05 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:50520 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbXDWVRD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 17:17:03 -0400
Received: from tigra.home (Fcb75.f.strato-dslnet.de [195.4.203.117])
	by post.webmailer.de (fruni mo14) (RZmta 5.6)
	with ESMTP id B01574j3NHe9QO ; Mon, 23 Apr 2007 23:17:01 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 87399277BD;
	Mon, 23 Apr 2007 23:16:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 69A3DBDDE; Mon, 23 Apr 2007 23:16:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsCoME=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45364>

Junio C Hamano, Mon, Apr 23, 2007 19:15:16 +0200:
> >> As 'ident' conversion is stateless, I do not mind too much
> >> including it in v1.5.2-rc1.  On the other hand, the arbitrary
> >> 'filter' is quite contentious, although the character-code
> >> conversion example I gave myself might be a good enough reason
> >> for people to want it.  Undecided.
> >
> > Can I suggest a config option to completely disable content
> > munging code? So that people who really care about the
> > real content, or just don't have the tools for the filters still
> > can checkout the repos depending on the filters.
> 
> The code may have bugs, but the intent is that you can have this
> line in your $GIT_DIR/info/attributes to override whatever
> attribute settings used in .gitattributes files that are
> in-tree:
> 
> 	*	!ident !filter
> 

Imagine a project which started using the attributes at some point of
time. And imagine developers whose repos suddenly start breaking
because of clueless integrator created a filter which does not work
anywere but his system (typical, really) and didn't tell anyone to
update their configuration (whereas .gitattribute files are in working
trees already).

How do you suggest to distribute filter configurations, BTW?
They are not cloned (can they?)
How about checkout performance impact? (in case they are not active,
of course. You're hosed anyway if the filters used. Especially if you
happen to have real big files).

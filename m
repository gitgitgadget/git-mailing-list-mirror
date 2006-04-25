From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 12:09:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251204320.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
 <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
 <7vr73lwkdt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 21:09:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSut-0002Sz-T8
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 21:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWDYTJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 15:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDYTJk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 15:09:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751267AbWDYTJj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 15:09:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PJ9YtH019858
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 12:09:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PJ9XHQ001497;
	Tue, 25 Apr 2006 12:09:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr73lwkdt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19171>



On Tue, 25 Apr 2006, Junio C Hamano wrote:
> 
> Actually, it does help Porcelain to be able to mark unrelated
> crud as 'note'. 

A "note" header that explicitly has no meaning _what-so-ever_ for git 
would be fine. Then the semantics are well-defined, and they really do 
boil down to: random strings that git will ignore, and that won't normally 
be shown by "git log".

Those are actually real semantics, the same way the current "content" is 
real semantics: we don't care about it at all, and we _guarantee_ that we 
don't care about it.

The problem with the proposed "related" thing was that it was somethign 
that git was supposed to care about, but since it had no sane semantics, 
there was no way to _make_ git care about it sanely. That was the problem.

So I'm not objecting to adding headers. I'm objecting to adding headers 
that have insane or badly defined semantics where we might be asked to do 
something for them and different versions of git migth do different 
things. 

			Linus

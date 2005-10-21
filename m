From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 17:19:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201717100.10477@g5.osdl.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
 <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com>
 <Pine.LNX.4.63.0510210140400.12723@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510201647490.10477@g5.osdl.org>
 <Pine.LNX.4.63.0510210157070.14563@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junio@twinsun.com>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 02:21:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkdu-0001eM-AA
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVJUATz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVJUATz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:19:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932561AbVJUATy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:19:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9L0JhFC003333
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 17:19:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9L0Jg06016417;
	Thu, 20 Oct 2005 17:19:42 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510210157070.14563@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10392>



On Fri, 21 Oct 2005, Johannes Schindelin wrote:
> > 
> > Oh, they'll need to revert if they want to match Junios history. Otherwise 
> > they'll always generate yet another merge when they pull.
> 
> So?

History matters. History matters as much as the data does.

> It does not have to be a fast-forward. After all, what is another merge? 
> Since that merge does not have Junio as committer, close inspection of 
> the commit will reveal that.

It _does_ have to be a fast-forward, if you expect the tree to have the 
same content as Junio's.

Even if it merges everything automatically, if the history is different, 
it could in theory at least merge _differently_ than what Junio had. Plus 
you'll have a really ugly version history for no good reason.

But yes, it will _work_. It just won't work the way people expect it to, 
so they'll make bug-reports about not being able to merge automatically, 
and others will say that they can't re-create it and blame the wrong 
person.

		Linus

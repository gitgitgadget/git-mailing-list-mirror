From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Finally implement "git log --follow"
Date: Thu, 21 Jun 2007 09:09:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706210907190.3593@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
  <e5bfff550706192327l187b30eblb5bd5e4e76b3eab6@mail.gmail.com> 
 <alpine.LFD.0.98.0706200940000.3593@woody.linux-foundation.org>
 <e5bfff550706202321t354ec0e3xb218f382f1c983ae@mail.gmail.com>
 <alpine.LFD.0.98.0706210842340.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211654100.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 21 18:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1PEF-0001sF-AD
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbXFUQJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 12:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbXFUQJp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 12:09:45 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44727 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753661AbXFUQJo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 12:09:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LG9c2k012001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 09:09:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LG9Xpm031953;
	Thu, 21 Jun 2007 09:09:33 -0700
In-Reply-To: <Pine.LNX.4.64.0706211654100.4059@racer.site>
X-Spam-Status: No, hits=-2.528 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50639>



On Thu, 21 Jun 2007, Johannes Schindelin wrote:
> 
> The only quirk here is that "--stdin" makes no sense with a pager. 
> Therefore, you'd have to move the automatic pager invocation to _after_ 
> option parsing.

I don't know.. The pager invocation already checks whether the output is a 
tty. Quite frankly, I think that is sufficient for all cases we're 
discussing right now (ie anybody who uses "--stdin" would *also* redirect 
the output!), and we could certainly make it check that both the input 
*and* the output is a tty.

			Linus

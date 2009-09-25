From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] print_wrapped_text(): allow hard newlines
Date: Fri, 25 Sep 2009 10:21:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909251018200.4985@pacific.mpi-cbg.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org> <1253655038-20335-1-git-send-email-heipei@hackvalue.de> <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
 <alpine.LFD.2.01.0909231659010.3303@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Gilger <heipei@hackvalue.de>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 10:19:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr61D-0000tk-Ak
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 10:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbZIYIS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 04:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbZIYIS6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 04:18:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:34064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752351AbZIYIS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 04:18:56 -0400
Received: (qmail invoked by alias); 25 Sep 2009 08:18:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 25 Sep 2009 10:18:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xbFh0rvOxbDIZHviMmAwA101FG1s2C0BViEN6cd
	UbkzEBrQjX0lak
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0909231659010.3303@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129067>

Hi,

On Wed, 23 Sep 2009, Linus Torvalds wrote:

> On Wed, 23 Sep 2009, Johannes Schindelin wrote:
> > 
> > print_wrapped_text() will insert its own newlines. Up until now, if 
> > the text passed to it contained newlines, they would not be handled 
> > properly (the wrapping got confused after that).
> > 
> > The strategy is to replace a single new-line with a space, but keep 
> > double new-lines so that already-wrapped text with empty lines between 
> > paragraphs will be handled properly.
> 
> May I suggest doing this _only_ if the newline is followed by an 
> alphanumeric characer?
> 
> If the thing is indented ("newline + space") or quoted ("newline + ">" 
> or whatever) then reflowing it is likely wrong and will result in an 
> unholy mess.

After further consideration, I decided to heed your advice; it is an 
obvious improvement when comparing the output with and without the 
isalnum().

So I updated my log-rewrap branch:

http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/log-rewrap

Thanks,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach filter-branch about subdirectory filtering
Date: Fri, 8 Jun 2007 06:04:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080603520.4059@racer.site>
References: <Pine.LNX.4.64.0706080130000.4046@racer.site>
 <7vzm3bmfeq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 07:08:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwWhx-0005QB-IY
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 07:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbXFHFIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 01:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbXFHFIL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 01:08:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:33680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755594AbXFHFIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 01:08:10 -0400
Received: (qmail invoked by alias); 08 Jun 2007 05:08:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 08 Jun 2007 07:08:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ebiY4d6Me5o69HxQ3i+o6882OzqhYIfsEQ18SzI
	RaglXEB/08iswU
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm3bmfeq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49430>

Hi,

On Thu, 7 Jun 2007, Junio C Hamano wrote:

> Good thing you folded git-split into this, which is an obviously right 
> thing to do.

So my secritt evvil plann did not stay secritt that long.

> But it makes me wonder, if it is common to want to split a combined 
> project into two (or more) sets, taking more than one directories at a 
> time.

It's just a guess, but now that we come really, really close to having a 
concise implementation of git-subproject which will probably soon 
propagate to master, and then maint, I gather that more and more people 
come and want to split their projects (which they maintained as one big 
project) into several subprojects (which they should have been from the 
start, but the tool did not easily allow for that).

> We might however want to make sure that we detect an attempt to give 
> more than one --subdirectory-filter parameter.

Yeah. But then, I think that rev-list actually does not like to be passed 
a file/directory which does not exist currently, so that is probably a 
sensible safeguard against that usage.

Unless you think -- as I fear you do -- that people could think 
git-filter-branch (its name not withstanding) filters _multiple_ branches 
_at once_.

That case I did not foresee, and you're right, I should output a big fat 
error for the case when somebody says "filter-branch --subdirectory-filter 
a/ --subdirectory-filter b/". It does not make any sense. But humans are 
known for their unique feeling that things should work, even if they make 
no sense at all, and their brain should have warned them (that it is 
unlikely, at best, to work), but failed to do so.

Ciao,
Dscho

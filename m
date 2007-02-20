From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 10:46:07 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702201040460.31945@xanadu.home>
References: <200702191839.05784.andyparkins@gmail.com>
 <200702201021.58754.andyparkins@gmail.com>
 <7vabz9w270.fsf@assigned-by-dhcp.cox.net>
 <200702201057.21398.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 16:46:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJXC2-0000U2-Go
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 16:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbXBTPqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 10:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbXBTPqK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 10:46:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965021AbXBTPqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 10:46:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDR00AQCQGVCEA0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Feb 2007 10:46:07 -0500 (EST)
In-reply-to: <200702201057.21398.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40241>

On Tue, 20 Feb 2007, Andy Parkins wrote:

> On Tuesday 2007 February 20 10:30, Junio C Hamano wrote:
> 
> > But at least to me,
> >
> > 	if (!prefixcmp(head, PATH_REFS_HEADS))
> > 		head += strlen(PATH_REFS_HEADS);
> >
> > is easier to follow than:
> >
> >         if (ref_is_head(head))
> >                 head += STRLEN_PATH_REFS_HEADS;

Ditto for me.

> Fine.  I don't really mind - and it's less work on my patch :-)
> 
> My argument in favour of the ref_is_head() method is that the prefixcmp() 
> method requires knowledge from the caller about how you tell whether a given 
> ref is a head - the second pushes that information further down the call 
> tree, abstracting it out just a little more.

That's the problem though.  Too much abstraction hides away the purpose.  
With prefixcmp() it shows that the code cares about a string prefix.  
With ref_is_head() you don't know what is happening there since that 
might be many things like a pointer comparison, etc. and you have to 
look ref_is_head() implementation to be sure.


Nicolas

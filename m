From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually
 useful
Date: Mon, 3 Mar 2008 13:01:24 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803031252410.19665@iabervon.org>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWEzS-0004MZ-Jj
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555AbYCCSB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757437AbYCCSB3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:01:29 -0500
Received: from iabervon.org ([66.92.72.58]:56364 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbYCCSB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:01:27 -0500
Received: (qmail 11712 invoked by uid 1000); 3 Mar 2008 18:01:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Mar 2008 18:01:24 -0000
In-Reply-To: <alpine.LSU.1.00.0803021555500.22527@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75957>

On Sun, 2 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 2 Mar 2008, Alex Riesen wrote:
> 
> > -			add_file_to_cache(path, verbose);
> > +			if (add_file_to_cache(path, verbose))
> > +				exit(1);
> 
> Does it really, really _have_ to be exit(1)?  I mean, now you block even 
> the faintest chance that we can libify libgit.a by overriding die_routine.

It would be handy to have a die_no_message(), for cases like this where a 
function wants to print an error message but it's up to the caller whether 
to abort (in the contextually reasonable way).

	-Daniel
*This .sig left intentionally blank*

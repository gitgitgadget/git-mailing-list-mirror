From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 4 Apr 2007 18:59:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704041856210.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net>
 <200704041540.59977.andyparkins@gmail.com> <4613C97C.9050600@dawes.za.net>
 <Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0704040935350.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ8ph-0005u2-Mn
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbXDDQ7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXDDQ7i
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:59:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:49454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751341AbXDDQ7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 12:59:37 -0400
Received: (qmail invoked by alias); 04 Apr 2007 16:59:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 04 Apr 2007 18:59:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bfQg8Ak3bdTBVlvTZRYbK80APAX6ZwKPlWFOqXs
	AAL322CsmS7LVI
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0704040935350.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43757>

Hi,

On Wed, 4 Apr 2007, Linus Torvalds wrote:

> On Wed, 4 Apr 2007, Johannes Schindelin wrote:
> > 
> > The subtle difference: your approach is _expensive_ in terms of CPU time, 
> > while the byte change approach is _dirt cheap_.
> 
> Well, you could do a combination (still dirt cheap):
>  - show the size before/after (and yes, new/delete should be separate from 
>    "zero size before/after")
>  - show the size of the binary patch.

... and by this (size of binary patch) you mean the deltified object?

In general, we do not have the binary patch. And the generation of that 
binary patch is what I was referring to being expensive.

Remember, most binary files are way larger than the average source code 
files we have, since it is much, much easier to generate binary data than 
to write meaningful code. Therefore, the binary patch generation has to 
look at much larger pieces to begin with, which translates into CPU time.

Having said that, I have to admit that I don't have numbers backing this 
reasoning up. So, if somebody comes up with numbers contradicting my 
theory, I will gladly change my mind.

Ciao,
Dscho

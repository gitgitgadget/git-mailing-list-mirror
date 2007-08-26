From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls?
 etc.
Date: Sun, 26 Aug 2007 17:05:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708261656500.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
 <7v1wdqud0z.fsf@gitster.siamese.dyndns.org> <52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 17:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPJgW-00080c-Up
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 17:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbXHZPFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 11:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbXHZPFX
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 11:05:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:60331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750772AbXHZPFW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 11:05:22 -0400
Received: (qmail invoked by alias); 26 Aug 2007 15:05:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp050) with SMTP; 26 Aug 2007 17:05:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MY290T/LMN2oxUY6kVleqHP223xMPEhCQFVIkyZ
	Pnqfv4QA4IGy8+
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56688>

Hi,

On Sat, 25 Aug 2007, Dmitry Kakurin wrote:

> ----- Original Message ----- From: "Junio C Hamano" <gitster@pobox.com>
> >> 2. Storing metadata in regular source-controlled files feels wrong to 
> >> me.
> > You are free to _feel_ whatever you want without thinking, but
> 
> I did quite a bit of thinking before posting it. Not sure what made you 
> think otherwise.

Well, it certainly appears to me that your proposal to move metadata from 
the working tree (where it is visible, and easily editable with the editor 
of _your_ choice) to the index (where it is hidden, and could only be 
edited with _yet another_ git command) is not well thought through.

It certainly would make some common operation much more complicated, for 
no gain at all.

Should you still not be convinced, please find some convincing mails by 
Linus (which are  much longer than I would have the patience to write) 
where he goes into detail _why_ it is _wrong_ to _hide_ things away from 
the working tree.

(Just a small hint: git is much more powerful _because_ it keeps metadata 
visibly in the filesystem.)

As for your proposal to munge the different metadata files into sections 
of _one_ file: I doubt that this is "cleaner" or "more elegant" than what 
we have now.  For one, if a script fscks up one file, it does not fsck up 
the others.

For another, scripts do not have to jump through hoops to edit the 
metadata files, as long as they do not have sections (containing 
completely independent informations).

Ciao,
Dscho

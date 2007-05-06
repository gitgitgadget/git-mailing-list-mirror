From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Mon, 7 May 2007 01:12:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705070110040.4167@racer.site>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site>
 <7vwszolz26.fsf@assigned-by-dhcp.cox.net> <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
 <Pine.LNX.4.64.0705051637450.4015@racer.site> <7vwszmfod8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705061653100.4015@racer.site> <7v1whtdfd2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 01:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpth-0000Vp-5Q
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbXEFXMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbXEFXMF
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:12:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:33784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752097AbXEFXME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:12:04 -0400
Received: (qmail invoked by alias); 06 May 2007 23:12:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 07 May 2007 01:12:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nqmEhCQnnXs+St+RmZz7JUV7QjAoZFCa2YAvwof
	IJwvWzL/6EFsrX
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1whtdfd2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46395>

Hi,

On Sun, 6 May 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 5 May 2007, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> >> (a) In a bare repository, I believe 
> >> >> setup.c:setup_git_directory_gently() determines the prefix to be 
> >> >> NULL.  This means my patch will see ALL paths as absolute, except 
> >> >> :../path which will result in an error.
> >> >
> >> > My point was that it feels inconsistent to take the current path into 
> >> > account in one case, but not in the other.
> >> 
> >> I do not understand your reasoning.  In a bare repository you cannot 
> >> even be in a subdirectory to begin with.
> >
> > Exactly! That is my point. If you can do it in a working directory, but 
> > also with a bare repository, I find it highly confusing and inconsistent 
> > to have different meaning.
> 
> Sorry.  Now you confused me further.  I can do:
> 
> 	cd Documentation
>         git diff v1.5.0 v1.5.1 -- git.txt
> 
> Is that confusing, inconsistent and bad for the users?

Well, I am partly at fault that you _can_ execute git-diff outside of a 
repository.

But given the _arguments_ you give to git-diff as above, I'd expect it to 
actually care about the working directory. IOW I would _not_ expect this 
to work outside of a working directory (even if it does).

Ciao,
Dscho

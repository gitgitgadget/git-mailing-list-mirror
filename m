From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Tue, 10 Oct 2006 00:48:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610100045430.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com> 
 <4529B77A.707@gmail.com>  <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org>
 <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Liu Yubao <yubao.liu@gmail.com>,
	Dongsheng Song <dongsheng.song@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 00:49:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX3ve-0003uK-PP
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 00:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWJIWs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJIWs4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 18:48:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:696 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750710AbWJIWsz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 18:48:55 -0400
Received: (qmail invoked by alias); 09 Oct 2006 22:48:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 10 Oct 2006 00:48:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28582>

Hi,

On Tue, 10 Oct 2006, Martin Langhoff wrote:

> On 10/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> >  - outside of the SCM, keyword substitution can make sense, but doing it
> >    should be in helper scripts or something that can easily tailor it for
> >    the actual need of that particular project.

... like a pre-commit hook.

> If we have a tool that I can pass a file or a directory tree and will 
> find the (perfectly|closely) matching trees and related commits.
> 
> For the single file case, searching for an exact SHA1 match is easy,
> as is by path.

If you have the path, you can reuse the whole algorithm for finding the 
best delta base.

However, if you do not have the path, you might as well just give up (if 
there is no perfect match for the SHA1), since the SHA1 is _not_ similar 
for similar contents. IOW, you'd literally have to search _all_ objects in 
the repository, which usually takes a long, long time.

Ciao,
Dscho

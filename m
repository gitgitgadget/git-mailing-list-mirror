From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Tue, 29 May 2007 12:12:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705291209510.4648@racer.site>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <20070528213511.GB7044@spearce.org> <alpine.LFD.0.98.0705282008400.26602@woody.linux-foundation.org>
 <200705291204.10606.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Johan Herland <johan@herland.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 13:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HszdX-00087o-26
	for gcvg-git@gmane.org; Tue, 29 May 2007 13:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbXE2LMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 07:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756172AbXE2LMT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 07:12:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:49753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753887AbXE2LMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 07:12:18 -0400
Received: (qmail invoked by alias); 29 May 2007 11:12:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 29 May 2007 13:12:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pXoQ8r18pJtx1Q4J020CQpeYgcXeDZMsW+cYNiz
	j7xYIHE+sHZHAA
X-X-Sender: gene099@racer.site
In-Reply-To: <200705291204.10606.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48683>

Hi,

On Tue, 29 May 2007, Andy Parkins wrote:

> On Tuesday 2007 May 29, Linus Torvalds wrote:
> 
> > So you'd have to have a separate database. You could do it with a 
> > separate index file (or mixing it up with the "index v4" and doing it 
> > with a single index file that also contains normal objects), but the 
> > point is, it's going to be a real separate database.
> 
> This is an off-the-wall suggestion; but why not use the object database 
> a bit more strongly than just for storing the notes?

I alluded to the same yesterday.

However, just before waking up, I had the same idea as you, using a 
branch.

> So where a normal tree has
> 
> 100644 blob 156e952df8603c72532bcda95ddcd3bcb16ec5fd somefile
> 
> A "notes" tree would have
> 
> 100644 blob 156e952df8603c72532bcda95ddcd3bcb16ec5fd $SHA1_OF_TARGET_COMMIT1
> 100644 blob 97e08b0ab483146cb8fff31138eaa828c24ac84f $SHA1_OF_TARGET_COMMIT2

Actually, just throw in one fan-out stage, and you should be fine, 
performance-wise.

And what is best: you could merge notes from somebody else easily, 
_exactly_ because it is a proper branch now.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [CLEANUP PATCH RESEND] git wrapper: Make while loop more
 reader-friendly
Date: Fri, 2 Jan 2009 19:49:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021947170.30769@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901021240270.27818@racer> <200901021228.07599.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIp6g-0007em-IP
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902AbZABSt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757657AbZABSt2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:49:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:34672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752891AbZABSt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:49:28 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:49:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 02 Jan 2009 19:49:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jA8lCI2xjizNazulEbKhyYoXVS/s0IiBsLCILwj
	8aYmd9liksZl+8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901021228.07599.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104400>

Hi,

On Fri, 2 Jan 2009, Boyd Stephen Smith Jr. wrote:

> On Friday 2009 January 02 12:07:52 you wrote:
> > It is not a good practice to prefer performance over readability in
> > something as performance uncritical as finding the trailing slash
> > of argv[0].
> >
> > So avoid head-scratching by making the loop user-readable, and not
> > hyper-performance-optimized.
> 
> > -	do
> > -		--slash;
> > -	while (cmd <= slash && !is_dir_sep(*slash));
> > +	while (cmd <= slash && !is_dir_sep(*slash))
> > +		slash--;
> 
> What confused people?  The predecrement or the do/while?  Should people that 
> don't understand one of those be hacking on git?
> 
> That said, I'm not opposed to the patch.  It is easier on the eyes, though I 
> prefer the one-liner:
> for (; cmd <= slash && !is_dir_sep(*slash); --slash);

As I mentioned in the commit message: readability is something to be 
cherished and worshipped.

For your pleasure, I will not go into details about the motions my bowels 
went through when I looked at those three lines.  Or your single line, for 
that matter.

Ciao,
Dscho

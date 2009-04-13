From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
 index)
Date: Mon, 13 Apr 2009 18:19:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904131817160.10279@pacific.mpi-cbg.de>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>  <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>  <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>  <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
  <alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de> <fabb9a1e0904101159w7ab19247k81f4b67b8a91198f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtOrz-00048o-7n
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 18:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbZDMQRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 12:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbZDMQRL
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 12:17:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:42699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753412AbZDMQRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 12:17:09 -0400
Received: (qmail invoked by alias); 13 Apr 2009 16:17:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 13 Apr 2009 18:17:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OXCBRfiFO9CF/QuVPL4jTOIhyHYgs4zystpdemQ
	n8Nd4O0PkY2LwK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0904101159w7ab19247k81f4b67b8a91198f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116445>

Hi,

On Fri, 10 Apr 2009, Sverre Rabbelier wrote:

> On Fri, Apr 10, 2009 at 20:10, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> > As others have mentioned, there _is_ a 
> reason we have a working directory.
> > Please understand this as a "I do not like the idea of editing the 
> > index directly at all".
> 
> I do not intend use it as a replacement of the working directory, but 
> mostly as a way to split up patches easier. Mainly to _remove_ lines 
> that I staged that I would like to be in a different patch in the series 
> (possibly after doing 'git reset --soft'). I always go through my a 
> longer patch series multiple times until I am satisfied with the result, 
> this addition would make that a lot easier.

Would not a much saner way be

	$ git reset HEAD^
	$ git add -p
	$ git stash save --keep-index
	# test it
	$ git commit
	$ git stash apply
	# test again
	$ git commit

Hmm?

BTW I do not like the "longness" of "git stash save --keep-index"; of 
course I could install an alias for that, but it feels wrong to have only 
a cumbersome to call something that should be part of a _lot_ of 
workflows.

Ciao,
Dscho

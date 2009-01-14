From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 22:07:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901142203190.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com> <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <200901142104.16134.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:08:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNCyN-0000Ms-Dd
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 22:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbZANVG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 16:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbZANVG7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 16:06:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:54583 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753850AbZANVG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 16:06:58 -0500
Received: (qmail invoked by alias); 14 Jan 2009 21:06:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 14 Jan 2009 22:06:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z69lSj8DZk6ajdpXe7VxB3jdw+IqQasvXrYIK6F
	qW8CycX7A9mPAU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901142104.16134.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105702>

Hi,

On Wed, 14 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 
> > The only "funny" thing I realized is that the lines which are output
> > by emit_line() add a RESET at the end of the line, and I do not do that
> > in color_fwrite_lines().
> 
> Umm.... but you seem to do?

Oh, right!  I think the culprit is in fn_out_diff_words_aux(), which calls 
fwrite() directly for the common words.

> Ack on the new regex semantics, though I'd have implemented it via dying 
> on '\n' instead of silently splitting there (and restarting a new 
> match!).

Hmm.  I'd rather not die() in the middle of it.

Maybe we can even handle newlines correctly by replacing them with NULs 
which libxdiff handles just fine?

> Thus, Ack on 4/4 once the boundary bug is fixed.  Thanks for your work!

Phew.  I was almost convinced you would hate me for my criticiscm.

Thanks,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use nonrelative paths instead of absolute paths for
 cloned repositories
Date: Fri, 6 Jun 2008 18:34:13 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061832330.1783@racer>
References: <alpine.LNX.1.00.0806052244300.19665@iabervon.org> <alpine.DEB.1.00.0806060422310.21190@racer> <7viqwmv7ff.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 19:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4frc-0006SR-RE
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 19:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbYFFRfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 13:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbYFFRfj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 13:35:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:44948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753763AbYFFRfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 13:35:38 -0400
Received: (qmail invoked by alias); 06 Jun 2008 17:35:36 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 06 Jun 2008 19:35:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0tMl3Z4r0CJZxlaOKce2Hgs+AgVQCUKWlNcniwn
	djgLcuoRsxvsjv
X-X-Sender: gene099@racer
In-Reply-To: <7viqwmv7ff.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84093>

Hi,

On Fri, 6 Jun 2008, Junio C Hamano wrote:

> In the longer term, we would inevitably face "when should one use 
> nonrelative and when should one use absolute?" and we would eventually 
> have to answer it.  It may turn out that many current users of 
> "absolute" are better off using "nonrelative", but I suspect we won't 
> get rid of "absolute" completely, because one of the reasons it avoids 
> symlinks at great lengths is so that it can check the containment 
> relationships between paths reliably (e.g. "is this path outside the 
> repository, in which case we should refuse to add it to the index, and 
> we use --no-index without being asked when running "diff"").
> 
> But using "absolute" for containment comparison is one thing.  Storing 
> the result of "absolute" is quite another.

The easy way would be to add an option to make_absolute_path(), say 
"resolve_symlinks".

Ciao,
Dscho

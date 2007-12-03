From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Mon, 3 Dec 2007 11:47:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031146520.27959@racer.site>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com>
 <20071203040108.GS14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 12:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz9mQ-0003MS-Jd
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 12:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbXLCLrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 06:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbXLCLrq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 06:47:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:54702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753102AbXLCLrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 06:47:45 -0500
Received: (qmail invoked by alias); 03 Dec 2007 11:47:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 03 Dec 2007 12:47:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xkBNGimUx4Mv+GHC12f3mMQ3YUyEl0XeM8Press
	IfP4f59vd/VH7R
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203040108.GS14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66913>

Hi,

On Sun, 2 Dec 2007, Shawn O. Pearce wrote:

> Steven Grimm <koreth@midwinter.com> wrote:
> > This is useful in cases where a hook needs to modify an incoming commit
> > in some way, e.g., fixing whitespace errors, adding an annotation to
> > the commit message, noting the location of output from a profiling tool,
> > or committing to an svn repository using git-svn.
> ...
> > +/* Update hook exit code: hook has updated ref on its own */
> > +#define EXIT_CODE_REF_UPDATED 100
> 
> Hmm.  I would actually rather move the ref locking to before we run
> the update hook, so the ref is locked *while* the hook executes.

Would that not mean that you cannot use update-ref to update the ref, 
since that wants to use the same lock?

Ciao,
Dscho

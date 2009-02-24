From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [HALF A PATCH] Teach the '--exclude' option to 'diff
 --no-index'
Date: Tue, 24 Feb 2009 17:15:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902241713520.10279@pacific.mpi-cbg.de>
References: <499E92FD.8000900@alum.mit.edu> <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de> <7v1vttt6d4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 17:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzxA-0003zE-CY
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbZBXQOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 11:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758077AbZBXQOF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 11:14:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:41953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757582AbZBXQOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 11:14:04 -0500
Received: (qmail invoked by alias); 24 Feb 2009 16:14:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 24 Feb 2009 17:14:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XMlBlR2HXSm56OwmMtEbXG8nJ00jR2eEgQAJhKy
	16ziMgqrj0BZmq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vttt6d4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111309>

Hi,

On Fri, 20 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > With this patch, it is possible to exclude files based on basename
> > patterns.  Example:
> >
> > 	$ git diff --no-index -x Makefile -x Makefile.in a/ b/
> >
> > In this example, the recursive diff between a/ and b/ will be shown
> > modulo changes in files named 'Makefile' or 'Makefile.in'.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	Michael wrote:
> >
> > 	> I can't think offhand of a more portable tool that could replace 
> > 	> "diff -r -x" here (suggestions, anyone?).
> >
> > 	Maybe something like this?
> 
> I agree that diff_options is the logical way to hook this information and
> diff_opt_parse() is the right place to add this, but why isn't this done
> at diff_{addremove,change,unmerge}() layer?  That way you should be able
> to cover both no-index special case and the normal diffs, no?

The principal aim of this patch was to support git diff --no-index -x, 
that is why (and in addition, avoiding unnecessary work when we can 
exclude stuff already early in the code path).

It is unlikely that I will work on this before next week.

Thanks,
Dscho

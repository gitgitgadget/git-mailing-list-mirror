From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git repack: keep commits hidden by a graft
Date: Fri, 24 Jul 2009 11:36:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907241133080.19988@intel-tinevez-2-302>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de> <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de> <7veis6vfh5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 11:36:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUHCG-0001Vc-JJ
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 11:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZGXJgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 05:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbZGXJgE
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 05:36:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:37510 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750893AbZGXJgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 05:36:03 -0400
Received: (qmail invoked by alias); 24 Jul 2009 09:36:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 24 Jul 2009 11:36:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3RJANFL/3/KdTLPOzNfx9ibXA3uaA4OaLt0PQQ6
	+fUNfnBWzhvWnh
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7veis6vfh5.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123910>

Hi,

On Thu, 23 Jul 2009, Junio C Hamano wrote:

> It would probably make more sense to call it "--keep-real-parents" or 
> something.

Much better.

> Do we want to cull duplicated parents?  I do not think it matters in 
> this particular context of checking the reachability, but I am just 
> double checking if you thought about the issue.

I thought about it, and decided it is not worth the hassle: originally I 
had the option in setup_revisions() until I realized that this is never 
called by pack-objects.  So how about this addition to the commit message:

	As this behavior can only be triggered by git pack-objects, and as 
	that command handles duplicate parents gracefully, we do not 
	bother to cull such parents.

Ciao,
Dscho

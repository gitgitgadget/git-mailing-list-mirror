From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] rebase -i: Export GIT_AUTHOR_* variables
 explicitly
Date: Fri, 22 Jan 2010 12:16:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001221212350.4985@pacific.mpi-cbg.de>
References: <cover.1264151435.git.mhagger@alum.mit.edu> <c6efda03848abc00cf8bf8d84fc34ef0d652b64c.1264151435.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, tarmigan+git@gmail.com,
	j.sixt@viscovery.net
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 22 12:10:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYHPY-0005KA-J2
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 12:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab0AVLKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 06:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788Ab0AVLK2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 06:10:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:57952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754398Ab0AVLK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 06:10:27 -0500
Received: (qmail invoked by alias); 22 Jan 2010 11:10:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 22 Jan 2010 12:10:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Kqhkj/4sK5jkvQZq1kBJdLyMwmW8kfPhQWcf+3i
	za8lrWqafWgxaV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <c6efda03848abc00cf8bf8d84fc34ef0d652b64c.1264151435.git.mhagger@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137755>

Hi,

On Fri, 22 Jan 2010, Michael Haggerty wrote:

> As pointed out on the mailing list, one-shot shell variable exports do
> not necessarily work with shell functions.  So export the GIT_AUTHOR_*
> variables explicitly using "export".

This one's a bit hairy; I really was not sure about unintended side 
effects, that is why I avoided the export.

Just imagine, for example, some git commit --amend which forgets to set 
the author information; I am not saying that this is happening, but I 
cannot be sure, because every possible code path to a git 
commit/commit-tree has to be checked, and this does not mean that future 
patches will not introduce such broken code, either.

It might also be possible that some people scripted rebase -i with a 
custom "editor" as in the tests (I have done so in the past).  They would 
be affected.

Ciao,
Dscho

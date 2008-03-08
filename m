From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix recursive-merge of empty files with different
 permissions
Date: Sat, 8 Mar 2008 18:51:48 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803081850470.3975@racer.site>
References: <20080308171726.GA16129@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Mar 08 18:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY3Db-0005ml-Nz
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 18:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYCHRvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 12:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYCHRvp
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 12:51:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:43879 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751421AbYCHRvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 12:51:45 -0500
Received: (qmail invoked by alias); 08 Mar 2008 17:51:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 08 Mar 2008 18:51:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ifRNmZYri4UdL883QUTKin4uFfQna1KGywvDuBK
	2w+Ne3iN73K6f1
X-X-Sender: gene099@racer.site
In-Reply-To: <20080308171726.GA16129@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76569>

Hi,

On Sat, 8 Mar 2008, Clemens Buchacher wrote:

> I do not understand why, but this does not happen if the file 
> permissions are the same.

I think this is the biggest problem.

>  t/t6031-merge-recursive.sh |   23 +++++++++++++++++++++++
>  xdiff/xmerge.c             |   30 ++++++++++++++----------------

... because xdiff/xmerge.c is definitely the wrong place to "fix" this 
issue.  xdl_merge() does not even _know_ about permissions.

Ciao,
Dscho

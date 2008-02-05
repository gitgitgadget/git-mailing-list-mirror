From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/9] Allow callers of unpack_trees() to handle failure
Date: Tue, 5 Feb 2008 01:11:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050107440.8543@racer.site>
References: <alpine.LNX.1.00.0802041334450.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCMC-0008IZ-OV
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbYBEBLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756595AbYBEBLn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:11:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:59048 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756214AbYBEBLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:11:42 -0500
Received: (qmail invoked by alias); 05 Feb 2008 01:11:40 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.71]) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 05 Feb 2008 02:11:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uPh0DG+suOtjrjSnb9r+NRBQPwZxf9kyGCnFrFU
	KK6ZgnEL5AF7qb
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041334450.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72604>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> Return an error from unpack_trees() instead of calling die(), and exit
> with an error in read-tree and builtin-commit.

Technically, there is still a possibility that an xcalloc() fails with a 
die(), but I agree that it is a good change.

BTW after the whole series (was too lazy to check the individual 
patches), I count one instance in builtin-checkout.c and two in diff-lib.c 
where unpack_trees()' return value is not checked.  Is this intended?

Ciao,
Dscho

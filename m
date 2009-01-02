From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Fri, 2 Jan 2009 22:59:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901022244240.27818@racer>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at> <1230843273-11056-2-git-send-email-drizzd@aon.at> <1230843273-11056-3-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0812170605300.14632@racer> <20081216232452.GV5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIs4U-00083y-RJ
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758804AbZABV7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758580AbZABV7S
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:59:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:33625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758804AbZABV7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:59:16 -0500
Received: (qmail invoked by alias); 02 Jan 2009 21:59:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 02 Jan 2009 22:59:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183vbh3hKw35RTCnqNtcvjTx9G4dtY+gTatvQ7iQ5
	+QvhKbsgvbiVo+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1230843273-11056-3-git-send-email-drizzd@aon.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104425>



On Thu, 1 Jan 2009, Clemens Buchacher wrote:

> Commit 0cf73755 (unpack-trees.c: assume submodules are clean during
> check-out) changed an argument to verify_absent from 'path' to 'ce',
> which is however shadowed by a local variable of the same name.
> 
> The bug triggers if verify_absent is used on a tree entry, for which
> the index contains one or more subsequent directories of the same
> length. The affected subdirectories are removed from the index. The
> testcase included in this commit bisects to 55218834 (checkout: do not
> lose staged removal), which reveals the bug in this case, but is
> otherwise unrelated.
> ---

Sign-off?

Just for the record, this patch fixes the testcase Miklos reported 
earlier.

Ciao,
Dscho

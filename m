From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Tue, 6 Jan 2009 23:20:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901062319070.30769@pacific.mpi-cbg.de>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-99601540-1231280442=:30769"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=D8yvind_Harboe?= <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 23:22:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKKJ7-0006aR-LC
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 23:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757966AbZAFWUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 17:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757974AbZAFWUI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 17:20:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:38545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757966AbZAFWUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 17:20:06 -0500
Received: (qmail invoked by alias); 06 Jan 2009 22:20:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 06 Jan 2009 23:20:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LOPRRA1PL3Oi8HDuPEGRgeoynt7+ouaFocFdFtg
	GjUG8aSwy6tLhP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104730>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-99601540-1231280442=:30769
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 6 Jan 2009, Øyvind Harboe wrote:

> Q1: How can I figure out what it is in .git that takes so much space?

If it is a pack that is taking so much space:

$ git verify-pack -v $PACK | grep -v "^chain " | sort -n -k 4

and then for the last few lines do a

$ git rev-list --all --objects | grep $SHA1

Hth,
Dscho

--8323328-99601540-1231280442=:30769--

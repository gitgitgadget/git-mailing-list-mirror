From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: collapsing commits with rebase
Date: Thu, 8 Jan 2009 01:45:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901080144270.30769@pacific.mpi-cbg.de>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:47:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKj3P-0008Ve-UI
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbZAHApU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbZAHApT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:45:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:43967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750814AbZAHApR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 19:45:17 -0500
Received: (qmail invoked by alias); 08 Jan 2009 00:45:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 08 Jan 2009 01:45:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UT7oFdiWU16awF1GFbX4mlkL5X7eDgRSt1hzZ97
	JctJ8OjBSAQxCQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104859>

Hi,

On Thu, 8 Jan 2009, Geoff Russell wrote:

> Dear gits,
> 
> I have a series of commits:
> 
>     A---B---C---D---E---F
> 
> I want to collapse B---C---D into one single commit. git rebase -i B 
> will allow me to do this, but I'm looking for a non-interactive 
> incantation.

You set GIT_EDITOR to a script ;-)

Alternatively, something like this should work for you:

	$ git checkout A
	$ git read-tree -u -m D
	$ git commit -m "My message"
	$ git cherry-pick E
	$ git cherry-pick F

Hth,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git filter-branch --subdirectory-filter error
Date: Mon, 22 Oct 2007 12:20:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221218150.25221@racer.site>
References: <200710221227.13279.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:20:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjvKo-0004Wt-Tg
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbXJVLU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbXJVLU2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:20:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:47353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751721AbXJVLU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:20:27 -0400
Received: (qmail invoked by alias); 22 Oct 2007 11:20:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 22 Oct 2007 13:20:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BgyIQbMzBh+1jcydrFkM/BPIKiDZGXs4h6dqzgB
	F+rPyh5hUvHnzP
X-X-Sender: gene099@racer.site
In-Reply-To: <200710221227.13279.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61989>

Hi,

On Mon, 22 Oct 2007, Jan Wielemaker wrote:

> Finished a big re-shuffle of a big project, while other developers 
> continued. Worked really well. Thanks guys! But now I have two top 
> directories and I want to create two new repositories, each containing 
> one of these directories (because the one holds copyrighted data and we 
> want the other to become public software). So, I happily run
> 
> 	$ git filter-branch --subdirectory-filter RDF HEAD
> 
> Where RDF is an existing directory.  I get:
> 
> Rewrite 95807fe01c39d3092e3ac3a98061711323154d77 (1/12)fatal: Not a valid 
> object name 95807fe01c39d3092e3ac3a98061711323154d77:RDF
> Could not initialize the index

I guess that 95807fe01 is the parent of a commit adding the RDF/ 
directory.

The subdirectory filter does not look kindly upon a history where some 
commits lack the subdirectory in question.  However, this should work:

	git filter-branch --subdirectory--filter RDF 95807fe01..HEAD

Hth,
Dscho

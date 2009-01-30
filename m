From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Fri, 30 Jan 2009 18:12:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <1233308489-2656-2-git-send-email-geofft@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoffrey Thomas <geofft@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSww4-0005Bv-UR
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbZA3RMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 12:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbZA3RMR
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:12:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:45829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752277AbZA3RMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 12:12:16 -0500
Received: (qmail invoked by alias); 30 Jan 2009 17:12:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 30 Jan 2009 18:12:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dfyxRJVzd0wdScddJ4V+E9wS0npUlu6Buq51O8K
	3674TLdHXKYDuy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1233308489-2656-2-git-send-email-geofft@mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107853>

Hi,

On Fri, 30 Jan 2009, Geoffrey Thomas wrote:

> From: Geoffrey Thomas <geofft@mit.edu>
> git blame misaligns output if a author's name has a differing display width and
> strlen; for instance, an accented Latin letter that takes two bytes to encode
> will cause the rest of the line to be shifted to the left by one. To fix this,
> use utf8_strwidth instead of strlen (and compute the padding ourselves, since
> printf doesn't know about UTF-8).

Good point (even if your commit message has lines much longer than 72 
chars, ASCII ones at that).

But how certain are you at that point that the authors are in UTF-8 
format?  IOW what encoding conversions were possibly performed up to that 
point?

You might want to make it easier on possible reviewers by putting that 
discussion into the commit message.

Ciao,
Dscho

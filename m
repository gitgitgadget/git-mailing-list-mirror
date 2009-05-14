From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] read_directory(): infrastructure for pathname
 character set conversion
Date: Thu, 14 May 2009 15:47:03 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905141546220.3343@localhost.localdomain>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain> <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain> <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain> <alpine.DEB.1.00.0905150018070.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 00:47:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jiJ-0001pH-MC
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759810AbZENWrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759738AbZENWrT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:47:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60989 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759714AbZENWrS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 18:47:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EMl45s008974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 15:47:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EMl3ZS013277;
	Thu, 14 May 2009 15:47:04 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0905150018070.26154@pacific.mpi-cbg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.962 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119235>



On Fri, 15 May 2009, Johannes Schindelin wrote:
> 
> On Thu, 14 May 2009, Linus Torvalds wrote:
> 
> > The use of "//" as the filesystem path component separator may be odd,
> 
> Hopefully it will not bite us on Windows: "//fileserver/x" is different 
> from "/fileserver/x" there: the former tries to access the share "x" of 
> samba server "fileserver", while the latter will expand to "C:\Program 
> Files\Git\fileserver\x" (or wherever you installed Git).

It only does it in the middle of names, so it should be safe. 

That said, it's also meant to be just a temporary debugging aid. I'm fine 
with the '//' part not being merged.

			Linus

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] MinGW: a hardlink implementation
Date: Tue, 17 Mar 2009 11:12:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903171110420.6393@intel-tinevez-2-302>
References: <49BF53C2.6020707@kdbg.org> <49BF5563.2060500@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Kodl <petrkodl@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWJM-0003kn-RE
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759068AbZCQKMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756316AbZCQKMl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:12:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:52978 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754078AbZCQKMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:12:40 -0400
Received: (qmail invoked by alias); 17 Mar 2009 10:12:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 17 Mar 2009 11:12:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zA5kP7dxzyzB/eCIo3fXVK2+UFfn5ABv0NtYNdV
	yPGig/RwDLfpwo
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49BF5563.2060500@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113449>

Hi,

On Tue, 17 Mar 2009, Johannes Sixt wrote:

> From: Petr Kodl <petrkodl@gmail.com>
> Date: Sat, 24 Jan 2009 15:04:39 +0100
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  This is the meat of Petr's original patch with the fixup that was 
>  discussed in the msysgit mailing list (WINAPI was added in the 
>  typedef).

To save everybody searching why WINAPI is needed: in the error case (e.g. 
when you try to hard link from a different device), the stack was 
corrupted, leading to a rather nasty segmentation fault (which has a 
different name on Windows, just as everything else: access violation):

	http://code.google.com/p/msysgit/issues/detail?id=204

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: determine the list of header files using a
 glob
Date: Fri, 27 Nov 2009 10:36:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
References: <4B0F8825.3040107@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 10:36:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDxFY-0004Er-RN
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 10:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbZK0JgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 04:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbZK0JgN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 04:36:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:44561 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752338AbZK0JgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 04:36:12 -0500
Received: (qmail invoked by alias); 27 Nov 2009 09:36:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 27 Nov 2009 10:36:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SOOdsZAuSoJdaqxZEsI5QhDvPv7pYB66NB+7YqR
	keBu25g1Rr7LcT
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B0F8825.3040107@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133884>

Hi,

On Fri, 27 Nov 2009, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> The list of header files was incomplete because a number of header files
> were added to the code base, but were not added to the list LIB_H that we
> have in the Makefile. This meant that no rebuild was triggered if one of
> the missing headers was changed because we do not have automatic
> dependency tracking, either.
> 
> Sidestep the issue by computing the list using $(wildcard).

Funny; I thought that not all header files are library header files, i.e. 
not all header changes should trigger a full new build of libgit.a.

Am I wrong?

Ciao,
Dscho

P.S.: Something that comes to mind is the http.h header, which should 
really be independent of libgit.a.  Which reminds me: do we _still_ tell 
libgit.a at _compile time_ whether git-remote-http is compiled with cURL?

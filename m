From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 11:56:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 11:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgzed-0003T1-Kv
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 11:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbZCJK4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbZCJK4O
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 06:56:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:60959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751170AbZCJK4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 06:56:13 -0400
Received: (qmail invoked by alias); 10 Mar 2009 10:56:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 10 Mar 2009 11:56:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jz6J8fCrj7yPArBxmmzsmJv/tE3GV0QLZEfbpnZ
	mMoifQcOhT8JSP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49B61703.8030602@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112802>

Hi,

On Tue, 10 Mar 2009, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> This removes the last parameter of recv_sideband, by which the callers
> told which channel band #2 data should be written to. Since both callers
> of the function passed 2 for the parameter, we hereby remove the
> parameter and send band #2 to stderr explicitly using fprintf.

To be honest, I considered this myself.

But I think it is wrong.  Just because the current callers happen to 
output to stderr does not mean that we would not like sidebands that 
exchange binary data for other uses in the future.

I am thinking GitTorrent here.

And clearly, sideband support was written with future uses like that in 
mind, as it goes out of its way to transmit packets instead of strings.

Ciao,
Dscho

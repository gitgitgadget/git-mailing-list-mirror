From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Change xdl_merge to generate output even for null
 merges
Date: Mon, 25 May 2009 09:51:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905250948420.26154@pacific.mpi-cbg.de>
References: <1243210874-18451-1-git-send-email-charles@hashpling.org> <1243210874-18451-2-git-send-email-charles@hashpling.org> <1243210874-18451-3-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon May 25 09:51:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Uy9-0003it-6l
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZEYHug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 03:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbZEYHuf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:50:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:41948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752070AbZEYHue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:50:34 -0400
Received: (qmail invoked by alias); 25 May 2009 07:50:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 25 May 2009 09:50:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/doJ9uZjzd2HMMo6tGg3ze5dx3NWUa4101YpAsiy
	29Nxh4zRRmucL/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1243210874-18451-3-git-send-email-charles@hashpling.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119897>

Hi,

On Mon, 25 May 2009, Charles Bailey wrote:

> xdl_merge used to have a check to ensure that there was at least
> some change in one or other side being merged but this suppressed
> output for the degenerate case when base, local and remote
> contents were all identical.
> 
> Removing this check enables correct output in the degenerate case
> and xdl_free_script handles freeing NULL scripts so there is no
> need to have the check for these calls.
> 
> Signed-off-by: Charles Bailey <charles@hashpling.org>

Maybe mention here that it just so happens that when there were no changes 
in base->local, it does not matter what changes (_if any_) were made to 
base->remote, we should output the remote version.

Took me more than 2 seconds to find that out, so let's spare the 
occasional reader this time (2 seconds is my attention span).

Your fix is correct.

Ciao,
Dscho

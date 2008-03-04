From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule: Don't die when command fails for one
 submodule
Date: Tue, 4 Mar 2008 15:01:28 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041500170.22527@racer.site>
References: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:03:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYfN-0007xM-4u
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854AbYCDPCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbYCDPCQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:02:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:37315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756726AbYCDPCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:02:16 -0500
Received: (qmail invoked by alias); 04 Mar 2008 15:02:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 04 Mar 2008 16:02:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g1jAFTdegTopLbPZPeWIFjS5pNJHOoZcpOh+bzJ
	g5MuQrDSWgVacu
X-X-Sender: gene099@racer.site
In-Reply-To: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76094>

Hi,

On Tue, 4 Mar 2008, Ping Yin wrote:

> When handling multiple modules, init/update/status command will exit 
> when it fails for one submodule. This patch makes the command continue 
> bypassing the failure.

I think that you should not do this.  The failure should not be ignored.  
Maybe continuing, but not forgetting about the error.  So:

> -		name=$(module_name "$path") || exit
> +		name=$(module_name "$path") || continue

I do not like this.  It should remember that there was something foul, and 
eventually exit with that status.

Ciao,
Dscho


From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/9] Add flag to make unpack_trees() not print errors.
Date: Tue, 5 Feb 2008 01:16:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050112380.8543@racer.site>
References: <alpine.LNX.1.00.0802041335390.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:19:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCSi-0001Kp-3d
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759348AbYBEBRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbYBEBRT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:17:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:44430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759348AbYBEBRR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:17:17 -0500
Received: (qmail invoked by alias); 05 Feb 2008 01:17:14 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 05 Feb 2008 02:17:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1870r0OQR873tLSuos2PjA21x6RttzzgCsTbTWhi6
	SuS41ZZa3Uusuj
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041335390.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72605>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> This will allow builtin-checkout to suppress merge errors if it's going 
> to try more merging methods.

I saw one error() in twoway_merge(), one in bind_merge(), and one in 
onway_merge() that were not guarded by o->gently.

Also, I'd call it "silent", not "gently".

> Additionally, if unpack_trees() returns with an error, but without 
> printing anything, it will roll back any changes to the index (by 
> rereading the index, currently). This obviously could be done by the 
> caller, but chances are that the caller would forget and debugging this 
> is difficult.

Granted, it is easy to forget.  But maybe the caller does not need the 
index?  Or maybe it wants a different one?  I'd prefer the caller to clean 
up, if necessary.

Ciao,
Dscho

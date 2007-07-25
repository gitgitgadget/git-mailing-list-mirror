From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: easy repository initialization that turned out not to be that
 easy
Date: Wed, 25 Jul 2007 21:15:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707252112250.14781@racer.site>
References: <0EAD32C5-11DA-4B99-919D-87C0006A389C@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDnGi-0004Dl-C4
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbXGYUPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbXGYUPd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:15:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:58427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752300AbXGYUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:15:32 -0400
Received: (qmail invoked by alias); 25 Jul 2007 20:15:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 25 Jul 2007 22:15:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185nxhKKSA5Y+PPHKuO9b7s8VE7dGrA7b6lhffcfz
	Esxxfpw0K2ucOK
X-X-Sender: gene099@racer.site
In-Reply-To: <0EAD32C5-11DA-4B99-919D-87C0006A389C@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53713>

Hi,

On Wed, 25 Jul 2007, Steffen Prohaska wrote:

> Cloning it to shared doesn't work either because the meaning of 
> 'git-clone --bare --shared' is different from 'git-init --shared'.

Yes, I lamented on that already.  But we cannot change that.  Too many 
users.

>    mkdir shared.git
>    cd shared.git
>    git --bare init --shared
> 
> and tried to naively fetch all by executing
> 
>    git fetch ../private.git

Almost.  "git fetch" does not store anything by default, so you have to do 
something like

	$ git config remote.origin.url ../private.git
	$ git config remote.origin.fetch 'refs/*:refs/*'
	$ git fetch

Eventually, I would like that to be available with

	$ git remote add --mirror fetch ../private.git

If nobody beats me to it, I'll do it later today.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Mon, 4 Feb 2008 15:16:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041512140.7372@racer.site>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gi mailing list <git@vger.kernel.org>, Nicolas Pitre <nico@cam.org>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 16:17:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM34Y-0005fC-OL
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 16:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbYBDPQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 10:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYBDPQv
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 10:16:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:52896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979AbYBDPQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 10:16:51 -0500
Received: (qmail invoked by alias); 04 Feb 2008 15:16:49 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 04 Feb 2008 16:16:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qBJ5bdMQqQPec8GuK8kJnOIcJ75JU8Ig9fwHyVu
	Z/duoeB/DXloCB
X-X-Sender: gene099@racer.site
In-Reply-To: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72515>

Hi,

On Mon, 4 Feb 2008, David Tweed wrote:

> +                       if(c>0 && c<4096 && stat(name, &status) == 0
> +                          && status.st_mtime < now - 600){

Please have spaces after the "if" and before the "{" (just imitate the 
style of the rest of the file).

Also, 10 minutes grace period for any ongoing fetch or repack seems a bit 
arbitrary.  Maybe default to 10 minutes, and introduce 
prune.packGracePeriod?

(Which reminds me that it might be useful to add a 
prune.looseObjectsGracePeriod to avoid having to type --expire= all the 
time?)

Ciao,
Dscho

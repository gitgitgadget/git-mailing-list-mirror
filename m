From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pack-objects: only throw away data during memory
 pressure
Date: Mon, 11 Feb 2008 15:20:23 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802111519300.3870@racer.site>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 11 16:21:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOaSh-0005oj-9h
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 16:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbYBKPUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 10:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbYBKPUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 10:20:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:41497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753857AbYBKPUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 10:20:14 -0500
Received: (qmail invoked by alias); 11 Feb 2008 15:20:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 11 Feb 2008 16:20:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bsaELe8TbgVrCbrXZU7pP+Ns7FK9G6+qqvsA7bq
	6QcQgWF1bplngh
X-X-Sender: gene099@racer.site
In-Reply-To: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73540>

Hi,

On Mon, 11 Feb 2008, Martin Koegler wrote:

> What about this not really tested patch for dealing with memory pressure 
> in git-pack-objects?
> 
> It will slow down the repack in the case of memory pressure, but missing 
> memory will not affect the results.

It almost helped:

$ /usr/bin/time git repack -a -d -f --window=250 --depth=250
Counting objects: 2477715, done.
fatal: Out of memory, malloc failed411764)
Command exited with non-zero status 1
10050.12user 240.63system 2:53:37elapsed 98%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (29555major+94032945minor)pagefaults 0swaps

So, it ran longer until it ran out of memory.

Ciao,
Dscho

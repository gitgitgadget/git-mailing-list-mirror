From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bisection oddity.
Date: Mon, 12 Mar 2007 20:50:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703122047480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070312192821.GA24992@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dave Jones <davej@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqY7-00011o-Hc
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbXCLTu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbXCLTu6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:50:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:47696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752835AbXCLTu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:50:57 -0400
Received: (qmail invoked by alias); 12 Mar 2007 19:50:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 12 Mar 2007 20:50:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/06Hx7f3n0DFp7nY9FTZc/YQPjgGzGRv/yLP+6NO
	dffmdz8jW08bEe
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070312192821.GA24992@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42070>

Hi,

On Mon, 12 Mar 2007, Dave Jones wrote:

> I'm chasing a kernel bug that was introduced somewhere between
> v2.6.20 and 2.6.21rc1, and bisect has done this so far..
> 
> git-bisect start
> # bad: [c8f71b01a50597e298dc3214a2f2be7b8d31170c] Linux 2.6.21-rc1
> git-bisect bad c8f71b01a50597e298dc3214a2f2be7b8d31170c
> # good: [fa285a3d7924a0e3782926e51f16865c5129a2f7] Linux 2.6.20
> git-bisect good fa285a3d7924a0e3782926e51f16865c5129a2f7
> # bad: [574009c1a895aeeb85eaab29c235d75852b09eb8] Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus
> git-bisect bad 574009c1a895aeeb85eaab29c235d75852b09eb8
> # bad: [43187902cbfafe73ede0144166b741fb0f7d04e1] Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6
> git-bisect bad 43187902cbfafe73ede0144166b741fb0f7d04e1
> # good: [1545085a28f226b59c243f88b82ea25393b0d63f] drm: Allow for 44 bit user-tokens (or drm_file offsets)
> git-bisect good 1545085a28f226b59c243f88b82ea25393b0d63f
> # good: [c96e2c92072d3e78954c961f53d8c7352f7abbd7] Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6
> git-bisect good c96e2c92072d3e78954c961f53d8c7352f7abbd7
> 
> What I'm puzzled at is that this lands me at 2.6.20-rc5, which is *before*
> the range I'm interested in.  What happened here?

This lands me at

v2.6.20-rc5-301-g31c56d8

which is _not_ an ancestor of v2.6.20 (your first good commit), oddly 
enough. Start "gitk v2.6.20-rc5-301-g31c56d8...v2.6.20" to see how the 
commits are related.

So, it is intended behaviour.

Hth,
Dscho

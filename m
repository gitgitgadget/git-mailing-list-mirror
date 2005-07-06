From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git-update-cache:
Date: Wed, 6 Jul 2005 03:11:50 +0200
Message-ID: <20050706011150.GA9081@mars.ravnborg.org>
References: <20050705210256.GA28700@mars.ravnborg.org> <20050705224220.GA22219@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 06 08:11:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq38G-0002w0-OE
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 08:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVGFGKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 02:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVGFGFy
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 02:05:54 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:44161 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262127AbVGFGFY
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 02:05:24 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id CDFF4262824
	for <git@vger.kernel.org>; Wed,  6 Jul 2005 08:05:17 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 4BECA6AC021; Wed,  6 Jul 2005 03:11:51 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050705224220.GA22219@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2005 at 12:42:20AM +0200, Sam Ravnborg wrote:
> > 
> > I receive the following error:
> > git-update-cache: symbol lookup error: git-update-cache: undefined
> > symbol: deflateBound
> > 
> 	
> > open("/usr/lib/libz.so.1", O_RDONLY)    = 3
> 
> This is the reason.
> 
> For a strange reason when git-update-chache was compiled is was linked
> dynamically towards an older libz.so version.
> Latest installed is libz.1.2.2 which includes deflateBound.
> libz.so.1 points at 1.1.4 which does not.

The solution was to let libz.so.1 point to latest libz.so file.
In my gentoo distribution there seems to be inconsistency
if /lib or /usr/lib is used. That was the root cause.

Back to do some useful stuff..

	Sam

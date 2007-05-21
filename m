From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Mon, 21 May 2007 20:05:06 +0200
Message-ID: <20070521180506.GP942MdfPADPa@greensroom.kotnet.org>
References: <11795163061588-git-send-email-skimo@liacs.nl>
 <20070518215312.GB10475@steel.home>
 <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
 <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
 <20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
 <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
 <20070520155407.GC27087@efreet.light.src>
 <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
 <20070521165938.GA4118@efreet.light.src>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 21 20:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCGS-0001rP-8d
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764833AbXEUSFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 14:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758073AbXEUSFM
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:05:12 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:46497 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764974AbXEUSFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:05:09 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIE00IKIKWKBE@smtp17.wxs.nl> for git@vger.kernel.org; Mon,
 21 May 2007 20:05:08 +0200 (CEST)
Received: (qmail 12363 invoked by uid 500); Mon, 21 May 2007 18:05:06 +0000
In-reply-to: <20070521165938.GA4118@efreet.light.src>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48034>

On Mon, May 21, 2007 at 06:59:38PM +0200, Jan Hudec wrote:
> We could store the GIT_DIR of submodule within the GIT_DIR of the
> superproject instead of the submodule directory itself. So instead of:
>  /
>  /.git
>  /subdir
>  /subdir/.git
> 
> There would be:
>  /
>  /.git
>  /subdir
>  /.git/submodules/submodule-name.git

I have this already, except that I use /.git/submodules/submodule-name/.git
because I was too lazy to figure out how to get clone to use the above
without using --bare, because --bare disables separate-remotes.

Is there any good reason, btw for --bare not to do separate-remotes ?
We could throw out a lot of speical cases, especially the --bare http
fetch if we would simply always do a separate-remotes.

> This would require changes to the logic how git finds GIT_DIR (which would be
> really deep change),

Euhm.... I just add a symlink...

skimo

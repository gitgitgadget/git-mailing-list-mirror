From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set up GIT_DIR/workdir if GIT_WORK_DIR is set
Date: Mon, 12 Mar 2007 19:08:37 +0100
Message-ID: <20070312180837.GA22701@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <20070312115350.GA15179@moooo.ath.cx> <20070312121226.GB2268@always.joy.eth.net> <20070312131253.GA16452@moooo.ath.cx> <fcaeb9bf0703120636r7038a7fat24e571e7c087d13d@mail.gmail.com> <20070312140808.GA17450@moooo.ath.cx> <7vabyitlld.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQowu-0003RM-5A
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbXCLSIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbXCLSIl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:08:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:44151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872AbXCLSIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:08:40 -0400
Received: (qmail invoked by alias); 12 Mar 2007 18:08:38 -0000
Received: from pD9EBB74D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.183.77]
  by mail.gmx.net (mp051) with SMTP; 12 Mar 2007 19:08:38 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX181PjIwve01Rj2gSnCwRw1Fd3F+rS6lYDaJ+2T11c
	TyWcPMihcVJpqg
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabyitlld.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42051>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > ... because
> > $GIT_WORK_DIR is normally interpreted as relative path to the current
> > working directory and not relative to $GIT_DIR.
> 
> Well, it could be that _that_ handling of the environment
> variable is what needs to be fixed.

You're right,  this seems to be much better.

I just thought that GIT_WORK_DIR should be relative to the current
working directory because it's more intuitive, e.g.

    $ git --git-dir=/path/to/repo.git --work-dir=../.. add a

where ../.. matches the path to the toplevel working directory from
cwd.  But this definitely is annoying when changing directories.

I'll go and fix this.  Do you prefer an amended patch or just a patch
on top?

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] "git help -a" should search all exec_paths and PATH
Date: Mon, 22 Oct 2007 02:39:33 -0400
Message-ID: <20071022063933.GU14735@spearce.org>
References: <20071021214846.GI16291@srparish.net> <20071022053016.GN14735@spearce.org> <20071022063201.GN16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:39:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijqx8-0001wV-Pv
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbXJVGjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbXJVGjj
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:39:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47764 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXJVGji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:39:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijqwo-0003ZV-S6; Mon, 22 Oct 2007 02:39:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B9D3020FBAE; Mon, 22 Oct 2007 02:39:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071022063201.GN16291@srparish.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61957>

Scott Parish <sRp@srparish.net> wrote:
> On Mon, Oct 22, 2007 at 01:30:17AM -0400, Shawn O. Pearce wrote:
> 
> > fchdir() isn't as portable as Git currently is.
> 
> I hadn't realized it wasn't portable, but i do see that there's no POSIX
> entry in its man page. I was actually looking to use getcwd, but its
> man page had suggested using this open()/fchdir() method.
> 
> Anyway, is there a reason to avoid changing the directory? If not
> i'm tempted to take the approach that j.sixt suggested--not restoring
> the cwd since we're exiting anyway. I don't have any good reason
> to not do the string manipulation, but why do something more
> complicated then necessary?

Yea, that was another thought I had.  You probably can just chdir(),
list, exit, and not worry about going back to the previous directory.
And more complicated is always a bad idea.  Keep it simple, 'cause
us gits like it that way.  :-)

-- 
Shawn.

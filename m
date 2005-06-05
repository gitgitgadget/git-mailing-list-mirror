From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] git-daemon server
Date: Sun, 05 Jun 2005 12:49:38 -0400
Message-ID: <1117990178.10424.15.camel@port.evillabs.net>
References: <Pine.LNX.4.21.0506031727400.30848-100000@iabervon.org>
	 <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 18:47:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeyGR-0006Ue-TW
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFEQtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVFEQtp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:49:45 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:52670
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S261588AbVFEQtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 12:49:39 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id DFEFF40C5A; Sun,  5 Jun 2005 12:49:38 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4-3mdk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-06-03 at 14:59 -0700, Linus Torvalds wrote:
> Me, I want to have a fairly simple script that does the equivalent of what
> I do now for pushing:
> 
> 	rsync -av --delete --exclude-from=.exclude .git/ master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> except I'd want it to do the locking and the "only accept trivial pushes" 
> stuff (ie no merging, just a pure update).


$ GITCONNECTION="--tcp ...."

$ git-sync $GITCONNECTION head master master `cat .git/HEAD`

(Yeah, the 'master master' is a cheezy way to do an update, but
 if you're the only one who can update the head, it's a non-issue)



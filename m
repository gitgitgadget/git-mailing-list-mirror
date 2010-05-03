From: Yann Dirson <yann.dirson@bertin.fr>
Subject: Re: WANTED: patch splitting tool - waypoints
Date: Mon, 3 May 2010 06:43:18 +0000 (UTC)
Message-ID: <loom.20100503T082814-180@post.gmane.org>
References: <20100502115842.GA11607@brong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 08:43:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8pNP-0003MJ-KI
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 08:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944Ab0ECGna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 02:43:30 -0400
Received: from lo.gmane.org ([80.91.229.12]:56398 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab0ECGn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 02:43:29 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8pNI-0003IR-L0
	for git@vger.kernel.org; Mon, 03 May 2010 08:43:28 +0200
Received: from host.1.68.26.195.rev.coltfrance.com ([host.1.68.26.195.rev.coltfrance.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 08:43:28 +0200
Received: from yann.dirson by host.1.68.26.195.rev.coltfrance.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 08:43:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.68.26.1 (Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.1.8) Gecko/20100312 Iceweasel/3.5.8 (like Firefox/3.5.8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146218>

Bron Gondwana <brong <at> brong.net> writes:
> My toolkit is missing a tool.  I've never seen it
> or anything like it, but I can describe it - and
> hopefully someone else knows if it exists.
> 
> It's basically a combination of git rebase -i and
> git add -p.  Something that allows you to split
> either a single patch or a series of patches that
> had bad "waypoints".

Right, this is a use-case I also commonly have, and nowadays I
mostly use the rebase -i approach already described, combined with
the use of git-gui for easy selection.

One additional trick I sometimes use, when I have reordered/squashed/split
a couple of commits, is things like "git checkout @{1}" to catch any missing
changes I could have lost while working.

Some time ago I was using stgit extensively, and had developped
a couple of scripts to support that workflow.  You will find them
in the contrib/ directory of the stgit repo, and in the
stgit-contrib debian package.  Note that I did not use them much
lately, and they may need some tweeking to work with recent
git/stgit.

The still-relevant scripts are:
  * stg-fold-files-from: pick specific hunks from another patch up the stack
  * stg-dispatch: dispatch specific hunks into another patch down the stack

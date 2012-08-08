From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Wed, 8 Aug 2012 23:07:54 +0000
Message-ID: <20120808230754.GB24956@dcvr.yhbt.net>
References: <1343856397-6536-1-git-send-email-robert@debian.org>
 <20120802104421.GA13271@dcvr.yhbt.net>
 <5021F9D4.1010700@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:08:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzFM8-0007zS-VN
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 01:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758328Ab2HHXH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 19:07:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36986 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953Ab2HHXHz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 19:07:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B6D1F5BE;
	Wed,  8 Aug 2012 23:07:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5021F9D4.1010700@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203143>

Robert Luberda <robert@debian.org> wrote:
> Eric Wong wrote:
> >> +		echo "PATH=\"$PATH\"; export PATH" >> $hook
> >> +		echo "svnconf=\"$svnconf\"" >> $hook
> >> +		cat >> "$hook" <<- 'EOF2'
> >> +			cd work-auto-commits.svn
> >> +			svn up --config-dir "$svnconf"
> > 
> > That doesn't seem to interact well with users who depend on
> > svn_cmd pointing to something non-standard.  Not sure
> > what to do about it, though....

> I have no idea how to change it either. I've tried to source the
> lib-git-svn.sh file inside the hook, but it sources test-lib.sh, and the
> latter script doesn't work well if it is sourced by non-test script.
> Anyway I the part of my original patch unchanged.

Ah, so svn_cmd only cares about --config-dir and you already handled
that :)   I misremembered it also allowed for non-standard SVN
installations :x

I've pushed your updated patch to my "maint" branch on
git://bogomips.org/git-svn since "master" has larger pending changes.

Thanks!

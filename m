From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: teach git-svn to populate svn:mergeinfo
Date: Tue, 6 Sep 2011 13:45:58 -0700
Message-ID: <20110906204558.GA12574@dcvr.yhbt.net>
References: <20110902140702.066a4668@robyn.woti.com>
 <4E612319.7030006@vilain.net>
 <20110902144922.383ed0f1@robyn.woti.com>
 <4E6127F5.5070009@vilain.net>
 <20110902154206.331b80e9@robyn.woti.com>
 <4E614AE7.7090706@vilain.net>
 <20110903084947.GA16711@dcvr.yhbt.net>
 <20110906100003.4c87daba@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R12Wx-0004i5-Qe
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab1IFUqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:46:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57129 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242Ab1IFUp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:45:59 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20B821062;
	Tue,  6 Sep 2011 20:45:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110906100003.4c87daba@robyn.woti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180834>

Bryan Jacobs <bjacobs@woti.com> wrote:
> On Sat, 3 Sep 2011 08:49:47 +0000
> Eric Wong <normalperson@yhbt.net> wrote:
> > dcommit needs to continually rebase because it's possible somebody
> > else may make a commit to the SVN repo while a git-svn user is
> > dcommiting and cause a conflict the user would need to resolve in the
> > working tree.
> > 
> > At least I think that was the reason...  There is also the
> > "commit-diff" command in git-svn.  It was the precursor to dcommit
> > which requires no changes to the working tree.
> 
> Let me see if I've got this right.
> 
> The goal here is to commit each x~..x for each x in A..B, aborting if
> the SVN tree is not in state "x~" when the diff arrives.

Yes.

> So why am I seeing files added in changes on alternate
> branches ending up in the working copy when I abort before apply_diff
> is called for the commit which merges them into the present branch?

I don't know.

In my past use of git-svn, I've _always_ stuck with linear changes and
avoided anything non-linear.  SVN mergeinfo didn't exist when/where I
used SVN and my only current uses of git-svn is read-only.


Anyhow, I'm willing to accept your change since it doesn't appear to
break anything for existing users and Sam seems to approve.

-- 
Eric Wong

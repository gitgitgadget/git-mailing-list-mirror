From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] git svn: Set default --prefix='origin/' if --prefix
 is not given
Date: Tue, 1 Oct 2013 04:07:52 +0000
Message-ID: <20131001040752.GA882@dcvr.yhbt.net>
References: <CALKQrgeXAtWeTedqkVtcTAUgbsBA9U6rbqUntu_ArmPgL9R3pg@mail.gmail.com>
 <1380581194-5269-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tfnico@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 01 06:08:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQrFk-0005AQ-9P
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 06:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab3JAEHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 00:07:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56983 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab3JAEHx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 00:07:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34781F523;
	Tue,  1 Oct 2013 04:07:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1380581194-5269-1-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235641>

Johan Herland <johan@herland.net> wrote:
> git-svn by default puts its Subversion-tracking refs directly in
> refs/remotes/*. This runs counter to Git's convention of using
> refs/remotes/$remote/* for storing remote-tracking branches.

> Furthermore, combining git-svn with regular git remotes run the risk of
> clobbering refs under refs/remotes (e.g. if you have a git remote
> called "tags" with a "v1" branch, it will overlap with the git-svn's
> tracking branch for the "v1" tag from Subversion.
> 
> Even though the git-svn refs stored in refs/remotes/* are not "proper"
> remote-tracking branches (since they are not covered by a proper git
> remote's refspec), they clearly represent a similar concept, and would
> benefit from following the same convention.

I regretted my original naming shortly after introducing it (IIRC,
git-svn was the first refs/remotes/* user).  However, this risks
breaking existing code and 3rd-party docs/tutorials.

How about we put a big warning of impending change in there for now and
wait until git 1.9/2.0 to make the actual change?

Thanks for bringing this up again!

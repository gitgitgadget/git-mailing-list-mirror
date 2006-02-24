From: linux@horizon.com
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: 23 Feb 2006 20:23:12 -0500
Message-ID: <20060224012312.25603.qmail@science.horizon.com>
References: <Pine.LNX.4.63.0602240152490.32472@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: cworth@cworth.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 02:23:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCRfw-0007KH-Eh
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 02:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWBXBXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 20:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWBXBXN
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 20:23:13 -0500
Received: from science.horizon.com ([192.35.100.1]:63809 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932392AbWBXBXN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 20:23:13 -0500
Received: (qmail 25604 invoked by uid 1000); 23 Feb 2006 20:23:12 -0500
To: Johannes.Schindelin@gmx.de, linux@horizon.com
In-Reply-To: <Pine.LNX.4.63.0602240152490.32472@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16681>

> Not heretical. How do you intend to switch branches now?

Point .git/HEAD at the branch like usual.
.git/HEAD would not be a symref *only* when on the unnamed temporary
branch (which doesn't accept commits).

> And how do you intend to record the starting point of git-seek to
> which you want to return to?

Te same way it's done now for git-seek or git-bisect: by copying the
old HEAD to a temporary location like .git/head-name.

> All leads back to .git/HEAD pointing to a branch (or whatever 
> you want to call it).

In the usual case, yes it should.  Any time you want to be able to
develop on a branch, you need .git/HEAD pointing to a branch.
You only make it point to a commit directly is when exploring the
history with no intention of developing from it.

(Note that you can easily change your mind with a simple
"git checkout -b <branch>".)

> And BTW, .git/HEAD is no symlink these days, but a symref.

Yes, I'm sorry; I was just being lazy with my terminology.

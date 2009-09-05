From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Question about git-svn
Date: Fri, 4 Sep 2009 23:09:40 -0700
Message-ID: <20090905060940.GB22272@dcvr.yhbt.net>
References: <b4abed330908310601h197f8909h8f626e918f8e5090@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin liste larsson <martin.liste.larsson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjoTB-0006Xz-1Z
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbZIEGJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 02:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbZIEGJk
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:09:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39342 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbZIEGJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:09:39 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 716511F5D0;
	Sat,  5 Sep 2009 06:09:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b4abed330908310601h197f8909h8f626e918f8e5090@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127777>

martin liste larsson <martin.liste.larsson@gmail.com> wrote:
> I have a problem using git-svn. Is this the right place to ask then?

Hi, Yes, feel free to Cc me directly as well.

> I have followed Andy Delcambre's
> http://herebeforeatreplies.com/2008/03/04/git-svn-workflow.html, but
> it seems that not all my tags and branches are being imported from svn
> to (local) git. That is, 'git branch -a' gives much less output (about
> half) of the combination 'svn list http://repos/branches' and 'svn
> list http://repos/tags'.

Are there branches/tags in subdirectories?

As in, do you have stuff in http://repos/branches/foo/* as well
as just http://repos/branches/* ?

You'll need git 1.6.4 to handle that with multiple branches entries:

before:

	[svn-remote "svn"]
		branches = project/branches/*:refs/remotes/*

after:
	[svn-remote "svn"]
		branches = project/branches/*:refs/remotes/*
		branches = project/branches/foo/*: refs/remotes/foo/*

> What's missing seems to be the newest
> branches and tags.

Just checking the obvious, you are running "git svn fetch", right?

-- 
Eric Wong

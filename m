From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for git-svn-id
Date: Wed, 1 Aug 2012 14:43:18 -0700
Message-ID: <20120801214318.GA10384@dcvr.yhbt.net>
References: <1343856197-6393-1-git-send-email-robert@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwghQ-0004QU-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab2HAVnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:43:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49419 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778Ab2HAVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:43:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01A81F7BA;
	Wed,  1 Aug 2012 21:43:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343856197-6393-1-git-send-email-robert@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202730>

Robert Luberda <robert@debian.org> wrote:
> While importing changes from SVN by `git svn fetch' strip any
> white spaces from beginnings and endings of SVN commit messages
> and skip adding a new line character before `git-svn-id:'
> line in case the commit message ends with another pseudo-header
> (like From:, Signed-off-by: or Change-Id:, etc.).
> 
> This patch allows one to use gerrit code review system on git-svn-managed
> repositories. gerrit expects its `Change-Id:' header to appear in the
> last paragraph of commit message and `git-svn-id:' following a new
> line character was breaking this expectation.

I've long wanted to change this, but it breaks compatibility if folks
are importing from the same repo, sharing changes and one upgrades
git-svn.

How about making this optional and configurable at init/clone time?

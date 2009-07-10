From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn is "Unable to determine upstream SVN information..."
Date: Thu, 9 Jul 2009 20:31:33 -0700
Message-ID: <20090710033133.GA23082@dcvr.yhbt.net>
References: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esskov@oncable.dk
X-From: git-owner@vger.kernel.org Fri Jul 10 05:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP6q9-0002WY-9u
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 05:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbZGJDbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 23:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZGJDbf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 23:31:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56969 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbZGJDbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 23:31:34 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 3D5221F78E;
	Fri, 10 Jul 2009 03:31:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123032>

esskov@oncable.dk wrote:
> 	Hi,
> 
> I'm trying to clone the trunk of an svn repo, so that I can work on a set
> of patches locally, and then occasionally push some of them back to svn.
> 
> The git-svn clone seems to go well, and the resulting git log looks
> alright. However, git-svn info and git-svn rebase both say "Unable to
> determine upstream SVN information from working tree history".
> Also, git-svn log shows nothing.  I'm using the svn:// protocol btw, but I
> guess the protocol shouldn't matter?

Protocol shouldn't matter.  Do you have any non-linear history from
merges in git?  git-svn (and SVN) doesn't play very nicely with
non-linear history that git merges can generate.

Does having a clean clone of that repo fix things?  You didn't use
--no-metadata or blow away your .git/svn/* directories, did you?

> To test if this was a general problem, I just tried to git-svn clone a
> repo on some public svn server which was also using the svn protocol. I
> used exactly the same syntax for the svn init and fetch commands. However,
> the resulting git repo did NOT suffer from the problem, i.e., git-svn info
> reported nicely etc.
> 
> At some point I suspected that there might be a problem with the
> "git-svn-id ..." lines in the commits for the problematic repo, but they
> look just like the ones for the working repo. The .git/config files of the
> working and the non-working git-repos are similar as well. 
> 
> What could be causing this problem?

Which version of git svn is this?  Are there any weird characters in the
URL?  Off the top of my head I can't think of anything else; I assume
you're not allowed to share access to the repo (or to the clone) you're
having problems with?

-- 
Eric Wong

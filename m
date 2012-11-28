From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/4] Recommend use of structure options for git svn.
Date: Wed, 28 Nov 2012 15:46:45 +0100
Message-ID: <50B623D5.9090606@drmicha.warpmail.net>
References: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name> <a4de87e8d09c26221eff116c3209b0a3606dfc21.1353691892.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:47:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdiuk-0007xz-5I
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 15:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab2K1Oqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 09:46:47 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54727 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753233Ab2K1Oqq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2012 09:46:46 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4B05F20D28;
	Wed, 28 Nov 2012 09:46:46 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 28 Nov 2012 09:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=fXzbcUOhuHZWh+2ojguqwA
	IFeNw=; b=F5o6OZxMjtKNg75CXRrKLRfzHmNc0LdJoBnnFJGcPp5vRNAPzSO3FA
	aB7NJOemtrlcZKpnaECbWrYHSbJ/EkCIF6u0KMvKAJ/ngqzRomdjHCiTOBNffIk4
	fHwv8AtPPNKUmvCmpwHQBJ5esZniVrKGbfD2Sf7WLM9VK6I33Qstk=
X-Sasl-enc: 5r2Qo9XjV23iN+Z+IwzC3LgzxitU6ALWWIsZrXKUj8Dc 1354114006
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B14028E0550;
	Wed, 28 Nov 2012 09:46:45 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <a4de87e8d09c26221eff116c3209b0a3606dfc21.1353691892.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210734>

Sebastian Leske venit, vidit, dixit 21.11.2012 08:13:
> Document that when using git svn, one should usually either use the
> directory structure options to import branches as branches, or only
> import one subdirectory. The default behaviour of cloning all branches
> and tags as subdirectories in the working copy is usually not what the
> user wants.

"Usually" assumes that usually svn repos follow a branch/tag structure.
That may be quite true nowadays (but wasn't in the beginning).

In fact I would suggest to emphasize "--stdlayout" as the most standard
choice nowadays, followed by specifying a specific branch (usually
trunk) as the repo uri.

> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
>  Documentation/git-svn.txt |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 482d60d..928a961 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -871,6 +871,16 @@ already dcommitted.  It is considered bad practice to --amend commits
>  you've already pushed to a remote repository for other users, and
>  dcommit with SVN is analogous to that.
>  
> +When cloning an SVN repository, if none of the options for describing
> +the repository layout is used (--trunk, --tags, --branches,
> +--stdlayout), 'git svn clone' will create a git repository with
> +completely linear history, where branches and tags appear as separate
> +folders in the working copy.  For projects with many branches this will
> +lead to a working copy many times larger than just the trunk.  It is
> +recommended to either use the the options for trunk / tag / branch
> +directory, or to only clone the trunk (or a subdirectory of the
> +trunk).
> +
>  When using multiple --branches or --tags, 'git svn' does not automatically
>  handle name collisions (for example, if two branches from different paths have
>  the same name, or if a branch and a tag have the same name).  In these cases,
> 

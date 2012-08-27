From: Semen Vadishev <semen.vadishev@tmatesoft.com>
Subject: Re: synchronization with Subversion
Date: Mon, 27 Aug 2012 20:42:14 +0200
Message-ID: <503BBF86.5090707@tmatesoft.com>
References: <OFD8B086DC.EB0E996E-ON85257A53.00705446-85257A53.00707425@sita.aero>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tad.Mannes@sita.aero
X-From: git-owner@vger.kernel.org Mon Aug 27 20:42:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T64GY-0004b2-IV
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 20:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab2H0SmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 14:42:20 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60821 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab2H0SmT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 14:42:19 -0400
Received: by bkwj10 with SMTP id j10so1361802bkw.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 11:42:18 -0700 (PDT)
Received: by 10.204.133.220 with SMTP id g28mr4042631bkt.117.1346092937999;
        Mon, 27 Aug 2012 11:42:17 -0700 (PDT)
Received: from vs.local ([109.80.120.205])
        by mx.google.com with ESMTPS id hg13sm11253804bkc.7.2012.08.27.11.42.15
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 11:42:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <OFD8B086DC.EB0E996E-ON85257A53.00705446-85257A53.00707425@sita.aero>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204365>

Hello Tad,

> we maintain a "central/main" git repository which our developers clone
> from.  We want to synchronize this "central" git repository with
> Subversion.  I know this is not the recommended way to do this, but this
> was the choice that was made.  The "central" git repository was originally
> cloned from Subversion as that was our migration path to git.

Have you looked at SubGit, http://subgit.com/ ?

SubGit is a bi-directional git-svn synchronization tool. It's basically 
a set of hooks that enable instant conversion of changes between 
Subversion and Git repositories. So, I think it'd work great for you.

SubGit does not use git-svn internally, it's built on home-grown 
conversion engine. Most probably you have to re-translate your 
Subversion repository with SubGit in order to keep repositories synced.

SubGit is a commercial closed-source product. But we provide free 
options for open-source and academic projects. It's also free for 
evaluation period.

Semen Vadishev,
TMate Software,
http://subgit.com/ - git+svn on the server side!

On 8/7/12 22:28, Tad.Mannes@sita.aero wrote:
> Greetings,
>
> we maintain a "central/main" git repository which our developers clone
> from.  We want to synchronize this "central" git repository with
> Subversion.  I know this is not the recommended way to do this, but this
> was the choice that was made.  The "central" git repository was originally
> cloned from Subversion as that was our migration path to git.
>
> Currently I can't get the synchronization to work again after another
> sprint.  I get the following error message:
> Unable to determine upstream SVN information from HEAD history.
> Perhaps the repository is empty. at /usr/libexec/git-core/git-svn line
> 525.
> This synchronization has worked a number of times, but now it always fails
> with the above error.
>
> I have read that it's best to have a linear commit history when
> synchronizing to Subversion, and I've read that "git rebase" is the way to
> accomplish this.  I've attempted this, but I run into two problems trying
> to do this:
>
> 1. Any files/directories which get moved/renamed cause the rebase to stop
> and I have to tell git to skip the commit, though it appears to me that
> the move/rename actually worked.  I am confused by this behavior, and
> don't understand why it happens at all.
>
> 2. There are a number of conflicts which occur during the rebase.  This
> also confuses me.  I think I understand why they happen, but I'm not clear
> about how to handle them.  Our code base goes back many years and contains
> a huge number of commits (originally in CVS, then migrated to Subversion
> and Git).  It isn't obvious what impact the conflict resolution would
> have.  My suspicion, is that it will breed even more conflicts as the
> rebase continues from that point.
>
> As you might have guessed, Subversion is the corporate mandated
> repository, which is why we are attempting to maintain the
> synchronization.  We have a "central" git repository as we want to have
> more control over which changes are accepted.
>
> I'm hoping for some suggestions for dealing with this.  Any takers?
>
> Thnks/Brgds             --Tad
> ---
> Tad K. Mannes
> Senior Developer
> SITA - Societe Internationale de Telecommunications Aeronautiques
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

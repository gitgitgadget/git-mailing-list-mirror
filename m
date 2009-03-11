From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Confusing `stash apply` behavior
Date: Wed, 11 Mar 2009 19:02:17 +0900
Message-ID: <20090311190217.6117@nanako3.lavabit.com>
References: <c115fd3c0903101246n1eff50d4rc819e5fe7586a974@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 11:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhLIs-00065L-5h
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 11:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbZCKKCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 06:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbZCKKCy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 06:02:54 -0400
Received: from karen.lavabit.com ([72.249.41.33]:51670 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741AbZCKKCw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 06:02:52 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id E136811B8BD;
	Wed, 11 Mar 2009 05:02:50 -0500 (CDT)
Received: from 1522.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 6ZU58DTCD7KX; Wed, 11 Mar 2009 05:02:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=jjK+H+zzAKeEamF0l24uQoqbOgqEF/RJkksQXc9vtPPElZBP+f0k3JZuUa0PlHoz+7dwONWr7fUKfXfAD4sB2SY3s3tGnYPM5/lBlTu9qFZQMr/Y2PwJfIxjijsCnAAZveaIcJSQMZkqm1oE0KONqGOiT/43xJX8dBlK8VaA3oo=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <c115fd3c0903101246n1eff50d4rc819e5fe7586a974@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112903>

Quoting Tim Visher <tim.visher@gmail.com>:

> When I do `git stash apply`, it deletes the file I'm working with.
>
>     $ ls
>     featureList.txt*  keycontrol.mdb*
>
>     $ git show stash@{0}
>     commit b3c0f4b9b3c3ef7741a03fb27174f5838abc939d
>     Merge: 9fb9886 112bba9
>     Author: Tim Visher <timothy.visher@fms.treas.gov>
>     Date:   Tue Mar 10 15:25:04 2009 -0400
>
>     WIP on dev: 9fb9886 Added DB Lock file to .gitignore. EOM
>
>     diff --cc keycontrol.mdb
>     index 68a9bac,68a9bac..0000000
>     --- a/keycontrol.mdb
>     +++ b/keycontrol.mdb
>
>     $ git stash apply
>     Removing keycontrol.mdb
>     # On branch refactoring
>     # Changed but not updated:
>     #   (use "git add/rm <file>..." to update what will be committed)
>     #   (use "git checkout -- <file>..." to discard changes in working
> directory)
>     #
>     #       deleted:    keycontrol.mdb
>     #
>     no changes added to commit (use "git add" and/or "git commit -a")
>
> Considering the output of `git show` I would expect that the contents
> of the stash are, well, what I expect them to be: a new version of
> keycontrol.mdb.

The 'index' line in your 'diff --cc' output says that back when you created that stash, the HEAD and your index both held a blob object 68a9bac and your working tree didn't have that file, ie, removed. It is very natural that the file is removed when you apply that stash.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

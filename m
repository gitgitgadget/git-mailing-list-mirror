From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 18:31:01 +0200
Message-ID: <845b6e870610210931r19aaaac3y3dfd0d9c4af8ed40@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
	 <20061021130111.GL75501@over-yonder.net>
	 <200610211608.18895.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 18:33:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJmQ-00022P-2K
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWJUQc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 12:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992785AbWJUQc6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:32:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:39859 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161475AbWJUQc6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 12:32:58 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k9LGWeGm021868
	for <git@vger.kernel.org>; Sat, 21 Oct 2006 16:32:52 GMT
Received: by py-out-1112.google.com with SMTP id z74so42787pyg
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 09:31:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f19isD7yD/hNg/KrnGB0c/Noinb707ed9pB17xk/kUwUnj0HVrSvVRu2ZFwtGib0pJQE28xTIkDUuTRKEHL2ONahGfI4bXYtmd5BR3FvxkRwIOV4qOg/tctl+31wwx1dgeP/UaCxwV2aGETUouJhRuh60BteapFet4AmDmX4Eqo=
Received: by 10.35.77.18 with SMTP id e18mr2990885pyl;
        Sat, 21 Oct 2006 09:31:01 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Sat, 21 Oct 2006 09:31:01 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200610211608.18895.jnareb@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/2061/Sat Oct 21 09:05:13 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29632>

> There _are_ terminology conflicts. For example bzr "branch" is roughly
> equivalent to one-branch git "repository";

Agreed.

> bzr "repository" is just
> collection of branches sharing common storage,
Agreed

> which is similar to set
> of git "repositories" with .git/objects/ linked to common object
> repository (storage area) or appropriately set alternates file
> (although that is not common usage in git, and for example you would
> have to be carefull with running git-prune); bzr "lightweight checkout"
> is equivalent to nonexistent "lazy clone"/"remote alternates" discussed
> on git mailing list but not implemented because of performance
> concerns; bzr "normal checkout" is I think similar to git "shared
> clone" (but shared clone is limited to repositories on the same
> filesystem); bzr "heavyweight checkout" is roughly equivalent to
> one-branch-only "clone" in git or cg (cg = Cogito).

This is wrong. There are two kinds of checkouts
lightweight.. and "normal/heavyweight".

I think you are getting this alittle wrong, and I think the reason is
that you are thinking of repositories, while in bzr you normally think
of branches.

For example, I think (correct me if I'm wrong) that if I have a git
repository of a upstream linux-repo (Linus' for example).  I guess
I'll use "pull" to keep my copy up to date with the upstream repo? If
I then would like to hack something special, I would "clone" the repo
and get a new repo and that's where I do my work.  Is that correct?

In bzr you never (well...)  clone a full repository, but you clone one
line-of-development (a branch).  So "bzr branch"  is always a
"one-branch-only "clone" in git or cg".

"bzr checkout" is a "bzr branch" followed by a setting saying
"whenever you commit here, commit in the master branch also".

"bzr checkout --lightweight" is a way to get only a snapshot of the
working tree out of a branch. Whenever you commit, it's done in the
remote branch.

/Erik

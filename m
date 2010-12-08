From: Johan Herland <johan@herland.net>
Subject: Re: git stash path/to/only/one/subdirectory
Date: Wed, 8 Dec 2010 16:38:56 +0100
Message-ID: <201012081638.56543.johan@herland.net>
References: <AANLkTim+sOeVfkAac1v-CsD5GG8Vj2VSjXn-9SSw+Hjb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 16:39:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQM6k-0001FW-T7
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 16:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab0LHPjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 10:39:00 -0500
Received: from smtp.opera.com ([213.236.208.81]:33050 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829Ab0LHPi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 10:38:59 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oB8FcurH027220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Dec 2010 15:38:57 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTim+sOeVfkAac1v-CsD5GG8Vj2VSjXn-9SSw+Hjb@mail.gmail.com>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163201>

On Wednesday 08 December 2010, Patrick Doyle wrote:
> Looking at the man page for git-stash, it seems like I can do this
> with the --patch option to git-stash, but I figured I'd ask the
> questions anyway...
>
> Is it possible to git-stash a single directory, while leaving the
> rest of my working copy in the state it's in?
>
> In my particular case (as of 9:00am this morning), I've realized that
> I want to split my work into 2 separate commits; I'm not done with
> either of them yet; and they are in completely separate directories
> from each other.  I would like to do something like:
>
> $ git stash --subdir-only dir1
> edit/test stuff in dir2, possibly committing once or twice along the
> way $ git commit dir2
> go off and do other stuff for a while, and come back to the dir1
> stuff I was playing with
> $ git stash pop
> finish the dir1 work
> $ git commit dir1

Usually, I solve these problems by staging dir2 with 'git add dir2' and 
then committing it ('git commit' without -a), then running 'git stash' 
to remove dir1 changes from the worktree. I can now test the dir2 
changes and fix the dir2 commit (if needed) with 'git commit --amend'. 
Then, when it looks good, I can bring dir1 back with 'git stash pop' 
and continue working on that.

You should also look at 'git add -p' to stage changes hunk-by-hunk. That 
is really helpful when dir1 changes and dir2 changes are not in 
separate directories.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

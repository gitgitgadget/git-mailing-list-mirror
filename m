From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is ignored by git?
Date: Fri, 9 Apr 2010 16:50:41 +0200
Message-ID: <201004091650.43326.jnareb@gmail.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com> <m3sk74hjkg.fsf@localhost.localdomain> <20100409140215.GB27899@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 16:51:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0FY0-0002bb-MJ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 16:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab0DIOuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 10:50:54 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:58198 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0DIOuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 10:50:52 -0400
Received: by fxm23 with SMTP id 23so2891505fxm.21
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7vAfccJDKrVgtBIR2plvaG4N2Y9NTWieSMUTANq95PE=;
        b=Wmoo5KD0NsOqCAE9eEf12nwlYxF2hCdFsK5NK059rhcWyVU7c3QNt5qGw83kf3LQOo
         fWCAFdktVW/EXYpplhVLrO/TAfuOLKkJLzWBaXsZyDRCqkyW31Y5dMGTwH2vST5/3PyM
         mDYwrFlhnnuUEC54h2gwrYGW/bcKWkE5GsRQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kV/u0T1mcFtpwBv1Xq90yS7grpy7LnvjNbb2DpVIXpo+j2+g9JNKJsbBRz9VbjmJhn
         aOZG6unfzOJK7E35Z83yiD0VULkW8Lox4zp4RFVdhvTJJTsppIW0pOWw++OX7quK+0uu
         ZwjRH8xXaNRYfNG+gpM0MZYedxrTS4Xz5Nt4g=
Received: by 10.223.5.207 with SMTP id 15mr201603faw.6.1270824651053;
        Fri, 09 Apr 2010 07:50:51 -0700 (PDT)
Received: from [192.168.1.13] (abvc167.neoplus.adsl.tpnet.pl [83.8.200.167])
        by mx.google.com with ESMTPS id 16sm791735fxm.4.2010.04.09.07.50.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 07:50:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100409140215.GB27899@thyrsus.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144437>

On Fri, 9 Apr 2010, Eric Raymond wrote:
> Jakub Narebski <jnareb@gmail.com>:
> > There is also
> > 
> >         git status --short
> 
> Not documented in my installed version, 1.6.3.3.  Where can I go in the
> repo to read about this?

It was *documented* in git version 1.7.0 in 
  7c9f703 (commit: support alternate status formats, 2009-09-05)
I am running git version 1.7.0.1.

BTW. it is only since git 1.7.0 that "git status" is no longer
"git commit --dry-run"... and has sane behaviour wrt. specifying paths.

[...]
> > > 
> > >   'needs-update      The file has not been edited by the user, but there is
> > >                      a more recent version on the current branch stored
> > >                      in the master file.
> > 
> > Needs *update* looks like it came from centralized VCS like CVS and
> > Subversion, where you use update-the-commit method.  You can't say
> > that HEAD version is more recent that working file...
> > 
> > The rought equivalent would be that upstream branch for current
> > branch (e.g. 'origin/master' can be upstream for 'master' branch) is
> > in fast-forward state i.e. current branch is direct ancestor of
> > corresponding upstream branch, and the file was modified upstream.
> 
> Agreed. But there's no way to tell that this is the case without 
> doing a pull operation or otherwise querying origin, and I'm
> not going to do that.
> 
> Explanation: My general rule for DVCS back ends is that the status commands
> aren't allowed to do network operations, and it's OK for them not to
> report a state code if that would be required.  This is so VC will fully
> support disconnected operation when the VCS does.
> 
> I have, however, added a note to vc-git.el explaining that this is
> possible if we ever teach the mode front end to behave differently when
> it knows it has live Internet.  I might do this in the future.
>  
> > > 
> > >   'needs-merge       The file has been edited by the user, and there is also
> > >                      a more recent version on the current branch stored in
> > >                      the master file.  This state can only occur if locking
> > >                      is not used for the file.
> > 
> > This, like 'needs-update, looks like it is relevant only in
> > update-the-commit workflow centralized VCS.
> 
> Following your previous logic, I think it would make sense to set this if 
> we could detect that the upstream of the current branch has forward commits 
> touching this file.  Again, this would require a network operation in the
> general case.

Actually it would not require network access, but it would require extra
work, and equivalents of 'needs-update and 'needs-merge would not exist
in all cases (in all situations).

In Git you have remote-tracking branches, which are tracking where 
branches in remote repository point to.  Since quite some time by default
the reside in 'refs/remotes/<remote>/' namespace, while ordinary local
branches in 'refs/heads/' namespace.  For example remote-tracking branch
'refs/remotes/origin/master', usually referred to in short as 
'origin/master', tracks (follows) branch 'master' ('refs/heads/master')
in remote 'origin'.  Those branches might be out-of-date with respect
to remote repository, and to update them you need network connection.

Local branches can be created to "track" other branches, to base work
on the other branches.  In particular you need to create local branch
which "tracks", or in other words has as 'upstream' some remote-tracking
branch, as you cannot work on non-local branch (outside 'refs/heads/'
namespace).

Now, *if* you are on branch with some upstream, you can check without
need for network operation whether "git pull" would do if there were
no new changes in remote, which means what "git merge <upstream>" would
do (pull = fetch + merge).

We can check if remote-tracking branch, which is upstream of current
branch, modified current file.  We can also check if remote-tracking
branch is in fast-forwardable state wrt. current branch (the equivalent
of 'needs-update state, I guess), or did remote-tracking branch diverged
from current branch (the equivalent of 'needs-merge state, I guess).
All this without need for network operation... but all this based on
current information that might be stale.


P.S. Simple "git checkout" would show if branches diverge, although
it is meant for end user, not scripting.  For example:

  $ git checkout
  Your branch and 'gitweb-kernel.org/gitweb-ml-v5' have diverged,
  and have 912 and 9 different commit(s) each, respectively.

P.P.S. When documentation is insufficient, you can always as last resort
take a look at git test suite, e.g. at t/t3000-ls-files* and 
t/t7508-status.sh
-- 
Jakub Narebski
Poland

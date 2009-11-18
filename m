From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 11:40:45 -0800 (PST)
Message-ID: <m37htnd3kb.fsf@localhost.localdomain>
References: <005a01ca684e$71a1d710$54e58530$@com>
	<20091118142512.1313744e@perceptron>
	<008401ca6880$33d7e550$9b87aff0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "=?iso-8859-15?q?'Jan_Kr=FCger'?=" <jk@jk.gs>,
	<git@vger.kernel.org>
To: "George Dennie" <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 20:40:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAqOg-0006t6-QQ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 20:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758376AbZKRTkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758268AbZKRTkm
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 14:40:42 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:44176 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758056AbZKRTkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 14:40:41 -0500
Received: by fxm21 with SMTP id 21so1573491fxm.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 11:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=bTW7oEfci3l/hhtC3yIabMCpUGfmhciMlXmnJw0mtrU=;
        b=Z1oLedkrIXZP0+uYChQA2Tl3gNabjb5j9tecGX+Lfmt4Xsj7/Hk1KJpDzdH28dhfjN
         yple7xVWBDwPAZnjxpt/LwxBUYSUZJPcjQHsv8KgdWq+hfow5RdRlUixqhLHS4pfd1gl
         mPVv+XJXIvzEG9E+cCgFERV9RatvozPulAC1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Rtj4/VXFPaTDlZGYcVc4O7m9xilFBpXeX5SrVRT9PQA/02mjFzEXt/zrjDEIGODGNr
         BqMlQjOP/dkNiEV527nxRQbYehWTgW55H2+Nx/6BtTErZm+emJY16rt1vgdHTCqpvQ+4
         e6L8Pal7t321EEZuk6iGQikCwbAmla5E94R8w=
Received: by 10.204.154.85 with SMTP id n21mr7331640bkw.171.1258573246760;
        Wed, 18 Nov 2009 11:40:46 -0800 (PST)
Received: from localhost.localdomain (abwj15.neoplus.adsl.tpnet.pl [83.8.233.15])
        by mx.google.com with ESMTPS id 15sm150121bwz.12.2009.11.18.11.40.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 11:40:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAIJecb3021488;
	Wed, 18 Nov 2009 20:40:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAIJeaGF021485;
	Wed, 18 Nov 2009 20:40:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <008401ca6880$33d7e550$9b87aff0$@com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133196>

"George Dennie" <gdennie@pospeople.com> writes:

> Thanks Jan, Jason, Jonathan, and Thomas for your response, your thoughts and
> concerns are enlightening....
 
> Jason Sewell wrote...
>
> > If you have a bunch of debugging code sitting around in your working tree
> > after you've tracked down a problem, you don't want to commit all
> > of those printfs, etc. - you want to commit the fix. This has
> > ramifications from making diffs of history cleaner to making git
> > bisect actually useful.
> 
> One of the concerns I have with the manual pick-n-commit is that you can
> forget a file or two.

I don't think that this concern is valid.  

The files which make project are those defined in Makefile or
equivalent project file, _not_ all files (or even all files of
specific type / extension) that do happen to reside in given
directory.  And those files whould be known to git, either added when
importing project into git, or added when they were created.  And if
they are known it is enough to use "git commit -a" to pick all
changes.

So I don't see how you can 'forget a file or two'.

Are those *theoretical* concerns, or is it something that happened to
you doring using git?

> Consequently, unless you do a clean checkout and test
> of the commit, you don't know that your publishable version even compiles.
> It seems safer to commit the entirety of your work in its working state and
> then do a clean checkout from a dedicated publishable branch and manually
> merge the changes in that, test, and commit.

That's what

  git stash --keep-index

is for.  

That, and continuous integration repository, with it's hooks.

> 
> It seems the intuitive model is to treat version control as applying to the
> whole document, not parts of it. In this respect the document is defined by
> the IDE, namely the entire solution, warts and all.

Yes, and IDE has project file which defines which files are in
project, just like version control system has it's tracked files.

> When you start
> selectively saving parts of the document then you are doing two things,
> versioning and publishing; and at the same time. This was a critical flaw in
> older version control approaches because the software solution document is a
> file system sub-tree.

Atomic commits are important, but the distinction between tracked
files, (untracked) ignored files, and files in "limbo" state (neither
tracked nor ignored) is orthogonal to having atomic commits.

> Jason Sewell wrote...
>
> >  Isn't fastidiously maintaining a .gitignore file to contain
> > everything you *don't* want in the project more confusing than
> > explicitly specifying things you *do* want in the project?  
> 
> This is git ignore for "cleaning prior to a check" and git ignore for
> "adding to index" and is not an either or. You would specify what you don't
> want to version tracked as normal but you can also stipulate what you don't
> want to be deleted during a clean restore (which should otherwise completely
> wipe the folder prior to restoring a specific commit). This would permit
> embedding non-version elements within the version tree for whatever reason
> you find necessary.

And this is supposedly easier to use?  I don't think so.

> Thomas Rast wrote...
>
> > That would require supernaturally good maintenance of your
> > .gitignore to avoid adding or (worse) nuking files by accident.
> 
> On the contrary, the approach would all but eliminate the possibility of
> loss of data since you would not manually (and therefore error prone-ingly)
> pruning until after a commit. In fact, one might default automatic commits
> (if required) prior to checkouts or at least an alert system when
> uncommitted changes exists.

What?  I cannot understand you here.

I think that automatic pruning of non-versioned files is _more_ error
prone than manual deleting of files.  And much more error prone that
just keeping non-ignored and non-tracked files.

-- 
Jakub Narebski
Poland
ShadeHawk on #git

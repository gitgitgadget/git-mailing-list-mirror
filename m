From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Bug#557477: git-svn: git svn dcommit doesn't handle network failure
Date: Sat, 9 Jan 2010 01:57:43 -0600
Message-ID: <20100109075743.GA3377@progeny.tock>
References: <20091122112434.29914.59452.reportbug@localhost.localdomain>
 <20100109010058.GA11922@progeny.tock>
 <20100109021347.GA26520@dcvr.yhbt.net>
Reply-To: Jonathan Nieder <jrnieder@gmail.com>, 557477@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brice Goglin <bgoglin@debian.org>, 557477-forwarded@bugs.debian.org,
	557477@bugs.debian.org, git@vger.kernel.org,
	Alex Vandiver <alex@chmrr.net>, Pedro Melo <melo@simplicidade.org>,
	Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org Sat Jan 09 09:05:37 2010
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Envelope-to: glddb-debian-bugs-dist@m.gmane.org
Received: from liszt.debian.org ([82.195.75.100])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTWKF-0004OE-My
	for glddb-debian-bugs-dist@m.gmane.org; Sat, 09 Jan 2010 09:05:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id 97FA82D8B55; Sat,  9 Jan 2010 08:05:35 +0000 (UTC)
Old-Return-Path: <debbugs@rietz.debian.org>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on liszt.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=4.0 tests=FOURLA,LDO_WHITELIST,
	MURPHY_DRUGS_REL8,MURPHY_SEX_L5,RCVD_IN_DNSWL_LOW autolearn=failed
	version=3.2.5
X-Original-To: lists-debian-bugs-dist@liszt.debian.org
Delivered-To: lists-debian-bugs-dist@liszt.debian.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id F3FED13A64A0
	for <lists-debian-bugs-dist@liszt.debian.org>; Sat,  9 Jan 2010 08:05:28 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank bug
X-Amavis-Spam-Status: No, score=-0.411 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2.599, FH_DATE_PAST_20XX=3.188, RCVD_IN_DNSWL_LOW=-1]
	autolearn=no
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id huPY8My6IMFH
	for <lists-debian-bugs-dist@liszt.debian.org>;
	Sat,  9 Jan 2010 08:05:23 +0000 (UTC)
Received: from rietz.debian.org (rietz.debian.org [140.211.166.43])
	by liszt.debian.org (Postfix) with ESMTP id 6654213A634D;
	Sat,  9 Jan 2010 08:05:23 +0000 (UTC)
Received: from debbugs by rietz.debian.org with local (Exim 4.63)
	(envelope-from <debbugs@rietz.debian.org>)
	id 1NTWHx-00040w-Ry; Sat, 09 Jan 2010 08:03:13 +0000
X-Loop: owner@bugs.debian.org
Resent-From: Jonathan Nieder <jrnieder@gmail.com>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Gerrit Pape <pape@smarden.org>
X-Loop: owner@bugs.debian.org
Resent-Date: Sat, 09 Jan 2010 08:03:12 +0000
Resent-Message-ID: <handler.557477.B557477.126302387313656@bugs.debian.org>
X-Debian-PR-Message: followup 557477
X-Debian-PR-Package: git-svn
X-Debian-PR-Keywords: 
X-Debian-PR-Source: git-core
Received: via spool by 557477-submit@bugs.debian.org id=B557477.126302387313656
          (code B ref 557477); Sat, 09 Jan 2010 08:03:12 +0000
Received: (at 557477) by bugs.debian.org; 9 Jan 2010 07:57:53 +0000
Received: from mail-iw0-f178.google.com ([209.85.223.178])
	by rietz.debian.org with esmtp (Exim 4.63)
	(envelope-from <jrnieder@gmail.com>)
	id 1NTWCm-0003XW-QN; Sat, 09 Jan 2010 07:57:52 +0000
Received: by iwn8 with SMTP id 8so14252177iwn.23
        for <multiple recipients>; Fri, 08 Jan 2010 23:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fhtFacL65R18rxyDzEdbyaBaPd5tvhOkHQZhRTeG5Og=;
        b=TcvFDCpcvyw8gcNKG5/Ci290hl3rO5w1cotT6JtR3r3RSev5wRAFa0N+jpAmSSi5iP
         acTo4u3NJcDzr2jaNWx/HHn2mueatx3iujoCGfoVbP5mg0xNzxA/+G6CHwNlG07KEf0t
         CLSdausHpKVq3QDgV6SY/++gUGbiv1C1Za5zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lkSs5n9EE5g2oUbdUTQ4e6yDozH3mXXiYS/aS7zwRsYiKlEBc/+ApkrRjKwZDt+orI
         +KdWq75kING8X8deAr4sBfyUBgd7FB+VpBBflK8IY4mJhtqVNbw7VDWCakC7gYpbiaY1
         iwqr8Oji7k7wVj2t8lyjnkMkv2/ZOIKf34PUo=
Received: by 10.231.168.136 with SMTP id u8mr617912iby.56.1263023867109;
        Fri, 08 Jan 2010 23:57:47 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2324869iwn.3.2010.01.08.23.57.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 23:57:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100109021347.GA26520@dcvr.yhbt.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Resent-Date: Sat, 09 Jan 2010 08:03:13 +0000
X-Debian-Message: from BTS
X-Rc-Virus: 2007-09-13_01
X-Rc-Spam: 2008-11-04_01
X-Mailing-List: <debian-bugs-dist@lists.debian.org> archive/latest/576308
X-Loop: debian-bugs-dist@lists.debian.org
List-Id: <debian-bugs-dist.lists.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-bugs-dist-request@lists.debian.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136525>

Eric Wong wrote:

> I agree that error recovery for dcommit sucks right now.
> 
> I think Brice's idea (creating a temporary branch to dcommit from)
> is easier to implement and less likely to break than automatically
> unapplying patches.

Sounds sane to me.  Probably that temporary branch could just be
a detached HEAD.

Current dcommit:

 diff-index --quiet HEAD || carp "Cannot dcommit with a dirty index"
 if head ne 'HEAD':
	save the old HEAD
	check out the head
 find svn upstream
 decide what commits to push (linearize_history)
 for each commit d to push:
	commit diff from d~ to d to the remote repository
		(this involves applying the diff locally?)
	remember parents
	fetch remote revision, using remembered parents for commit

	unless args include --no-rebase:
		rebase the current HEAD against fetched revision
			(or reset if there are no changes)
		update the list of commits to push
 if head ne 'HEAD':
	let the user know the branch or commit id for the finished dcommit
	check out the old head again

If I understand you correctly, before finding the svn upstream,
dcommit would save the HEAD ref name (if any) and detach the HEAD;
after pushing the relevant commits, update that ref and reattach the
HEAD.

If pushing fails early, what should git-svn do?  Leave the HEAD
detached, with a message suggesting to return to the old ref?  Check
out the old ref, with a message suggesting to 'git svn rebase' and try
again?  Do the 'git svn rebase' automatically?

I guess the safest option is the first one.  That would at least be a
starting point for experimenting with more friendly behaviors.

I should also mention that there seems to be a little race here: if
git-svn dies before (or while) fetching the newly commited revision,
when it is fetched later it will have the wrong parents.

Jonathan

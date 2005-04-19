From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 12:40:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com>
	<20050419185807.GA1191@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <gregkh@suse.de>, Git Mailing List <git@vger.kernel.org>,
        linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
X-From: lm78@Stimpy.netroedge.com Tue Apr 19 21:36:54 2005
Return-path: <lm78@Stimpy.netroedge.com>
Received: from stimpy.netroedge.com ([206.228.191.3])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNyVn-0007Io-Gk
	for gls-sensors@gmane.org; Tue, 19 Apr 2005 21:35:56 +0200
Received: from Stimpy.netroedge.com (IDENT:lm78@localhost [127.0.0.1])
	by Stimpy.netroedge.com (8.12.10/8.12.10) with ESMTP id j3JJf6pv007172;
	Tue, 19 Apr 2005 12:41:06 -0700
Received: (from lm78@localhost)
	by Stimpy.netroedge.com (8.12.10/8.12.8/Submit) id j3JJf3MZ007165;
	Tue, 19 Apr 2005 12:41:03 -0700
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	by Stimpy.netroedge.com (8.12.10/8.12.10) with ESMTP id j3JJf0pv007146
	for <sensors@stimpy.netroedge.com>; Tue, 19 Apr 2005 12:41:01 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JJcls4009314
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 12:38:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JJcjvm027220;
	Tue, 19 Apr 2005 12:38:46 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050419185807.GA1191@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
X-sensors-spam: ham; 0.01



On Tue, 19 Apr 2005, Greg KH wrote:
> 
> Nice, it looks like the merge of this tree, and my usb tree worked just
> fine.

Yup, it all seems to work out.

> So, what does this now mean?  Is your kernel.org git tree now going to
> be the "real" kernel tree that you will be working off of now?  Should
> we crank up the nightly snapshots and emails to the -commits list?

I'm not quite ready to consider it "real", but I'm getting there.

I'm still working out some performance issues with merges (the actual
"merge" operation itself is very fast, but I've been trying to make the
subsequent "update the working directory tree to the right thing" be much
better).

> Can I rely on the fact that these patches are now in your tree and I can
> forget about them? :)
> 
> Just wondering how comfortable you feel with your git tree so far.

Hold off for one more day. I'm very comfortable with how well git has 
worked out so far, and yes, mentally I consider this "the tree", but the 
fact is, git isn't exactly easy on "normal users".

I think my merge stuff and Pasky's scripts are getting there, but I want
to make sure that we have a version of Pasky's scripts that use the new
"read-tree -m" optimizations to make tracking a tree faster, and I'd like
to have them _tested_ a bit first.

In other words, I want it to be at the point where people can do

	git pull <repo-address>

and it will "just work", at least for people who don't have any local
changes in their tree. None of this "check out all the files again" crap.

But how about a plan that we go "live" tomorrow - assuming nobody finds
any problems before that, of course.

			Linus

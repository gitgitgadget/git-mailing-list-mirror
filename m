From: Eric Blake <ebb9@byu.net>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 07:03:23 -0600
Message-ID: <4628BA1B.30802@byu.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <200704172239.20124.andyparkins@gmail.com> <1176983993.30690.13.camel@cauchy.softax.local> <20070420062254.GB29069@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: cygwin@cygwin.com,  git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: cygwin-return-132226-goc-cygwin=m.gmane.org@cygwin.com Fri Apr 20 15:02:52 2007
Return-path: <cygwin-return-132226-goc-cygwin=m.gmane.org@cygwin.com>
Envelope-to: goc-cygwin@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1HeslH-0003Dp-C5
	for goc-cygwin@gmane.org; Fri, 20 Apr 2007 15:02:51 +0200
Received: (qmail 25375 invoked by alias); 20 Apr 2007 13:02:44 -0000
Received: (qmail 25355 invoked by uid 22791); 20 Apr 2007 13:02:43 -0000
X-Spam-Check-By: sourceware.org
Received: from sccrmhc11.comcast.net (HELO sccrmhc11.comcast.net) (63.240.77.81)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 20 Apr 2007 14:02:39 +0100
Received: from [192.168.0.103] (c-67-169-243-15.hsd1.ut.comcast.net[67.169.243.15])           by comcast.net (sccrmhc11) with ESMTP           id <2007042013023601100ffe59e>; Fri, 20 Apr 2007 13:02:37 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.5.666
In-Reply-To: <20070420062254.GB29069@spearce.org>
X-IsSubscribed: yes
Mailing-List: contact cygwin-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin.cygwin.com>
List-Unsubscribe: <mailto:cygwin-unsubscribe-goc-cygwin=m.gmane.org@cygwin.com>
List-Subscribe: <mailto:cygwin-subscribe@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin/>
List-Post: <mailto:cygwin@cygwin.com>
List-Help: <mailto:cygwin-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-owner@cygwin.com
Mail-Followup-To: cygwin@cygwin.com
Delivered-To: mailing list cygwin@cygwin.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45100>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Shawn O. Pearce on 4/20/2007 12:22 AM:
>> Maybe it could be, if cygwin managed to create normal setup program
>> one day...
> 
> Yea.  I've had a number of Git users get burned by the
> git-merge-recursive script changing to git-merge-recursive.exe,
> and Cygwin's installer left git-merge-recursive in the directory
> when upgrading, but deleted some of the supporting Python modules.
> So they were unable to execute a merge.

Please report these sorts of bugs to the cygwin list, so that the cygwin
team can be aware of them and work towards fixing them.

> 
> Better, one user succeeded in doing a `git merge -s ours foo`,
> completely tossing away the work of 20+ users over 3 months,
> because their HEAD was very old and their merge-recursive was
> utterly broken...  They did not mean to do an ours style merge, it
> just happened that merge-recursive didn't do squat...  because it
> was the old Python version, partially installed...
> 
> I found out about the breakage only after those 20+ users managed
> to cram another 80 or so commits onto the top of that bad merge.
> Which meant that I couldn't just rewind the tree to redo the merge.
> I actually had to redo the merge as a new commit ontop of the bad
> history.  Without losing any of the new changes.  Ick.
> 
> Thankfully just the week before I taught merge-recursive how to
> take trees (and not commits), allowing me to use it to carry the
> changes through whilest ignoring the bad merge base history.
> 
> So anyway, my Git-on-Cygwin installer is now:
> 
> 	...on the master system...
> 	make clean &&
> 	make prefix=/usr/local/git &&
> 	rm -rf /usr/local/git &&
> 	make install prefix=/usr/local/git &&
> 	tar jcf update-git.tar.bz2 /usr/local/git
> 
> 	...and on other systems...
> 	cd / &&
> 	rm -rf /usr/local/git &&
> 	tar jxf update-git.tar.bz2
> 
> because dammit, that works, all of the time.  Unlike Cygwin's
> setup.exe.
> 

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGKLoa84KuGfSFAYARAlVwAKCL++zyeKO5iomF/gUQuRP6+N5qkgCfZpHa
3OrAwLmpJ4IbFpUiuj27jRw=
=Dyjw
-----END PGP SIGNATURE-----

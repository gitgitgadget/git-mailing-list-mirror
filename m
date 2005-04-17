From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Yet another base64 patch
Date: Sat, 16 Apr 2005 23:53:32 -0400
Message-ID: <4261DDBC.3050706@dwheeler.com>
References: <425DEF64.60108@zytor.com>	<20050414022413.GB18655@64m.dyndns.org>	<425E0174.4080404@zytor.com>	<20050414024228.GC18655@64m.dyndns.org>	<425E0D62.9000401@zytor.com>	<Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>	<425EA152.4090506@zytor.com>	<Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>	<20050414191157.GA27696@outpost.ds9a.nl>	<425EC3B4.6090908@zytor.com>	<20050414214756.GA31249@outpost.ds9a.nl>	<Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>	<425F13C9.5090109@zytor.com> <20050414205831.01039ee8.pj@engr.sgi.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 17 05:48:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN0lJ-0002ev-M2
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 05:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDQDvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 23:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVDQDvm
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 23:51:42 -0400
Received: from cujo.runbox.com ([193.71.199.138]:39384 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261248AbVDQDvj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 23:51:39 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DN0os-0007UE-93
	for git@vger.kernel.org; Sun, 17 Apr 2005 05:51:38 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DN0or-0002Nl-Ie
	for git@vger.kernel.org; Sun, 17 Apr 2005 05:51:38 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20050414205831.01039ee8.pj@engr.sgi.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson wrote:
> Earlier, hpa wrote:
> 
>>The base64 version has 2^12 subdirectories instead of 2^8 (I just used 2 
>>characters as the hash key just like the hex version.)
> 
> Later, hpa wrote:
> 
>>Ultimately the question is: do we care about old (broken) filesystems?
> 
> 
> I'd imagine we care a little - just not alot.

Some people (e.g., me) would really like for "git"
to be more forgiving of nasty filesystems,
so that git can be used very widely.
I.E., be forgiving about case insensitivity,
poor performance or problems with a large # of files
in a directory, etc.  You're already working to make
sure git handles filenames with spaces & i18n filenames,
a common failing of many other SCM systems.

If "git" is used for Linux kernel development & nothing else,
it's still a success.  But it'd be even better from
my point of view if "git" was a useful tool for MANY
other projects.  I think there are advantages, even if you
only plan to use git for the kernel, to making "git" easier
to use for other projects.  By making git less
sensitive to the filesystem, you'll attract more (non-kernel-dev)
users, some of whom will become new git developers who
add cool new functionality.

As noted in my SCM survey (http://www.dwheeler.com/essays/scm.html),
I think SCM Windows support is really important to a lot of
OSS projects.  Many OSS projects, even if they start
Unix/Linux only, spin off a Windows port, and it's
painful if their SCM can't run on Windows then.
Problems running on NFS filesystems have caused problems
with GNU Arch users (there are workarounds, but now you
need to learn about workarounds instead of things
"just working").  If nothing else, look at the history
of other SCM projects: all too many have undergone radical and
painful surgeries so that they can be more portable to
various filesystems.

It's a trade-off, I know.

--- David A. Wheeler

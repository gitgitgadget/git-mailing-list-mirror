From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Yet another base64 patch
Date: Sun, 17 Apr 2005 02:38:10 -0400
Message-ID: <42620452.4080809@dwheeler.com>
References: <425DEF64.60108@zytor.com>	<20050414022413.GB18655@64m.dyndns.org>	<425E0174.4080404@zytor.com>	<20050414024228.GC18655@64m.dyndns.org>	<425E0D62.9000401@zytor.com>	<Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>	<425EA152.4090506@zytor.com>	<Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>	<20050414191157.GA27696@outpost.ds9a.nl>	<425EC3B4.6090908@zytor.com>	<20050414214756.GA31249@outpost.ds9a.nl>	<Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>	<425F13C9.5090109@zytor.com>	<20050414205831.01039ee8.pj@engr.sgi.com>	<4261DDBC.3050706@dwheeler.com> <20050416210513.1ba26967.pj@sgi.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 08:32:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN3Ko-0002Th-CA
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 08:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDQGgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 02:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVDQGgU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 02:36:20 -0400
Received: from cujo.runbox.com ([193.71.199.138]:31874 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261273AbVDQGgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 02:36:16 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DN3OB-0008V9-Tj; Sun, 17 Apr 2005 08:36:15 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DN3OB-0003C6-Bv; Sun, 17 Apr 2005 08:36:15 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416210513.1ba26967.pj@sgi.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson wrote:
> David wrote:
> 
>>It's a trade-off, I know.
> 
> 
> So where do you recommend we make that trade-off?

I'd look at some of the more constraining, yet still
common cases, and make sure it worked reasonably
well without requiring magic. My list would be:
ext2, ext3, NFS, and Windows' NTFS (stupid short filenames,
case-insensitive/case-preserving).  Samba shouldn't be
more constraining than NTFS, and I would expect ReiserFS
wouldn't be a constraining case.  Bonus points if the
names lengths are inside POSIX guarantees, but I bet the
POSIX limits are so tiny as to be laughable.  Bonus points for
CD-ROM format with the Rock Ridge extensions (I _think_ DVDs
and later use that format too, yes?), though if that
didn't work tar files are an easy workaround. Imagine a full
Linux kernel source repository, for 30+ (pick a number) years..
can the filesystems handle the number of objects in those cases?
If it works, your infrastructure should be sufficiently
portable to "just work" on others too.

Anyway, my two cents.

--- David A. Wheeler

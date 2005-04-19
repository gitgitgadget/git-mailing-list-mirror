From: Greg KH <greg@kroah.com>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 12:47:30 -0700
Message-ID: <20050419194728.GA24367@kroah.com>
References: <20050419043938.GA23724@kroah.com>
	<20050419185807.GA1191@kroah.com>
	<Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
        sensors@Stimpy.netroedge.com
X-From: lm78@Stimpy.netroedge.com Tue Apr 19 21:47:41 2005
Return-path: <lm78@Stimpy.netroedge.com>
Received: from stimpy.netroedge.com ([206.228.191.3])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNyg9-0000Po-H5
	for gls-sensors@gmane.org; Tue, 19 Apr 2005 21:46:38 +0200
Received: from Stimpy.netroedge.com (IDENT:lm78@localhost [127.0.0.1])
	by Stimpy.netroedge.com (8.12.10/8.12.10) with ESMTP id j3JJpRpv008570;
	Tue, 19 Apr 2005 12:51:27 -0700
Received: (from lm78@localhost)
	by Stimpy.netroedge.com (8.12.10/8.12.8/Submit) id j3JJpHos008551;
	Tue, 19 Apr 2005 12:51:17 -0700
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by Stimpy.netroedge.com (8.12.10/8.12.10) with ESMTP id j3JJpDpv008538
	for <sensors@stimpy.netroedge.com>; Tue, 19 Apr 2005 12:51:16 -0700
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net
	[24.22.118.199])	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3JJnAi10405;
	Tue, 19 Apr 2005 12:49:10 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNyh1-6Rq-00; Tue, 19 Apr 2005 12:47:31 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
X-sensors-spam: ham; 0.00

On Tue, Apr 19, 2005 at 12:40:44PM -0700, Linus Torvalds wrote:
> I'm still working out some performance issues with merges (the actual
> "merge" operation itself is very fast, but I've been trying to make the
> subsequent "update the working directory tree to the right thing" be much
> better).

Ok, if you want some practice with "real" merges, feel free to merge from
the following two trees whenever you are ready:
	kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
for 11 aoe bugfix patches, and:
	kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
for 13 driver core, sysfs, and debugfs fixes.

The diffstats are:

aoe:
 Documentation/aoe/mkdevs.sh       |    1 
 Documentation/aoe/mkshelf.sh      |    1 
 Documentation/aoe/todo.txt        |   14 ++++
 Documentation/aoe/udev-install.sh |    6 +-
 drivers/block/aoe/aoe.h           |   23 +++++--
 drivers/block/aoe/aoeblk.c        |    5 +
 drivers/block/aoe/aoecmd.c        |  110 ++++++++++++++++++++++----------------
 drivers/block/aoe/aoedev.c        |    8 +-
 drivers/block/aoe/aoenet.c        |    8 +-
 9 files changed, 111 insertions(+), 65 deletions(-)

driver:
 Documentation/kref.txt        |  221 +++++++++++++++++++++++++++++++++++++++++-
 drivers/base/class.c          |    2 
 drivers/base/core.c           |    3 
 drivers/base/firmware_class.c |    3 
 drivers/base/platform.c       |    1 
 drivers/usb/host/hc_crisv10.c |    1 
 fs/partitions/check.c         |    2 
 fs/sysfs/file.c               |   35 ++++++
 include/linux/debugfs.h       |   14 +-
 include/linux/sysfs.h         |    7 +
 lib/kobject.c                 |    7 -
 net/bridge/br_sysfs_if.c      |    2 
 scripts/ver_linux             |    2 
 13 files changed, 290 insertions(+), 10 deletions(-)

No rush, but they should be good test for your merge speeds, as they are
based off of an older HEAD than your current one :)

> In other words, I want it to be at the point where people can do
> 
> 	git pull <repo-address>
> 
> and it will "just work", at least for people who don't have any local
> changes in their tree. None of this "check out all the files again" crap.

That would be very nice to have.

> But how about a plan that we go "live" tomorrow - assuming nobody finds
> any problems before that, of course.

That's fine with me.

thanks,

greg k-h

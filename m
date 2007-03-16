From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Merging on a dirty tree???
Date: Thu, 15 Mar 2007 23:59:53 -0400
Message-ID: <200703152359.53543.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 05:11:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS3mU-0001FT-IW
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 05:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXCPELB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 00:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbXCPELB
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 00:11:01 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:32803 "EHLO
	asav15.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbXCPELA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 00:11:00 -0400
X-Greylist: delayed 656 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Mar 2007 00:11:00 EDT
Received: from 74-133-19-184.dhcp.insightbb.com (HELO mail.corenet.homeip.net) ([74.133.19.184])
  by asav15.insightbb.com with ESMTP; 15 Mar 2007 23:59:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlwPAB6z+UVKhRO4UGdsb2JhbACBZ4VMh1wBASo
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42319>

Hi,

I just tried to pull from Linus' tree into my local tree and it seems
that fast forward was committed even though the tree was dirty:

...
drivers/media/video/cx88/cx88-input.c: needs update
drivers/media/video/ir-kbd-i2c.c: needs update
drivers/media/video/saa7134/saa7134-input.c: needs update
include/linux/device.h: needs update
include/linux/input.h: needs update
fatal: Entry 'drivers/base/core.c' not uptodate. Cannot merge.
 Makefile                                |    4 +-
 arch/i386/kernel/nmi.c                  |    8 ----
 arch/x86_64/kernel/nmi.c                |    5 +--
 drivers/base/core.c                     |   29 ++++++++++++++
 drivers/hid/hid-core.c                  |   20 ++++-----
 drivers/net/natsemi.c                   |   58 +++++++++++++++-------------
 drivers/net/netxen/netxen_nic.h         |    1 +
 drivers/net/netxen/netxen_nic_ethtool.c |    1 +
 drivers/net/netxen/netxen_nic_hw.c      |    5 ++-
 drivers/net/netxen/netxen_nic_init.c    |   11 ++++-
 drivers/net/skge.c                      |   28 ++++++++-----
 drivers/s390/cio/ccwgroup.c             |   18 +++++++-
 drivers/scsi/scsi_sysfs.c               |   14 ++++++-
 fs/sysfs/file.c                         |   64 ++++++++++++++++++++++++++++--
 fs/sysfs/inode.c                        |   10 +++-
 include/asm-i386/nmi.h                  |    2 +-
 include/asm-x86_64/nmi.h                |    2 +-
 include/linux/device.h                  |    2 +
 include/linux/sysfs.h                   |    9 ++++
 19 files changed, 211 insertions(+), 80 deletions(-)
[dtor@anvil work]$ git --version
git version 1.5.0.3.438.gc49b2

It used to refuse merge if there were conflicts...

-- 
Dmitry

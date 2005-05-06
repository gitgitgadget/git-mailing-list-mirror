From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fix compare symlink against readlink not data
Date: Fri, 6 May 2005 09:03:59 -0700
Message-ID: <20050506160359.GB6904@kroah.com>
References: <20050506134501.GA11430@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 17:58:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5Cr-0007qc-EY
	for gcvg-git@gmane.org; Fri, 06 May 2005 17:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVEFQEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEFQEP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:04:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:64487 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261208AbVEFQEH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:04:07 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j46G43i11388;
	Fri, 6 May 2005 09:04:04 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DU5J2-3S5-00; Fri, 06 May 2005 09:04:00 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050506134501.GA11430@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2005 at 03:45:01PM +0200, Kay Sievers wrote:
> Fix update-cache to compare the blob of a symlink against the link-target
> and not the file it points to. Also ignore all permissions applied to
> links.
> Thanks to Greg for recognizing this while he added our list of symlinks
> back to the udev repository.

Hm, even with this patch applied (it's in Linus's tree right now), I
still get the following with a clean checked out udev tree:
 $ cg-diff
 Index: test/sys/block/cciss!c0d0/device
 ===================================================================
 Index: test/sys/block/rd!c0d0/device
 ===================================================================
 Index: test/sys/block/sda/device
 ===================================================================
 Index: test/sys/bus/pci/devices/0000:00:09.0
 ===================================================================
 Index: test/sys/bus/pci/devices/0000:00:1e.0
 ===================================================================
 Index: test/sys/bus/pci/devices/0000:02:05.0
 ===================================================================
 Index: test/sys/bus/pci/drivers/aic7xxx/0000:02:05.0
 ===================================================================
 Index: test/sys/bus/scsi/devices/0:0:0:0
 ===================================================================
 Index: test/sys/bus/scsi/drivers/sd/0:0:0:0
 ===================================================================
 Index: test/sys/bus/usb-serial/devices/ttyUSB0
 ===================================================================
 Index: test/sys/bus/usb-serial/drivers/PL-2303/ttyUSB0
 ===================================================================
 Index: test/sys/bus/usb/devices/3-0:1.0
 ===================================================================
 Index: test/sys/bus/usb/devices/3-1
 ===================================================================
 Index: test/sys/bus/usb/devices/3-1:1.0
 ===================================================================
 Index: test/sys/bus/usb/devices/usb3
 ===================================================================
 Index: test/sys/bus/usb/drivers/hub/3-0:1.0
 ===================================================================
 Index: test/sys/bus/usb/drivers/pl2303/3-1:1.0
 ===================================================================
 Index: test/sys/bus/usb/drivers/usb/3-1
 ===================================================================
 Index: test/sys/bus/usb/drivers/usb/usb3
 ===================================================================
 Index: test/sys/class/tty/ttyUSB0/device
 ===================================================================
 Index: test/sys/devices/pci0000:00/0000:00:09.0/usb3/3-1/ttyUSB0/driver
 ===================================================================

Any idea?

thanks,

greg k-h

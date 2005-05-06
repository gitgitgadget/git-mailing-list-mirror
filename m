From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fix compare symlink against readlink not data
Date: Fri, 6 May 2005 09:37:40 -0700
Message-ID: <20050506163740.GB17766@kroah.com>
References: <20050506134501.GA11430@vrfy.org> <20050506160359.GB6904@kroah.com> <7vy8ascod4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:34:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5kv-0005fq-RN
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVEFQi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVEFQiv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:38:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:53382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261229AbVEFQhw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:37:52 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j46Gbci04260;
	Fri, 6 May 2005 09:37:38 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DU5pd-55O-00; Fri, 06 May 2005 09:37:41 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy8ascod4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2005 at 09:26:15AM -0700, Junio C Hamano wrote:
> 
> Also could you try the low-level git command, git-diff-cache -p,
> against the tree you are comparing?  The built-in diff stuff
> might get this wrong too.

No, 'git-diff-cache -r HEAD' shows me:

$ git-diff-cache -r HEAD
*120000->100644 blob    2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a      test/sys/block/cciss!c0d0/device
*120000->100644 blob    2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a      test/sys/block/rd!c0d0/device
*120000->100644 blob    2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a      test/sys/block/sda/device
*120000->100644 blob    1c776568bdc9dc750addd0885dded6b008a44460->1c776568bdc9dc750addd0885dded6b008a44460      test/sys/bus/pci/devices/0000:00:09.0
*120000->100644 blob    e000c77614a23ad57fed284bd007ed7c1cb7872e->e000c77614a23ad57fed284bd007ed7c1cb7872e      test/sys/bus/pci/devices/0000:00:1e.0
*120000->100644 blob    630d35bf617944a4ba6afc90ca5176cb342a2662->630d35bf617944a4ba6afc90ca5176cb342a2662      test/sys/bus/pci/devices/0000:02:05.0
*120000->100644 blob    bd644e0e9d0c2f289bc4a3e3a034d528d5d671cc->bd644e0e9d0c2f289bc4a3e3a034d528d5d671cc      test/sys/bus/pci/drivers/aic7xxx/0000:02:05.0
*120000->100644 blob    ebb65b3bac36ef935a55a7f1010e4d3a242188eb->ebb65b3bac36ef935a55a7f1010e4d3a242188eb      test/sys/bus/scsi/devices/0:0:0:0
*120000->100644 blob    239003f712dd9112171e635a44160da1898f5996->239003f712dd9112171e635a44160da1898f5996      test/sys/bus/scsi/drivers/sd/0:0:0:0
*120000->100644 blob    b7733a68e08e564300212a22c9f81888c12bb55a->b7733a68e08e564300212a22c9f81888c12bb55a      test/sys/bus/usb-serial/devices/ttyUSB0
*120000->100644 blob    177f109e4899cf4008b9413933392d4f07832fdc->177f109e4899cf4008b9413933392d4f07832fdc      test/sys/bus/usb-serial/drivers/PL-2303/ttyUSB0
*120000->100644 blob    9137978832942ecce572d376f14244c1588748a2->9137978832942ecce572d376f14244c1588748a2      test/sys/bus/usb/devices/3-0:1.0
*120000->100644 blob    e47b4d58c4e5406bdba3ea1384c0c3efe007b8f6->e47b4d58c4e5406bdba3ea1384c0c3efe007b8f6      test/sys/bus/usb/devices/3-1
*120000->100644 blob    f519185eb36af29f79ca89d4b3d51011756b6837->f519185eb36af29f79ca89d4b3d51011756b6837      test/sys/bus/usb/devices/3-1:1.0
*120000->100644 blob    fb1919e7c9794ce31a257b50621f71f6f4f8bdef->fb1919e7c9794ce31a257b50621f71f6f4f8bdef      test/sys/bus/usb/devices/usb3
*120000->100644 blob    2bc160c20cd950c52e34d4bab30e1e25d6f4df34->2bc160c20cd950c52e34d4bab30e1e25d6f4df34      test/sys/bus/usb/drivers/hub/3-0:1.0
*120000->100644 blob    49d32d5abd7e26766f4c905f1d4edf1e28f8b322->49d32d5abd7e26766f4c905f1d4edf1e28f8b322      test/sys/bus/usb/drivers/pl2303/3-1:1.0
*120000->100644 blob    03c76193e99a93c7ff45c9ac986d2bc8e0706b0b->03c76193e99a93c7ff45c9ac986d2bc8e0706b0b      test/sys/bus/usb/drivers/usb/3-1
*120000->100644 blob    61dc52a61345178c8c171ecfe96df9646af2f16c->61dc52a61345178c8c171ecfe96df9646af2f16c      test/sys/bus/usb/drivers/usb/usb3
*120000->100644 blob    b7733a68e08e564300212a22c9f81888c12bb55a->b7733a68e08e564300212a22c9f81888c12bb55a      test/sys/class/tty/ttyUSB0/device
*120000->100644 blob    9ff2c81f529a95bd93ddaf66de6a72c74166c268->9ff2c81f529a95bd93ddaf66de6a72c74166c268      test/sys/devices/pci0000:00/0000:00:09.0/usb3/3-1/ttyUSB0/driver

thanks,

greg k-h

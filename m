From: Kay Sievers <kay.sievers@vrfy.org>
Subject: change of git-diff-tree and symlinks
Date: Wed, 25 May 2005 13:17:11 +0200
Message-ID: <20050525111711.GA27492@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 13:16:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DatrY-0002kk-9b
	for gcvg-git@gmane.org; Wed, 25 May 2005 13:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVEYLRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 07:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVEYLRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 07:17:25 -0400
Received: from soundwarez.org ([217.160.171.123]:57240 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262156AbVEYLRP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 07:17:15 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 034DB393E2; Wed, 25 May 2005 13:17:11 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,
I'm catching up with gitweb.cgi to parse the changed output. Works fine
so far and is really much easier to parse. Here is something that does
not work anymore. See the difference between:

   http://www.kernel.org/git/?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6
   http://ehlo.org/~kay/gitweb.cgi?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6

On my box is the lates git with the adapted gitweb.cgi. Here is the raw
output of the old git-diff-tree:
  kay@dhcp-188:~/src/udev> /home/kay/src/cogito/git-diff-tree -r 49cedafaf893bfe348eb7598227f1a11ae24bfd6 17f2b1a7e0d10334af7f9622848788add125dea8
  *120000->100644 blob 2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a test/sys/block/cciss!c0d0/device
  *120000->100644 blob 2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a test/sys/block/rd!c0d0/device
  *120000->100644 blob 2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a test/sys/block/sda/device
  *120000->100644 blob 1c776568bdc9dc750addd0885dded6b008a44460->1c776568bdc9dc750addd0885dded6b008a44460 test/sys/bus/pci/devices/0000:00:09.0
  *120000->100644 blob e000c77614a23ad57fed284bd007ed7c1cb7872e->e000c77614a23ad57fed284bd007ed7c1cb7872e test/sys/bus/pci/devices/0000:00:1e.0
  ...

The new one shows simply nothing.
Shouldn't it print the mode changes like the old one?

Kay

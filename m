From: Jeff Garzik <jgarzik@pobox.com>
Subject: local clone much slower than remote clone
Date: Fri, 30 Sep 2005 22:45:54 -0400
Message-ID: <433DF862.4020500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 01 04:46:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELXNx-00082j-Fi
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 04:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVJACp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 22:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVJACp5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 22:45:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3978 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750716AbVJACp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 22:45:57 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1ELXNs-0003rK-CX
	for git@vger.kernel.org; Sat, 01 Oct 2005 02:45:56 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9581>


Case 1: remote clone

time git clone 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
scsi-sas-2.6
...
real    3m36.432s
user    0m0.584s
sys     0m0.656s


Case 2: local clone
time git clone /spare/repo/linux-2.6 scsi-sas-2.6
...
Packing 99084 objects
Unpacking 99084 objects
...
real    4m31.876s
user    4m43.618s
sys     0m40.047s


Downloading an entire kernel tree over cable modem is almost a minute 
faster than a local clone!  IMHO the local clone should just hardlink 
the packs and objects, and be done with it.

	Jeff

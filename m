From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linus kernel tree corrupt?
Date: Sat, 09 Jul 2005 11:03:32 -0700
Message-ID: <42D01174.4050501@zytor.com>
References: <9e473391050708085756bd463e@mail.gmail.com> <12c511ca05070810065db87043@mail.gmail.com> <20050709114303.B2175@flint.arm.linux.org.uk> <20050709115530.GC26343@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmk@arm.linux.org.uk>,
	Tony Luck <tony.luck@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 09 20:04:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrJgP-0004PH-RN
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 20:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVGISED (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 14:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVGISED
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 14:04:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:21453 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261651AbVGISEB
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Jul 2005 14:04:01 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j69I3Xwi005877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Jul 2005 11:03:34 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050709115530.GC26343@pasky.ji.cz>
X-Virus-Scanned: ClamAV version 0.86.1, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> 
> Yes, please do. I deprecated rsync a day before Linus "broke" http-pull.
> It's un-deprecated again for now in the latest Cogito.
> 

Presumably for packed repos you want to drop the --ignore-existing 
--whole-file options I assume?

Also, pulling with cogito-0.12:

cg-clone -s 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/

I still get:

receiving file list ... done
master

sent 147 bytes  received 863 bytes  2020.00 bytes/sec
total size is 41  speedup is 0.04

receiving file list ... done
progress: 1929 objects, 5796451 bytes, 100% done
pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.idx
pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack

sent 42599 bytes  received 73373124 bytes  451789.06 bytes/sec
total size is 73178114  speedup is 1.00

receiving file list ... done
v2.6.11
v2.6.11-tree
v2.6.12
v2.6.12-rc2
v2.6.12-rc3
v2.6.12-rc4
v2.6.12-rc5
v2.6.12-rc6
v2.6.13-rc1
v2.6.13-rc2

sent 339 bytes  received 1802 bytes  4282.00 bytes/sec
total size is 410  speedup is 0.19
Missing object of tag v2.6.11... different source (obsolete tag?)
Missing object of tag v2.6.11-tree... different source (obsolete tag?)
Missing object of tag v2.6.12... different source (obsolete tag?)
Missing object of tag v2.6.12-rc2... different source (obsolete tag?)
Missing object of tag v2.6.12-rc3... different source (obsolete tag?)
Missing object of tag v2.6.12-rc4... different source (obsolete tag?)
Missing object of tag v2.6.12-rc5... different source (obsolete tag?)
Missing object of tag v2.6.12-rc6... different source (obsolete tag?)
Missing object of tag v2.6.13-rc1... different source (obsolete tag?)
Missing object of tag v2.6.13-rc2... different source (obsolete tag?)
New branch: 0109fd37046de64e8459f8c4f4706df9ac7cc82c
Cloned (origin 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
available as branch "origin")
Cloned to ./ (origin 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
available as branch "origin")

Is the "missing objects" thing spurious?

	-hpa

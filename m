From: David Lang <dlang@digitalinsight.com>
Subject: Re: Yet another base64 patch
Date: Sat, 16 Apr 2005 21:10:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504162107040.22904@qynat.qvtvafvgr.pbz>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org>
 <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org>
 <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org>
 <425EA152.4090506@zytor.com> <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
 <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com>
 <20050414214756.GA31249@outpost.ds9a.nl> <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>
 <425F1394.5020709@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, bert hubert <ahu@ds9a.nl>,
	Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 06:08:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN15L-0003Zn-B9
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 06:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDQEMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 00:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDQEMU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 00:12:20 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:9699 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261251AbVDQEMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 00:12:15 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 21:07:07 -0700
Received: by atlexc01.digitalinsight.com with Internet Mail Service (5.5.2657.72)
	id <JCF7DXDS>; Sun, 17 Apr 2005 00:08:17 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YXFAAY; Sat, 16 Apr 2005 21:10:12 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425F1394.5020709@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Apr 2005, H. Peter Anvin wrote:

> Linus Torvalds wrote:
>> 
>> Even something as simple as "ls -l" has been known to have O(n**2) 
>> behaviour for big directories.
>> 
>
> For filesystems with linear directories, sure.  For sane filesystems, it 
> should have O(n log n).

note that default configs of ext2 and ext3 don't qualify as sane 
filesystems by this definition.

ext3 does have an extention that you can enable to have it hash the 
directory access, but even if you enable that on a filesystem you aren't 
guaranteed that it will be active (if the directory existed before it was 
turned on, or has been accessed by a kernel that didn't understand the 
extention then the htree functionality won't be used until you manually 
tell the system to generate the tree)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

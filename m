From: David Lang <david.lang@digitalinsight.com>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 15:31:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704031530040.21680@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> 
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> 
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> 
 <alpine.LFD.0.98.0704031625050.28181@xanadu.home> 
 <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> 
 <20070403210319.GH27706@spearce.org>   <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
  <20070403211709.GJ27706@spearce.org>  
 <alpine.LFD.0.98.0704031730300.28181@xanadu.home><56b7f5510704031540i4df918
 e6g5a82389b6759c50b@mail.gmail.com> <Pine.LNX.4.64.0704031544110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, Chris Lee <clee@kde.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYs0w-00005C-QW
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 01:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992490AbXDCXBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992486AbXDCXBk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 19:01:40 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:63170 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S2992485AbXDCXBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 19:01:39 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 3 Apr 2007 16:01:38 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 03 Apr 2007 16:00:04 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0704031544110.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43691>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> On Tue, 3 Apr 2007, Dana How wrote:
>>
>> Larger and larger pack files make me nervous.
>> They are expensive to manipulate,
>> and >2GB requires a file format change.
>
> It sometimes also requires a new filesystem. There are a lot of
> filesystems that can handle more than 4GB total, but not necessarily in a
> single file.
>
> The only really useful such filesystem is probably FAT, which is still
> quite useful for things like USB memory sticks. But that is probably
> already worth supporting.
>
> So I think we want to support 64-bit (or at least something like 40+ bit)
> pack-files, but yes, I think that even if/when we support it, we still
> want to support the "multiple smaller pack-files" schenario exactly
> because for some uses it's much *better* to have ten 2GB packfiles rather
> than one 20GB pack-file.

however, for historical archives you may end up with wanting to do a 2GB 
packfile of 'recent' stuff, and a 14GB packfile of 'ancient' stuff (with the 
large one built with all space-saving options turned up all the way, no matter 
how much time it takes to build the pack)

David Lang

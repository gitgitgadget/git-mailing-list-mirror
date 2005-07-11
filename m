From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 17:28:30 -0400
Message-ID: <42D2E47E.8060602@yahoo.com>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>	<20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>	<7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>	<42D2CBA2.8060705@yahoo.com> <7virzhrtfy.fsf@assigned-by-dhcp.cox.net> <7vy88dqe4h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bryan.larsen@gmail.com,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 23:35:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds5w2-00082K-3G
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 23:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVGKVd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVGKVaT
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 17:30:19 -0400
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:34642 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262782AbVGKV2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 17:28:33 -0400
Received: (qmail 75732 invoked from network); 11 Jul 2005 21:28:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2pQ3L+GNGkRpybtoC1S3iiQraQ191WT+BrolHm00vxV1OVsvFUByCGI8eDX7Y4uQxVzr9wXtuq6Wa95+m3ip0N3Ba4l4Pvz1NPuCY0/nMFsoi4boeEgi6ZLm2LqFveza9FBRLbhJF7ILKXuS2TT0/bGSB1OnkwXT5XTGwyWFXco=  ;
Received: from unknown (HELO ?192.168.2.80?) (bryanlarsen@69.159.204.165 with plain)
  by smtp111.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 21:28:30 -0000
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy88dqe4h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> 
>>The only user of "cp -l" in the Linus GIT is git-clone-script
>>local optimization.  I could revert it to the version that I
>>originally sent to the list, which uses cpio -pld, if your cpio
>>groks that flag.
> 
> 
> Bryan, does this work for you?
> 

Yes, it appears to work fine.

For the record, "${XARGS} -0r" may be uglier than "xargs -0r", but 
replacing it with several lines of shell magic is a loss.  OTOH shell 
magic can be wrapped up into nice little functions.  Certainly I'll 
appreciate being able to remove my coreutils and findutils dependency, 
but I think that assuming the user has gnu tools available somewhere is 
a reasonable assumption for tools of this type.

The tradeoff might be different for git and cogito.  Cogito uses shell 
scripts more heavily and requires bash instead of Bourne.  Certainly 
you've demonstrated that git can be made portable relatively cleanly.  I 
doubt cogito will fall as easily.

But if you prefer to go this route, I'm happy with it.

Bryan

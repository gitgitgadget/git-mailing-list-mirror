From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-daemon --inetd
Date: Fri, 16 Sep 2005 09:54:00 -0700
Message-ID: <432AF8A8.6070807@zytor.com>
References: <43290EFF.3070604@zytor.com>	<Pine.LNX.4.58.0509150829090.26803@g5.osdl.org> <7vbr2tqwl0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 18:56:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGJTm-0003JL-F0
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 18:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbVIPQyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 12:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbVIPQyT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 12:54:19 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:57731 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1161188AbVIPQyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 12:54:18 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8GGs0Jv010197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 Sep 2005 09:54:01 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr2tqwl0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8693>

Junio C Hamano wrote:
> 
> Later exchanges between you and HPA appeared to me that we would
> need a chroot environment which has "enough stuff" and that this
> patch may not help him very much.  Am I mistaken?
> 

Well, building a chroot environment which supports execing is a bit of a 
pain, but it's fully doable.  mount --bind especially makes that quite 
feasible.  It's just more work.

> I think resolving user and group to numeric before you do
> chroot() might make the setting up of chrooted environment a
> little simpler; no need for supporting getpwnam and getgrnam
> there.  On the other hand it may not matter -- you can always
> give numeric uid/gid to begin with.

Yes, resolve the username first.

	-hpa

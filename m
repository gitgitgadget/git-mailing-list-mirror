From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 28 Sep 2005 22:07:10 -0700
Message-ID: <433B767E.7050704@zytor.com>
References: <433B3B10.5050407@zytor.com> <7v64skpkbb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 07:08:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKqe1-0008JD-Q9
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 07:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVI2FH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 01:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVI2FH3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 01:07:29 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:41443 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751199AbVI2FH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 01:07:28 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8T57BJv015305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2005 22:07:11 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64skpkbb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9462>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>There are still funnies.  In particular, Cygwin and Samba handle 
>>symlinks differently, so you can't trivially share a repository via 
>>Samba.  Linus' "symbolic refs" changes should eventually take care of that.
> 
> 
> I just sent out "The other side of Linus' symbolic refs" patch,
> saying that Cygwin capable of doing symlink would probably made
> it irrelevant.  But it may not be a waste after all, considering
> what you said above.
> 

After looking at it some more, what Samba does when talking to a host 
that doesn't support Unix extensions is that it simply resolves the 
symlink, in effect turning it into a hard link.  That might be all git 
needs.  The reverse still doesn't work, though.

	-hpa

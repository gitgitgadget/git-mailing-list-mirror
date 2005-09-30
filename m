From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix gcc-4 warning in accept() call
Date: Thu, 29 Sep 2005 21:46:18 -0700
Message-ID: <433CC31A.9090808@zytor.com>
References: <200509292311.j8TNBZDm022135@inti.inf.utfsm.cl> <20050930000917.rrwggw4g0gogs8w4@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 06:47:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELCnZ-00020B-FO
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 06:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVI3Eqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 00:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVI3Eqx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 00:46:53 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:9707 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932267AbVI3Eqw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 00:46:52 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8U4kJJv027480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Sep 2005 21:46:21 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20050930000917.rrwggw4g0gogs8w4@webmail.spamcop.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9535>

Pavel Roskin wrote:
> Quoting Horst von Brand <vonbrand@inf.utfsm.cl>:
> 
> 
>>>+				unsigned int sslen = sizeof(ss);
>>
>>Shouldn't this be size_t?
> 
> 
> No.  That would actually break things on big-endian 64-bit platforms.
> 
> You can see "info libc" for the whole story.  My (limited!) understanding is
> that it should be 32-bit for compatibility reasons, so socklen_t was a trick to
> fool size_t proponents from the POSIX committee :-)
> 

Formally it should be "socklen_t" or "int".  It should *not* be 
"unsigned int"!

	-hpa

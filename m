From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix gcc-4 warning in accept() call
Date: Thu, 29 Sep 2005 22:58:42 -0700
Message-ID: <433CD412.8020409@zytor.com>
References: <1128027901.24397.57.camel@dv> <7vachv9kbq.fsf@assigned-by-dhcp.cox.net> <433CD2E7.5090909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 07:59:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELDvA-0006vR-Eb
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 07:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVI3F65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 01:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVI3F65
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 01:58:57 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:20459 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932558AbVI3F64 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 01:58:56 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8U5wfJv027913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Sep 2005 22:58:42 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433CD2E7.5090909@zytor.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9541>

H. Peter Anvin wrote:
> Junio C Hamano wrote:
> 
>> Pavel Roskin <proski@gnu.org> writes:
>>
>>
>>> gcc-4 warns about sign mismatch in pointers.  Third argument in accept()
>>> is socklen_t, which is unsigned.  Since Linus doesn't like socklen_t
>>> (see commit 7fa090844f7d1624c7d1ffc621aae6aec84a1110), let's use
>>> unsigned int.
>>
>>
>> Based on the list comments, I'd drop this patch -- it appears
>> that gcc-4 warning is useless in this case.
>>
> 
> No, it's not.  The proper type, if you don't use socklen_t, is int, not 
> unsigned int.
> 

Apparently I'm wrong; socklen_t is unsigned int at least on glibc for 
i386.  I'll shut up now.

	-hpa

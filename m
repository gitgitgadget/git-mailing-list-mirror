From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 09:13:02 -0800
Message-ID: <43737F9E.60703@zytor.com>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43730E39.6030601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751163AbVKJRNc@vger.kernel.org Thu Nov 10 18:16:16 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751163AbVKJRNc@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaFzw-0001yM-0M
	for glk-linux-kernel-3@gmane.org; Thu, 10 Nov 2005 18:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVKJRNc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 Nov 2005 12:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKJRNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:13:32 -0500
Received: from terminus.zytor.com ([192.83.249.54]:4565 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750948AbVKJRNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:13:31 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAAHD3sM007591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Nov 2005 09:13:04 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <43730E39.6030601@pobox.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11492>

Jeff Garzik wrote:
> 
>> Oh, and we will not be moving things out of /usr/bin/ during 1.0
>> timeframe.
> 
> 
> :(  bummer.  I do like the elegance of having /usr/bin/git executing 
> stuff out of /usr/libexec/git.
> 
> /usr/libexec/git also makes it IMO cleaner when integrating git plugins 
> from third parties (rpm -Uvh git-newfeature), because you don't have to 
> worry about the /usr/bin namespace.
> 

It's nice in concept, but I think there are a lot of reasons why this is 
a bad idea:

- "man" doesn't handle it.  It would be another thing if "man" could be 
taught to understand commands like "man cvs checkout" or "man git fetch".

- There is no general way to teach shells etc about it, for tab 
completion etc.

- Makes it harder (but not impossible) to run git from a build directory 
without installing it first.

In comparison, the issue of clutter in /usr/bin is actually a pretty 
small issue, especially with htree.  Most vendors have gone back to 
putting everything into /usr/bin since all variants that involve 
splitting it up seem to be more of a loss than a gain.

	-hpa

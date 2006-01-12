From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git binary size...
Date: Thu, 12 Jan 2006 09:37:19 -0800
Message-ID: <43C693CF.3020800@zytor.com>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>	 <43C558FB.3030102@op5.se>	 <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org> <2cd57c900601120215pdb5da27l@mail.gmail.com> <43C65E70.7090702@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:39:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex6OG-0000zH-Gl
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 18:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWALRh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 12:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWALRh0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 12:37:26 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47243 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932387AbWALRhY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 12:37:24 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0CHbJJK003780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jan 2006 09:37:20 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C65E70.7090702@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14570>

Andreas Ericsson wrote:
>>
>> To make git not tight to Linux, but cross platform, consider autoconf.
> 
> git is already fairly portable without the autoconf hackery. It's easy 
> enough to move some of the conditional stuff out of the Makefile without 
> autoconf, but it would still require GNU Make, so there's no real point 
> in doing so.
> 

The problem is that one really at some point end up reinventing a whole 
lot of autoconf.

Now, a lot of autoconf ugliness comes from two sources:

  - Not abstracting appropriately (#ifdef mess)
  - Not using GNU make features

Once you require GNU make, you can have a top-level Makefile and have 
configure generating MCONFIG and config.h, and have conventional 
dependencies on those rules.  Pretty much the whole autoconstipation 
should be confined to those two files.

I might eventually try to make a clean patch for autoconf with git, and 
hopefully show that when done correctly, it's probably cleaner than the 
increasing Makefile mess, plus it's automatic.

	-hpa

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 10:24:18 -0700
Message-ID: <43552FC2.3000000@zytor.com>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 19:24:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERvCU-0002sQ-Lo
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 19:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVJRRYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 13:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVJRRYV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 13:24:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:3227 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751103AbVJRRYV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 13:24:21 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9IHOISM027754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 10:24:19 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20051018110725.GB6929@vrfy.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10217>

Kay Sievers wrote:
> 
>>Most of the hits we get are either the 
>>gitweb front page or the gitweb rss feeds, and it's eating I/O bandwidth 
>>like crazy.
> 
> I tested some stuff on these boxes and 30 stat() calls alone take app. 2 seconds
> on these boxes cause of I/O load ... :)
> 

Welcome to my hell :)

I set up mod_cache (which I didn't know about, silly me) and so far it 
seems to work and has produced a tremendous decrease in load and 
improvement in response time.  I do, have, however, a request.  There 
are some gitweb pages which are more likely to change than others; in 
particular, some gitweb pages will *never* change (because they directly 
reflect immutable git data.)

If gitweb could produce Last-Modified and Expires headers where 
appropriate, it should improve caching performance.

	-hpa

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Shell quoting
Date: Thu, 15 Sep 2005 13:18:13 -0700
Message-ID: <4329D705.8050101@zytor.com>
References: <43290BB8.90501@zytor.com>	<7vy85yahjk.fsf@assigned-by-dhcp.cox.net> <4329C11A.1040302@zytor.com>	<Pine.LNX.4.58.0509151153140.26803@g5.osdl.org>	<4329CC02.8090104@zytor.com> <7vll1yyusn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:22:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG0By-0002fk-2b
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 22:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbVIOUSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbVIOUSn
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 16:18:43 -0400
Received: from terminus.zytor.com ([209.128.68.124]:2516 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161006AbVIOUSn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 16:18:43 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8FKIH38014376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Sep 2005 13:18:18 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll1yyusn.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8638>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>Linus Torvalds wrote:
>>
>>>Does anybody really still use tcsh? It's a broken mess.
>>>
>>
>>Yes.
> 
> Yes to "still use", or yes to "broken mess" ;-)?
> 

Both :)

>>>Junio's "sq_quote()" works wonderfully on any valid shells. The fact
>>>that tcsh expands ! even inside single quotes is just pure
>>>braindamage.
>>
>>>You could expand "sq_quote" to handle '!' and '\' characters the exact
>>>same way it handles the single tick (end single-tick quoting, do \! or \\
>>>and start single-tick quoting again) and that might be good enough for
>>>tcsh.
>>
>>It seems easier to just \-escape any special characters.
> 
> I am sympathetic.  The beauty of sq_quote() comes directly from
> the behaviour of single quoting rules of "any valid shells" --
> there is no need to maintain a list of special characters.  Just
> single quote itself is special and nothing else.

Well, in the patch I just posted I simply \-escape a blacklist of 
characters.  It should be quite safe, since the blacklist consists of 
all ASCII characters that aren't known to be regularly used on the 
command line.

	-hpa

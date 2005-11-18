From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 14:12:59 -0800
Message-ID: <437E51EB.7050100@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org> <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 00:20:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdETz-0001y0-NL
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKRWNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 17:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVKRWNT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:13:19 -0500
Received: from terminus.zytor.com ([192.83.249.54]:63156 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750828AbVKRWNS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 17:13:18 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAIMD4d3014847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 14:13:04 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12282>

Linus Torvalds wrote:
> 
> Want to do on-the-fly conversion on CVS import (or worse yet - something 
> like clearcase)? With magic rules or fragile heuristics for binary files? 
> That's crazy, and that's not how these things work. No, the way these 
> things work is that they continue to be maintained in EUC-JP or whatever, 
> and a tool that requires conversion is a tool that just doesn't get used.
> 

On the fly conversion on CVS import isn't particularly crazy, as long as 
it's under user control.  Although I was primarly thinking about it in 
the context of commit messages, it could be done on file contents as 
well, since CVS has the ability to flag files as text or as binary 
(-kb).  We already have a bunch of options relating to how to map CVS 
onto git, and conversion time is a good time to do it.

Similarly, it may not be a bad idea to add an *option* -- now when we 
have a config file mechanism -- to signal error on invalid UTF-8 import. 
  This would keep a correct UTF-8 repository from getting inadvertently 
messed up.

What *does* need to happen, I'm convinced, is that any tool that handles 
email needs to be able to take the email and convert its character set 
encodings (by default to UTF-8).  Most MUAs today use all kinds of weird 
heuristics for which character set to use, and it's frequently not what 
the user expected.

	-hpa

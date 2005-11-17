From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 15:18:32 -0800
Message-ID: <437D0FC8.6000906@zytor.com>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 00:21:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ect1u-0001j1-I1
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 00:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVKQXSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 18:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVKQXSz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 18:18:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:698 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964884AbVKQXSz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 18:18:55 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAHNIbuO017609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Nov 2005 15:18:37 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12170>

Linus Torvalds wrote:
> This allows people to use syntax like "last thursday" for the approxidate. 
> 
> (Or, indeed, more complex "three thursdays ago", but I suspect that would 
> be pretty unusual).
> 
> NOTE! The parsing is strictly sequential, so if you do
> 
> 	"one day before last thursday"
> 
> it will _not_ do what you think it does. It will take the current time, 
> subtract one day, and then go back to the thursday before that. So to get 
> what you want, you'd have to write it the other way around:
> 
> 	"last thursday and one day before"
> 
> which is insane (it's usually the same as "last wednesday" _except_ if 
> today is Thursday, in which case "last wednesday" is yesterday, and "last 
> thursday and one day before" is eight days ago).
> 
> Similarly,
> 
> 	"last thursday one month ago"
> 
> will first go back to last thursday, and then go back one month from 
> there, not the other way around.
> 
> I doubt anybody would ever use insane dates like that, but I thought I'd 
> point out that the approxidate parsing is not exactly "standard English".
> 

I believe English would always parse from right to left, it might be the 
right thing to do...

	-hpa

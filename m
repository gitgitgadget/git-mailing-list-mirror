From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Cygwin and git 1.5.1
Date: Sat, 14 Apr 2007 18:21:40 +0100
Message-ID: <46210DA4.1090600@ramsay1.demon.co.uk>
References: <461BCBC0.2000705@ramsay1.demon.co.uk> <461C134D.8020803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 19:21:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hclwb-00045O-0z
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 19:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbXDNRVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 13:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754251AbXDNRVq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 13:21:46 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:3029 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754246AbXDNRVp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2007 13:21:45 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HclwP-000F3q-6L; Sat, 14 Apr 2007 17:21:38 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <461C134D.8020803@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44462>

H. Peter Anvin wrote:
> Ramsay Jones wrote:
>> Hi Junio,
>>
>> I recently upgraded to 1.5.1, via tarball as usual, without much problem.
>> The only problem being the "printf format warnings" issue, which prevents
>> me building with -Werror.
>>
>> I have included, below, an updated version of my patch from the 1.5.0 
>> series.
>> We agreed last time that this patch is not the correct solution to this
>> problem in general (but it works on cygwin!), so this is *not* intended
>> for submission. I just wanted to document the problem. As before, I don't
>> really have a solution; I suppose I will just have to carry this patch
>> forward with each release - no big deal.
>>
>> Note that the patch has grown larger. This is due to the increased use of
>> uint32_t (in combination with printf/die/error etc).
>> I guess not many others use -Werror to build on cygwin! ;-)
> 
> The excruciatingly correct way to do this is to use the macros defined 
> in <inttypes.h>, so for uint32_t one should use %"PRNu32" instead of %u, 
> for example.
> 
>     -hpa
> 

Yes, that would work. However, I rejected this solution last time, because
I did not want to add a dependency on the C99 header files.
Having said that, that ship has probably sailed ... ;-)

Maybe I will rework the patch to see how it looks. (I suspect that, while
it will be better than sprinkling casts about the place, it will probably
look quite ugly ;-P)

All the best,

Ramsay Jones

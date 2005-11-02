From: Ben Lau <benlau@ust.hk>
Subject: Re: Clone a repository with only the objects needed for a single
 tag
Date: Wed, 02 Nov 2005 17:10:57 +0800
Message-ID: <436882A1.1020207@ust.hk>
References: <43681E47.4010203@ust.hk> <7vy847y1m2.fsf@assigned-by-dhcp.cox.net> <43687869.7060104@ust.hk> <43687DAE.2010604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 10:14:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXEez-0007KN-L9
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 10:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbVKBJLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 04:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbVKBJLP
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 04:11:15 -0500
Received: from mx3.ust.hk ([143.89.13.11]:22288 "EHLO mx3.ust.hk")
	by vger.kernel.org with ESMTP id S932685AbVKBJLO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 04:11:14 -0500
Received: from [143.89.135.153] (benlau.rd.ust.hk [143.89.135.153])
	by mx3.ust.hk (8.12.11/8.12.11) with ESMTP id jA29Ax54087278;
	Wed, 2 Nov 2005 17:11:00 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43687DAE.2010604@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11013>

Andreas Ericsson wrote:

> Ben Lau wrote:
>
>> Hi Junio,
>>
>>  It works!  Thanks a lot.
>>
>>  However, it has a problem when involves the gitk/git-log.
>
>
>
> Both those programs use the history, which you don't have. With a 
> shallow repository like this some commands just won't work. git-*log 
> and gitk are among those.

yes, it is expected. However, I just think with a fake parent like what 
.git/info/grafts could provide may solve the issue. At least it make 
git-log be happy to show the only log message in the shallow repository 
without any error.
The rest of problem is gitk could not show any item like what git-log shown.

I am not sure is it right to have a pair of same ID into 
.git/info/grafts or it should be solved by a little patch to gitk.

>
>>
>> git-log/gitk do not complains afterward, but it also make gitk shows 
>> nothing during run. Any solution?
>>
>
> * Get a second machine with more disk-space and run the history tools 
> there. If you use it as mothership and push your commits to it you'll 
> be able to track your changes from the laptop as well.
>
> * Get a larger disk. They're not terribly expensive now adays.
>
> * Check out one tag (i.e. release) more than you need. Then you'll get 
> history back to that tag.
>

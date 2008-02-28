From: Paul Franz <thefranz@comcast.net>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as threads.
Date: Thu, 28 Feb 2008 12:48:58 -0500
Message-ID: <47C6F40A.4010703@comcast.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:55:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUmyn-0003h9-3E
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 18:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbYB1Ryy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 12:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757799AbYB1Ryx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 12:54:53 -0500
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:53572
	"EHLO QMTA06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751740AbYB1Ryw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 12:54:52 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2008 12:54:52 EST
Received: from OMTA08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by QMTA06.westchester.pa.mail.comcast.net with comcast
	id v2CQ1Y00F0Fqzac560L100; Thu, 28 Feb 2008 17:48:47 +0000
Received: from paul-franz-laptop.local ([148.87.66.55])
	by OMTA08.westchester.pa.mail.comcast.net with comcast
	id v5oy1Y00R1BY6Hw3U00000; Thu, 28 Feb 2008 17:49:15 +0000
X-Authority-Analysis: v=1.0 c=1 a=jYeb2YJqOk4A:10 a=VwQbUJbxAAAA:8
 a=mjVkJa99VFQJpAUNhJQA:9 a=lzY9C-ajnPzA69EzHm4A:7
 a=wbx9tFFKfOiWV8qYUOXoN5Ir0LQA:4 a=XF7b4UCPwd8A:10
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.LSU.1.00.0802281525510.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75429>

This reminds me of a crazy idea and I know it would be quite a bit of 
work. Do you think it would be possible to change git to use Apache's 
apr library? The benefit would be that the cross platform stuff is 
already written. I understand that it would not be tweaked to be 
optimized for git's usage. But it would allow people to focus on the 
heart of the git and not the way git interacts with the OS level stuff.  
Obviously, the scripts that make up part of git are not as portable but 
that is a different animal unless you want to either support a cross 
platform scripting language as part of git.

As I said it is a crazy idea.

Paul Franz

Johannes Schindelin wrote:
> Hi,
>
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
>
>   
>> In upload-pack we must explicitly close the output channel of rev-list. 
>> (On Unix, the channel is closed automatically because process that runs 
>> rev-list terminates.)
>>     
>
> When I read this patch, my impression was that it litters the source code 
> with #ifdef's.  IMO this makes the code less readable, and as a 
> consequence easer to fsck up.
>
> Unfortunately, I have no idea how to help that, other than implementing 
> compat/thread.[ch], abstracting the thread functions, and introducing a 
> NO_FORK Makefile variable and preprocessor constant.
>
> Hmpf.
>
> Ciao,
> Dscho
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

-- 

-------------------------------------------

There are seven sins in the world.
     Wealth without work.
     Pleasure without conscience.
     Knowledge without character.
     Commerce without morality.
     Science without humanity.
     Worship without sacrifice.
     Politics without principle.

   -- Mohandas Gandhi

-------------------------------------------


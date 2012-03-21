From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Has anyone written a hook to block fast forward merges to a branch?
Date: Wed, 21 Mar 2012 16:14:21 -0500
Message-ID: <4F6A44AD.4040600@gmail.com>
References: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com> <4F6A3ACA.6050100@gmail.com> <20120321204333.GB15021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 22:14:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SASrV-0006Ct-RV
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 22:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654Ab2CUVOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 17:14:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48196 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab2CUVOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 17:14:24 -0400
Received: by ghrr11 with SMTP id r11so1361809ghr.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nJ7bbX87W1lAmM4ayv0glO+fl7gfUJ4QS1sZpvOKVnk=;
        b=rPyhIbI6t9A2/pgvyrUPGQmTXg/4y+cG9HUNGfjvBmaNmztryZtcQxSeC/BWgE9A6M
         DCo4QqP2+d9ilmkAuqfWfiZwH4ygRyuTN0OaYIYd5xVQ36OOjw2N+tNA/ux1hu08KQxq
         72aKFfe+tDLL5luKgBygbwMOxadydoaTMq9Zpc16e5wU2vc1JzhMuB0P7vfQp3oudoc1
         ceWYsRWNitc6iAg/pFN+U6JdRDtamb/1x+gLsr3j1ee+MwMaYgbt/hIo1cu2gC3/a0ZD
         ZbwAM8203DYWc4jrxwyNiWA0TzDnpYXkPjTfJQenp6NZeHge61Mvl+9Z198eBJCQ0Wno
         UeVw==
Received: by 10.60.9.102 with SMTP id y6mr6738085oea.46.1332364463787;
        Wed, 21 Mar 2012 14:14:23 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id f2sm2142089oef.6.2012.03.21.14.14.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 14:14:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120321204333.GB15021@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193618>

On 3/21/2012 3:43 PM, Jeff King wrote:
> On Wed, Mar 21, 2012 at 03:32:10PM -0500, Neal Kreitzinger wrote:
>
>> On 3/21/2012 1:22 PM, Chris Patti wrote:
>>> I know there are hooks out there to block various other kinds of
>>> change, but I was wondering if anyone had specifically ever
>>> written one to block fast forward merges.
>>>
>> Maybe git-merge --no-ff would also be helpful to "do what you
>> want".
>
> When I wrote my response, I assumed the intent was that people
> _should_ be using --no-ff, but that he wanted to enforce it via hook
> during a push to a central repository.
>
> Reading it again, I'm not sure whether that is the case or not. If
> not, the disregard my original response. :)
>
Would your script only work at "push time", or would it also work at
"commit time"?  I'm not sure at what point he thinks he wants to enforce 
it.  I don't think git yet knows the info your script is asking for at 
"commit time" (ie, pre-commit hook and its brethren), and by the time it 
does know it's too late to block the commit locally.  Maybe it does know 
that inof at the point one of those "commit time" hooks runs.  I haven't 
tried it.

v/r,
neal

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 08:32:06 -0500
Message-ID: <CAMP44s2HPXnudioSSj0O_r2PbmbAqcyTORJNhRL_a=NWu_niBw@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
	<CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
	<CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
	<CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
	<CALkWK0m+_AbCd305dU5p5bxwuPPCBKJH7a3e6rHgxxnySMz0pQ@mail.gmail.com>
	<CAMP44s1eB+bvg7vnG5S3SBACHTrkpCqJNX-Q2tzEVdvzFWvkcA@mail.gmail.com>
	<CALkWK0nBUHHkqOQannMu5Kjs00Fro8KBbiocfsT4Uf74jO9FgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 15:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcyI1-0006oL-UA
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab3EPNcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:32:10 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:63303 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab3EPNcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:32:08 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so3025777lab.12
        for <git@vger.kernel.org>; Thu, 16 May 2013 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=GYUKktQj2oWbA8HMvGzHCwlgJXvU7HqtTaIhIOmZy3E=;
        b=h3+ZdSHbo/rNwEN/PtoI9ZRogisDrlE1eSm9vG4HCadzfxnGHUPJfxN1/M6pJxJG5I
         u+DLps7+EM6t4h53wxuc5fpRrv6MW45ioGC7OxXNoJMnFREik6pVdLPhxhFznCRdPF3j
         jHRlBxXV8EzxhlLTL1S9OcX6AHmpbezd4WVPOQ89G3dsgLvGhb5hfBEDYE8oysoW2Yxz
         fPIQc54L52kqlyhPyPxiK05eF3wj+2Ur847KqCIfN6u8rUrFtEYdZHn0ABiZm48ginzi
         sRPeeWPww4n0gaFFHyHLwZJ1/+/2hqZFCo2A4Lipv/xuq+Z+Qyc+VKWRxUZhKSInRl7y
         x7lQ==
X-Received: by 10.152.22.168 with SMTP id e8mr20323489laf.20.1368711126086;
 Thu, 16 May 2013 06:32:06 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 06:32:06 -0700 (PDT)
In-Reply-To: <CALkWK0nBUHHkqOQannMu5Kjs00Fro8KBbiocfsT4Uf74jO9FgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224565>

On Thu, May 16, 2013 at 6:31 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Would I be able to do:
>>
>> % git branch --set-upstream-to origin/master --set-downstream-to
>> github/fc/master
>>
>> ?
>>
>> Would I see these branches when I do 'git branch -vv'?
>> Would I be able to do 'git push next@{downstream}'?
>
> Hm, losing this functionality in the name of generality would
> certainly be very undesirable.

I don't even know what that means.

>> That is orthogonal to 'branch.A.push' the same way 'remote.B.fetch' is
>> orthogonal to 'branch.A.merge'.
>
> Not at all (which is what I've been trying to say).
> remote.<name>.fetch is operated on by fetch, while branch.<name>.merge
> is operated on by merge; they are really orthogonal.  What happens if
> both branch.<name>.push and remote.<name>.push are set?  What will
> push do?

The same that 'git pull' does when both branch.<name>.merge and
remote.<name>.fetch are set.

> Perhaps we should get both, and get branch.<name>.push to override
> remote.<name>.push.

Does branch.<name>.merge overrides remote.<name>.fetch? No. They
complement each other.

> The issue being @{d} will not work if
> remote.<name>.push is set.

Of course it would work. Does @{u} stop working when remote.<name>.fetch is set?

> Then again, since we're targeting Gerrit
> users here, I don't really think it's an issue: refs/for/master is not
> really a "downstream branch"; it's a pseudo-ref that Gerrit handles
> internally.

It is a downstream branch.

-- 
Felipe Contreras

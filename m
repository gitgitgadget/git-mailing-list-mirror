From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: git-rev-list  in local commit order
Date: Sun, 15 May 2005 17:43:57 -0400 (EDT)
Message-ID: <1392.10.10.10.24.1116193437.squirrel@linux1>
References: <4127.10.10.10.24.1116107046.squirrel@linux1> 
    <1116186533.11872.152.camel@tglx> 
    <4971.10.10.10.24.1116187076.squirrel@linux1> 
    <1116189873.11872.171.camel@tglx> 
    <1102.10.10.10.24.1116189916.squirrel@linux1> 
    <1116191636.11872.195.camel@tglx> 
    <1273.10.10.10.24.1116192097.squirrel@linux1>
    <1116192629.11872.201.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 23:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQtu-00030c-8D
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEOVoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEOVoB
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:44:01 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:47287 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261260AbVEOVn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:43:58 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050515214357.BUKT11606.simmts5-srv.bellnexxia.net@linux1>;
          Sun, 15 May 2005 17:43:57 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4FLhvpS008825;
	Sun, 15 May 2005 17:43:57 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 15 May 2005 17:43:57 -0400 (EDT)
In-Reply-To: <1116192629.11872.201.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 5:30 pm, Thomas Gleixner said:
> On Sun, 2005-05-15 at 17:21 -0400, Sean wrote:
>> > Time is illusion.
>>
>> What you're missing is that time is only important in this case to
>> deduce
>> the relative age of each commit LOCALLY.   The intention of this
>> proposal
>> is not to allow time comparison of commits between repositories.
>
> I do not want to compare times. I want to figure out workflows and
> histories between different repositories.

Well I honestly don't know what you want.   If I wanted to include a
"fortune" line in every commit and couldn't explain what value it
provided, i'd expect you or others to object.

My time based proposal solves the issue of :

Rn------\
Rn-1    Mn
Rn-2    Mn-1
Rn-3 ---/
Initial

Showing up in two repositories sorted based on the order they were
committed locally.  This was an issue that you stated you were trying to
solve.  The test case works just as advertised.  Remote times don't
matter, all that matters is the time you merge the objects locally.

> Even LOCALLY is no guarantee for correct timestamps.

Sure, but then your repoid might have gone missing or be set incorrectly
too.   One nice thing if your time is wrong, you can simply reset the
timestamp on the file.   If your repo-id is wrong, you have to recast the
commit object which will get a different SHA1 number and make things more
difficult.

Sean



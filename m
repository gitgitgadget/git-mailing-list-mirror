From: John Tapsell <johnflux@gmail.com>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Thu, 26 Mar 2009 02:05:21 +0000
Message-ID: <43d8ce650903251905p6f9798f5u79be7dff3b118d5c@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
	 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
	 <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
	 <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
	 <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
	 <alpine.LNX.1.00.0903242118270.19665@iabervon.org>
	 <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
	 <alpine.LNX.1.00.0903242304530.19665@iabervon.org>
	 <7001b7a00903251023r1ce5cc0dnb29b7f9379408c42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Irene Ros <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 03:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmezd-0003ek-Pa
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 03:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbZCZCFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 22:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZCZCFY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 22:05:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:58468 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbZCZCFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 22:05:23 -0400
Received: by wf-out-1314.google.com with SMTP id 29so380271wff.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 19:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zt2smcvt/JVRkUhAi9uVrPbyeSfpUEHOaRd5hRE4/AY=;
        b=FVWHGmK1R9cfdeaB/bpyo8zjVUw3UJJljrLm38VOhefiAJvy9jbV7qa8HoWnpE2Vc9
         bb6vkRKx3Utzzz4ds7yiPoAcE+6E9NATol1I/LPSqi/e0kSvMHWLGR9MId0LYYz7petg
         T7siWRFvfcOrbVt2gk+sspve6MUTsicBj3fmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pVPXPeCwcKw531Qav62zm+rzAh4eFTBSp2/X080mQLFIFr3Tpklo0IJpCOz3o8ca7K
         SCdVC1uIwlBap8qY10bpET82oqdukicC6LuClhk9kxHtzFljwVLFkX9REO1EOv0xycdw
         tT/cSg+pOCXIpRqPCuWOzUK84+lJ7Mb9hh504=
Received: by 10.143.33.19 with SMTP id l19mr131834wfj.30.1238033121216; Wed, 
	25 Mar 2009 19:05:21 -0700 (PDT)
In-Reply-To: <7001b7a00903251023r1ce5cc0dnb29b7f9379408c42@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114705>

2009/3/25 Irene Ros <imirene@gmail.com>:
> Hi Daniel,
>
> Thank you for the explanation, doing a git fetch actually did do the
> trick although I still don't quite see the difference between
> git pull origin myBranch
> and
> git fetch

git pull origin myBranch    is equivalent to two commands:

git fetch
git merge origin/myBranch

(so fetch actual remote repository to local remote repository.  Then
do the merge)

>
> When I push to origin myBranch it's clear that it actually pushes my
> changes to our remote repository since others can then pull and get
> them. So is it the case that:
>
> git push ==> actual remote repository
Yes

> while
> git pull <== local copy of remote repository for this branch ?

git pull <== actual remote repository copied to local copy of remote
repository.  Then local copy of remote repository merged into your
branch.


> In that case why is it that in all branches that I have, besides this
> one, doing a 'git pull origin whateverBranch' actually pulls from the
> remote branch and not the local copy? This case has been quite unique
> given dozens of branches that we constantly switch to and from. We've
> never actually used (or clearly saw the need for) git fetch until now.


If you always git pull  after git push, then you'll have no problem,
since git pull also does a git fetch.

git is sometimes a bit too bare bones :-/  It would be nice to try to
hide these implementation details better

From: David Lang <david@lang.hm>
Subject: Re: Question re. git remote repository
Date: Fri, 18 Jan 2013 13:27:55 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301181320070.21503@nftneq.ynat.uz>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca> <20130116220615.48c159546bccfa5b9cd9028e@domain007.com> <20130116182156.GB4426@sigill.intra.peff.net> <20130116233744.7d0775eaec98ce154a9de180@domain007.com> <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz> <201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca> <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com> <201301181833.r0IIXNGb027544@smtpb02.one-mail.on.ca>
 <alpine.DEB.2.02.1301181127590.21503@nftneq.ynat.uz> <7v622uqjch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Lang, David" <David.Lang@uhn.ca>,
	"'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwJVW-00051g-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 22:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872Ab3ARV3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 16:29:30 -0500
Received: from mail.lang.hm ([64.81.33.126]:57659 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930Ab3ARV33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 16:29:29 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0ILTKun014427;
	Fri, 18 Jan 2013 13:29:20 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7v622uqjch.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213939>

On Fri, 18 Jan 2013, Junio C Hamano wrote:

> David Lang <david@lang.hm> writes:
>
>> What I would do is to have each developer have their own local copy
>> that they are working on.
>>
>> I would then find a machine that is going to be on all the time (which
>> could be a developer's desktop), and create a master repository
>> there. Note that if this is on a developers desktop, this needs to be
>> a different repository ... from
>> what they use to do their work.
>>
>> developers then do their work locally, and after a change has been
>> reviewed, pull it into the master repository.
>
> s/pull it into/push it into/; I think.

fair enough, I always think in terms of pulling from feature branches into the 
main repository so that any merge conflicts get resolved. I didn't describe this 
clearly enough.

Junio, is there a really good place we should be pointing David where the 
different workflows are described and explained?

for David

After the work is completed in the feature branches, you now have the problem of 
how to combine this work in with whatever other work has taken place in the 
meantime.

One common way to do this is to pull from the feature branch into the main tree. 
If there are conflicts, git will help you identify them and resolve them (note 
that some changes will not produce conflicts that git detects, but can still 
result in non-working code)

developers can (and should) do a dry run on this if significant changes have 
happened in the master. Create a new throw-away branch of the master tree and 
merge your feature branch into that tree and see what happens. If everything 
works, you are good to go. If you have massive conflicts, it may be worth doing 
work to avoid the conflicts and then submit the result of that to the master 
(also known as upstream)

With only two developers, you can have each of them do the merge work on a 
temporary branch and then push the results upstream to the master, or you can 
have one of them 'change hats' to be the release manager and work from the point 
of view of the master to pull the changes in)

David Lang

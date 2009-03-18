From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Wed, 18 Mar 2009 11:05:29 +0100
Message-ID: <49C0C769.8020401@drmicha.warpmail.net>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com> <20090318005413.GC25454@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tom Preston-Werner <tom@github.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljsg7-0007XQ-5O
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 11:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbZCRKFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 06:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbZCRKFp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 06:05:45 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:57531 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516AbZCRKFo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 06:05:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3DD512F4E65;
	Wed, 18 Mar 2009 06:05:43 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 18 Mar 2009 06:05:43 -0400
X-Sasl-enc: XTdY4wDhN2xpEsdAmWMZUKpeIPByJ91HX3dfA028MMCg 1237370742
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 880AB4CD6C;
	Wed, 18 Mar 2009 06:05:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090317 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090318005413.GC25454@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113605>

Jeff King venit, vidit, dixit 18.03.2009 01:54:
> On Tue, Mar 17, 2009 at 12:19:35PM -0700, Tom Preston-Werner wrote:
> 
>> After cloning this with a standard `git clone`, the refs are:
>>
>> [11:48][tom@solid:~/dev/sandbox/site(release)]$ git branch -r -v
>>   origin/HEAD    a52528a Fixed some routing problems
>>   origin/release a52528a Fixed some routing problems
>>   origin/trunk   a52528a Fixed some routing problems
>>
>> And the checked out branch is 'release' instead of 'trunk' as I would expect:
> 
> As others have explained, this is because the information is lacking at
> the client and we are forced to make a guess. There is a heuristic in
> the guess to prefer "master" if it is an option. I suppose we could make
> a similar exception for "trunk", which might make sense to people
> working with SVN repositories.
> 
> OTOH, I am not sure I want to open the can of worms that is writing an
> exhaustive list of heuristics that will work for everybody. Fixing the
> protocol itself would probably be easier. :)

One might even argue that in case of ambiguities, checking out a
detached head would be most appropriate. Really, why impose creation of
certain local branches on a user at all, unless asked for? Detached
heads are natural in git! But I don't really expect positive consensus
on that one...

Michael

From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 08:19:19 +0200
Message-ID: <48CA09E7.8090102@dawes.za.net>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Sep 12 08:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke28N-0007uD-Sz
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 08:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbYILGV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 02:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYILGV4
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 02:21:56 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:36155 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYILGVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 02:21:55 -0400
Received: from spunkymail-a10.g.dreamhost.com (balanced.mail.policyd.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 1149617D97C
	for <git@vger.kernel.org>; Thu, 11 Sep 2008 23:21:15 -0700 (PDT)
Received: from [192.168.201.100] (unknown [41.246.247.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a10.g.dreamhost.com (Postfix) with ESMTP id 9BB8916148F;
	Thu, 11 Sep 2008 23:19:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080912054739.GB22228@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95686>

Stephen R. van den Berg wrote:
> Linus Torvalds wrote:
>> On Fri, 12 Sep 2008, Sam Vilain wrote:
>> It can happen even without any conflicts, just because the context 
>> changed. So it really isn't about merge conflicts per se, just the fact 
>> that a patch can change when it is applied in a new area with a three-way 
>> diff - or because it got applied with fuzz.
> 
> Quite.
> 
>> You could add it as a 
> 
>> 	Original-patch-id: <sha1>
> 
> That will probably work fine when operating locally on (short) temporary
> branches.
> 
> It would probably become computationally prohibitive to use it between
> long lived permanent branches.  In that case it would need to be
> augmented by the sha1 of the originating commit.  Which gives you two
> hashes as reference, and in that case you might as well use the two
> commit hashes of which the difference yields the patch.

Pardon my confusion, but why include two commit hashes? Surely the 
commit already has its parent, so there is no need to include that in 
your "cherry pick". And if the commit has more than one parent, then I 
doubt you could/should really cherry-pick it anyway.

Besides, you could always augment your local repo with a mapping of 
patch ids to commits/commit pairs to reduce lookup time.

Rogan

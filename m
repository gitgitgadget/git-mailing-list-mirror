From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Show an example of deleting commits with git-rebase.
Date: Wed, 07 Feb 2007 11:25:41 +0100
Organization: At home
Message-ID: <eqc9c7$9lr$1@sea.gmane.org>
References: <20070205202106.GA8755@spearce.org> <20070207101624.GC20290@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 11:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjyo-0003RG-Pi
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 11:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbXBGKYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 05:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbXBGKYa
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 05:24:30 -0500
Received: from main.gmane.org ([80.91.229.2]:45244 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161148AbXBGKY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 05:24:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEjyN-0004hq-K6
	for git@vger.kernel.org; Wed, 07 Feb 2007 11:24:19 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 11:24:19 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 11:24:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38909>

Michael S. Tsirkin wrote:
> Shawn O. Pearce <spearce@spearce.org> wrote:

>> Subject: [PATCH] Show an example of deleting commits with git-rebase.
>> 
>> +A range of commits could also be removed with rebase.  If we have
>> +the following situation:
>> +
>> +------------
>> +    E---F---G---H---I---J  topicA
>> +------------
>> +
>> +then the command
>> +
>> +    git-rebase --onto topicA~5 topicA~2 topicA
>> +
>> +would result in the removal of commits F and G:
>> +
>> +------------
>> +    E---H'---I'---J'  topicA
>> +------------
>> +
>> +This is useful if F and G were flawed in some way, or should not be
>> +part of topicA.  Note that the argument to --onto and the <upstream>
>> +parameter can be any valid commit-ish.
>> +
> 
> Good clarification, a couple of comments:
> - The use of <branch> is more confusing than useful in this case.
>   You can always just do
>       git reset --hard topicA
>       git rebase --onto topicA~5 topicA~2
>   instead, correct?

I disagree. In my opinion using of <branch> makes it more clear: which
branch we are rebasing, and range of commits moved.
 
> - The use of ~ notation here is also more scary than clarifying.
>    git rebase --onto F H
>   will be clearer I think.

I agree.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

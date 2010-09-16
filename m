From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Sep 2010, #05; Wed, 15)
Date: Thu, 16 Sep 2010 18:06:21 +0200
Message-ID: <4C92407D.5090105@drmicha.warpmail.net>
References: <7viq266461.fsf@alter.siamese.dyndns.org> <AANLkTimd0j4toF6kEF+6H_-JcE60aA2jbM67PoLjJ=bs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 18:06:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwGyd-0000pD-5Y
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 18:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab0IPQGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 12:06:17 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36348 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601Ab0IPQGQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 12:06:16 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4D2FC3AD;
	Thu, 16 Sep 2010 12:06:16 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 16 Sep 2010 12:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8gIJMI2bWLm9V7XUfru7GrOC9zY=; b=qrqMKM42cvk2iDpIKUzSnXhP9doRVFGODPKKaq5q3rDrbTPG6kN79NNtUEXRDQ1hxY+IKLI3JyOb/moaOa0fFpFxqpfZopnl6Qe8c+WAAmYj6ELLiu5wzqMXpNA1lKYN6VjFdov2rIzgUtw3u+WH1zAW67FkB7uWJ1CiimRk110=
X-Sasl-enc: FJt4J80q1NEGZ3/R4NjJEkzWEcXeKmIfR74v4mZnDnV/ 1284653176
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AB603406C87;
	Thu, 16 Sep 2010 12:06:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <AANLkTimd0j4toF6kEF+6H_-JcE60aA2jbM67PoLjJ=bs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156340>

Bo Yang venit, vidit, dixit 16.09.2010 17:23:
> On Thu, Sep 16, 2010 at 6:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> [Cooking]
>>
>> * by/line-log (2010-09-11) 18 commits
>>  (merged to 'next' on 2010-09-12 at e29a029)
>>  + log -L: do not free parents lists we might need again
>>  (merged to 'next' on 2010-08-26 at a160ff1)
>>  + Document line history browser
>>  + Add tests for line history browser
>>  + Add --full-line-diff option
>>  + Add --graph prefix before line history output
>>  + Add parent rewriting to line history browser
>>  + Make graph_next_line external to other part of git
>>  + Make rewrite_parents public to other part of git
>>  + Hook line history into cmd_log, ensuring a topo-ordered walk
>>  + Print the line log
>>  + map/take range to the parent of commits
>>  + Add range clone functions
>>  + Export three functions from diff.c
>>  + Parse the -L options
>>  + Refactor parse_loc
>>  + Add the basic data structure for line level history
>>  + parse-options: add two helper functions
>>  + parse-options: enhance STOP_AT_NON_OPTION
>>
>> How would one trace history of lines 440,450 in t/t7300-clean.sh starting
>> from the tip of 'pu'?  "git log -p -L 440,450 pu -- t/t7300-clean.sh"
>> would be the most natural but it does not work (it wants "pu" to be a
>> path).  "git log -p -L 440,450 t/t7300-clean.sh pu" doesn't work either.
> 
> Please put the revision before the '-L' options, you can run:
> 
> git log -p origin/pu  -L 440,450 t/t7300-clean.sh
> 
> It will work.
> 
>> The command line parser of this series needs to be rethought (didn't I say
>> that many times?  Perhaps I was ignored).  Might want to kick this out of
>> 'next' and move to the stalled category after 1.7.3.
> 
> Yes, you have mentioned this many times, and I will put some time on this issue.
> 

I really haven't looked at the feature, but from other commands I would
suspect:

- refs go before paths
- options go before refs

Now, if "-L x,y" is an option /specific to a single file argument/ (not
an overall option for all file arguments) it needs to go before the file
it applies to. Is it file specific?

It would still be nice to make the parser more lenient in the sense that
it accepts an "-L x,y" in the usual place and applies it to all file
arguments.

Michael

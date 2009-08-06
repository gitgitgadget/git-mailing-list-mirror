From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] git-rev-list.txt: Clarify the use of multiple revision
 arguments
Date: Thu, 06 Aug 2009 10:48:59 +0200
Message-ID: <4A7A98FB.7070104@drmicha.warpmail.net>
References: <1249459117-3853-1-git-send-email-git@drmicha.warpmail.net> <1249459117-3853-2-git-send-email-git@drmicha.warpmail.net> <7vd47adxfq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 10:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYyfU-0001Pp-3U
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 10:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZHFItQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 04:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbZHFItP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 04:49:15 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48985 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232AbZHFItO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 04:49:14 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BC4F48D4;
	Thu,  6 Aug 2009 04:49:13 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 06 Aug 2009 04:49:13 -0400
X-Sasl-enc: 8FHbdQ3NrmHAAtYkiiHCHRkf5wk2uGxu8pk/FaDUGKAt 1249548553
Received: from localhost.localdomain (vpn-137-070.rz.uni-augsburg.de [137.250.137.70])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D534829F92;
	Thu,  6 Aug 2009 04:49:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <7vd47adxfq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125053>

Junio C Hamano venit, vidit, dixit 05.08.2009 18:42:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
>> index 847cc7d..40ca276 100644
>> --- a/Documentation/git-rev-list.txt
>> +++ b/Documentation/git-rev-list.txt
>> @@ -66,6 +66,13 @@ command:
>>  means "list all the commits which are included in 'foo' or 'bar', but
>>  not in 'baz'".
>>  
>> +So, the resulting set of commits is the union of 'foo' and 'bar',
>> +intersected with the complement of baz. The order of arguments is
>> +irrelevant: first, the union of all positive refs (those without
>> +'{caret}') is taken, then the result is intersected with all negative
>> +refs (i.e. with the complement of the union of all refs which appear
>> +with a preceding '{caret}').
> 
> It seems to me that the first sentence just repeats what the previous
> sentence that we can see in the context with different fuzziness.
> 
> I am guessing that the reason you are patching this is because you felt
> that the existing "list all the commits which are _included in_ 'foo' or
> 'bar', but not _in_ 'baz'" uses "be included in" without defining what it
> really means (i.e. "reachable by following the ancestry").
> 
> I however find the "union of 'foo' and 'bar' intersected with the
> complement of 'baz'" similarly lacking.  The sentence equates commit X
> with the set of commits that are reachable from X, without explaining that
> is what it is doing.
> 
> To me, this feels much worse than the original.  When you say commit X,
> the reader must guess if you are talking about the single commit, or the
> set of commits reachable from it by following the ancestry chain.
> 
> How about rewriting it a bit more without repeating?

Yes, I tried to be minimally invasive, which is also why I split the
patch in two (correction + addition). I really prefer your rephrased
version. Feel free to squash in/ask me to resubmit/whatever suits you.

Michael

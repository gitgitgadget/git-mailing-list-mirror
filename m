From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Mon, 26 Jan 2009 11:21:44 -0500
Message-ID: <497DE318.2070603@xiplink.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <7vpricmoda.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901242156320.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:23:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUEz-0006Ry-5s
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZAZQVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbZAZQVr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:21:47 -0500
Received: from smtp222.iad.emailsrvr.com ([207.97.245.222]:35983 "EHLO
	smtp222.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbZAZQVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:21:47 -0500
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jan 2009 11:21:46 EST
Received: from relay12.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay12.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 8822D20768A;
	Mon, 26 Jan 2009 11:21:45 -0500 (EST)
Received: by relay12.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id ED4C820A887;
	Mon, 26 Jan 2009 11:21:44 -0500 (EST)
User-Agent: Icedove 1.5.0.14eol (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0901242156320.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107223>

I'm sorry, but I just don't understand the purpose of 'was E' (or 
whatever syntax) in the merge command.  Why is there a need to refer to 
E at all?  The only reason I can think of is to replicate E's commit 
message.  Am I missing something?

Come to think of it, what if the user wants to edit a merge commit's 
message?  Should there be an 'editmerge' command?

		M.


Johannes Schindelin wrote:
>
>> - Why do you need "merge D' was E"?  Shouldn't "pick E" be able to 
>>   notice that E is a merge and decompose it into "merge D' was E" 
>>   internally?
>>
>>   This one I am somewhat complaining, unless your answer is "because 
>>   this way the user could drop some parents from the merge in the 
>>   editor".
> 
> Not only that; the user could use this to fix mismerges, i.e. by replacing 
> a SHA-1 with the SHA-1 (or indeed, a short name, unless it is "was") of 
> the branch that she _actually_ wanted to merge with.
> 
>>   And if your answer is that, then my next question will be "if that is 
>>   the case, can the user be expected to easily find out which commit 
>>   each parent SHA-1 refers to, without having more hint on the 'merge' 
>>   insn line?"
> 
> Nope.
> 
> In most cases, however, that should be plenty enough:
> 
> 	merge 9383af1' was f39d50a Merge branch 'mh/unify-color' into next
> 
> The user does not have to guess much what 9383af1 might refer to.

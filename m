From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 23:33:15 +0100
Message-ID: <473A262B.4010205@op5.se>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org> <87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de> <473A027E.5000107@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Sergei Organov <osv@javad.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4KE-0005yX-Q4
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 23:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762336AbXKMWdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 17:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762799AbXKMWdU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 17:33:20 -0500
Received: from mail.op5.se ([193.201.96.20]:38314 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762336AbXKMWdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 17:33:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CFA2C1F08711;
	Tue, 13 Nov 2007 23:33:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRzHpbmAWZOL; Tue, 13 Nov 2007 23:33:17 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 83E561F0870D;
	Tue, 13 Nov 2007 23:33:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <473A027E.5000107@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64897>

Andreas Ericsson wrote:
> Steffen Prohaska wrote:
>>
>> BTW, what's the right name for this type of branch.
>> I found "tracking branch", "remote tracking branch", and
>> "remote-tracking branch" in the manual. The glossary only
>> mentions "tracking branch".  Or is it a "tracked remote branch"
>> as the output of "git remote show" suggests.  I remember,
>> there was a lengthy discussion on this issue.  Does someone
>> remember the conclusion?
>>
> 
> It seems we agreed to disagree. However, a "tracked remote branch"
> is definitely not in your local repo. I think remote-tracking branch
> grammatically is the most correct, as that's the only non-ambiguous
> form (remote tracking branch might mean "remote tracking-branch" or
> "remote-tracking branch"). It's also the only form that works when
> used with "local" in front of it. "Tracked remote branch" will
> always be a "remote branch", no matter how you prefix it.
> 
> I hate that part of git nomenclature with a passion. It's ambiguous
> at best and, as a consequence, downright wrong for some uses.
> 

I confess myself corrected. The Documentation/glossary.txt file doesn't
mention them at all. It does however describe "tracking branch", and
mentions "Pull: " refspecs in the same sentence, indicating that that
particular description is a leftover from the pre-1.5 era.

I've got half a patch ready to change all occurrences of anything but
"remote-tracking branch" to that self-same description. This is what
I've got in Documentation/glossary.txt so far:

[[def_remote_tracking_branch]]remote-tracking branch:
    A "remote-tracking branch" is a branch set up to track the
    state of a branch in a remote repository which the user has named. 
    These branches follow exactly the same rules as the branches which
    reside in the remote repository, except that they are manipulated
    by `git fetch` instead of `git push`. That is, they can only be
    updated if the update would result in a 
    <<def_fastforward,fast forward>>, or if the user supplies the 
    '--force' option. 
    They cannot be checked out or committed to by users, but serve
    solely as local reference-pointers to their corresponding branches
    in the remote repository.
    The most common example of a remote-tracking branch is origin/master.


It's a bit long-winded. Anyone got any improvements?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

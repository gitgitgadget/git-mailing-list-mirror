From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 18:05:05 -0500
Message-ID: <20071113230505.GJ22590@fieldses.org>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org> <87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de> <473A027E.5000107@op5.se> <473A262B.4010205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4pF-0008Qs-Ld
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761000AbXKMXFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761390AbXKMXFN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:05:13 -0500
Received: from mail.fieldses.org ([66.93.2.214]:54504 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761000AbXKMXFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:05:11 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Is4ob-0002bQ-K5; Tue, 13 Nov 2007 18:05:05 -0500
Content-Disposition: inline
In-Reply-To: <473A262B.4010205@op5.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64902>

On Tue, Nov 13, 2007 at 11:33:15PM +0100, Andreas Ericsson wrote:
> Andreas Ericsson wrote:
>> Steffen Prohaska wrote:
>>>
>>> BTW, what's the right name for this type of branch.
>>> I found "tracking branch", "remote tracking branch", and
>>> "remote-tracking branch" in the manual. The glossary only
>>> mentions "tracking branch".  Or is it a "tracked remote branch"
>>> as the output of "git remote show" suggests.  I remember,
>>> there was a lengthy discussion on this issue.  Does someone
>>> remember the conclusion?
>>>
>>
>> It seems we agreed to disagree. However, a "tracked remote branch"
>> is definitely not in your local repo. I think remote-tracking branch
>> grammatically is the most correct, as that's the only non-ambiguous
>> form (remote tracking branch might mean "remote tracking-branch" or
>> "remote-tracking branch"). It's also the only form that works when
>> used with "local" in front of it. "Tracked remote branch" will
>> always be a "remote branch", no matter how you prefix it.
>>
>> I hate that part of git nomenclature with a passion. It's ambiguous
>> at best and, as a consequence, downright wrong for some uses.
>>
>
> I confess myself corrected. The Documentation/glossary.txt file doesn't
> mention them at all. It does however describe "tracking branch", and
> mentions "Pull: " refspecs in the same sentence, indicating that that
> particular description is a leftover from the pre-1.5 era.
>
> I've got half a patch ready to change all occurrences of anything but
> "remote-tracking branch" to that self-same description. This is what
> I've got in Documentation/glossary.txt so far:
>
> [[def_remote_tracking_branch]]remote-tracking branch:
>    A "remote-tracking branch" is a branch set up to track the
>    state of a branch in a remote repository which the user has named.    
> These branches follow exactly the same rules as the branches which
>    reside in the remote repository, except that they are manipulated
>    by `git fetch` instead of `git push`. That is, they can only be
>    updated if the update would result in a    <<def_fastforward,fast 
> forward>>, or if the user supplies the    '--force' option.

This is a little confusing--by default fetch does force updates.

--b.

> They cannot 
> be checked out or committed to by users, but serve
>    solely as local reference-pointers to their corresponding branches
>    in the remote repository.
>    The most common example of a remote-tracking branch is origin/master.
>
>
> It's a bit long-winded. Anyone got any improvements?
>
> -- 
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

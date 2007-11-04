From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] errors: "strict subset" -> "ancestor"
Date: Sun, 4 Nov 2007 17:08:10 -0500
Message-ID: <20071104220810.GC22762@fieldses.org>
References: <20071103023944.GA15379@fieldses.org> <3F4A5458-AB2F-40C7-AA0E-9D26981BCE9D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 23:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ionds-0007Tb-C2
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 23:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXKDWIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 17:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbXKDWIN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 17:08:13 -0500
Received: from mail.fieldses.org ([66.93.2.214]:55136 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752703AbXKDWIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 17:08:12 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ionda-0007VF-8y; Sun, 04 Nov 2007 17:08:10 -0500
Content-Disposition: inline
In-Reply-To: <3F4A5458-AB2F-40C7-AA0E-9D26981BCE9D@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63450>

On Sat, Nov 03, 2007 at 08:51:29AM +0100, Steffen Prohaska wrote:
>
> On Nov 3, 2007, at 3:39 AM, J. Bruce Fields wrote:
>
>> From: J. Bruce Fields <bfields@citi.umich.edu>
>>
>> The term "ancestor" is a bit more intuitive (and more consistent with
>> the documentation) than the term "strict subset".
>>
>> Also, remove superfluous "ref", capitalize, and add some carriage
>> returns, changing:
>>
>> 	error: remote 'refs/heads/master' is not a strict subset of local ref 
>> 'refs/heads/master'. maybe you are not up-to-date and need to pull first?
>> 	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/git.git'
>>
>> to:
>>
>> 	error: remote 'refs/heads/master' is not an ancestor of
>> 	 local 'refs/heads/master'.
>> 	 Maybe you are not up-to-date and need to pull first?
>> 	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/git.git'
>
>
> Junio suggested in [1] (see also earlier messages in that
> thread) to replace the recommendation to pull with a hint
> where to look in the user manual.
>
> [1] http://marc.info/?l=git&m=119398999317677&w=2
>
>
> The point is, there are various ways to resolve the problem.
> pull is not necessarily the right solution. At least, you should
> consider to rebase. Or maybe just something else went wrong.

Yeah, actually in my case I usually want to force....

So I think it's a good suggestion, but I'm putting it off for now as I'm
not sure yet where to refer people to, and don't like making the error a
lot longer.

Hm.  I wonder if extra "help" commandline flags would be a way to get
people extra guidance on particular situations without cluttering up the
default messages ("not sure what to try next?  Try -h notanancestor..."
Maybe not.)

>
> Nonetheless I think it could be a good idea to keep the most
> likely cases. So, how about
>
> "Are you up-to-date? Did you forget to pull or rebase? See User's Manual 
> for details."
>
> I put it as questions to avoid making a suggestion. The questions
> should give sufficient hints for searching in the User's Manual.
> I haven't found the single section that would explain exactly
> the situation we're dealing with.

Me neither.  And I don't think a reference to the whole thing is
helpful.

--b.

From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Pushing into a repository with working directory?
Date: Mon, 08 Jan 2007 13:53:42 +0000
Message-ID: <45A24CE6.5060201@shadowen.org>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org> <7vwt41j1le.fsf@assigned-by-dhcp.cox.net> <20070105193646.GC8753@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 14:54:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3uwl-00025B-8k
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 14:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbXAHNxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 08:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbXAHNxu
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 08:53:50 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4453 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161302AbXAHNxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 08:53:49 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H3uvg-0006pl-UZ; Mon, 08 Jan 2007 13:52:49 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070105193646.GC8753@spearce.org>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36259>

Shawn O. Pearce wrote:
> Junio C Hamano <junkio@cox.net> wrote:
>> Andy Whitcroft <apw@shadowen.org> writes:
>>
>>> Special casing the 'current' branch makes any sort of automated push
>>> setup unreliable.  Indeed the special case preventing a fetch into the
>>> current branch is pretty annoying for the same reason.  I would almost
>>> prefer to relax that than add the same for push.
>> How would you relax the fetch case?  Fetching into the current
>> branch, unless the repository is bare, is always a fishy
>> operation.
> 
> And so is pushing into the current branch, so long as the current
> branch has a working directory attached to it.
> 
> Most new users to Git expect to be able to push into the current
> branch of a repository and `just have it work`.  Only they don't
> really seem to have an idea of _how_ that operation should behave,
> which means they really don't want it to work at all.  I certainly
> don't want an operation to succeed if I can't reason about what
> its success means!
> 
> Right now pushing into the current branch makes the index become
> way out of sync from HEAD.  This causes git-runstatus to display a
> large number of differences, basically undoing any of the changes
> introduced by HEAD@{1}..HEAD.  The user is left with a dirty
> working tree that they can commit - and committing it will just
> revert the prior commits.  The user will later cuss at Git for
> losing their changes.  Not pretty.

Ok, both seem to be bad.  Can I re-ask if this would be solved by having
the 'dangling head' support we talked about.  Such that pulling into or
pushing into the current head could break the link and make the current
head a dangling head?  In my mind thats very similar to creating a
temporary branch for the user before updating the head they were on, but
without having to actually make one.

-apw

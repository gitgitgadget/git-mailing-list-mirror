From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Main branch being maintained with 'git am', how do mere mortals
 interact without too much conflicts?
Date: Sat, 10 Jan 2009 16:29:43 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmhj7n.4nl.sitaramc@sitaramc.homelinux.net>
References: <87vdsntnyd.dancerj%dancer@netfort.gr.jp>
 <eaa105840901100647y70b53ae0w495af69b7281cae7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 17:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgk3-0005CJ-01
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 17:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbZAJQ3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 11:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZAJQ3y
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 11:29:54 -0500
Received: from main.gmane.org ([80.91.229.2]:41938 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbZAJQ3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 11:29:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LLgie-0006cG-OI
	for git@vger.kernel.org; Sat, 10 Jan 2009 16:29:52 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 16:29:52 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 16:29:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105127>

On 2009-01-10, Peter Harris <git@peter.is-a-geek.org> wrote:
> On Sat, Jan 10, 2009 at 6:11 AM, Junichi Uekawa wrote:
>> I am thinking of recommending the users to create a branch
> ...
>> and throw away their branches when they are included upstream.
>
> Yes, with a patch based workflow, this is almost required; all of the
> commits will at least have different committer information.
>
> There's nothing wrong with this approach.

That is almost exactly what a rebase does.  Each patch on
your local "master" that eventually made it upstream gets
discarded during the rebase (which is a pretty cool thing!),
and what remains are commits that did not make it upstream
-- their current "work in progress".

The difference between "origin/master" and "master", after
each rebase, is their "private branch".

Except you don't have to confuse them by saying so ;-)

>> Something tells me the problem is that I'm probably using a workflow
>> that resembles SVN too much, and users aren't used to branches yet.
>> Has anybody found this to be a problem, or better yet, is there a
>> better workflow?
>
> If you need the commits to be identical, and you don't mind your email
> consisting of a binary blob attachment, you can ask your contributors
> to send you a bundle instead of a series of patches. "git help bundle"
> for details.

Excellent idea.  But it only works for the first user who
sends him a bundle.  The next one that he gets, assuming
that user also started from the same "upstream" commit as
the starting point, will be a merge, and he has to resolve
conflicts anyway.

Essentially, two things have to happen to reduce conflict
resolution overall.  The users must rebase against the
latest upstream before sending the patch, and the supervisor
must process and push received patches asap.

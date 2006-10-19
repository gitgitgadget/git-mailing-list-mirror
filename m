From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 19:01:58 -0400
Message-ID: <453803E6.2060309@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>	<45357411.20500@utoronto.ca>	<200610180246.18758.jnareb@gmail.com>	<45357CC3.4040507@utoronto.ca>	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<4536EC93.9050305@utoronto.ca>	<87lkncev90.wl%cworth@cworth.org>	<453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 01:02:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gagtw-0004jW-Da
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 01:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946645AbWJSXCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 19:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946646AbWJSXCI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 19:02:08 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:43399 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1946645AbWJSXCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 19:02:05 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gagtk-00069f-00; Thu, 19 Oct 2006 19:02:01 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <878xjc2qeb.wl%cworth@cworth.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29385>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Carl Worth wrote:
> On Thu, 19 Oct 2006 10:58:48 -0400, Aaron Bentley wrote:

> Let's imagine there's a complete fork in the bzr codebase tomorrow. We
> need not suppose any acrimony, just an amiable split as two subsets of
> the team start taking the code in different directions.

...

> Finally the two teams ... want to
> merge their code together.
> 
> After the merge, there can be only one mainline, so one team or the
> other will have to concede to give up the numbers they had generated
> and published during the fork.

I don't think this is true.  The abandoned mainline does not need to be
destroyed.  It can be kept at the same location that it always was, with
the numbers that it always had.  So the number + URL combo stays
meaningful.  Additionally, the new mainline can keep a mirror of the
abandoned mainline in its repository, because there are virtually no
additional storage requirements to doing so.

> An individual takes the bzr codebase and starts working on it. It's
> experimental stuff, so it's not pushed back into the central
> repository yet. But our coder isn't a total recluse, so his friends
> help him with the code he's working on. They communicate about their
> work, (perhaps on the main bzr mailing list), and make statements such
> as "feature F is working perfectly as of version V".
> 
> But for these communications, revision numbers will not provide
> historically stable values that can be used.

They certainly can.

The coder says "I've put up a branch at http://example.com/bzr/feature.
 In revision 5, I started work on feature A.  I finished work in
revision 6.  But then I had to fix a related bug in revision 7."

As long as that coder is active, they'll keep their repository at the
same location.  And because branches are cheap (even cheaper than
delta-compressed revisions), there's no reason to delete old branches.
It's better to keep them around for reference purposes.

> It's impossible for our
> coder to predict the numbers that will be assigned to his code when
> they get merged back into the mainline---since some other unknown
> programmer may have branched at exactly the same point and is trying
> to make the same determination.

This is true, but his code is likely to all land in the mainline at
once.  Since his own revnos are more fine-grained, he's not likely want
to use the mainline revnos.

> Now, the programmers could get stable numbers by keeping the branch in
> the main tree, or by at least pushing out the branching point to
> "reserve" a number in the main tree.

I don't know what you mean by pushing out the branching point.

>> That doesn't follow.  Just because something is arguably true doesn't
>> make it bad.  And in this case, I'm not arguing that it's true, I'm
>> saying that it's true, because that is what my experience tells me is true.
> 
> [I'm sorry, but I didn't grasp this sentence. I think I lost the
> antecedent of "it" somewhere.]

I felt that you were mischaracterizing my _statement_ that "it's
exceedingly uncommon for [revnos] to change" as an _argument_ "it's
exceedingly uncommon for [revnos] to change".  The reality is that we
keep saying revnos don't change because git users keep saying "but what
if the revnos change?".


>>          And I personally have been developing a bugtracker that is
>> distributed in the same way bzr is; it stores bug data in the source
>> tree of a project, so that bug activities follow branches around.
> 
> That kind of thing sounds very useful. As I've been talking about
> "numbers" here in bug trackers and mailing lists, it should be obvious
> that I consider the information stored in such systems an important
> part of the history of a code project. So it would be nice if all of
> that history were stored in an equally reliable system in some way.

If you're interested, it's called "Bugs Everywhere" and it's available here:
http://panoramicfeedback.com/opensource/

New VCS backends are welcome :-D

>> In the first place, it seems fairly common in the Git community to
>> rebase.  This process throws away old revisions and creates new
>> revisions that are morally equivalent[1].
> 
> Yes, rebasing does "destroy history" in one sense, (in actual fact, it
> creates new commits and leaves the old ones around, which may or may
> not have references to them anymore). But i's definitely not common
> for git users to use rebase in a situation where it would change any
> published number.

So actually, not all branches are treated equally by Git users.  Public
branches are treated as append-only, but private branches are treated as
mutable.  (It's the same with bzr users, of course.)

> And git helps with this as well. If I ever forget that I've already
> pushed a change and then I rebase, then the next time I try to push,
> git will complain that I'm attempting to throw away history on the
> remote end, and will refuse to cooperate, (unless I force it).

Same here.

> There's a similar safety mechanism on the pull side. If I did force a
> history-rewriting push, then users who tried to pull it would also
> have to force git's hand before it would rewrite their history.

Same here.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOAPm0F+nu1YWqI0RAhkdAJ9InxuEjbToGQU2AOJmfZw124Lb2wCeMmDC
9w08eZbmL19FfVQmtpPcYkQ=
=AmGo
-----END PGP SIGNATURE-----

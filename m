From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 10:58:48 -0400
Message-ID: <453792A8.1010700@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>	<45357411.20500@utoronto.ca>	<200610180246.18758.jnareb@gmail.com>	<45357CC3.4040507@utoronto.ca>	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 16:59:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaZMI-0005Cj-Km
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 16:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946106AbWJSO6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 10:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946107AbWJSO6z
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 10:58:55 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:10475 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1946106AbWJSO6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 10:58:54 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GaZMA-0007nO-00; Thu, 19 Oct 2006 10:58:50 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87lkncev90.wl%cworth@cworth.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29355>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Carl Worth wrote:
> On Wed, 18 Oct 2006 23:10:11 -0400, Aaron Bentley wrote:
> But think about your favorite example of an unhealthy social situation
> around a software project and a big, nasty fork. Every example I can
> think of involves some technical distinction that makes one branch
> more special than another.
>
> Now, those situations also involve social problems, and those are even
> more significant. But the technical blessing of one branch does not
> help. And I think it contributes to the social problems in many cases.

I'm not as familiar with those details.  The one fork that I know a lot
about, when Baz (the old Bazaar architecture) forked off from Arch,
showed me that for each developer branch, one branch must be special.

This is just because it is hard to maintain a branch that applies
cleanly to two diverging codebases.  So each developer must develop
against the fork that they want to merge their code into.  If they want
their code to be applied to the other fork, someone must port it.

So I really do feel that special branches are inescapable.

With bzr, you have the freedom to choose which branch you consider
special, and change your mind at any time.  There are no technical
limitations in that regard.

> As far as the revision numbers, my impression is that the numbers
> would be confusing or worthless if I were to use bzr the way I'm
> currently using git, as they certainly could not remain stable.

They would remain stable if you only used pull to update your origin
branch, and used merge+commit to update your development branch.

>> In bzr development, it's very rare for anyone's revision numbers to change.
> 
> Which just says to me that the bzr developers really are sticking to a
> centralized model.

I don't see why you're reaching that conclusion.  I'd like to understand
that better, because Linus seems to be concluding the same thing, and it
doesn't make sense to me.

>> I think you're implying that on a technical level, bzr doesn't support
>> this.  But it does.  Every published repository has unique identifiers
>> for every revision on its mainline, and it's exceedingly uncommon for
>> these to change.
> 
> Every argument you make for the number change being uncommon just
> strengthens the argument that it will be all that more
> confusing/frustrating when the numbers do change.

That doesn't follow.  Just because something is arguably true doesn't
make it bad.  And in this case, I'm not arguing that it's true, I'm
saying that it's true, because that is what my experience tells me is true.

> In cairo, for example, we've made a habit of including a revision
> identifier in our bug tracking system for every commit that resolves a
> bug.

We do it the other way around: we put a bug number in the commit
message.  And I personally have been developing a bugtracker that is
distributed in the same way bzr is; it stores bug data in the source
tree of a project, so that bug activities follow branches around.

> I like having the assurance that those numbers will survive
> forever. And it doesn't matter if the repository moves, or the project
> is forked, or anything else. Those numbers cannot change.
> 
> I understand that bzr also has unique identifiers, but it sounds like
> the tools try to hide them, and people aren't in the habit of using
> them for things like this. Do bzr developers put revision numbers in
> their bug trackers? Is there a guarantee they will always be valid?

Yes, we put revnos in our bug trackers.  No, we can't prove that they
will always be valid.  But there are significant disincentives to
changing them, so I am quite comfortable assuming they will not change.
 And the older a revno gets, the less likely it is to change.

On the other hand, I think your revision identifiers are not as
permanent as you think.

In the first place, it seems fairly common in the Git community to
rebase.  This process throws away old revisions and creates new
revisions that are morally equivalent[1].  I don't know whether Git
fetches unreferenced revisions, but bzr's policy is to fetch only
revisions referenced in the ancestry DAG of the branch.

In the second place, one must consider the "nuclear launch codes"
scenario.  In this scenario, someone has committed the codes necessary
to begin a nuclear attack into their branch.  This is an unlikely event,
of course, but nuclear launch codes are an extreme example of data that
absolutely, positively must be completely expunged from the branch.
Other examples include proprietary code (e.g. if SCO wasn't a bunch of
charlatans), passwords and obscene or libelous statements.

In a nuclear codes scenario, the revision that introduced the nuclear
launch codes and all its descendants must be expunged from the
repository.  You may, perhaps, rebase in order to retain the shape of
the history, but the revision-ids that you have recorded will be gone.

Aaron

[1] This is a process that I find discomforting, because I consider the
original revisions to be real, historical data, and I don't like the
idea of throwing it away.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFN5F70F+nu1YWqI0RAhrsAJ9rcqNGv28134eTvbGoxxteOxif3wCfTbaq
fpD0HNeGgdlMwuJldyzUxRM=
=9k8r
-----END PGP SIGNATURE-----

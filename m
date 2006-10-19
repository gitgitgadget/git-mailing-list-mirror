From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 23:10:11 -0400
Message-ID: <4536EC93.9050305@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 05:10:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaOId-00013U-Tz
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 05:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423228AbWJSDKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 23:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWJSDKZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 23:10:25 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:56031 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1030294AbWJSDKY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 23:10:24 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GaOIQ-0007JF-00; Wed, 18 Oct 2006 23:10:15 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29316>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> For example, what happens is that:
>  - you like the simple revision numbers
>  - that in turn means that you can never allow a mainline-merge to be done 
>    by anybody else than the main maintainer

That's not true of bzr development.  The "main maintainer" that runs the
bzr.dev is an email bot.  It's not an integrator-- its work is purely
mechanical.  It can't resolve merge conflicts.

Most of the merge work is done in integration branches run by the core
developers.  Although Martin is our project leader, lays out ground
rules, and makes design decisions, he doesn't have to be involved in any
particular merge.

> The "main trunk matters" mentality (which has deep roots in CVS - don't 
> get me wrong, I don't think you're the first one to do this) is 
> fundamentally antithetical to truly distributed system, because it 
> basically assumes that some maintainer is "more important" than others. 

Linus, if you got hit by a bus, it would still be a shock, and it would
still take time for the Linux world to recover.  Your insights and
talent, both technical and social, make you the most important kernel
developer.  And it stays that way because you deserve it.  Projects with
good leadership don't fork, or if they do, the fork withers and dies
pretty quickly.

It is fine to say all branches are equal from a technical perspective.
- From a social perspective, it's just not true.

The scale of Bazaar development is much smaller than the scale of kernel
development, so it doesn't make sense to maintain long-term divergent
branches like the mm tree.  We do occasionally have long-lived feature
branches, though.

> That special maintainer is the maintainer whose merge-trunk is followed, 
> and whose revision numbers don't change when they are merged back.

In bzr development, it's very rare for anyone's revision numbers to change.

> That may even be _true_ in many cases. But please do realize that it's a 
> real issue, and that it has real impact - it does two things:
> 
>  - it impacts the technology and workflow directly itself: "pull" and 
>    "merge" are different: a central maintainer would tend to do a "merge", 
>    and one more in the outskirts would tend to do more of a "pull", 
>    expecting his work to then be merged back to the "trunk" at some later 
>    point)

AFAIK, everyone who maintains long-lived branches in bzr uses "merge".

>  - it will result in _psychological_ damage, in the sense that there's 
>    always one group that is the "trunk" group, and while you can pass the 
>    baton around (like the perl people do), it's always clear who sits 
>    centrally.

As I mentioned earlier, there are four people who each run their own
integration branches and make decisions about what gets merged.  No baton.

> 
> Maybe this is fine. It's certainly how most projects tend to work. 
> 
> I'll just point out that one of my design goals for git was to make every 
> single repository 100% equal. That means that there MUST NOT be a "trunk", 
> or a special line of development. There is no "vendor branch".

I think you're implying that on a technical level, bzr doesn't support
this.  But it does.  Every published repository has unique identifiers
for every revision on its mainline, and it's exceedingly uncommon for
these to change.  There are special procedures to maintain bzr.dev, but
there's nothing technically unique about it.  People develop against
bzr.dev rather than my integration branch, because they have
non-technical reasons for wanting their changes to be merged into
bzr.dev, not my integration branch.

> It's 
> something that a lot of people on the git lists understand now, but it 
> took a while for it to sink in - people used to believe that the "first 
> parent" of a merge was somehow special, and I had to point out several 
> times on the git list that no, that's not how it works - because the merge 
> might have been done by somebody _else_ than the person who you think of 
> as being "on the trunk".

On an actively-developed bzr branch, the first parent *is* special:
- - it's a revision that you committed
- - the diff between a revision and its first parent is the same as the
  diff that would be produced just before it was committed.

> So when I say that your "simple" revision numbers are totally broken and 
> horrible, I say that not because I think a number like "1.45.3.17" is 
> ugly, but because I think that the deeper _implications_ of using a number 
> like that is ugly. It implies one of two things:
> 
>  - the numbers change all the time as things get merged both ways
> 
> OR
> 
>  - people try to maintain a "trunk" mentality

I don't think your analysis holds together completely, because all
actively-maintained branches have very stable revnos that anyone can
refer to.

> In git, the fact that everybody is on an equal footing is something that I 
> think is really good. For example, when I was away for effectively three 
> weeks during August, all the git-level merging for the kernel was done by 
> Greg KH.
> 
> And realize that he didn't use "my tree". No baton was passed. I emailed 
> with him (and some others) before-hand, so that everybody knew that I 
> expected to be just pull from Greg when I came back, but it was _his_ tree 
> that he merged in, and he just worked the same way I did.
>
> And when I did come back, I did a "pull" from his tree.

That sounds to me like a baton was passed.  You asked Greg to behave
like you, and told everyone else to expect that, too.  Passing the baton
was a social, not technical event, but it did happen.  And there would
certainly be no difficulty doing exactly that (right down to running
"pull") in Bazaar land.

In fact, we are currently rotating release managers.  The 0.10 and 0.11
releases were done by Robert, and the upcoming 0.12 is being managed by
John.  Neither of them is the project leader.  They threaten that they
want me to manage a release, too.  We shall see...

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNuyT0F+nu1YWqI0RAjxSAJ9YulgRMmIuy9RS1xrrYnKl9x2arQCaAr5/
u56sojZb6jhKl3fMQ/ZxLf4=
=EYC+
-----END PGP SIGNATURE-----

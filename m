From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 21:06:40 -0400
Message-ID: <45382120.9060702@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>	<45357411.20500@utoronto.ca>	<200610180246.18758.jnareb@gmail.com>	<45357CC3.4040507@utoronto.ca>	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<4536EC93.9050305@utoronto.ca>	<87lkncev90.wl%cworth@cworth.org>	<453792A8.1010700@utoronto.ca>	<878xjc2qeb.wl%cworth@cworth.org>	<453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 03:07:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gair4-0003J9-1w
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 03:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWJTBHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 21:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWJTBHR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 21:07:17 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:16777 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751643AbWJTBHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 21:07:16 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gaiqr-0007La-00; Thu, 19 Oct 2006 21:07:13 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87ods727pn.wl%cworth@cworth.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29397>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Carl Worth wrote:
> On Thu, 19 Oct 2006 19:01:58 -0400, Aaron Bentley wrote:

> Do you see how "maintain
> an independent URL namespace for every distributed branch" doesn't
> encourage much distributed development?

I understand your argument now.  It's nothing to do with numbers per se,
and all about per-branch namespaces.  Correct?

>>             Additionally, the new mainline can keep a mirror of the
>> abandoned mainline in its repository, because there are virtually no
>> additional storage requirements to doing so.
> 
> And this part I don't understand. I can understand the mainline
> storing the revisions, but I don't understand how it could make them
> accessible by the published revision numbers of the "abandoned"
> line. And that's the problem.

I meant that the active branch and a mirror of the abandoned branch
could be stored in the same repository, for ease of access.

Bazaar encourages you to stick lots and lots of branches in your
repository.  They don't even have to be related.  For example, my repo
contains branches of bzr, bzrtools, Meld, and BazaarInspect.

> It sounds like bzr has numbers like this inside it, (but not nearly as
> simple as the ones that git has), but that users aren't in the
> practice of communicating with them. Instead, users communicate with
> the unstable numbers. And that's a shame from an historical
> perspective.

I can see where you're coming from, but to me, the trade-off seems
worthwhile.  Because historical data gets less and less valuable the
older it gets.  By the time the URL for a branch goes dark, there's
unlikely to be any reason to refer to one of its revisions at all.

> The original claim that sparked the discussion was that bzr has a
> "simple namespace" while git does not. We've been talking for quite a
> while here, and I still don't fully understand how these numbers are
> generated or what I can expect to happen to the numbers associated
> with a given revision as that revision moves from one repository to
> another. It's really not a simple scheme.

When you create a new branch from scratch, the number starts at zero.
If you copy a branch, you copy its number, too.

Every time you commit, the number is incremented.  If you pull, your
numbers are adjusted to be identical to those of the branch you pulled from.

Is that really complicated?

> Meanwhile, I have been arguing that the "simple" revision numbers that
> bzr advertises have restrictions on their utility, (they can only be
> used with reference to a specific repository, or with reference to
> another that treats it as canonical). I _think_ I understand the
> numbers well enough to say that still.

Sure.  It's the "favors centralization" thing that I don't agree with,
but I now understand your argument.

> Compare that with the git names. The scheme really is easy to
> understand, (either the new user already understands cryptographic
> hashes, or else it's as easy as "a long string of digits that git
> assigns as the name").

In my experience, users who don't understand distributed systems don't
understand why UUIDS must be used as identifiers.

> The naming in git really is beautiful and beautifully simple.

Well, you've got to admit that those names are at least superficially ugly.

> It's not monotonically increasing from one revision to the next, but
> I've never found that to be an issue. Of course, we do still use our
> own "simple" names for versioning the releases and snapshots of
> software we manage with git, and that's where being able to easily
> determine "newer" or "older" by simple numerical examination is
> important. I've honestly never encountered a situation where I was
> handed two git sha1 sums and wished that I could do the same thing.

What's nice is being able see the revno 753 and knowing that "diff -r
752..753" will show the changes it introduced.  Checking the revo on a
branch mirror and knowing how out-of-date it is.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOCEf0F+nu1YWqI0RAhgtAJwK4jkWFjjF2iHJb1VyXqgszsHElACff2U7
olZJiAED80tIS6kgkqFsJps=
=BkRZ
-----END PGP SIGNATURE-----

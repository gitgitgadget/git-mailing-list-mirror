From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 21:00:51 -0400
Message-ID: <45357CC3.4040507@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 03:01:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzns-0007LR-IP
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWJRBBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWJRBA7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:00:59 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:52422 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751212AbWJRBA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 21:00:59 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZznh-0006RG-00; Tue, 17 Oct 2006 21:00:54 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610180246.18758.jnareb@gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29169>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Aaron Bentley wrote:
>> Linus Torvalds wrote:
>>> On Tue, 17 Oct 2006, Aaron Bentley wrote:
>>>>> Excuse me? What does that "throws away your local commit ordering" mean?
>>>> Say this is the ordering in branch A:
>>>>
>>>> a
>>>> |
>>>> b
>>>> |
>>>> c
>>>>
>>>> Say this is the ordering in branch B:
>>>>
>>>> a
>>>> |
>>>> b
>>>> |\
>>>> d c
>>>> |/
>>>> e
>>>>
>>>> When A pulls B, it gets the same ordering as B has.  If B did not have e
>>>> and c, the pull would fail.
>>> Sure. But that doesn't throw away any local commit ordering. The original
>>> order (a->b->c) is still very much there.
>> After the pull, it's no longer the mainline ordering for the branch.  c
>> is represented a revision that was merged into the branch, while d is
>> represented as a commit on the mainline of the branch.
> 
> Well, that is another example while generation number is/can be global,
> any numbering of branches must be local-only.

No.  The numbering always follows the leftmost parent.  So each revision
has a permanent (but non-unique) number.

> That doesn't matter...

It has significant UI impact.

>> and the revision numbers can change.
> 
> ...but that means that revision numers are totally, absolutely useless.
> Unless by some miracle of engineering, or adding namespace, they can be
> made unchangeable.

No, because no one pulls unless they're trying to maintain a mirror of
the other branch, or else they decide to throw their local history away.

>> Nobody is forced to use your local view.
> 
> But if you record "fast-forward merge", you force all people pulling
> from your repository to have this purely local and without any significant
> information "I have fetched then" marker.

Even if I agreed that the revision was meaningless, the cost of such a
revision is miniscule.

>>> In other words, the empty merge is totally semantically empty even in the
>>> bazaar world. Why does it exist?
>> It exists because it is useful.  Because it makes the behavior of bzr
>> merge uniform.  Because in some workflows, commits show that a person
>> has signed off on a change.
> 
> Signing off the fact of fetching changes? For true merge you are signing
> off the fact that there were no conflicts, or you sign off your conflict
> resolution.

You sign off on the contents of the revision you fetched.  You say "I
have reviewed this revision, and approved it."

>> It's not something special-- it's just another commit, like regular
>> commits, and merge commits.  It would be harder to forbid than it is to
>> permit.
> 
> Actualy the check is very easy.

Agreed.  It's just that not checking is easier still.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNXzD0F+nu1YWqI0RAiGvAJsEbPNNlqZ7QCH7EE39YABqEm/BtwCaAxIo
NHqG4NVZpvymTUlCLYyCqKM=
=YUdC
-----END PGP SIGNATURE-----

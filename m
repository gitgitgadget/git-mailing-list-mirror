From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 00:45:17 +0200
Message-ID: <20090424224517.GA10155@atjola.homenet>
References: <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net> <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com> <20090424181539.GB11360@coredump.intra.peff.net> <0FC64949-689C-43A4-B656-9618E808962B@boostpro.com> <20090424202403.GB13561@coredump.intra.peff.net> <2B5084A3-9BDB-4463-8530-3C8AB2E09A1F@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUAj-00005R-8K
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 00:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbZDXWpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 18:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbZDXWpb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 18:45:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:54474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752969AbZDXWpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 18:45:31 -0400
Received: (qmail invoked by alias); 24 Apr 2009 22:45:28 -0000
Received: from i59F5B10E.versanet.de (EHLO atjola.local) [89.245.177.14]
  by mail.gmx.net (mp020) with SMTP; 25 Apr 2009 00:45:28 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/2n2kChwL2lysIV5xbAWmmGom+FEYKxXz4cnb+WY
	7hAoXOQajv2ynk
Content-Disposition: inline
In-Reply-To: <2B5084A3-9BDB-4463-8530-3C8AB2E09A1F@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117507>

On 2009.04.24 17:06:27 -0400, David Abrahams wrote:
> On Apr 24, 2009, at 4:24 PM, Jeff King wrote:
>> On Fri, Apr 24, 2009 at 03:00:19PM -0400, David Abrahams wrote:
>>> It would even help a lot if the plumbing were all spelled "git-xxx"
>>> and the high level stuff were "git xxx."
>>
>> Differentating calling conventions like that was proposed when dashe=
d
>> forms were deprecated and removed from the PATH. But if we had dashe=
d
>> forms for plumbing (i.e., not forwarding them via the "git" wrapper)=
,
>> then you have to do one of:
>>
>>  - put them in the user's PATH. Now tab completion or looking in you=
r
>>    PATH means you see _just_ the plumbing commands, and none of the
>>    high level ones. Which is one of the reasons they were removed
>>    from the PATH in the first place (due to numerous user
>>    complaints).
>>
>>  - put them elsewhere, and force plumbing users to add $GIT_EXEC_PAT=
H
>>    to their PATH. That becomes very annoying for casual plumbing
>>    users. If you come to the mailing list with a problem, I would
>>    have to jump through extra hoops to ask you to show me the output
>>    of "git ls-files".
>
> I see your point.
>
>   llgit xxx
>
> ?

If that was the exclusive way of calling the low-level commands, that
would still break existing scripts. And if you keep e.g. "git
write-tree" and just add "llgit write-tree" as an alias, that will IMHO
just cause more confusion once old and new git users meet. And I agree
with Peff, it's not important whether it's "git foo", "llgit foo", "git
lowlevel foo" or something else. It's just about how much your users
really _need_ to know and how you tell them to use the stuff.

> I think UI/API works way better than porcelain/plumbing. We are, afte=
r
> all, programmers.

We are programmers, but not all git users are programmers.

> It would also be good to link to a definition any time you use a term
> of art in the docs. I would even do that in the case of UI/API since
> the distinction could appear to be subtle.
>
> I should also say, most of the docs and interfaces I see in Git (and
> its wrappers, web interfaces, etc.) give the SHA1 hashes way too much
> exposure. The times when it's actually more convenient to use a hash
> instead of one of the other notations are rare,

How often do you need a name for a commit shown by a command and can
accept that it is not stable? I usually need a name because I
want to reference that commit later on, either because I need to talk t=
o
other users, or because I'm working on something and might need to look
at that commit now and then, regardless on my current state of things.
One big exception in my workflow is when I use "git blame", then I
usually just need the name once to look at the full commit. But then I
prefer a 7-8 characters long sha-1 prefix to something like
improve_foo_speed~132^12~1^3. And "pseudo-stable" numbers have been
discussed to death.

> and if hashes weren't so exposed I bet most interfaces would make
> those other names more available. One reason I think hashes retain
> their prominent exposure is that you have no other reasonably stable
> way of referring to commits, since branch~NN counts backward from
> HEAD. Adding such a thing would help.

It counts backwards from "branch".

> Oh, one other specific issue: the rev-parse manpage uses $GIT_DIR
> without saying what it is. I *think* that means the root of the
> working copy and has nothing to do with environment variables, but
> it's hard to be sure, and if I'm right about that, it's misleading
> notation.

$GIT_DIR means the .git directory of a non-bare repo.

Bj=F6rn

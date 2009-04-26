From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [doc] User Manual Suggestion
Date: Mon, 27 Apr 2009 01:35:39 +0200
Message-ID: <20090426233539.GC12338@atjola.homenet>
References: <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net> <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com> <20090424181539.GB11360@coredump.intra.peff.net> <0FC64949-689C-43A4-B656-9618E808962B@boostpro.com> <20090424202403.GB13561@coredump.intra.peff.net> <2B5084A3-9BDB-4463-8530-3C8AB2E09A1F@boostpro.com> <20090424224517.GA10155@atjola.homenet> <78D97574-74AB-4A4D-AEB2-874BFBB4345E@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyDzW-0003tn-1H
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 01:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbZDZXfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 19:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZDZXfy
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 19:35:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:38480 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752515AbZDZXfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 19:35:54 -0400
Received: (qmail invoked by alias); 26 Apr 2009 23:35:51 -0000
Received: from i59F5A916.versanet.de (EHLO atjola.local) [89.245.169.22]
  by mail.gmx.net (mp057) with SMTP; 27 Apr 2009 01:35:51 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19OnXZa4p5Obc5sMNb93k89cfmXOyzWNPBp/41rbi
	3jz42Tuz+qSSQJ
Content-Disposition: inline
In-Reply-To: <78D97574-74AB-4A4D-AEB2-874BFBB4345E@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117608>

On 2009.04.24 20:39:12 -0400, David Abrahams wrote:
>
> On Apr 24, 2009, at 6:45 PM, Bj=F6rn Steinbrink wrote:
>
>>> I think UI/API works way better than porcelain/plumbing. We are,
>>> after all, programmers.
>>
>> We are programmers, but not all git users are programmers.
>
> I'm sure you will admit that the vast majority are programmers.  This=
 is=20
> about speaking effectively to your primary audience.

My experience says to at least drop the "vast", but that might be
biased, due to the fact that the non-programmers probably need more tim=
e
when you explain things to them.

But thinking about it again, I don't think I like UI/API regardless of
that. High-Level/Low-Level yes, but API? No. The plumbing is meant to b=
e
stable so it can serve as an API, and it also has options that only mak=
e
sense when you use it that way (e.g. the parse-opt support in rev-parse=
)
but I also happen to just use those programs as a UI. For example
ls-files, ls-remote, or apply.

And git(1) also has the sections titled "HIGH-LEVEL COMMANDS
(PORCELAIN)" and "LOW_LEVEL COMMANDS (PLUMBING)". So if we were to get
rid of the porcelain and plumbing terms, then _I_ would go for just
"high-level commands" and "low-level commands".

>>> I should also say, most of the docs and interfaces I see in Git (an=
d
>>> its wrappers, web interfaces, etc.) give the SHA1 hashes way too mu=
ch
>>> exposure. The times when it's actually more convenient to use a has=
h
>>> instead of one of the other notations are rare,
>>
>> How often do you need a name for a commit shown by a command and can
>> accept that it is not stable?
>
> I can accept it as long as it's stable inside my own repo.  Maybe I
> need the SHA1 to talk about it wherever it may roam.  I think you
> could count in the other direction (i.e. from the roots instead of th=
e
> leaves) to get fairly stable symbolic names.

I'm sure this has been discussed in the earlier "stable revision
numbers" threads as well, so you can find more information there, but I
just want to mention that one drawback of this is that those numbers
still have no notion of "commit age". You could have 5000 commits in
your repo, and then you fetch someone elses stuff that might have some
very old stuff that you don't have yet. And that gets high numbers now.
So 5051 might be older than 200. Doesn't exactly help to make those
numbers "useful". Just like the "gaps" you get by using e.g. rebase -i
or other means that cause commits to be garbage collected.

> Also, I don't think I need to see the hashes for trees and blobs most=
 of=20
> the time.

OK, I think finally see what you might mean there. I'm almost
exclusively using the CLI and gitk and seldomly see tree/blob object
names in a prominent way unless I ask for them. But I just noticed that
gitweb is at least showing a "daunting" number of object names without
further details when you ask for a "commit", while the "commitdiff" is
closer to what "git show <commit>" would show. And yeah, I think that
could be improved, moving the object name more into the "background" (I
don't think it should be completely removed, just be less prominent).
Any other "high-level" tool that you noticed being noisy about tree/blo=
b
hashes?

>>> Oh, one other specific issue: the rev-parse manpage uses $GIT_DIR
>>> without saying what it is. I *think* that means the root of the
>>> working copy and has nothing to do with environment variables, but
>>> it's hard to be sure, and if I'm right about that, it's misleading
>>> notation.
>>
>> $GIT_DIR means the .git directory of a non-bare repo.
>
>
> Thanks for clarifying.  But don't neglect to fix the docs so the next
> guy doesn't have to ask ;-)

Hm, I provide the information, you provide the patch? ;-) Hm, maybe I'l=
l
find some time to provide one myself. But my git and general todo lists
already grew beyond all limits...

> BTW, "[non-]bare repo" is yet another Git-specific jargon.  I know wh=
at=20
> it means... again, only because I asked someone.

At least "bare repository" appears as an entry in the glossary
(gitglossary(7), also reachable via "git help glossary").

Bj=F6rn

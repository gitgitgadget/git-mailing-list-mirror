From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 11:12:07 -0700
Message-ID: <47125BF7.2070503@midwinter.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>	 <Pine.LNX.4.64.0710130130380.25221@racer.site>	 <853awepyz6.fsf@lola.goethe.zz> <20071013202713.GA2467@fieldses.org>	 <Pine.LNX.4.64.0710140135020.25221@racer.site>	 <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org>	 <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih7wr-0001JT-S8
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbXJNSMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 14:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbXJNSMM
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:12:12 -0400
Received: from tater.midwinter.com ([216.32.86.90]:47172 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752543AbXJNSMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:12:10 -0400
Received: (qmail 10744 invoked from network); 14 Oct 2007 18:12:10 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=TpvauB//h+tsssZDjnT5YiFYUSL1htqFHJLmHDBZSmnA9irpkUDLRo5i9viwoU1q  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 14 Oct 2007 18:12:10 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60888>

Reece Dunn wrote:
> The core plumbing in git is solid. The porcelain, with the 1.5 series=
,
> makes git simpler to use from the command line. Now, the GUI availabl=
e
> for git is seriously lacking.
>  =20

I'm not sure I agree with that. Here's the section on git from the=20
"Comparison with other systems" part of the Mercurial book. I'll=20
reproduce it in its entirety here and add my own comments about each=20
paragraph.

 > Git is a distributed revision control tool that was developed for=20
managing the
 > Linux kernel source tree. Like Mercurial, its early design was=20
somewhat influenced
 > by Monotone.

No argument there.

 > Git has an overwhelming command set, with version 1.5.0 providing 13=
9
 > individual commands. It has a reputation for being difficult to=20
learn. It does not have
 > a user manual, only documentation for individual commands.

The part about the user manual is bunk (and was bunk in version 1.5.0,=20
IIRC, so I'm not sure where he gets that.) But the first part of that i=
s=20
the key here. I admit that's even bitten me from time to time. I=20
couldn't remember the name of the "git-instaweb" command just yesterday=
;=20
doing "ls /usr/local/bin/git-*" was, I'd have to agree, pretty overwhel=
ming.

We could probably solve that by tucking the plumbing commands away in a=
=20
lib or libexec directory and only exposing the porcelain commands in th=
e=20
directory the end user is likely to look at.

But that's just an aspect of a more general fact: it's hard to use git=20
without getting exposed to the plumbing at least a little. Another=20
example is the manpages: try to look up the commonly-used options to=20
"git diff" (porcelain) and you will be forced to learn about "git=20
rev-parse" (plumbing).

The point is, though, that this is a valid complaint about git's UI tha=
t=20
has nothing to do with GUIs.

 > In terms of performance, git is extremely fast. There are several=20
common cases
 > in which it is faster than Mercurial, at least on Linux. However, it=
s=20
performance
 > on (and general support for) Windows is, at the time of writing, far=
=20
behind that of
 > Mercurial.

A fair statement, though of course that's been improving by leaps and=20
bounds of late and hopefully will soon be an outdated argument. The=20
Windows user experience has been subpar historically.

 > While a Mercurial repository needs no maintenance, a Git repository=20
requires frequent
 > manual =93repacks=94 of its metadata. Without these, performance=20
degrades, while space
 > usage grows rapidly. A server that contains many Git repositories=20
that are not rigorously
 > and frequently repacked will become heavily disk-bound during=20
backups, and there
 > have been instances of daily backups taking far longer than 24 hours=
=20
as a result.
 > A freshly packed Git repository is slightly smaller than a Mercurial=
=20
repository, but an
 > unpacked repository is several orders of magnitude larger.

This was true at the time the hg book was written. Now that we have the=
=20
auto-packing code, hopefully it will be a moot point. So that's one "fi=
x=20
the UI" complaint that has been addressed; whether *successfully* or=20
not, time will tell. But hg definitely had a user experience advantage=20
here until very recently.

 > The core of Git is written in C. Many Git commands are implemented a=
s=20
shell or Perl
 > scripts, and the quality of these scripts varies widely. I have=20
encountered a number of
 > instances where scripts charged along blindly in the presence of=20
errors that should have
 > been fatal.

No doubt this is true as well. Obviously the C-ification process will=20
take care of a lot of this, though of course one can charge along=20
blindly in the presence of errors in any language (including, shock of=20
shocks given the implication here, Python.) To the extent we can find=20
places where this is still true, obviously they should be fixed. I=20
wonder if anyone knows the author of the book well enough to ferret som=
e=20
specifics out of him toward that end.

Now, about hg vs. git in general. I actually spent some time this=20
weekend coming up to speed on hg basics just to see what all the UI fus=
s=20
was about. As far as I can see it is about a wash all told; some things=
=20
are easier in git and some in hg. However, here's my speculation about=20
why people might claim hg is easier. I see three things:

Multiple branches per repo. Mercurial allows them, but you won't find=20
them mentioned anywhere in any of the beginner tutorials. They encourag=
e=20
people to use a "one repo per branch" model. Having gotten used to git'=
s=20
branching model, you'd have to pry that feature out of my cold, dead=20
fingers, but it's fundamentally much easier to understand a model of "i=
f=20
you want to make two unrelated changes to your code, just make two=20
copies of the source tree." It's possible git's introductory=20
documentation should delay talking about "git branch" until later, and=20
start off talking about how to work with one (checked out) branch per r=
epo.

Update to a dirty working copy. I think there's a tendency in these=20
parts to vastly underestimate the importance of being able to pull down=
=20
updates from a master repository while you're in the middle of=20
development. Mercurial's equivalent to bare "git pull", namely "hg pull=
"=20
followed by "hg update", works fine if you have edits in your working=20
copy; if there are conflicting changes, it pops you into a conflict=20
resolution UI (or adds conflict markers, depending on your settings) an=
d=20
you continue on your merry way after resolving everything. This workflo=
w=20
is really common, especially in corporate settings where there's very=20
fine-grained collaboration going on during initial development (a huge=20
difference from the open-source world where most of the time it's just=20
one person doing an initial prototype.) Right now working this way is a=
=20
pain in git. Less so now that we have "git stash", but it could still b=
e=20
much, much smoother.

Verbosity. IMO Mercurial swings too far in this direction, but in=20
general it's either completely silent or very terse in its output. Ther=
e=20
is never, as far as I can see, any low-level diagnostic information spi=
t=20
out to the user unless an hg command is run with a "verbose" option.=20
Here's "hg pull; hg update", for example (and "pull" is one of hg's=20
chattier commands):

pulling from ../child1
searching for changes
adding changesets
adding manifests
adding file changes
added 8 changesets with 8 changes to 3 files (+1 heads)
(run 'hg heads' to see heads, 'hg merge' to merge)
3 files updated, 0 files merged, 0 files removed, 0 files unresolved

Compare with the equivalent "git pull" and put yourself in the shoes of=
=20
a user who is running that command for the first time:

remote: Generating pack...
remote: Counting objects: 9
remote: Done counting 1118 objects.
Result has 832 objects.
remote: Deltifying 822 objects...
remote: 100% (822/822) done
Indexing 832 objects...
remote: Total 832 (delta 668), reused 0 (delta 0)
100% (832/832) done
Resolving 668 deltas...
100% (668/668) done
258 objects were added to complete this thin pack.
* refs/remotes/origin/session-fix: fast forward to branch 'session-fix'=
=20
of ssh://devrs005/~/www
old..new: 3de27db..a3d44c1
Already up-to-date.

So anyway, there are a few specifics. That's based on just a bit of=20
playing around with hg; maybe the differences go deeper than this, but =
I=20
think there isn't a huge usability gap between the two systems any more=
=2E

-Steve

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:47:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610191258290.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <87lkncev90.wl%cworth@cworth.org> <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
 <20061019161319.GA75501@over-yonder.net> <Pine.LNX.4.64.0610190948540.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610191110290.3962@g5.osdl.org> <vpqlknc3zmn.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-2135423530-1161290873=:3962"
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 22:48:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaeoZ-0007Kt-Mp
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 22:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423254AbWJSUs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 16:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423228AbWJSUs2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 16:48:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423230AbWJSUs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 16:48:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9JKltaX027582
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 13:47:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9JKlrdg024324;
	Thu, 19 Oct 2006 13:47:53 -0700
To: Matthieu Moy <Matthieu.Moy@imag.fr>
In-Reply-To: <vpqlknc3zmn.fsf@ecrins.imag.fr>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29382>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-2135423530-1161290873=:3962
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 19 Oct 2006, Matthieu Moy wrote:
> 
> By curiosity, how would you compare git and Bitkeeper, on a purely
> technical basis? (not asking for a detailed comparison, but an "X is
> globaly/much/terribly/not better than Y" kind of statement ;-) )

I think git is better for kernel work these days, but a large portion of 
that is that a lot of the features have literally been tweaked for us (for 
very obvious reasons).

For example, the whole "rebase" thing (or explicitly making cherry-picking 
easy) is something that a number of kernel people do, and even if I have 
to admit to not liking the practice very much (it kind of hides the "true" 
development history), it does have huge advantages, and it makes history a 
lot easier to read.

Similarly, I often used the single-file graphical history viewing in BK 
("revtool"), but being able to follow the history of multiple files as one 
"entity" really is something that once you get used to, it's really really 
hard going back, and "gitk" does generate a much more readable graph.

And I think the git way of doing branches is just simply superior. Git 
always did branches in the sense that the way merges happened you _always_ 
had several heads, but actually making them available and switching 
between them was something that wasn't my idea, and that I even was a bit 
apprehensive about. I was wrong. Git branches are branches done right. I 
just don't see how you _could_ do them better.

That said, a lot of the features I like and _I_ consider really important 
are possibly not that important to others. For example, maybe nobody else 
really cares about viewing the history of a particular subsystem, the way 
I do. For a lot of people, single-file is probably ok. 

For example, while git now does "annotate" (or "blame"), it's not 
lightning fast, and I simply don't care. Doing a

	git blame kernel/sched.c

takes about three seconds for me, and that's on a pretty good machine (and 
on the kernel tree, which for me is always in the cache ;). Quite frankly, 
if I cared deeply about that kind of annotation, I'd probably be upset 
about it. There are basically _no_ other git operations that take that 
long. I can get the _full_ log of the last 18 months of the kernel much 
faster than that.

And the slowness of annotate comes directly from the design of git, and 
from the fact that it's not how I tend to look at changes. Rather than 
doing "git blame kernel/sched.c", I'm _much_ more likely to just do

	git log -p kernel/sched.c

and see the changes as individual patches instead (and perhaps search for 
some pattern that I'm looking for by just literally using a regex in the 
pager).

Also, the fact that you need to repack the archive every once in a while 
doesn't disturb me. I probably end up repacking the kernel almost daily, 
which is _waay_ excessive, but it's just become habit of mine. I've seen 
people who really don't like it, and I've also seen people who apparently 
never even realized that they should do an occasional "git repack -a -d", 
and then they have hundreds of thousands of loose objects and wonder why 
the performance is so bad ;)

BK never had these issues. BK always kept things "packed", which made a 
lot of operations much slower ("bk undo" was painfully slow). BK could 
annotate quickly, since it was really a file-based history, in a way that 
git fundamentally isn't, and can never be (and I don't _want_ it to be, 
but it means that "annotate" is slow).

And BK had some great tools. The merge tool was superior ("bk resolve"? I 
forget). The patch-application tool was great.

But both of those tools are things that git doesn't have, for _another_ 
reason: the way git works, you don't really need them. For example, the 
patch application tool was great, but the biggest reason it was needed in 
the first place was tracking renames explicitly.

In that kind of environment, you have serious problems with patches, and 
you actually _need_ a tool to let the user explain when something is a 
rename and when it isn't. With git not tracking renames, the patch 
application tool simply isn't needed.

The same goes to some degree to "bk resolve". Because git has the index, 
and you can _leave_ things unresolved in the index, you don't need a 
graphical tool to resolve things - git knows very fundamentally about 
incomplete merges _and_ about multiple branches (which you need in order 
to keep track of both the branch you merge from and the branch you merge 
into), and it's fine to resolve any conflicts in the normal working tree.

So for at least _my_ usage, git does everything very well, but that's 
because if it didn't fit me, I fixed it until it did. 

And "git bisect" really does rock. I still cannot believe that apparently 
nobody did it before us. It's such a useful thing, and it works so well in 
unambiguous cases (and not all cases are that unambiguous, but an 
appreciably large subset is).

So that said, git does work very well for us, but I do want to end on a 
note on thigns that BitKeeper did and nobody else has:

 - Larry was first. The undeniable fact is, that before BK (and for 
   several years _after_ BK), the open-source alternatives were just CRAP.

   You can say anything you like about his personality, but dammit, 
   compared to Larry, most people I know are idiots. People don't give BK 
   the credit it deserves. When Tridge "reverse-engineered" it, people 
   were making jokes about how trivial some of the protocols were. That 
   misses the point ENTIRELY. The point is, compared to BK, everything 
   else absolutely _sucked_, and BK really was a watershed program.

   Never EVER underestimate how important BK was. Quite frankly, I think 
   most open-source SCM's _still_ suck. I'm constantly amazed that anybody 
   would touch SVN with a ten-foot pole. Talk about crap. And SVN is at 
   least usable, unlike a lot of other projects.

 - When I did git, one of the things that actually _helped_ me was that I 
   was consciously trying to not do a BK clone. I wanted to do the same 
   things that BK did, but I very much did _not_ want to do them the _way_ 
   BK did them. I respect Larry too much, and I didn't want there to be 
   any question about git being just a "clone".

   So a lot of the git design ended up very much trying to avoid old 
   designs on purpose, and I think that really helped. The fact that I 
   didn't have a background in SCM's, and that I thought all the weaves 
   etc were confusing, meant that I instead went for a radically different 
   way of doing things.

   And I'm 100% convinced that "radically different" was the right thing 
   to do. That was what allowed git to really soar. A lot of the good 
   things in git come exactly from the fact that git does _not_ do things 
   like most traditional SCM's do. But BK should still get a lot of 
   credit, because it was what taught me (and a lot of other people) what 
   being "distributed" really meant.

 - On a more personal note: people say that BK showed the "failure" of 
   using a commercial closed-source program. I would disagree. Not only 
   did the kernel get a whole lot of useful work out of BK, we learnt how 
   distributed systems _should_ work, and quite frankly, I'd do ít all 
   over again in a heartbeat.

   If there was a "failure" in the BK saga, it was in how horrendously 
   _bad_ all open-source SCM's were, even with BK showing how it should 
   have been done for several years. THAT is the failure. The fact that 
   there were hundreds of people who whined about BK, and nobody really 
   did anything productive. 

Now, I'm obviously biased, but I really do believe that git is the best 
open-source SCM there is, by a _mile_. I don't know how many people 
realize this, but we literally haven't changed our data formats in over a 
year. I was looking at my old git import of the BKCVS tree today, because 
I wanted to look up the "BKrev" format for the email earlier in this tree, 
and I realized that the pack-file was from July of last year. That's 
within a few _weeks_ of the pack-file being introduced at all, and guess 
what? It all still worked. No "on-the-fly format conversion", no 
_nothing_. It just worked.

That should tell people something. It's pretty much the fastest SCM out 
there (and yeah, that's on almost any operation you can name), it still 
has the smallest disk footprint I've ever heard of, and it hasn't had the 
"format of the week" disease that every other project seems to go through.

And it's used in production settings on some of the biggest projects out 
there. SVN has more users, but let's face it, SVN really isn't even in the 
running. Technology-wise, the thing is just not worth bothering with, but 
it's a good crutch for people who are used to CVS and never want to use 
anything lse.

Am I happy with git? I'm happy as a clam. It turned out even better than I 
ever thought it would. And BK was what taught me what to aim for.

			Linus
--21872808-2135423530-1161290873=:3962--

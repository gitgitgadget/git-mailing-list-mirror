From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Tue, 1 May 2007 09:15:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705010829180.3808@woody.linux-foundation.org>
References: <200704300120.42576.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 18:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiv0z-0004Md-5e
	for gcvg-git@gmane.org; Tue, 01 May 2007 18:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbXEAQPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 12:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200AbXEAQPh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 12:15:37 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:46985 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754173AbXEAQPf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 12:15:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l41GFUen009444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 May 2007 09:15:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l41GFTj9000515;
	Tue, 1 May 2007 09:15:29 -0700
In-Reply-To: <200704300120.42576.jnareb@gmail.com>
X-Spam-Status: No, hits=-2.985 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45956>



On Mon, 30 Apr 2007, Jakub Narebski wrote:
> 
> Among others, author advocates using version control system as a basis 
> for running a project. In "Choosing a Version Contol System" he writes:
> 
>   As of this writing, the version control system of choice in the free
>   software world is the Concurrent Versions System or CVS.

Well, I actually personally suspect that the original Linux method of 
"patches + tar-balls" is a perfectly valid method of source control 
management, and in many ways preferable over CVS.

So no, I don't think using a version control system should be the _basis_ 
of running a project. Version control comes pretty far down the list, long 
long after "good taste" and "willingness to do things rather than talk 
about them", the latter of which tends to kill more hypothetical projects 
than even CVS has ever done.

The _basis_ of an open source project is a good manager, a good idea, and 
a realization that what matters most is _using_ the end result, rather 
than the idea or discussions or "cool features".

The SCM becomes relevant only once you are far enough along that tar-balls 
and patches really don't work, and that might well take years.

[ I'm really serious: I think a lot of the good practices that the kernel 
  project has gotten is exactly because of the "patches rule" mentality. 

  We now use real revision control, but I really *really* believe that 
  pushing patches around is a much better way of managing stuff than with 
  CVS or any other centralized model, because in the centralized model it 
  always ends up being about the "core team". In contrast, even if there 
  is a core team, if they just push patches around and discuss them as 
  such, non-core-team members are automatically basically all equal.

  And avoiding the politics, and avoiding the "five people are special" 
  mentality is a *lot* more important than the limited and broken tracking 
  capabilities that CVS brings to the table.

  So maybe I'm just in denial, but I really believe that the fact that the 
  kernel was basically maintained _without_ an SCM for a decade was 
  actually a *good* thing, considering the alternatives. ]

> Further on much of examples of managing project and managing volunteers 
> revolves around the idea of "commit access", and it is assumed 
> implicitely that version control system is centralized.

Karl Fogel is wrong. 

It's an understandable mistake to do, since commit access is so important 
in a centralized environment, and he probably has never used anything else 
(even decentralized SCM's are often _used_ as centralized ones), but he's 
still *wrong*. Fundamentally so:

> The distributed SCM is mentioned in footnote in section "Comitters" in 
> Chapter 8, Managing Volunteers:
> 
>  http://producingoss.com/producingoss.html#ftn.id284130
> 
>   [22] Note that the commit access means something a bit different in
>   decentralized version control systems, where anyone can set up a
>   repository that is linked into the project, and give themselves commit
>   access to that repository. Nevertheless, the concept of commit access
>   still applies: "commit access" is shorthand for "the right to make
>   changes to the code that will ship in the group's next release of the
>   software." In centralized version control systems, this means having
>   direct commit access; in decentralized ones, it means having one's
>   changes pulled into the main distribution by default. It is the same
>   idea either way; the mechanics by which it is realized are not
>   terribly important.

That's just making excuses. Yes, you can use the same words, and say that 
you call the two TOTALLY DIFFERENT things "commit access", and then, 
because you've made two totally different things use the same term, you 
claim that it's the same thing, and the differences aren't "terribly 
important".

It's like saying that a distributed (or threaded, for that matter) 
algorithm and a linear algorithm both result in the same result, so the 
"mechanics" of the algorithm are not terribly relevant: they're both 
algorithms.

Anybody who has ever done any distributed algorithms realizes that the 
mechanichs are *hugely* important.  The difference between a distributed 
situation and a centralized one is absolutely humongous. It changes 
literally everything.

Does the fact that you *can* run a distributed algorithm on one machine 
make it the same? No. Does the fact that the end result is called the same 
make the two the same? No. It's a totally different model, and they share 
almost none of the issues.

When it comes to "commit access", not only is the term nonsensical in a 
distributed environment, even if you want to use that term to describe the 
notion of "gets pulled into the next release", it's not even TRUE.

People like Andrew, Ingo, and Davem have what Karl would probably call 
"commit access". Andrew and Ingo have it even though they don't actually 
even use git to synchronize with me. But no, they don't actually get 
pulled into the next release by default _anyway_ - there's always a 
conscious choice after the fact, rather than any implicit permission.

I quite often tell maintainers that I won't pull their stuff, simply 
because the changes look too scary, and I'm too close to a release. Yes, 
it happens less often than me just silently pulling it, but that's not a 
sign of "commit access", that's a sign of the fact that the process 
_works_ in the first place. If we spent all our time arguing about it, and 
people didn't just "know" how to behave, we'd never get anything done.

So that "get pulled by default" has _nothing_ to do with commit access, 
and everything to do with much higher-level process issues. And it's 
something that distributed development makes _possible_ in a way that the 
centralized model with "commit access" simply does not.

Miles and miles apart. And a very important distinction.

(Btw, I'll argue that it's really important inside companies too, even 
when the source control in question is "controlled". When you do things 
like validation, you shouldn't just allow "commit access" to the tree to 
be validated. The validation group should maintain a tree that *they* 
control, and getting things accepted into their tree should be just one 
step on a "release schedule")

> Linus has said that fully distributed SCM improves forkability:

Yes. There's two issues to forkability:

 - all real development happens as "micro-forks", and so you should make 
   that easy, whether it's an "inside" developer or somebody else who just 
   has a wild and crazy idea that might just work.

 - all real _honesty_ comes from a belief that the code *can* be forked, 
   and that even the original developer and/or top maintainer cannot force 
   his world-view on anybody.

Both of these are important, but the latter is important not because it 
should be the "normal case", but just because the _knowledge_ that a fork 
can happen should keep people honest.

Big forks due to fundmanetal personality clashes (they are sometimes 
about technology, but even when they are ostensibly about technology 
issues, they are often very much about strong personal ideas about that 
technology) are painful. But they should be painful not because of the SCM 
in question, but simply because handling personality issues is inherently 
painful.

The SCM shouldn't allow people to be a*-holes and control freaks.

And I think Karl Fogel agrees with me on that. When he says 

   .. the more serious the threat of a fork becomes, the more willing 
   people are to compromise to avoid it.

he's right on the money, and I _think_ he meant it in the good way 
(compromise and trying to work with people is absolutely a _must_).

> Besides that, what are the differences between managing project using 
> centralized SCM and one using distributed SCM? What is equivalent of 
> committers, giving full and partial commit access, revoking commit 
> access?

So here's what happens for the kernel:

 - we simply don't *have* commit access

 - there's no "partial", and there's not "revoking"

 - there are people I trust, but I don't trust them implicitly in the 
   sense that I give them the keys to my repository. If they go crazy, 
   there's nothing to revoke. NOTHING. If they go crazy, I just don't pull 
   from them. It's really rhat easy!

 - there are people I trust in certain areas, but that doesn't mean that 
   they can't make changes everywhere. It just means that I won't pull 
   unless I see that the changes are only to those areas.

   And again, it's not an "up-front" decision: when people ask me to pull, 
   they tell me (by way of a diffstat) what they changed, and I can - and 
   actually do this, although mostly because it avoids mistakes - verify 
   it, because the pull always tells me what got changed.

 - In fact, what happens occasionally is that I pull something, and tell 
   people "nope, that won't do" and just discard their changes. It doesn't 
   happen every day, but it happened yesterday - David Miller (who is one 
   of the top developers) sent me a fix, I fetched it and told him it was 
   incomplete and I wouldn't pull until it was fixed.

Notice? No partial commit access, no revoking, no granting. No politics. 
No up-front "you have rights". Just a very basic issue: trust.

And the nice thing about this is that if some subsystem needs to make 
trivial changes to another subsystem, they don't need to ask for 
permission. They just do them, AND THEN THEY EXPLAIN THEM! And if they 
really were trivial and obvious (and that's almost always the case), they 
just get pulled normally. No special dispensation.

This is somethign that a centralized repository with commit access 
fundamentally *cannot* do! If a maintainer who has partial commit access 
needs to fix something else in order to make his subtree work, he's 
basically screwed. He cannot commit his changes to *his* area, just 
because they depend on a fix to another persons area, and he cannot commit 
that.

Centralized SCM's are *fundamentally* broken. And the whole "commit 
access" is very much part of that breakage. A distributed system doesn't 
have it, doesn't need it, and is much much better off without it!

This is why I said Karl was totally off when he said that there's an 
equivalent to "commit access" in a distributed system too. It's just not 
true. Everything that people use "commit access" for just entirely goes 
away!

> How good support for tagging and branching influences creating 
> code and build procedure? Is distributed SCM better geared towards 
> "benovolent dictator" model than "consensus-based democracy" model, as 
> described in OSSbook?

I think branching is so fundamnetal to being distributed, that asking 
whether good support for something like that is important for build 
procedure is just not a valid question. It's like asking "How important is 
water to your social life?" It's supremely important in the sense that 
without water, you wouldn't have a social life, but that's because you 
wouldn't _exist_ in the first place. But does that make water _directly_ 
important to your social life? Probably not, unless your life revolves 
around playing water polo with your buddies.

Same goes for the benevolent dictator vs consensus-based model. I think 
the distributed setup has advantages for both, and the advantages are much 
more fundamental than anything direct. You can use distributed for either 
model, and in both cases, the tools a distributed system gives you are 
just different (and much better). 

			Linus

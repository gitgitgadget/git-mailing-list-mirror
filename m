From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 13:19:10 +0200
Message-ID: <45360DAE.8000702@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <4535E844.8010604@op5.se> <20061018103220.GS75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 13:19:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga9SC-0005On-5U
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 13:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWJRLTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 07:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWJRLTR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 07:19:17 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:189 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1030229AbWJRLTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 07:19:16 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 6EDB36BD8A; Wed, 18 Oct 2006 13:19:14 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E9C766BD54; Wed, 18 Oct 2006 13:19:10 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061018103220.GS75501@over-yonder.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29225>

Matthew D. Fuller wrote:
> On Wed, Oct 18, 2006 at 10:39:32AM +0200 I heard the voice of
> Andreas Ericsson, and lo! it spake thus:
>> So in essence, the revnos work wonderfully so long as there is a
>> central server to make them immutable?
> 
> 
> With a star config, revnos are useful locally and with reference to
> the "main" branch[es].  And, most of the world is star configs of one
> sort or another.  Actually, one might say that practically ALL the
> world outside of linux-kernel is star-configs   ;)
> 

That might be the case today. However, since we introduced git at the 
office, mini-projects are cropping up like mad, and pieces of toy-code 
are being pushed around among the employees. When something is found to 
be useful enough to attract management attention, it's given a spot at 
the "master site". It doesn't need one. It's just that we have this one 
place where gitweb is installed, which management likes whereas devs 
don't have that on their laptop. It's also convenient to have one place 
to find all changes rather than pulling from 1-to-N different people 
just to have a look at what they've done.

The point I'm trying to make here is that the star config might be the 
most common case today because
a) old scm's enforced this use case and it is therefor the most common 
way just out of habit.
b) projects you actually *see* have gotten past the "Joe made some cool 
changes, pull his 'jukebox-ui' branch".


> In many cases in the star setup, a revno (particularly along the
> 'trunk') is more directly useful than a UUID; consider particularly
> the case of somebody who's just mirroring/following, not actively
> developing.  In some cases, the UUID is more useful.  Certainly, using
> a revno in a case where the UUID is more appropriate is Bad, but
> that's just a matter of using the right tool.
> 

I can easily imagine the use case Linus pointed out with BK. Because 
revnos work wonderfully 80% of the time, people get confused, frustrated 
and downright pissed off when they don't.

> 
> With a uber-distributed full-mesh setup, revnos may be basically
> useless for anything except local lookups (which boils down to
> "useless for most anything you'd identify a revision for").  For that
> case, you'd practically always use the UUID, and pretend revnos don't
> exist.
> 

But they *do* exist, and they *usually* work, so people are bound to try 
them first. Teaching them when they work and when they don't (or rather, 
when they should and when they shouldn't, cause they will work by 
accident sometimes too) is bound to be a lot harder than sending them a 
10 char irc message.

> 
> The merge revno forms (123.5.2.17 and the like), I'm somewhat
> ambivalent about in many ways.  But, you don't have to use them any
> more than you have to use "top-level" revnos.  If either form of revno
> is Wrong for your case (whether it be because "I hate numbers
> wholesale", or because "Numbers don't cover this case usefully"), then
> you just use the UUID and pretend the number isn't there.  If you
> wanted them completely out of sight, I wouldn't expect it to be very
> hard to talk bzr into never showing the revnos and just showing the
> UUID ("revid").
> 

So what's the point in having them? You can't seriously tell me that you 
think of 123.5.2.17 as something you can easily remember, do you? Count 
the times, during one day, where you use the revnos and type them manually.

> 
> 
> [ I don't speak for bzr, despite the fact that I'm about to appear to ]
> 
>>From where I sit, revnos are quite useful in the first 1.5 or 2 cases.
> Some would argue that they're not useless in the third case as well,
> but that's no necessary point to hash out; it certainly does no
> technical harm to have them there, since you can just ignore them if
> they don't help you.  I think a good case could be made that the vast
> majority of VCS use in the world is a form of case 2.
> 
> Git comes out of a world where case 3 is All, and the other cases are,
> if not actively ignored, at least far secondary considerations, so it
> can hardly be surprising that it doesn't have or want something that
> adds practically nothing to its case.
> 

Not really. It's just that case 3 is the most flexible of them all. It's 
trivial to enforce linear development in git. Just add a hook that 
forbids merge commits. Set up a "master repo" and put the hook there and 
you've turned it into CVS with off-line log-browsing (more or less).

Set up a master-server and enable the reflog there and you've turned it 
into bazaar, more or less.

In git, the mothership repo is there for conveniance, because it's nice 
to have one place to set up mailing-list hooks, gitweb, git-daemon and 
the likes. Everything works *exactly* as it would have done without it 
in all repos around the world.


> bzr, both in its own development schema, and in the expected audience,
> is overwhelmingly case 2 (of which case 1 is really just a degenerate
> version), but that doesn't mean case 3 is ignored or impossible.  The
> UUID's are there for when you need them, and can be used anywhere you
> might use a number, and just as easily.  It's a community convention
> to organize development in such a way that the number is "usually"
> useful, and when it is, it's certainly easier.  That doesn't mean you
> HAVE to use it in cases where it doesn't fit, though.  "bzr people
> like to avoid using UUID's" doesn't lead to "bzr can't handle the
> cases where UUID's are necessary".
> 

Have a look at the list of things that CVS "can handle" and compare it 
mentally to the things CVS "handles gracefully" and you'll see why 
people have stopped using it.

> 
>> Doesn't this mean that one of your key features doesn't actually
>> work in a completely distributed setup
> 
> That's one way of phrasing it, I guess.  I'd say rather "a particular
> feature isn't applicable to a completely distributed setup".

So how come it's in the same list of features as the "distributed 
repository model", and both are marked as supported when they're 
apparently mutually exclusive?


>  I'm sure
> git has a lot of features that are key for somebody that "don't work"
> for someone else, just because they're doing something that person
> doesn't want done.

The main point, the *important* point about git is that everything it 
shows always makes sense and works in exactly the same way no matter 
which setup you use. There are no features in git that are mutually 
exclusive, or only sane in one particular setup but not in others. You 
can use them all or pick which ones you like. Whatever you choose, it 
never comes at the expense of losing something else.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

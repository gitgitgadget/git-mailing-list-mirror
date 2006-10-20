From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 12:31:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201214530.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca>
	<Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
	<45390BAF.5040405@utoronto.ca>
	<Pine.LNX.4.64.0610201100070.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610201110320.3962@g5.osdl.org>
	<45391DC3.7060002@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 21:32:16 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb05u-0004My-Ag
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 21:31:52 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gb05i-0001V8-KO; Fri, 20 Oct 2006 20:31:38 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1Gb05b-0001TL-By
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 20:31:32 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KJVMaX001763
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 12:31:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KJVHj3031513;
	Fri, 20 Oct 2006 12:31:19 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45391DC3.7060002@utoronto.ca>
X-Spam-Status: No, hits=-0.976 required=5 tests=AWL,
	OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29528>



On Fri, 20 Oct 2006, Aaron Bentley wrote:
> > 
> > Btw, this is a pet peeve of mine, and it is not at all restricted to 
> > the SCM world.
> 
> I guess I don't mind a bit of high-mmv discussion, so long as it doesn't
> get in the way of real work.  Polishing these kinds of things seems to
> fall in the category of 10% of functionality that takes 90% of effort.

Well, the thing is, that 10% of the functionality usually takes a whole 
lot _less_ than 10% of the work.

The stuff you can think through (and argue about) tends to be the easy 
stuff. Exactly because you _can_ think about it abstractly.

The stuff that is actually really hard and time-consuming is the stuff 
that you find out in practice, and you have to iterate on.

In kernels, for example, it seems like 99% of the effort ends up being 
hardware-dependent stuff. Getting architecture interfaces right, and 
getting working drivers. Hotplugging and device management turns out to be 
a _much_ bigger issue than schedulers or VM page-out has _ever_ been. 

But show me a single paper about them. I'm sure they exist. I'm just 
saying that they're sure as heck not getting 99% of the attention (or even 
1% of the attention) in discussions, even though they're definitely 99% of 
the real everyday work and effort.

(Maybe it's not 99%. Numbers taken out of my nether regions. The point 
should be clear).

The same is actually true of SCM's too, I'm totally convinced. At least in 
git, we really haven't spent _that_ much time on merges, for example. My 
original stupid three-way merge was really simple, and I think the way I 
introduced "stages" into the git index was really clever, but it was still 
a small detail. And it worked surprisingly way.

After that merge, people improved it. And "recursive" is a _huge_ 
improvement, don't get me wrong: it's still entirely a 3-way merge on the 
file contents, but it now does those 3-way merges in several stages if 
there are multiple independent common parents, and the rename logic is 
clearly important.

But if you actually look at how much effort was spent on merging, and how 
much was spent on just "details in general", I think you'll find merging 
to be pretty low down the list, even though the recursive merge ended up 
_also_ getting re-written in C. Perhaps it was one of the bigger 
_individual_ efforts, but compared to all the work we've continually done 
on performance and usability, for example, it's been pretty small in the 
end.

As an example: I suspect that in git just the CVS importer has gotten 
_way_ more attention than merging ever got. Importing from CVS is simply a 
much harder problem in practice, and we've probably had more people 
working on it (and that's _despite_ the fact that this is one of the areas 
where git has successfully re-used other projects that had similar goals: 
cvsps, cvs2svn etc). It's hard to "think" about, because a lot of the 
problems with importing from CVS are literally all about the details and 
the nasty crud. I really think "merging" is _way_ easier.

			Linus

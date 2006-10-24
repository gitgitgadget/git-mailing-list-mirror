From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 19:26:22 -0500
Message-ID: <20061024002622.GC17019@over-yonder.net>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca> <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 02:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcA7o-0003gH-TB
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 02:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWJXA0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWJXA0Z
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 20:26:25 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:46314 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S932354AbWJXA0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 20:26:24 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 68B8B2842A;
	Mon, 23 Oct 2006 19:26:23 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id E4D9561C52; Mon, 23 Oct 2006 19:26:22 -0500 (CDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29905>

On Mon, Oct 23, 2006 at 03:44:13PM -0700 I heard the voice of
Linus Torvalds, and lo! it spake thus:
> 
> gitk (and all other logging functions) can take as its argument a
> set of arbitrary revision expressions.
  [...]
> And trust me, these are all very valid things to do, even though
> you're talking about different branches.

I have zero problem believing that.  It seems from all accounts a
wonderful swiss-army chainsaw, and while none of that power is useful
to me personally in anything I'm VCS'ing at the moment, I'd feel awful
shiny knowing it was sitting there waiting for me.  All else being
equal, I'd think more highly of a VCS with those capabilities than one
without.

bzr-the-program doesn't have a lot of that capability, and what it
does have is rather more verbose to access.  Perhaps some attribute of
bzr-the-current-storage-model would make some bit of that
significantly more expensive than it has to be (I don't know of any,
and can't think offhand of anywhere it might hide, but that's way off
my turf).

But I don't understand how bzr-the-abstract-data-model makes such
things impossible, or even significantly different than doing so in
git.  In git, you're just chopping off one DAG where another one
intersects it (or similar operations).  To do it in bzr, you'd do...
exactly the same thing.  The revnos, or the mainline, are completely
useless in such an operation of course, but they don't hurt it; the
tool would just just ignore them like it does the SHA-1 of files in
the revision.


> See? When you visualize multiple branches together, HAVING
> PER-BRANCH REVISION NUMBERS IS INSANE! Yet, clearly, it's a valid
> and interesting operation to do.

I wouldn't be so absolutist about it, but certainly they're of
extremely limited utility if of any at all in such cases.  And yes, it
can be an interesting operation.  But what does that have to do with
using revnos in other cases?  You keep saying "having" where I would
say "using".


> No. If you "undo", you'd undo the whole history too. And if you undo
> to a point that was on a branch, you'd have to re-write _all_ the
> revision ID's.

Well, I guess in this particular case I still don't see why you'd
generally undo big hunks of a branch versus just flipping your working
tree to different versions.  But contrived examples are still
examples, and even if so, truncate()'ing a list of numbers is a
constant time operation.  And even if you had to renumber totally...
my $DEITY, I'd expect my old 200MHz PPro to renumber a hundred
thousand rev long mainline in half a second.


> > I consider it a _technical_ sign of a way of thinking about
> > branches I prefer   8-}
> 
> Quite frankly, I just don't think you understand what it means.

Quite frankly, I just don't think you understand that I WANT to care
about first parents.  No, really.  Seriously.  I really really really
want to.  If my VCS didn't give me numbers along the mainline, I'd
still care out it.  If the revisions were all named SHA-1 hashes, I'd
still care about it.  If I had a metric quidnillion ways to
cross-section and compare branches, I'd still care about it.

This comes with costs.  Chief among them is a restriction of my
actions; I can't fast-forward branches where I care about the
mainline.  That's a cost.  That means I have to take some care about
what operations I perform.  I *GLEEFULLY* pony up that cost.

Because I care about the mainline, revnos can be useful.  I like
revnos.  It has to cost SOMETHING to come up with them (though there
seems to be disagreement about the size of that cost), since doing
'x+y' will always cost more than doing 'x'.  I've never seen a case
where that cost even appeared MEASURABLE, much less significant
(things have to be pretty expensive to compare to the cost of starting
up python and loading a bunch of files into it ;).  So far, I've not
seen the slightest hint of a cost that would make it even worth asking
the question of whether the cost is worth it to me.


I care about that first parent line.  Therefore, I require my tool to
at least _pretend_ to care.  I'm not aware of any way in which the
fundamental bzr structures care, but the UI is chock full of
pretending.  A necessary part of that pretending is not changing my
mainline unless I specifically ask for it, and that means a
merge-vs-pull distinction needs to be there.  That's a _technical_
sign that the tool is ready to work with me the way I want to work.  A
lack of it is a _technical_ sign that it's not suitable.

You, by your own words, don't care about the first parent line.  Your
tool naturally reflects this.  From that perspective, *ANY* cost for
maintaining such a thing is Bad And Wrong, and so you condemn it.
Those condemnations will keep failing to carry any weight with me,
though, as long as I care about that mainline and value the benefits I
find in it.


Maybe I won't always.  2 years ago, I could maybe see some benefits in
DVCS, but I couldn't imagine what possible use they could ever be to
me in anything I do.  Today, I'm using one (if lightly by the
standards of a lot of people in this discussion), and chafing at every
centralized system I have to deal with.  In 5 years, I may be standing
beside you slugging it out at those lunatics and hacks who keep
begging to pay these whopper costs, just to be able to do extra work
to maintain an ordering of parents that doesn't matter for crap.
Could be.  I've changed my mind about far more momentous things in my
life.

Maybe someday I'll still care, but the OTHER advantages of a system
(like git) that doesn't over all the ones that do will outweigh the
advantages I gain from that distinction.  Someday I might need such
ultra-expressive ways of comparing branches, and bzr won't have grown
them yet.  Someday I might reach a point where bzr's performance due
to the choice of storage structures or implementation language or
developer habits or whatever else just doesn't cut the mustard, and
git's does.  Someday, some set of other advantages may make it
worthwhile for me to give up my preciouss mainline no matter how much
I might still crave it.

But I can only work from today.  Today, I do care.  Today, it's well
worth whatever I give up to get it.  And I like that my tool makes
that caring easy for me.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.

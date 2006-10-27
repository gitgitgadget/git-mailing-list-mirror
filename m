X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Fri, 27 Oct 2006 06:51:37 +0200
Message-ID: <20061027045137.GB3179@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <20061017073839.3728d1e7.seanlkml@sympatico.ca> <20061021141328.GE29843@artax.karlin.mff.cuni.cz> <BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE> <845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com> <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 04:51:51 +0000 (UTC)
Cc: Erik B?gfors <zindar@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	bazaar-ng@lists.canonical.com, Sean <seanlkml@sympatico.ca>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30289>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdJh1-0007WQ-0l for gcvg-git@gmane.org; Fri, 27 Oct
 2006 06:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423613AbWJ0Evj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 00:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423641AbWJ0Evj
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 00:51:39 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:19366 "EHLO
 artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP id S1423613AbWJ0Evi
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 00:51:38 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196) id
 E97A85021; Fri, 27 Oct 2006 06:51:37 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Sat, Oct 21, 2006 at 02:04:56PM -0700, Linus Torvalds wrote:
> On Sat, 21 Oct 2006, Erik B?gfors wrote:
> > bzr is a fully decentralized VCS. I've read this thread for quite some
> > time now and I really cannot understand why people come to this
> > conclusion.
> 
> Even the bzr people agree, so what's not to understand?
> 
> The revision numbers are totally unstable in a distributed environment 
> _unless_ you use a certain work-flow. And that work-flow is definitely not 
> "distributed" it's much closer to "disconnected centralized".
> 
> Now, you could be truly distributed: BK used the same revision numbering 
> thing, but was distributed. But BK didn't even try to claim that their 
> revision numbers were "simple" and that fast-forwarding is sometimes the 
> wrong thing to do.
> 
> So BK always fast-forwarded, and the revision numbers were just randomly 
> changing numbers. They weren't stable, they weren't simple, and nobody 
> claimed they were.
> 
> So bzr can bite the bullet and say: "revision numbers are changing and 
> meaningless, and we should just fast-forward on merges", or you should 
> just admit that bzr is really more about "disconnected operation" than 
> truly distributed.
> 
> You can't have your cake and eat it too. Truly distributed _cannot_ be 
> done with a stable dotted numbering scheme (unless the "dotted numbering 
> scheme" is just a way to show a hash like git does - so the numbering has 
> no _sequential_ meaning).
> 
> Btw, this isn't just an "opinion". This is a _fact_. It's something they 
> teach in any good introductory course to distributed algorithms. Usually 
> it's talked about in the context of "global clock". 
> 
> Anybody who thinks that there exists a globally ticking clock in the 
> system (and stably increasing dotted numbers are just one such thing) is 
> talking about some fantasy-world that doesn't exist, or a world that has 
> nothing to do with "distributed".
> 
> 			Linus

Actually bzr used to have slightly different numbering scheme not long
ago. There was a revision-history in each branch listing the revisions
in order in which they were commited or merged in. Some time ago it was
changed to numbering along the leftmost parent, which was, IIRC, deemed
simpler and a little more logical. But in the light of these arguments,
maybe the former system was better -- it was more dependent on the
actual location, but on the other hand it allowed (or could allow --
IIRC there was some problem with it) to fast-forward merge while
_locally_ keeping the meaning of old revision numbers. In fact, the
revision-history used to be almost exactly the same as git reflog,
except it only stored the revids, not the times.

--------------------------------------------------------------------------------

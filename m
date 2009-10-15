From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Wed, 14 Oct 2009 23:08:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910142237010.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
 <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <20091015014737.GA9923@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 05:10:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyGjo-0005Ew-4D
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987AbZJODJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbZJODJm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:09:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46467 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbZJODJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:09:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRJ00G9GCQZ0Q60@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Oct 2009 23:08:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091015014737.GA9923@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130355>

On Wed, 14 Oct 2009, Jeff King wrote:

> On Wed, Oct 14, 2009 at 05:56:52PM -0700, Junio C Hamano wrote:
> 
> > Nicolas Pitre <nico@fluxnic.net> writes:
> > 
> > > Can't the user confusion be dealt with through some means other than 
> > > making the tool less flexible?  I don't mind extra help message to be 
> > > displayed after a headless commit is made for example.  But trying to 
> > > make the tool more friendly should perhaps come from better education 
> > > rather than added restrictions.
> > >
> > > My thoughts only.
> > 
> > I actually share that but there apparently are people who have given up on
> > the education route.
> 
> I am personally undecided on this issue (my "this is the best option"
> was the best of "a -f switch to commit, an 'expert' config option', or a
> session-based option to commit").
> 
> But we really seem to have reached an impasse with how to proceed with
> git ui.
> 
> People like Dscho are fed up with user complaints about parts of git
> that can be unfriendly to new users. And I can understand that.

People like Dscho have to grow a thicker skin then.  There will _always_ 
be user complaints regardless of how balanced you try to make a UI.

> There _is_ a perception that git is hard for beginners to use, and I 
> don't think that perception is entirely without merit. We expect the 
> user to understand the basic concepts of git, like history graphs, 
> named refs versus detached heads, tracking refs, the index, etc.

Sure.  That's part of it, and beginners must get over with that 
perception.  Git is a professional tool and not a toy project anymore.  
Like any professional grade tool, there is a greater effort needed from 
beginners before being comfortable with the tool.

> At the same time, I think that is what many of us _like_ about git. It
> is based around simple and powerful concepts, and it doesn't get in your
> way when you want to use those concepts in a powerful and flexible
> manner. And I can understand resistance to making those features hard or
> inconvenient to access; detached HEADs were invented for a reason, and
> we want to use them.

Right.  Removing features That _are_ being used sounds a bit backward. 
Just because they happen to be confusing to beginners is not a good 
justification to remove/cripple them IMHO.

> So what is the right way to mediate between those desires? We have tried
> or suggested several options, including:
> 
>   1. Educate users. Keep exposing them to the concepts, but make
>      messages more clear. Improve documentation. This is largely the
>      route taken with the index. Has it worked? I think there is still a
>      perception among new users that the index is confusing.

Well, New users won't be new forever.  And Git is different from most 
other SCMs.  Eventually that difference is well understood by most 
not-so-new-anymore Git users.  Right now I have to deal with Perforce at 
$work and I find it _terribly_ confusing and obnoxious to use.  So it's 
only a question of getting used to something different.

IMHO this patch proposed by Daniel about the detached head is probably a 
good compromise.  It makes "confusing" operations more verbose to give 
new users a better feeling while keeping the flexibility intact.  And 
increased verbosity is less annoying than decreased flexibility.


Nicolas

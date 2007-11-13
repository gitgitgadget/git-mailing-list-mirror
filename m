From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cloning empty repositories,
 was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 12:34:03 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711131229140.21255@xanadu.home>
References: <Pine.LNX.4.64.0711121715090.4362@racer.site>
 <18232.35893.243300.179076@lisa.zopyra.com>
 <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr>
 <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <vpqzlxiiii6.fsf@bauges.imag.fr>
 <20071113100209.GE14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:34:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irzec-0006VA-Ld
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 18:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbXKMReI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbXKMReH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 12:34:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27111 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbXKMReG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 12:34:06 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRG008KJGSRHC90@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Nov 2007 12:34:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071113100209.GE14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64814>

On Tue, 13 Nov 2007, Shawn O. Pearce wrote:

> Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > I repeat the use-case I mentionned above :
> > 
> > ,----
> > | a typical use-case is when I want to create a new project. I'd
> > | like to initialize an empty bare repo on my backed up disk, and then
> > | clone it to my local-fast-unreliable disk to get a working copy and do
> > | the first commit there.
> > `----
> > 
> > I find this quite natural, and up to now, no one gave me either a
> > rationale not to do that, or a _simple_ way to achieve this. As I
> > said, it's currently not _very_ hard to do, but I have to edit
> > .git/config by hand, while git clone knows how to do this much faster
> > than I for non-empty repositories.
> 
> Its a goal to redefine git-clone as the following, as that is
> really all it does:
> 
> 	mkdir foo && cd foo && git init &&
> 	git remote add -f origin $url &&
> 	git checkout -b master origin/master
> 
> So setting up an empty tree is basically that:
> 
> 	mkdir foo && cd foo && git init &&
> 	git remote add origin $url
> 
> Is that really so difficult?  git-clone is a handy crutch for when
> we didn't have things like git-remote.  Or remote tracking branches.
> IMHO the above may seem a little low level but it may make it easier
> to teach to newbies.  They are more likely to grasp the concept of
> their repository being just like someone else's, and that they can
> track other repositories beyond just their origin.

FWIW all my Git tutorials for $work so far always avoided 'git clone'. 
The 'git init' + 'git remote add' + 'git fetch' is what I ask people to 
do.  It is more obvious to give a good name for the remote repo that 
way, and this can be performed into either a new or an existing repo 
when the data is related.


Nicolas

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: People unaware of the importance of "git gc"?
Date: Fri, 7 Sep 2007 11:12:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709071111400.28586@racer.site>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709061651550.28586@racer.site> <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITapb-0004od-E9
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbXIGKMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 06:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbXIGKMu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:12:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:45086 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965036AbXIGKMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:12:49 -0400
Received: (qmail invoked by alias); 07 Sep 2007 10:12:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 07 Sep 2007 12:12:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cMY5dynXcPTOmQAT7b25KLlb7eIW4fx01TPmzck
	DopNmqb6199in2
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58014>

Hi,

On Thu, 6 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 5 Sep 2007, Junio C Hamano wrote:
> >
> >> @@ -20,6 +20,7 @@ static const char builtin_gc_usage[] = "git-gc [--prune] [--aggressive]";
> >>  
> >>  static int pack_refs = 1;
> >>  static int aggressive_window = -1;
> >> +static int gc_auto_threshold = 6700;
> >
> > Please don't do that.
> >
> > When you share objects with another git directory, git-gc --auto can 
> > get rid of the objects when some objects go away in the referenced 
> > repository.
> 
> I thought the whole point of "gc --auto" was to have something
> that does not lose/prune any objects, even the ones that do not
> seem to be referenced from anywhere.  That is why invocations of
> "git gc --auto" do not say --prune as you saw the second patch,
> and the repack command "gc --auto" runs is "repack -d -l"
> instead of "repack -a -d -l", which means that it does run
> git-prune-packed after repacking but not git-prune.
> 
> Maybe I am missing something...

No, _I_ missed the fact that no pack is rewritten...

Sorry for the line noise,
Dscho

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Wed, 20 Aug 2008 22:09:12 +0200
Message-ID: <20080820200912.GG16626@blimp.local>
References: <20080819234433.GJ24212@spearce.org> <20080820193557.GB16626@blimp.local> <20080820194407.GJ3483@spearce.org> <20080820195401.GD16626@blimp.local> <20080820200026.GK3483@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:10:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVu0Z-0006e1-NT
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbYHTUJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbYHTUJP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:09:15 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:17359 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbYHTUJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:09:14 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (klopstock mo11) (RZmta 16.47)
	with ESMTP id 006d85k7KHeg34 ; Wed, 20 Aug 2008 22:09:12 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 4C97F277AE;
	Wed, 20 Aug 2008 22:09:12 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 34D4236D18; Wed, 20 Aug 2008 22:09:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080820200026.GK3483@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93028>

Shawn O. Pearce, Wed, Aug 20, 2008 22:00:26 +0200:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > Shawn O. Pearce, Wed, Aug 20, 2008 21:44:07 +0200:
> > > 
> > > We could pick any number for the limit, just so long as its so
> > > large that the size of the reflog for it to be a valid @{nth}
> > > request would be something like 1 TB, and thus be highly unlikely.
> > > 
> > > I was just trying to be cute by using the original commit timestamp
> > > of Git itself.  Perhaps 12936648 (1TB / 83)?
> > 
> > How about the maximum value the platform's size_t can handle?
> 
> So on 64 bit platforms we need to wait for another 2.92277266
> x10^10 years before we will ever see a seconds-since-epoch which
> can't possibly be mistaken for a position in the relfog file?

It is just a timestamp. Can be set to anything.

> > Not because it is "highly unlikely", but because you and me frankly
> > have no idea exactly how unlikely for example a "12936648 terabytes" is?
> 
> I have half a brain.  Creating 12 million reflog entries would
> typically require 12 million git-update-ref forks. Anyone who is
> doing that many since reflog was introduced and has not yet truncated
> their reflog _really_ should reconsider what they are using it for.

Why? It may just as well work (unless there are some other, more
technical restrictions).

> Evaluating foo@{12936648} will be _horribly_ expensive.  Anyone who

Depends what you evaluate it on. 640kb was also more than enough for
anyone once.

> is waiting for that result and _cares_ about it would have already
> started asking on the list for a reflog which is not based on a
> flat file.  If they have already patched their Git to use something
> else (e.g. gdbm) I have no pity for them when this changes/breaks
> as they clearly have already patched their Git rather heavily.

Why should you _care_?

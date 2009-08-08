From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Sat, 8 Aug 2009 03:30:42 -0400
Message-ID: <20090808073042.GA20951@coredump.intra.peff.net>
References: <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net>
 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
 <c77435a80908071502y48d14a38h79eec14a1be8c6fb@mail.gmail.com>
 <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
 <c77435a80908071553m6f7d5298p5ea68b9386198b3f@mail.gmail.com>
 <7vfxc3ov8t.fsf@alter.siamese.dyndns.org>
 <c77435a80908080027p6a8de468w68983bd81364cefd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 09:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgOB-0007Hy-FC
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbZHHHao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbZHHHao
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:30:44 -0400
Received: from peff.net ([208.65.91.99]:45606 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754453AbZHHHan (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:30:43 -0400
Received: (qmail 23999 invoked by uid 107); 8 Aug 2009 07:32:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 Aug 2009 03:32:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Aug 2009 03:30:42 -0400
Content-Disposition: inline
In-Reply-To: <c77435a80908080027p6a8de468w68983bd81364cefd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125253>

On Sat, Aug 08, 2009 at 09:27:55AM +0200, Nick Edelen wrote:

> > IIRC from previous discussions, kernel.org's main performance problem is
> > I/O, not CPU. Are there any provisions for sharing rev-caches between
> > similar repositories, as we already do for objects?
> 
> I haven't implemented a transmission protocol or anything, but it
> would be perfectly possible to copy cache slices from one repo to
> another.  Generating the revision cache from scratch on large repos
> can take several minutes, so this wouldn't be a bad idea.

That might be useful, but I was thinking more of an "alternates"-like
mechanism between repos. So that the data is stored only once on disk
and in the disk cache, which is helpful for sites like kernel.org which
serve many similar repositories.

-Peff

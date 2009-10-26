From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Mon, 26 Oct 2009 17:26:28 -0400
Message-ID: <20091026212628.GC27744@sigio.peff.net>
References: <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com> <7v7huspjg0.fsf@alter.siamese.dyndns.org> <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com> <20091022062145.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de> <7vzl7h8fjp.fsf@alter.siamese.dyndns.org> <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com> <alpine.DEB.1.00.0910262111340.4985@pacific.mpi-cbg.de> <32541b130910261340g1988caednc17f3d159ec00d26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 22:22:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2X1k-0000E3-7x
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 22:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbZJZVWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZJZVWr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 17:22:47 -0400
Received: from peff.net ([208.65.91.99]:47993 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbZJZVWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 17:22:46 -0400
Received: (qmail 27786 invoked by uid 1000); 26 Oct 2009 21:26:28 -0000
Content-Disposition: inline
In-Reply-To: <32541b130910261340g1988caednc17f3d159ec00d26@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131272>

On Mon, Oct 26, 2009 at 04:40:41PM -0400, Avery Pennarun wrote:

> I don't think there's actually a plumbing alternative to git-checkout,
> however.  My git-subtree script (and another script at work) have
> already had some bugs because of this (specifically, the differing
> behaviour of git-checkout with and without a path specified).  Is
> there something else I should be using in my scripts to be maximally
> safe?

It's git-update-ref. Which highlights one problem with the
porcelain/plumbing distinction. Our plumbing building blocks work at a
very low level, but often when scripting you want to use higher level
building blocks. So porcelain gets used in scripts, and gets an
ambiguous state. Consider "git commit", for example. Does anyone
actually script around "write-tree" and "commit-tree" these days, or do
they just script around "git commit"?

-Peff

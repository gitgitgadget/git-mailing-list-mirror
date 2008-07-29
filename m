From: Sam Vilain <sam@vilain.net>
Subject: Re: GTP/0.1 terminology 101: commit reels and references
Date: Tue, 29 Jul 2008 19:00:47 +1200
Message-ID: <1217314847.28919.98.camel@maia.lan>
References: <488D42B6.4030701@gmail.com> <1217228570.6750.24.camel@maia.lan>
	 <7vk5f6tqsj.fsf@gitster.siamese.dyndns.org>
	 <1217239419.6750.73.camel@maia.lan>
	 <alpine.DEB.1.00.0807281350590.2725@eeepc-johanness>
	 <1217273166.25690.20.camel@maia.lan>
	 <alpine.DEB.1.00.0807290014110.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Roys <roysjosh@gmail.com>, gittorrent@lists.utsl.gen.nz,
	git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 09:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNjDY-00045F-Vx
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 09:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYG2HA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 03:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbYG2HA4
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 03:00:56 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35979 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbYG2HA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 03:00:56 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9309C21C97A; Tue, 29 Jul 2008 19:00:54 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 6CDBB21C972;
	Tue, 29 Jul 2008 19:00:47 +1200 (NZST)
In-Reply-To: <alpine.DEB.1.00.0807290014110.2725@eeepc-johanness>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90594>

On Tue, 2008-07-29 at 00:30 +0200, Johannes Schindelin wrote:
> > Yes, but it is more defined than that.  There are still ambiguities with 
> > topological sort, so the gittorrent spec specified exactly how all ties 
> > are broken.  They happen to be a further refinement of --date-order, 
> > with respect to the ordering of commits.
> 
> But does that not mean that any new ref branching off of an ancient commit 
> changes all the pack boundaries?

No.  A "References" object is a snapshot of all refs at a particular
time.  If you want to make a new ref you make a new "References" object.
*all* of the new objects are contained in the new reel, and the new
reels do not affect the old reels.

> That should be easy, but I think that it would be _even better_ if we ask 
> pack-objects to generate several packs from the needed objects.  Ooops.  
> That already exists: 
> 
> 	$ git pack-objects --max-pack-size=<n>

This does not deterministically generate the same pack for a given set of
refs across all git versions.

Your ideas would have been excellent earlier on, perhaps if developed
they might have resulted in something quite a bit simpler with all of
the features the current protocol has - but given we are in the second
half of a GSoC project of which the end is in sight then I think we
should shelve them until the project finishes.  There has certainly been
a lot of useful things come out of them!

Cheers,
Sam.

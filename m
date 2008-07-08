From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
 projects?
Date: Mon, 07 Jul 2008 18:14:41 -0700
Message-ID: <7vmyktxjlq.fsf@gitster.siamese.dyndns.org>
References: <200807080227.43515.jnareb@gmail.com>
 <20080708010050.GD6726@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 03:16:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1oP-0004ph-Bz
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 03:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbYGHBPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 21:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbYGHBPF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 21:15:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbYGHBPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 21:15:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3248C4918;
	Mon,  7 Jul 2008 21:15:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CE3EE490D; Mon,  7 Jul 2008 21:14:43 -0400 (EDT)
In-Reply-To: <20080708010050.GD6726@leksak.fem-net> (Stephan Beyer's message
 of "Tue, 8 Jul 2008 03:00:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 49B7AF48-4C8B-11DD-B724-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87680>

Stephan Beyer <s-beyer@gmx.net> writes:

> Imho the prototype patchset needs some more review from others.

Yes, very much.  Not just from others and not just from me.

> (Well, I think the
>    http://thread.gmane.org/gmane.comp.version-control.git/86985
> thread died in the last days, but I hope some responses will come and
> also that Junio's patch for cherry-picking root commits will be
> included. I try to be patient...) ;-)

Please don't be patient but actively re-review what you sent out.

I _really_ wanted to merge the basic bits and rewrite of "am" at least to
pu tonight, but I had to drop them after noticing that it does not seem to
handle --rebasing at all (it parses to set $rebasing but after that where
does that bit go?  bash completion wants to see rebasing or applying
markers in .dotest), which made it a non-starter especially I'll be
cooking the other ORIG_HEAD in 'next' as well.

About the "rewrite rebase to use sequencer" bits, because we've dropped
the older rebase-i change, I do not want your series to depend on it.

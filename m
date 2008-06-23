From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
 further processing
Date: Mon, 23 Jun 2008 13:17:16 -0700
Message-ID: <7vwskfhpo3.fsf@gitster.siamese.dyndns.org>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
 <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
 <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
 <20080618033010.GA19657@sigill.intra.peff.net>
 <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181709300.6439@racer>
 <7v8wx2zibp.fsf@gitster.siamese.dyndns.org>
 <20080619142527.GA8429@mediacenter>
 <alpine.DEB.1.00.0806221953470.6439@racer>
 <7v4p7khqp7.fsf@gitster.siamese.dyndns.org>
 <20080623195906.GC29569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	madcoder@debian.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:19:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsUb-0003mY-Is
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbYFWUR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755304AbYFWUR2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 16:17:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbYFWUR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 16:17:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 146304FE1;
	Mon, 23 Jun 2008 16:17:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 122254FD7; Mon, 23 Jun 2008 16:17:18 -0400 (EDT)
In-Reply-To: <20080623195906.GC29569@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 Jun 2008 15:59:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64DB537C-4161-11DD-A769-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85917>

Jeff King <peff@peff.net> writes:

> Now I'm confused: my understanding is that the diff option parser just
> leaves unrecognized stuff in argv. But isn't that what a
> PARSE_OPTIONS_IGNORE_UNKNOWN flag would do, and isn't that wrong?

I was thinking more about the way how the lower level diff_opt_parse()
works by letting the caller to handle things that it itself does not know
how.

But I say this because I am not interested in "-a -b -c <=> -abc" and
haven't thought about how you would go about parsing something like that
sanely with partial knowledge.

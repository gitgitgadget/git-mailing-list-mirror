From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sun, 06 Jan 2008 13:22:57 -0800
Message-ID: <7vlk724pji.fsf@gitster.siamese.dyndns.org>
References: <7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<20080106042409.GA4843@coredump.intra.peff.net>
	<20080106042935.GB4843@coredump.intra.peff.net>
	<7vejcv5is3.fsf@gitster.siamese.dyndns.org>
	<20080106111725.GA11603@coredump.intra.peff.net>
	<7vy7b33zjk.fsf@gitster.siamese.dyndns.org>
	<20080106205946.GA17482@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:23:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBcxz-000368-TR
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 22:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbYAFVXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 16:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYAFVXI
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 16:23:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYAFVXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 16:23:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB81AACB;
	Sun,  6 Jan 2008 16:23:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 79C42AACA;
	Sun,  6 Jan 2008 16:22:59 -0500 (EST)
In-Reply-To: <20080106205946.GA17482@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 6 Jan 2008 15:59:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69746>

Jeff King <peff@peff.net> writes:

> Yes, I considered making a %palette, as well, but it just seemed a
> little gratuitous (and the nice thing about using variables is that they
> catch typos better).

Yes, to a certain extent with Perl (I think if you make the same
typo twice you won't get much help, and that is quite easy to
trigger with variable name autocompletion and cut-and-paste).

I suspect "if (!$menu_use_color)" might need to be refined in
sub "highlight_prefix".  It should be tied with $prompt_color
somehow (i.e. either it is undef or the "plain" color),
shouldn't it?

But other than that the result looks quite nice.  I shuffled the
patches around and the resulting series consists of three patches:

 - "remove unused diff colors";

 - "color.diff" colors diff, "color.interactive" colors
   interaction (squashed the original with change to the "sub
   colored" to use palette setting instead of $use_color as the
   cue);

 - documentation update to redefine the color.interactive
   semantics;

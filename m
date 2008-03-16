From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On fetch refspecs and wildcards
Date: Sun, 16 Mar 2008 15:33:05 -0700
Message-ID: <7vve3mfgf2.fsf@gitster.siamese.dyndns.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
 <1205604534.7589.20.camel@gentoo-jocke.transmode.se>
 <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
 <200803161921.49274.tlikonen@iki.fi>
 <7v8x0igvdp.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1QW-0004fw-St
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 23:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYCPWdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbYCPWdW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 18:33:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbYCPWdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 18:33:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3393924C8;
	Sun, 16 Mar 2008 18:33:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 068E524C5; Sun, 16 Mar 2008 18:33:14 -0400 (EDT)
In-Reply-To: <7v8x0igvdp.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Sun, 16 Mar 2008 15:24:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77396>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> Fortunately or unfortunately, Documentation/pull-fetch-param.txt does not
> talk about wildcard refspecs (not even the syntax, let alone the
> semantics), so we can define whatever we want right now, and I think both
>
>     (1) allow duplicated destinations, including wildcard matches; and

Clarification.

"s/;/, but do honor requests to copy one thing to multiple destinations;/"
is what I meant here.

>     (2) refuse duplicated destinations for explicit ones, and more than
>         one wildcard patterns that match the same ref, but omit explicitly
>         specified ones from wildcard matches;
>
> are viable options.  I suspect the current code does not do either.  We
> should pick one semantics, make sure the implementation matches that, and
> document it.

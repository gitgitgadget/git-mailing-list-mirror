From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] use typechange as rename source
Date: Wed, 28 Nov 2007 16:02:49 -0800
Message-ID: <7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
References: <20071121171235.GA32233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWs9-0007xc-TS
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116AbXK2AC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280AbXK2ACz
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:02:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54749 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757805AbXK2ACy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:02:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 11AB72EF;
	Wed, 28 Nov 2007 19:03:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E6739AAD1;
	Wed, 28 Nov 2007 19:03:12 -0500 (EST)
In-Reply-To: <20071121171235.GA32233@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 21 Nov 2007 12:12:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66472>

Jeff King <peff@peff.net> writes:

> There are a few add-on questions:
>
>   - should typechanges in both directions be used, or just file ->
>     symlink?
>
>   - this actually produces a 'copied' status rather than a 'renamed'
>     since the 'foo' entry does still exist. Is this reasonable?

I do not think this is a risky change; it won't add too many rename
sources we did not consider traditionally (typechanges are usually rare
event anyway).

You are copying the source to elsewhere and then completely rewriting it
(even making it into a different type), so I do not think 'copied' is so
unreasonable.  An alternative would be to say you renamed it and then
created something totally different, which would also be reasonable.

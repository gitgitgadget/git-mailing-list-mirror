From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] allow '%d' pretty format specifier to show
 decoration
Date: Wed, 20 Aug 2008 11:32:16 -0700
Message-ID: <7vwsibr0zz.fsf@gitster.siamese.dyndns.org>
References: <20080820175325.GD27773@sigill.intra.peff.net>
 <20080820180034.GB32005@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsUw-00083l-SR
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYHTSc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYHTSc3
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:32:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYHTSc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:32:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A7565AB6A;
	Wed, 20 Aug 2008 14:32:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4160C5AB68; Wed, 20 Aug 2008 14:32:19 -0400 (EDT)
In-Reply-To: <20080820180034.GB32005@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Aug 2008 14:00:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 555FE720-6EE6-11DD-84DE-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93009>

Jeff King <peff@peff.net> writes:

>     Is it too loose? Perhaps the enclosing parentheses should be
>     automatic,...

I think so.  The default output should primarily be for humans.

>   - should this turn on --decorate automatically?

Oh, absolutely.  If you plan to have different kind of decorations in the
future, then the logic can be "if there is explicit decoration specified,
don't do anything, but if there isn't any, turn the default one on."

Also, if it doesn't already, "--pretty=[t]format:" should make sure parent
rewriting is enabled when %p and %P is used.  I didn't look.

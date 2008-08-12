From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Allow missing objects during packing
Date: Mon, 11 Aug 2008 19:08:45 -0700
Message-ID: <7vbpzzt26q.fsf@gitster.siamese.dyndns.org>
References: <20080811182839.GJ26363@spearce.org>
 <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
 <20080811224404.GQ26363@spearce.org> <20080812012859.GT26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 04:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSjKl-0004OG-TR
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 04:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbYHLCI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 22:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbYHLCI4
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 22:08:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbYHLCIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 22:08:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E0A855A61;
	Mon, 11 Aug 2008 22:08:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 72AEF55A60; Mon, 11 Aug 2008 22:08:48 -0400 (EDT)
In-Reply-To: <20080812012859.GT26363@spearce.org> (Shawn O. Pearce's message
 of "Mon, 11 Aug 2008 18:28:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C1C57B8-6813-11DD-9390-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92060>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If we are building a thin pack and one of the base objects we would
> consider for deltification is missing its OK, the other side already
> has that base object.  We may be able to get a delta from another
> object, or we can simply send the new object whole (no delta).
>
> This allows a shallow clone which may have only commits and trees
> (but only partial blobs) to generate a pack for a fetch client,
> so the shallow clone only needs to contain objects that are not
> in the common base.

I'd queue this to 'pu' (or 'next' if you want, but that amounts to about
the same thing as we will be rebuilding 'next' soon after 1.6.0 ships),
but this would probably be better demonstrated with a test script that
demonstrates in what workflow this would be useful.

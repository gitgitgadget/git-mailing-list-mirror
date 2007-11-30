From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] use typechange as rename source
Date: Thu, 29 Nov 2007 17:10:45 -0800
Message-ID: <7vmyswsfl6.fsf@gitster.siamese.dyndns.org>
References: <20071121171235.GA32233@sigill.intra.peff.net>
	<7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
	<20071129141452.GA32670@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuPO-0003c1-3T
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763426AbXK3BKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763415AbXK3BKu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:10:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52318 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762123AbXK3BKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:10:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AE3EB2EF;
	Thu, 29 Nov 2007 20:11:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B6C19B2EA;
	Thu, 29 Nov 2007 20:11:09 -0500 (EST)
In-Reply-To: <20071129141452.GA32670@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Nov 2007 09:14:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66591>

Jeff King <peff@peff.net> writes:

> OK. What next? Did the patch I sent make sense? Do you want a cleaned up
> version with a commit message and signoff, or does it need work?

It just hit me that breaking (as in diffcore-break) a filepair that is a
typechange may yield the same result, and if it works, that would be
conceptually cleaner.  After all, a typechange is the ultimate form of
total rewriting (the similarity between the preimage and the postimage
is very low -- even their types are different, let alone contents).

Compared to that, the rename_used++ in that codepath you touched feels
more magic to me.

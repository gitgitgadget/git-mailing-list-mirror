From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge: fail properly when we are in the middle
 of a conflicted merge
Date: Sat, 23 Aug 2008 02:01:43 -0700
Message-ID: <7v3akw2jgo.fsf@gitster.siamese.dyndns.org>
References: <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
 <1219479422-29148-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 11:02:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWp1M-000362-C7
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 11:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbYHWJBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 05:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYHWJBw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 05:01:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42602 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYHWJBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 05:01:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 84DBD64004;
	Sat, 23 Aug 2008 05:01:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8351E65000; Sat, 23 Aug 2008 05:01:45 -0400 (EDT)
In-Reply-To: <1219479422-29148-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 23 Aug 2008 10:17:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F969158-70F2-11DD-B83F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93445>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Using unmerged_cache() without reading the cache first never will return
> anything. However, if we read the cache early then we have to discard it
> when we want to read it again from the disk.

With this, I do not think you would need to keep the read_cache() you
added to the beginning of the read_tree_trivial(), for the same reason you
are removing read_cache_unmerged() from the beginning of
checkout_fast_forward() in this patch.

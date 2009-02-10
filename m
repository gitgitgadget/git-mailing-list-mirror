From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 15:05:57 -0800
Message-ID: <7v3aellwoa.fsf@gitster.siamese.dyndns.org>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
 <20090210110330.GB12089@coredump.intra.peff.net>
 <7vwsbynv0o.fsf@gitster.siamese.dyndns.org>
 <20090210181052.GA19634@coredump.intra.peff.net>
 <20090210191118.GA26651@coredump.intra.peff.net>
 <7vtz72kjz0.fsf@gitster.siamese.dyndns.org>
 <20090210225539.GC26954@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1hV-0007ix-Jv
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbZBJXGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755593AbZBJXGF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:06:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbZBJXGD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:06:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A38852ADD4;
	Tue, 10 Feb 2009 18:06:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B40312ADCB; Tue,
 10 Feb 2009 18:05:58 -0500 (EST)
In-Reply-To: <20090210225539.GC26954@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 10 Feb 2009 17:55:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63333874-F7C7-11DD-A1EA-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109335>

Jeff King <peff@peff.net> writes:

> So untracked_files is definitely the worst, but I was surprised that
> the index to HEAD diff takes so long.

There is an obvious optimization you can do to "diff-index --cached" using
cache-tree.  If your index is really clean, computing the tree object the
index would represent (without writing the tree object out) and comparing
it against HEAD^{tree} may be a tad faster.

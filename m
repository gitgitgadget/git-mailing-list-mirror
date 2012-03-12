From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] xdiff: load full words in the inner loop of xdl_hash_record
Date: Mon, 12 Mar 2012 21:13:22 +0100
Message-ID: <877gypr319.fsf@thomas.inf.ethz.ch>
References: <1e11b1466ea3209cfe74e1dd8dff45f8666e942b.1331564754.git.trast@student.ethz.ch>
	<7vmx7lsmjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:13:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Bcc-0000l4-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab2CLUNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:13:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:19573 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756584Ab2CLUN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:13:29 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 21:13:27 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 21:13:26 +0100
In-Reply-To: <7vmx7lsmjd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 12 Mar 2012 11:26:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192937>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Also definitely post-v1.7.10 material, but I figure many people will
>> be interested.  Since it's such a central part of much of git, it's
>> also quite important that it gets tested heavily.
>
> I am interested but this is a material not beyond 'pu'.  Until it
> learns to be nice on platforms that do not like unaligned accesses
> or use big endian, that is.

Umm, nice how?  It leaves in the old version for those platforms.  I can
perhaps make it #error if we are unhappy about the user's platform, but
that's about it.  Testing for endianness is possible, but testing for
unaligned access risks SIGBUS and thus requires spawning a helper
program.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

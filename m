From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hash: fix lookup_hash semantics
Date: Fri, 22 Feb 2008 12:54:24 -0800
Message-ID: <7v7igw90fz.fsf@gitster.siamese.dyndns.org>
References: <20080222194726.GA24532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Dane Jensen <careo@fastmail.fm>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSevJ-0003v5-Pz
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 21:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbYBVUyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 15:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754215AbYBVUyi
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 15:54:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbYBVUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 15:54:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E83C5290;
	Fri, 22 Feb 2008 15:54:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 59DC7528C; Fri, 22 Feb 2008 15:54:28 -0500 (EST)
In-Reply-To: <20080222194726.GA24532@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Feb 2008 14:47:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74759>

Jeff King <peff@peff.net> writes:

> We were returning the _address of_ the stored item (or NULL)
> instead of the item itself. While this sort of indirection
> is useful for insertion (since you can lookup and then
> modify), it is unnecessary for read-only lookup.

Very nicely spotted.  Thanks.

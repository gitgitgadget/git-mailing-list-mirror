From: Junio C Hamano <gitster@pobox.com>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 02 Apr 2013 09:11:02 -0700
Message-ID: <7vtxnogbft.fsf@alter.siamese.dyndns.org>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Larres <jan@majutsushi.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3o9-0006F0-1i
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825Ab3DBQLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:11:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791Ab3DBQLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:11:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2EB312D77;
	Tue,  2 Apr 2013 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=McI57Zo65Y3A4wbVHBjJLHJI4Ns=; b=PDDsUS
	fWLkrq7dygESmEL52riKBzm4rvIqI8Raild4j+BKNNMPezBcoJF3Cznh3Ilx7hBP
	YOStbkSVnVxucCyUsvogPkbmgYwxxQsgbSAi+pB/4PZGQlWquhZdQPyGF0VKksa8
	mWQV/9iT79XrpvxkI07Ulr3bopyGUx1x0u1ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yrnx0ViZmb+striytP3nrDyY10yPjykB
	BjVIOcgsXABmZQIAUmcv6TNWVdxHzbJPQ9WX4H/jzlG2PRMMf3q5Kghb5dSR2XW2
	6qOFYHwf1yMDFmBHxpD5izpqYPThtqud+UyYBmUlNBphrT7syTw2/ZxKsHKwscJY
	M39C24xraWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ACDF12D76;
	Tue,  2 Apr 2013 16:11:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18F4412D74; Tue,  2 Apr
 2013 16:11:04 +0000 (UTC)
In-Reply-To: <20130402143130.GC23828@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 2 Apr 2013 10:31:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB23F594-9BAF-11E2-9CDB-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219788>

Jeff King <peff@peff.net> writes:

> Yes, it is the expected behavior, though I cannot offhand think of
> anything that would break if we did apply it recursively.

Conceptually that breaks our brain.  "All files in doc/ directories
are text" and "doc/ directory is text" are two different things, no?

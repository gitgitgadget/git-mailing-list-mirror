From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Tue, 20 May 2014 11:46:51 -0700
Message-ID: <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
	<1400572806-21092-2-git-send-email-jmmahler@gmail.com>
	<20140520082740.GB27590@sigill.intra.peff.net>
	<xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
	<20140520182443.GA30533@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 20 20:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmp41-00069X-1c
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbaETSq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:46:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50469 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaETSq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:46:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6640D182D1;
	Tue, 20 May 2014 14:46:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9n/sBRCMUrmg9eNBvhTGxoEnCvU=; b=PBg2K+
	0Bx6bftOPPNAHymsZ3b/pe59XJW5SpcRBRTRCRLhXa6ep7Mk3LUUvDJ5ua4R3Wsf
	6USaMFkG0yeGwpjmXjmRV52XUfZm0u7STe5+gnbFKwJ32BbhXe9UeaxKVyW0vuuf
	xkIPGKB/qXP1zkoKiNGCwxi6foUD1qkPApMOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YiJ+Q3jVPDdYB0+gBwvCkGhT+fnSLl5S
	wbYAlkLCGUYrdQgEIfAV8xYMtizo4AaRAQdO0FPDLRWy8nbq7W++6RnK+Ol4BIRY
	Su/B7mDpEhzS+BK3x+rGdxVaJGU4Hb6hPg4dD835ER7CRH8VlJ71h++6ZwBVcnE6
	KylPlT17d7o=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D372182D0;
	Tue, 20 May 2014 14:46:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 141ED182CA;
	Tue, 20 May 2014 14:46:53 -0400 (EDT)
In-Reply-To: <20140520182443.GA30533@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 May 2014 14:24:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C2C0494-E04F-11E3-9CD8-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249726>

Jeff King <peff@peff.net> writes:

> If it were just "--signature", I'd agree. After all, nobody is even
> complaining. But this is also in preparation for --signature-file.
> Should the user create a file without a trailing newline?

Ahh, I missed that part.

I am fine with processing it with stripspace().

By the way, at some point we may want to move that helper function
to strbuf.c, but that is a separate issue.

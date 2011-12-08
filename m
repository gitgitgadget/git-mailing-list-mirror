From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Thu, 08 Dec 2011 13:34:29 -0800
Message-ID: <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
 <20111207064231.GA499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 22:34:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYlbx-0003gL-5X
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 22:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab1LHVec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 16:34:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab1LHVec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 16:34:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB8367FCA;
	Thu,  8 Dec 2011 16:34:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4MeNBuhl8KEfrf6aSPgVp7zCvxI=; b=nOYwBZ
	fRrCtD74QbPQ6Cr/ejOSYzKmNaoNw4sJ2tus+wCWmrI+glMOoeQtWw1xN7KPiyfv
	6zOn1h6/KKhJivovTiwKuM7aL781fyJ0aobAShXyQlxW2KRdLlC55cNOeLJYtX+H
	oFcJaNitqsQaSKr6u9K01ji7Ukirr7A/ex4fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tptUOE/XhNH+Wr5r86NIL4cUc90ISN2w
	yrFh7DwGX4pGstVaOT5v/sHvzaQHACqyH4MdsiK/7bmhiF7pplMloy+KVLpe8Pvu
	cIjuHASeKgz9VtTelNpdg86wuNhhVV1RwO7Y53Sft1t8fxGlXz4ZD5a+BdmLP/1d
	aAP5Wf5QVxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C368C7FC9;
	Thu,  8 Dec 2011 16:34:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C9167FC8; Thu,  8 Dec 2011
 16:34:31 -0500 (EST)
In-Reply-To: <20111207064231.GA499@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 7 Dec 2011 01:42:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A15C310-21E4-11E1-9AF5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186596>

Jeff King <peff@peff.net> writes:

> Because the pattern takes 0 or more lines and no terminator, we can't
> distinguish between empty or truncated input and the empty pattern.

I agree that such a positive "Ok here is the end of specification" marker
is a good idea, even if we do not worry about "an empty set".

When the requestor wants to specify the credentials with host and user,
but the wire is cut after host is communicated but before user is, we do
want to notice the communication error, instead of silently erasing all
the credentials on the host regardless of the user.

Thanks.

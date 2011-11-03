From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Improve use of select in http backend
Date: Thu, 03 Nov 2011 16:14:14 -0700
Message-ID: <7v7h3ger3t.fsf@alter.siamese.dyndns.org>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, daniel@haxx.se
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Fri Nov 04 00:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM6UI-0002T8-Pe
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 00:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371Ab1KCXOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 19:14:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab1KCXOR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 19:14:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E499F6CF5;
	Thu,  3 Nov 2011 19:14:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T/tZlZireZ4MJ+nHvq4jthGE4vo=; b=QaJ76t
	PEcTESkyfhaZhAmQYrNd39J90q1idGSqmkLKcCcIrCPJ+W50ih4XuHepNiQ4+/87
	AwWR6h2pI+D6nwmjOzoiny9Zd9kDyRUURx2z5HJPDRHBKQRDDp3dE72ofZO9bD7K
	N5aGK02Mxpjie7t4CJkAwXFHU2QRl2HB2NC6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UhD7dcVIanR8hLNezeb3aQjZdEJ6TKJf
	3Ohsy11JOxIieWJTl2Zaj/ve1Rl9IzHZPCsUbAG+91lUpw1MlN9s+/WirA6BTnLp
	UT5La+DqAQidPG+cQkgfKR7u1kxXsB4Xnp+cbsMXaQZI32Bdz87aE2U7n1bp6JGs
	mDE6VCAUBbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC0AC6CF4;
	Thu,  3 Nov 2011 19:14:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 723D66CF3; Thu,  3 Nov 2011
 19:14:16 -0400 (EDT)
In-Reply-To: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 (Mika Fischer's message of "Wed, 2 Nov 2011 21:21:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D04A9EC-0671-11E1-A580-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184751>

I re-read this thread once again, and my understanding of the current
situation on these two patch series is the following. Please correct me if
I am wrong.

 * This is not a regression fix, this is not a correctness fix, but it is
   a performance improvement;

 * Jeff gave an idea for improvement around the use of (rather, not having
   to use) data_received; and

 * Mika understood Jeff's suggestion, but was hesitant due to one
   potential issue around curl_multi_fdset() and asked Daniel's opinion,
   to which Daniel responded that the worrysome situation would not
   happen.

It appears to me that the next step is for Mika to decide either (1) we go
ahead with the original patch and leave the improvement for later, or (2)
update the patch as Jeff suggested and we review it again.

I can go either way, but whichever way you choose, I would want to see the
patches properly signed-off.

Thanks.

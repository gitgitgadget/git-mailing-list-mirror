From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's going on here?  Bad repo, no error locally?
Date: Tue, 21 Apr 2009 22:06:54 -0700
Message-ID: <7vws9d46q9.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 07:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwUhQ-0006z4-2g
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 07:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbZDVFHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 01:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbZDVFHJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 01:07:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZDVFHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 01:07:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5EA57AC86F;
	Wed, 22 Apr 2009 01:07:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 58493AC86E; Wed,
 22 Apr 2009 01:07:01 -0400 (EDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com>
 (John Dlugosz's message of "Tue, 21 Apr 2009 20:18:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B8B2B9C-2EFB-11DE-9069-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117173>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> Developer B runs git fsck --full, gets no errors but one dangling blob.
> Does a push.  No errors.
> Now, on the upstream repo, I run fsck, and find a bunch of danglings (as
> always) and a missing blob.
> Any fetch from that repo will fail, due to that missing blob.
>
> What's going on?  How can I fix his local repository, other than...

It sounds like there is nothing to fix in "his local repository"; the
error is in your "upstream repo".

The dangling objects can happen if you push over dumb transport and
interrupt in the middle, or you force a push of a rewound branch, so it
does not necessarily indicate any errors, but a missing object is always
an error.

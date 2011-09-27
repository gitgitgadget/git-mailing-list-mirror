From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix links to lines in blobs when
 javascript-actions are enabled
Date: Tue, 27 Sep 2011 10:17:20 -0700
Message-ID: <7v7h4tykf3.fsf@alter.siamese.dyndns.org>
References: <20110927094947.10955.qmail@stuge.se>
 <1317117060-3955-1-git-send-email-peter@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
X-From: git-owner@vger.kernel.org Tue Sep 27 19:17:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8bHb-0003qc-Hg
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 19:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175Ab1I0RRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 13:17:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1I0RRW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 13:17:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AE4C4DEF;
	Tue, 27 Sep 2011 13:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KB+KVMALQ9rz/YfB89Y1RdRXEok=; b=Nr+YJs
	EtPM162K78oi1q2R5vD2BbcuSvxqdZDb31OWm1k5OLIzmXx8jmq7Qt/J3pLnclpd
	gz30s9CeV98o3gxMYwRUK2A0o1qmTlNEeurgJOUOVPbud4Bzimdv0SZ0i4LNOmHr
	Ma/6/FqTOm9RxaE4f6dML/BeArKgp+sGcPYns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aMrOTdN9OQw+MjR8jA3nZlS6OnwHdrLJ
	kVjoTdNH3SnzNQPjJr4aZKnHnpNxtbzyAJpbfrquY3mzds72aOXPQQmkUtXceAOw
	K9OYAdMEeVQdiEQjOPM6NyEJWjFIsMub2arukV84f/bKXGzJZejKoXNMTZXpCmBR
	CCNWVWiFpRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 317F14DEE;
	Tue, 27 Sep 2011 13:17:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBDC04DED; Tue, 27 Sep 2011
 13:17:21 -0400 (EDT)
In-Reply-To: <1317117060-3955-1-git-send-email-peter@stuge.se> (Peter Stuge's
 message of "Tue, 27 Sep 2011 11:51:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F9430E0-E92C-11E0-A5D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182254>

Peter Stuge <peter@stuge.se> writes:

> Some javascript code will run in the browser onLoad and signals back to
> gitweb that the browser can actually do javascript.
>
> The code adds [?;]js=1 into the URL of all links on the page. The code
> always added [?;]js=1 to the end of links, which is wrong when links
> contain a URI fragment, such as links directly to a line in a blob:
> ..?p=repo.git;a=blob;f=file#l123
>
> In this case, [?;]js=1 must be added before the hashmark.
>
> Signed-off-by: Peter Stuge <peter@stuge.se>

Nicely done. You forgot to mention another bug you fixed (see Jakub's
sample in the thread), so I'll amend in a few sentences to describe it as
well.

Thanks.

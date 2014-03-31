From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] patch-id: make it stable against hunk reordering
Date: Mon, 31 Mar 2014 15:05:02 -0700
Message-ID: <xmqqfvly2fe9.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:05:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkL1-0003qh-MM
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaCaWFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:05:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbaCaWFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:05:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4393B79C7B;
	Mon, 31 Mar 2014 18:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=h3pPJOqBYEH2E5UR9+GFr/5X05Q=; b=Xz4FNZ8uAWtGFmgR5h4v
	Zieknsf6zE7lSAgP0osnlRNQeJdKWJ3iEaWBZwCJnj843jEKoPcIdWnAik33vl9l
	SIAi/v4Yc1W35LXmKAJqwF4ytctMfj7Pa+d2v30DZ8RqQH+2KDLRUXZe+pmPywDk
	UcZaxHOhAgMNKgtb39L9Yaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=B8lVYpkGsWbRtrjPrbpfqIHFxYU9A7COd/ZYezt1gzk/zw
	wB9ukGyhq9H7SLXU4L2SuZ0l5ab2+Cm5ledOE7v0bT/lfhcwWN8Oc3g9+a3jzgXf
	xrY4HEf7f89URjbmUwoC9d1arXpQCst0b4vXYWnT2WJyaS/1J2SpU5doq4w4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E49679C7A;
	Mon, 31 Mar 2014 18:05:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F9B879C78;
	Mon, 31 Mar 2014 18:05:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 832BFCB8-B920-11E3-B653-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245550>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> +						memcpy(&ctx, &header_ctx, sizeof ctx);
> +					} else {
> +						/* Save header ctx for next hunk.  */
> +						memcpy(&header_ctx, &ctx, sizeof ctx);

I'll fix these to sizeof(ctx) when queuing.

Thanks.

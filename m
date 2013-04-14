From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Sun, 14 Apr 2013 12:22:17 -0700
Message-ID: <7v8v4k6hp2.fsf@alter.siamese.dyndns.org>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:22:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSVN-0007js-1n
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab3DNTWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:22:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab3DNTWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:22:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8451B16487;
	Sun, 14 Apr 2013 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ojlrTxevJBwWDN8yNc/f2acWhgg=; b=tNrBgw
	kR4osBGdB/6t9uSl8jYqYPLA7OtFu+I2zWF8vLDP5YUb3pnQFj+/E3TTRDvA3C0P
	L8ap/B7818ka+6/C5gIEvkTZQJh4mzlEU9NWNechdXHSaxlVtlBXlOMcWryCP5mS
	2vfejkRbrnQ1tTg3QtqdwwwajPky+EV9YsVxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NMyG+iTurz/rDAYxAlrhpTwvg9O4Szlv
	r3XjoGDXZEQ+7YajEZ1m789gM8LzENtnXLR5VzKoQpQ1aMQ3789H+hYWO6CkYN75
	GhcGEiht9qj5/7CZ55EDiPZ3bm47tCWBcks3qfVs6oo0Z9QUC5SO58AImVhhRqYw
	R8E7SAWxeWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 782B116486;
	Sun, 14 Apr 2013 19:22:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8B9816485; Sun, 14 Apr
 2013 19:22:18 +0000 (UTC)
In-Reply-To: <1365949646-1988-1-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Sun, 14 Apr 2013 15:27:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FA449BA-A538-11E2-86E2-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221156>

Philip Oakley <philipoakley@iee.org> writes:

> This patch series seeks to add tests for the version string format
> and document it.
>
> The key questions to be answered are:
> * should the test be inside t0000, or somewhere else?
> * should the version string be limited to one line, <80 characters?

One line, perhaps, but I do not think any byte-limit is reasonable.

It is unreasonable to limit the form to X.Y.Z; after we hit Git 2.0,
it is likely that we would go to two-decimals.

If the "parsing" is done for white/blacklist purposes, is there a
need to straight-jacket the verison string format like this series?

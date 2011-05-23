From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 05/10] pack-objects: Teach new option
 --max-commit-count, limiting #commits in pack
Date: Mon, 23 May 2011 16:17:06 -0700
Message-ID: <7v4o4lt3bh.fsf@alter.siamese.dyndns.org>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 24 01:17:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOeNH-0004yA-QD
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab1EWXRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 19:17:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab1EWXRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:17:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B52294C3E;
	Mon, 23 May 2011 19:19:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pxYiqajFncMzAZxicnaZk8AKGP0=; b=KiMydl
	VIqtAUkru35g4Df0l1wUrqfv8diDf6M3v7L+NfxuQVeN+v6fsouCA3IP8dJTQO2X
	gM0C5W+CZpE0RSpjbDXtdzqm51+xB+TqNkiqCeOA2yQePS3eIrnrf15hewYPwZ1y
	kQPLVL6bjlrC2JXj0D4RjIvsz13yY7qPYbivE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nDZaPI+50akdTn14UJQ9FZ/GZ+YHIsQZ
	VV/cG9cMzRmTzi+tnwBfdXN2QQi2rBuPe2ePe4OVB+MMy+sxZvTNKWwYDSe3Z5+s
	45F/reZqTBM2nX/+PXmU0iWUp4nzhGcQfTobHkQee2YcH/cRbiNUff3jBszrouBD
	xOGF0il4tdk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 803894C3D;
	Mon, 23 May 2011 19:19:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 718404C3C; Mon, 23 May 2011
 19:19:16 -0400 (EDT)
In-Reply-To: <1306111923-16859-6-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 23 May 2011 02:51:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16712F1C-8593-11E0-94F9-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174290>

Johan Herland <johan@herland.net> writes:

> The new --max-commit-count option behaves similarly to --max-object-count,

Hmm?

Do we have --max-object-count at this point in the series, or am I missing
a patch?

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 20c8551..e43904e 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -113,6 +113,14 @@ base-name::
>  	The default is unlimited, unless the config variable
>  	`pack.packSizeLimit` is set.
>  
> +--max-commit-count=<n>::
> +	This option is only useful together with --stdout.
> +	Specifies the maximum number of commits allowed in the created
> +	pack. If the number of commits would exceed the given limit,
> +	pack-objects will fail with an error message.
> +	The number can be suffixed with "k", "m", or "g".
> +	The default is unlimited.

It feels a tad funny to count number of commits in increments of 2^10, but
that's Ok ;-).

The patch itself looks fine.  Thanks.

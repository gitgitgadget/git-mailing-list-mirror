From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6019: avoid refname collision on case-insensitive
 systems
Date: Thu, 15 Sep 2011 08:52:01 -0700
Message-ID: <7vzki5pzvi.fsf@alter.siamese.dyndns.org>
References: <02451a2849fc8f1cab7983b6c8c629ebb6a1aaa9.1316075573.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brad King <brad.king@kitware.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4EEV-0006o1-LW
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934086Ab1IOPwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 11:52:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934048Ab1IOPwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 11:52:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33FD94E01;
	Thu, 15 Sep 2011 11:52:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9CB6GtkB19AtZNW6SgbnUd9C0fU=; b=An7lDI
	f9c5yhi2TZnL/TGqXvXrNhusgWMYWR/DgwzhztLgwIVrVN9YO9c+McS/d1DIHnMY
	1gZqEhfnuqSwEMRCGtnxAeVqex3nLelaeQ2e2XpQlzGqRs8NKuwQ8ZQz594RS3RC
	d+2/JftPKQ1yRwV/c1CF7nfkceZzryEBPEBb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXrAEaTQ6sANaR3smw+4PJ1fgTRqPoQK
	CfmY9iVmH3gHFYXJZChu345MMrJ2CUrMl/hM/wB8l5IBxeAaWS/MTYseFg9vILiw
	9UBYMYx2t71QRCkkJTYiXS1I1f0Lh9n0yPzeHMbrzWTLwDTx4Z4+7lOELdXhTgR3
	AUNX/lNIAf0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A4D44E00;
	Thu, 15 Sep 2011 11:52:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B06C54DFC; Thu, 15 Sep 2011
 11:52:02 -0400 (EDT)
In-Reply-To: <02451a2849fc8f1cab7983b6c8c629ebb6a1aaa9.1316075573.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 15 Sep 2011 10:34:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8075414-DFB2-11E0-9C84-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181475>

Thomas Rast <trast@student.ethz.ch> writes:

> The criss-cross tests kept failing for me because of collisions of 'a'
> with 'A' etc.  Prefix the lowercase refnames with an extra letter to
> disambiguate.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> This fixes the tests on OS X.  Together with Peff's fix to the poll
> issue, it now tests clean again.

Hmm, I must have misplaced Peff's poll fix. Care to point me in the right
direction?

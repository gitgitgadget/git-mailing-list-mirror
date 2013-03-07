From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: Add colons to list headings in "verify"
Date: Thu, 07 Mar 2013 13:38:28 -0800
Message-ID: <7vvc92lwkr.fsf@alter.siamese.dyndns.org>
References: <1362617796-4120-1-git-send-email-git@cryptocrack.de>
 <1362617796-4120-2-git-send-email-git@cryptocrack.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Thu Mar 07 22:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDiWh-00023E-J6
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 22:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759820Ab3CGVic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 16:38:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758727Ab3CGVib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 16:38:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21AF8A3AB;
	Thu,  7 Mar 2013 16:38:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tqw+YMTEgtkPUmwI/Y4d2VgQ6dc=; b=JDvBdS
	+H/RHr5K4XGnlH+7m0mudA/g35ugJNk3OdJk4txYW85tMjw7ahIW9pdI0n1Nm0gK
	8zr/lXbHdbkBsiQVmjtCI41xKTFxzW7nEz47uUpmdYLyPzsvIlDMttjBvyd9SxF8
	WaDKPMoBweOSRBLHue/xqWZ5Cn3qpbXYP92hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FPAAX48SCO/MOq1z7J5tf9pe9uNugDy1
	AlupaF59Yq11lzsEA5rte0hvaUkOaJvSCc7GkghWISEenpxNhDadVFX70aEWmfjw
	FRvmP0drDZ4BkLUx+5thwQRa6R9d6xT1IcdXH85QzDZIbZ3tqo+jh08Xcpg86+5A
	mV3sb1pRJPU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 166D0A3A8;
	Thu,  7 Mar 2013 16:38:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9499CA3A2; Thu,  7 Mar 2013
 16:38:30 -0500 (EST)
In-Reply-To: <1362617796-4120-2-git-send-email-git@cryptocrack.de> (Lukas
 Fleischer's message of "Thu, 7 Mar 2013 01:56:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AA1371A-876F-11E2-90A7-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217617>

Lukas Fleischer <git@cryptocrack.de> writes:

> These slightly improve the reading flow by making it obvious that a list
> follows.
>
> Signed-off-by: Lukas Fleischer <git@cryptocrack.de>

Perhaps.

The earlier message says "contains X ref(s)" while the later one
says "requires this/these X ref(s)".  Do we want to make them
consistent, too?

> ---
>  bundle.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 65db53b..8cd8b4f 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -183,8 +183,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
>  		struct ref_list *r;
>  
>  		r = &header->references;
> -		printf_ln(Q_("The bundle contains %d ref",
> -			     "The bundle contains %d refs",
> +		printf_ln(Q_("The bundle contains %d ref:",
> +			     "The bundle contains %d refs:",
>  			     r->nr),
>  			  r->nr);
>  		list_refs(r, 0, NULL);
> @@ -192,8 +192,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
>  		if (!r->nr) {
>  			printf_ln(_("The bundle records a complete history."));
>  		} else {
> -			printf_ln(Q_("The bundle requires this ref",
> -				     "The bundle requires these %d refs",
> +			printf_ln(Q_("The bundle requires this ref:",
> +				     "The bundle requires these %d refs:",
>  				     r->nr),
>  				  r->nr);
>  			list_refs(r, 0, NULL);

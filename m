From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/7] invalidate_ref_cache(): rename function from
 invalidate_cached_refs()
Date: Wed, 12 Oct 2011 12:14:13 -0700
Message-ID: <7v1uui9g56.fsf@alter.siamese.dyndns.org>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
 <1318445067-19279-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:14:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4Fw-0005VC-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab1JLTOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:14:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351Ab1JLTOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:14:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17C644F67;
	Wed, 12 Oct 2011 15:14:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v0zCioi0/rKhz3xBG63/yZNLpWk=; b=WKjs+4
	JxJZfd2a2C1Y7cy+8QmnxJFSV3puV8LrBRsliNUN5xwDymXHvX7ufDfY5RkF9kjo
	TgOS2fNccjNED6fSc1KR0X5ImslrY/+kWymrNNNnaicrK41CGv/x2M4s1aFdBx0k
	abiX5miPQyvwyJ1pO+StOfGSJtrWCiQYzqm5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kOUX24YWwFVVREY8YlLKkN5Paw6OSQrv
	grS86PuTbBclIigHIrtfjSzln8QAX27RSVOc9j5fyu/8BSVVl8YEdmwQr61sZrhG
	ZcQJ87PG6hoqk5TGaxxVCM/+LWiTK3Za5cq1tEEtO9XwPd0NSs1oklymMtwISwXq
	IvVQIZ2yx5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EBFF4F66;
	Wed, 12 Oct 2011 15:14:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8750C4F65; Wed, 12 Oct 2011
 15:14:14 -0400 (EDT)
In-Reply-To: <1318445067-19279-2-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 12 Oct 2011 20:44:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FC1B816-F506-11E0-9C40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183401>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It is the cache that is being invalidated, not the references.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

> diff --git a/refs.c b/refs.c
> index 9911c97..120b8e4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -202,7 +202,7 @@ static struct cached_refs *get_cached_refs(const char *submodule)
>  	return refs;
>  }
>  
> -static void invalidate_cached_refs(void)
> +static void invalidate_ref_cache(void)
>  {
>  	struct cached_refs *refs = cached_refs;
>  	while (refs) {

If you call the operation "invalidate ref_cache", shouldn't the data
structure that holds that cache also be renamed to "struct ref_cache" from
"struct "cached_refs" at the same time?

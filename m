From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fix compilation with --disable-pthreads
Date: Mon, 13 Oct 2014 12:10:11 -0700
Message-ID: <xmqqwq833hws.fsf@gitster.dls.corp.google.com>
References: <d2df2f619967ea7ba9625868b9c77d79a1190665.1413038338.git.etienne.buira@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Etienne Buira <etienne.buira@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdl0f-0007Ud-UZ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 21:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbaJMTKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 15:10:16 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754236AbaJMTKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 15:10:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DC411599C;
	Mon, 13 Oct 2014 15:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jBykhxqMYqY4h5PRxOPtLjR9fZo=; b=Yces68
	q6SXlr1UmvF66FwVFBi+Totp8QSV06WRzJQeW6rE1fuGsSVoVRoAe21Z7d9lYbtb
	BJgv2+fU0IQHtroP5WaWZzxygmzlYZZ3EKvaa8GyOmbNFhfAH8Eqd0DBe+tPo0zc
	jECjzxxggB7NEpY9V1A6bbrWKH90xYROZ6CZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ovk7BwpwqiO3Z6uJsfq6CSLD/oS17Tny
	O4SZBxfCFPEg6TjqkT44XafKK/S39cxosGqxjXUKt3VVGWAJJpZkDHHo5gK7irii
	U7+NAm6afHGS9M1XB+KdbyXHDmgg74lgDD8XYpEyAbzOXk5AfluYdc7RozeNlL8N
	yRcG0uPHx1k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 444E21599B;
	Mon, 13 Oct 2014 15:10:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7A4315996;
	Mon, 13 Oct 2014 15:10:12 -0400 (EDT)
In-Reply-To: <d2df2f619967ea7ba9625868b9c77d79a1190665.1413038338.git.etienne.buira@gmail.com>
	(Etienne Buira's message of "Sat, 11 Oct 2014 16:42:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8EBFF710-530C-11E4-A2F3-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Etienne Buira <etienne.buira@gmail.com> writes:

> Subject: Re: [PATCH 1/2] fix compilation with --disable-pthreads

That probably is a typo of "NO_PTHREADS=NoThanks" or something.
Thanks.

Just out of curiosity, are you porting to some exotic platforms?

> Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
> ---
>  builtin/index-pack.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index eebf1a8..0f88f4b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -185,6 +185,9 @@ static void cleanup_thread(void)
>  #define deepest_delta_lock()
>  #define deepest_delta_unlock()
>  
> +#define type_cas_lock()
> +#define type_cas_unlock()
> +
>  #endif

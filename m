From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] remote: trivial style cleanup
Date: Tue, 28 May 2013 10:04:53 -0700
Message-ID: <7v38t72fyi.fsf@alter.siamese.dyndns.org>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
	<1369745671-22418-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNKg-00077c-N7
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934901Ab3E1RE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:04:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934848Ab3E1REz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:04:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5223C23D84;
	Tue, 28 May 2013 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kLDNasTDpH0EGhkaUIUFvOShZB4=; b=CRRpjVHdSWArulnK/68W
	NPMJlKVECF0Ue/+oykFY5apGcqk4LmgO5pKCfF/tevjzSSlS1S8UxM2E4/OTfygc
	mq2a+HxcI7haPFOtSkiHbUVLpCvEPP1YJu9IFMXko4Fu8t+3eQwuXEc99nrlEU6G
	msbPJ0blNXpFgAEq3zD20kE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VxmjFt1dK1CaIL3V2xCylNn5T+l0U5EmE4IyVoVOhLJ8Tn
	zBS9K05U0Dyd+jF5Aw6N7ZBENV+OPgS+En3Yz7S5fK5ojNpAQbpB4KPsVIQuoY9H
	Yfi+4/EoJzNP9d9WwpFqvSriiIYRTcbHiSRVvYBskmdN+f/rspElxrGDGrYFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48A2123D83;
	Tue, 28 May 2013 17:04:55 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE69823D81;
	Tue, 28 May 2013 17:04:54 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7DE0672-C7B8-11E2-BA26-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225666>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  remote.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 68eb99b..e71f66d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1474,8 +1474,7 @@ struct branch *branch_get(const char *name)
>  		ret->remote = remote_get(ret->remote_name);
>  		if (ret->merge_nr) {
>  			int i;
> -			ret->merge = xcalloc(sizeof(*ret->merge),
> -					     ret->merge_nr);
> +			ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));

Yeah, calloc is nmemb first and then size, so this makes sense.

>  			for (i = 0; i < ret->merge_nr; i++) {
>  				ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
>  				ret->merge[i]->src = xstrdup(ret->merge_name[i]);

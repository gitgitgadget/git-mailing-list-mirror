From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: remove dependency on git.spec
Date: Wed, 27 Apr 2016 13:24:13 -0700
Message-ID: <xmqqpota94wi.fsf@gitster.mtv.corp.google.com>
References: <20160427175431.GA15178@spirit>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:24:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avW0m-0000to-OJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbcD0UYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:24:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753261AbcD0UYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:24:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB6C017F6B;
	Wed, 27 Apr 2016 16:24:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sLLLx/3AURQ/+pPfYFf2JYMyh9U=; b=kER827
	dM1kt8NYUGcFbu2YhNgks0vYCaSoLq4SHbJ/H9iDHvfJeNkzpYHBcC+e2GAGab7T
	oK4qjNHJksPxh4l5ZNMrn0QW4PdhkQaaPbo9ZtwIv+GMoSQf3jcWK5W71W1sqrRA
	32A0xTnvEsHD78NG/37jroxnVM3T5rZJvgN1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MW6FL2FnSIdSBsIoC3vjCsILNhNWqTdO
	PzH0GU4GMhOKXok/P4VrtA/kE4Rb3jlHAnaA36HHiDon3+3QsyLHJX+pUq8c+b5k
	9f+dTdmSQJtA8UgzxRWg5/Juj20ZzRaKeIfTtdnfDr7R5anklD6AxJYePxWWKYZM
	eu/r9SLHr8Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1D3917F6A;
	Wed, 27 Apr 2016 16:24:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34AA017F69;
	Wed, 27 Apr 2016 16:24:15 -0400 (EDT)
In-Reply-To: <20160427175431.GA15178@spirit> (Dennis Kaarsemaker's message of
	"Wed, 27 Apr 2016 19:54:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02D1E848-0CB6-11E6-A62F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292815>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> ab21433 dropped support for rpmbuild using our own specfile by removing
> git.spec.in, but forgot to remove the dependency of dist on git.spec.
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---

Thanks.

>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 23182bc..8083b10 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2396,7 +2396,7 @@ quick-install-html:
>  ### Maintainer's dist rules
>  
>  GIT_TARNAME = git-$(GIT_VERSION)
> -dist: git.spec git-archive$(X) configure
> +dist: git-archive$(X) configure
>  	./git-archive --format=tar \
>  		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
>  	@mkdir -p $(GIT_TARNAME)

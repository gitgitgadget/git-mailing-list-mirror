From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/10] transport-helper: fix extra lines
Date: Thu, 31 Oct 2013 11:16:36 -0700
Message-ID: <xmqqeh7171bv.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:16:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbwnT-0007PJ-SG
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab3JaSQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:16:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab3JaSQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:16:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29FE74E676;
	Thu, 31 Oct 2013 14:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cOcS8MFZuG0WNkGVQ8fsm1yvaLE=; b=PNe3Vx
	fRC0OR2Hs59P1AAfkrIITzj/kzp3eb1CpI3FF18F6aja2Xk6lsHT+TN7A8RC2j2U
	GUliLFKD99FK7YuAyA9e7qOaLpCtWGR+6AjfVX9ND5Zc0p8pc9/NL3E/DDyIkZyR
	IrSVhKYF+d0nqxGA5Dtwjadb0c0g6gx+cJPrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DgOhn7xYTJGbHB1gLvg+lxll1bhRUwvA
	2mAGX4vQG7O1OhcS2CDg1QpzvdSE5yqjWLkMl2j0frPECo+qKnD12GNrSNr29Ami
	ljayXceL+lDlY2dSbWsbc8jX3LybwO3ycxRBL/bGCXnNjQJ6GECSgTKQyVeNrQrO
	NVv8aV/07Cc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A1944E675;
	Thu, 31 Oct 2013 14:16:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F6A84E673;
	Thu, 31 Oct 2013 14:16:38 -0400 (EDT)
In-Reply-To: <1383212197-14259-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 03:36:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 956C3242-4258-11E3-96E5-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237144>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit 9c51558 (transport-helper: trivial code shuffle) moved these
> lines above, but 99d9ec0 (Merge branch 'fc/transport-helper-no-refspec')
> had a wrong merge conflict and readded them.
>
> Reported-by: Richard Hansen <rhansen@bbn.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Ahh, sorry about that.  Will apply with a retitle.

>  transport-helper.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index b32e2d6..985eeea 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -874,9 +874,6 @@ static int push_refs_with_export(struct transport *transport,
>  		}
>  		free(private);
>  
> -		if (ref->deletion)
> -			die("remote-helpers do not support ref deletion");
> -
>  		if (ref->peer_ref) {
>  			if (strcmp(ref->peer_ref->name, ref->name))
>  				die("remote-helpers do not support old:new syntax");

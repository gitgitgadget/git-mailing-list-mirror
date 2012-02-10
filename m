From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] diff --stat: use most of the space for file names
Date: Thu, 09 Feb 2012 16:55:34 -0800
Message-ID: <7v62fftsl5.fsf@alter.siamese.dyndns.org>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
 <1328831921-27272-5-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 01:55:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvemD-00042g-7n
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859Ab2BJAzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:55:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab2BJAzh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 19:55:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 983FB6414;
	Thu,  9 Feb 2012 19:55:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0oH3TqDWfxT0
	5NnJQPkKpAImRtQ=; b=iwqdbToLTlRJJF/NdK2wvjjsuKPa32x8kXncBmLwmBkU
	R5oYiRc/QlCrBhK8nUiZ2qZdGblCJwUgoQ62PT+19ZpyTWdR0e1GzYVHmVXoFpIA
	DsJcNx8zGIvw5wCLOxrUn45gAeTtqp8gumFjOAiGAxF4VUKLCBQepgDZfiYsIP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ob0s+2
	1VhVTst2ANMB3vwE3HTdqbSBHbWGqSGJSmldyj1Zyobvq59NxthNlMQ2LDf2qw7S
	hcIsapkdpHzu8A+8WUKgFcGpznpHu5EX65tKjaBO8aUCwgGi6bRO0apd93mmtTtM
	744r3o7ngjlR4M9j1OcPfJYcs1Cn1/8oGb5fw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DEA96413;
	Thu,  9 Feb 2012 19:55:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C1BA6412; Thu,  9 Feb 2012
 19:55:35 -0500 (EST)
In-Reply-To: <1328831921-27272-5-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 10 Feb 2012
 00:58:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F136A98A-5381-11E1-ADCA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190359>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
>  diff.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 8406a0d..6220190 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1343,7 +1343,8 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
>  	}
> =20
>  	width =3D options->stat_width ? options->stat_width : term_columns(=
);
> -	name_width =3D options->stat_name_width ? options->stat_name_width =
: 50;
> +	name_width =3D options->stat_name_width ? options->stat_name_width
> +		: term_columns() - 20; /* the graph defaults to 20 columns */

Why?  Isn't 80-50 =3D 30?

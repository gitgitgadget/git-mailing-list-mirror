From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/28] git-remote-mediawiki: Rewrite unclear line of instructions
Date: Tue, 11 Jun 2013 08:04:14 -0700
Message-ID: <7vsj0od6z5.fsf@alter.siamese.dyndns.org>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-8-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 17:04:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmQ7S-0000Ao-RY
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 17:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab3FKPES convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 11:04:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab3FKPER convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 11:04:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D29AF2557C;
	Tue, 11 Jun 2013 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QBOb9AlBoI3Q
	bMp//rk1VCxR/mM=; b=GaVPaGY+ybW4IfPz2PZpvXSySHuiYcIDKSWOGXdQQQyc
	3OUrAFJUCtX+w5D0/UTzBEXbmkuywuBawGjRhHIYtc0E8Az3wmzKJ6sPUIkkF1Wk
	uTDewO9371pPNA5rKiIJJl5MrlO10r2tNFozRTKLD0E4oZJCrIZRcSzfjSp0Jz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WZ85Rm
	jfKD4w5D829vkDyjAq/YqvRXvU29B4En+2NRG3skO1quDOp11RiOETH7T2zc8toQ
	BRdje+wM0767Rc09h5s1TE4Tl2/ha0BW9TSl+qIeryzl0h3W640OdKkZniawXDsx
	TsxcEZ/lh8lXsuoPdNmNoCCmTsp13rCrv8n6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C07E325579;
	Tue, 11 Jun 2013 15:04:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 323FF25577;
	Tue, 11 Jun 2013 15:04:16 +0000 (UTC)
In-Reply-To: <1370816573-3808-8-git-send-email-celestin.matte@ensimag.fr>
	(=?utf-8?Q?=22C=C3=A9lestin?= Matte"'s message of "Mon, 10 Jun 2013
 00:22:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F2A12BC-D2A8-11E2-B865-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227451>

C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:

> Subroutines' parameters should be affected to variable before doing a=
nything
> else
> Besides, existing instruction affected a variable inside a "if", whic=
h break
> Git's coding style

I think s/affect/assign/g is what you meant.

By the way, I often see two styles of the "let's take arguments into
parameters before doing anything else" at the beginning of subs:

        my ($namespace) =3D @_;
	my $namespace =3D shift;

My impression has been that both are equally common, but the latter
is done more often when picking out small and fixed number of
mandatory parameters upfront (and later, optional parameters are
used by directly reading what remains in @_).  Does Perlcritique say
anything about this issue?

> Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 431e063..2db6467 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -1333,7 +1333,8 @@ sub get_mw_namespace_id {
>  }
> =20
>  sub get_mw_namespace_id_for_page {
> -	if (my ($namespace) =3D $_[0] =3D~ /^([^:]*):/) {
> +	my $namespace =3D shift;
> +	if ($namespace =3D~ /^([^:]*):/) {
>  		return get_mw_namespace_id($namespace);
>  	} else {
>  		return;

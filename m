From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/8] gitweb: Use descriptive names in
 esc_html_hl_regions()
Date: Wed, 04 Apr 2012 14:38:55 -0700
Message-ID: <7vwr5v6uts.fsf@alter.siamese.dyndns.org>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1333569433-3245-2-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:39:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXuy-0004UG-5q
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077Ab2DDVi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 17:38:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757007Ab2DDVi6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 17:38:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A273BE7;
	Wed,  4 Apr 2012 17:38:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xg7hlIlK0gDZ
	lEn1jItDzOovjME=; b=J4hpBhcMeEHOOtrdyAjVUX1C16JGizIukU7eIL567i3C
	pgKfEN7InFtu5SJfSl/kg47X+OYwHRVHBWUf7eCW1xF5+GYCrtgkEv0/2WP/zSBX
	FWUq8oumvfsxXXyCEtOVTtbVOTrDp124sRnqJNrNUuDbo5mXxu+K9xh65HOL2k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dpbdFy
	A4yQj9CShF1aBAMAbEjZ13ECVxL83fjL31hEBUECfx+v/roWtjrf9Npuwi6y5fhx
	kYN4finXhqpO7mKDvmxMeVWG12pryROnsYawFVcSvXVTJiYTfhnMFb5455RgPE5l
	07/YRBpZDl5KXXTDLzo31WqznkOEp1tBb0mco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F79F3BE6;
	Wed,  4 Apr 2012 17:38:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC11E3BE5; Wed,  4 Apr 2012
 17:38:56 -0400 (EDT)
In-Reply-To: <1333569433-3245-2-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Wed, 4 Apr 2012
 21:57:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9517D8CA-7E9E-11E1-93DA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194747>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> The $s->[0] and $s->[1] variables look a bit cryptic.  Let's rename t=
hem
> to $beg and $end so that it's clear what they do.

Why not $begin and $end?

>
> Suggested-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  gitweb/gitweb.perl |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a8b5fad..a3754ff 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1738,12 +1738,14 @@ sub esc_html_hl_regions {
>  	my $pos =3D 0;
> =20
>  	for my $s (@sel) {
> -		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
> -			if ($s->[0] - $pos > 0);
> +		my ($beg, $end) =3D @$s;
> +
> +		$out .=3D esc_html(substr($str, $pos, $beg - $pos))
> +			if ($beg - $pos > 0);
>  		$out .=3D $cgi->span({-class =3D> $css_class},
> -		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0=
])));
> +		                   esc_html(substr($str, $beg, $end - $beg)));
> =20
> -		$pos =3D $s->[1];
> +		$pos =3D $end;
>  	}
>  	$out .=3D esc_html(substr($str, $pos))
>  		if ($pos < length($str));

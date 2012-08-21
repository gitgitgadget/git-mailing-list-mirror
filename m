From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Tue, 21 Aug 2012 15:05:46 -0700
Message-ID: <7v628bdhol.fsf@alter.siamese.dyndns.org>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
 <1345523464-14586-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:05:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3waD-0002aq-N6
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 00:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715Ab2HUWFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 18:05:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758465Ab2HUWFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 18:05:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 917BD8D50;
	Tue, 21 Aug 2012 18:05:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BT9uV4WZjOo2
	F7AxmAYZtuJ3HrQ=; b=GfDFjSVauALf5jZ6+VUvs62Hke0f/Vh2pXL457YZJ7dA
	0m+tZOpAWh6BoomyFfYrKVyVyuCfhD48pqkbRfvvwLVpj/UiG3/qZcwp0iZzbSFQ
	pbOM0AGaiO4wLK7nD4P1B548Tnb9HXHXxxLbxHfZGbwHuaKsRnwiU8Ja+eHGmp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o9XYl8
	KSX9SI+6fWwNgxtpNrRl9oiDgybDh/mY2pRPxNWc7ndkBMi6/YCMMAIDi9/W6c+n
	99IPO4zCMJPuvJOysqBrK3M/Rpfto3VcFiKhCgBUKzInRPVYuAUS3J+GmaKI6k4B
	Kd6tqfXhBtPaQEXlmxeUo7fH4HP5K0RygPwzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F3538D4F;
	Tue, 21 Aug 2012 18:05:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D59728D4E; Tue, 21 Aug 2012
 18:05:47 -0400 (EDT)
In-Reply-To: <1345523464-14586-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 21 Aug
 2012 11:31:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CB9A1EC-EBDC-11E1-B515-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203997>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> From: Jiang Xin <worldhello.net@gmail.com>
>
> Use i18n-specific test functions in test scripts for git-remote.
> This issue was was introduced in v1.7.10-233-gbb16d5:
>
>     bb16d5 i18n: remote: mark strings for translation
>
> and been broken under GETTEXT_POISON=3DYesPlease since.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/t5505-remote.sh | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index e8af615..07045e3 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -27,10 +27,16 @@ tokens_match () {
>  	test_cmp expect actual
>  }
> =20
> +tokens_i18nmatch () {
> +	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
> +	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
> +	test_i18ncmp expect actual
> +}
> +
>  check_remote_track () {
>  	actual=3D$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\=
1|p')
>  	shift &&
> -	tokens_match "$*" "$actual"
> +	tokens_i18nmatch "$*" "$actual"
>  }

Which part of the output from "git remote show" does this test
expect to be translated?  Specifically, does "tracked" ever get
translated?

It appears that _(" tracked") is indeed marked for translation in
the source, so how can we expect value in $actual be any useful for
any comparison?

Confused...

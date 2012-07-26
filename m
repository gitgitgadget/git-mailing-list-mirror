From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: leave \n out of translated diffstat
Date: Thu, 26 Jul 2012 10:46:58 -0700
Message-ID: <7va9ym8lf1.fsf@alter.siamese.dyndns.org>
References: <1343307156-16528-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:47:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuS9V-0004Jt-Fd
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab2GZRrD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jul 2012 13:47:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212Ab2GZRrB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 13:47:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 742E98C24;
	Thu, 26 Jul 2012 13:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j+Zs35nsxTBu
	xK3hX9X4RGUOy80=; b=lbCJNVoDNLIIYrv0fbBtPNKoVgguU4vwQ+QPtkesf/OX
	6K0ZoyHVSFcQyKMiyXlLSYbw2oPN/E8xRo4PDJbKs+ZYKBx6O7ZZz35bU8ZY3q0U
	YBv2a2MEVW+5C64cdOHizCwqVW1xLF4X9I3pI8no+RtRMTd9poNeCQ+mwrbKrxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nArkNp
	InHvUa8P/yPz4yXbuDU3ccsCUyK8wHRw6Z8sPczCpxrJVnC4hXoOenrmY2eEFYrj
	fGoaFs3kDeMr87RIvYxwnBJu11pSPB+GzQa657nEhycSQ6bGahvq+6kYDpV1jTMm
	bJphBJYdqrDkp1s0qxkuwo0r1O2y2/72TLmS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D898C23;
	Thu, 26 Jul 2012 13:47:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E399D8C21; Thu, 26 Jul 2012
 13:46:59 -0400 (EDT)
In-Reply-To: <1343307156-16528-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 26 Jul
 2012 19:52:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E69C0C6C-D749-11E1-8B3E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202285>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/diff.c b/diff.c
> index 62cbe14..95706a5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1397,7 +1397,7 @@ int print_stat_summary(FILE *fp, int files, int=
 insertions, int deletions)
> =20
>  	if (!files) {
>  		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
> -		return fputs(_(" 0 files changed\n"), fp);
> +		return fprintf(fp, "%s\n", _(" 0 files changed"));
>  	}

Good.

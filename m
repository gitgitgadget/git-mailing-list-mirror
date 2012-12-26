From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] wildmatch: rename constants and update prototype
Date: Wed, 26 Dec 2012 10:44:43 -0800
Message-ID: <7vvcboodpg.fsf@alter.siamese.dyndns.org>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
 <1356163028-29967-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 19:45:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnvyY-00011L-OM
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 19:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab2LZSov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Dec 2012 13:44:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab2LZSou convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Dec 2012 13:44:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A5DAF22;
	Wed, 26 Dec 2012 13:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EvD+CCWe4ukF
	4pKhZRr681nHzG8=; b=AUDfg0hF/7vaj24c+sG1p6Zl6pWqgmAE1tO/WmEhOHnb
	nXV+5GPiTtRwBeezov36P+VBoiRlaCXqnfLPxhrAciXxNIJxSeqiYinE0fkVwR8m
	ksGzItpFWxJ27gB7eDuo1wljfFQbHVezlDYOKC1BrENOA0uuN6uKP/sKf2c1RTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RZFXDB
	ti0E+95GzqMLpd2d23AIsiplveFuenYp2OpT8hJLxW9ErIGlNQSVZ4ioHVade66y
	DxqxLMvXTImEQAgE920bV2VG9x8EFFSxfOQh+wvjHYy8b52iAHj5GgmTpKmS1zJ1
	QHJd6sw1pfGY0fUkbieVocP1NDqeKIFWHhdEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 520F0AF1F;
	Wed, 26 Dec 2012 13:44:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1C91AF1B; Wed, 26 Dec 2012
 13:44:46 -0500 (EST)
In-Reply-To: <1356163028-29967-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22 Dec
 2012 14:57:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52A7F8CA-4F8C-11E2-AEFA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212143>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -134,101 +131,102 @@ static int dowild(const uchar *p, const uchar=
 *text, int force_lower_case)
>  				p_ch =3D NEGATE_CLASS;
>  #endif
>  			/* Assign literal TRUE/FALSE because of "matched" comparison. */
> -			special =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
> +			special =3D p_ch =3D=3D NEGATE_CLASS;

Leftover comment needs to be reworded as well???

>  			if (special) {
>  				/* Inverted character class. */
>  				p_ch =3D *++p;
>  			}

I'd prefer "special" used in the "case '['" given a more sensible
name here.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] tag: support column output with --column
Date: Wed, 09 Feb 2011 13:51:02 -0800
Message-ID: <7vvd0sop15.fsf@alter.siamese.dyndns.org>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
 <1297178541-31124-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 22:51:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnHwS-0004vp-6R
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 22:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935Ab1BIVvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 16:51:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1BIVvK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 16:51:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C3F0426E;
	Wed,  9 Feb 2011 16:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=15oSF2FSI9Kh
	aq0oyKPfKR21W18=; b=SjrXQt6YdBCJASuruBy2vkfv3EpL6PizSrd1NUTlIymC
	yd1vlobKHtu1px5zWFZ17I6fBiuSgEuOBn2W/NzOE8NUfqmy98n/xzHIBTkNGvtz
	/aBLnUzqGbwzjFU9YjSxrbIxaEzOg9E/b+lOevJNjZXjFtOCe5acpQC0zxiFpl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=js+tcn
	b+rSB4+Vw2u7fXImOz1xK126JlTMy4ydtslJcR4+QtCifYy8e7UIQjJj1qpMr3E8
	97fmUg3m/wH9gGXlzOZki5/jBHtWY2CIMrXXYoZOOYjYov++f4unvC4/jczR6BLu
	75Af2l9G3Rre8+bD3Fdtotwv3WEM/2Jgb9rdA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1ADF6426D;
	Wed,  9 Feb 2011 16:52:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D545426C; Wed,  9 Feb 2011
 16:52:04 -0500 (EST)
In-Reply-To: <1297178541-31124-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Tue\,  8 Feb
 2011 22\:22\:20 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D72A1ABE-3496-11E0-B225-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166446>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -52,7 +54,7 @@ static int show_reference(const char *refname, cons=
t unsigned char *sha1,
>  		}
> =20
>  		if (!filter->lines) {
> -			printf("%s\n", refname);
> +			string_list_append(&layout.items, refname);

Hmm, is this robbing streaming output from people who do not care about
columnar output?

I tend to agree with others who suggested you to port column to platfor=
ms
that lack it.

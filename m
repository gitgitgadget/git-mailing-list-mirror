From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure.ac: link with -liconv for locale_charset()
Date: Thu, 20 Mar 2014 14:12:48 -0700
Message-ID: <xmqqzjkkwp4f.fsf@gitster.dls.corp.google.com>
References: <20140311183529.GA73693@hades.panopticon>
	<xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
	<531F902D.4050102@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, wxs@FreeBSD.org,
	Dmitry Marakasov <amdmi3@amdmi3.ru>
To: =?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 22:13:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQkGq-0004S3-3o
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 22:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759786AbaCTVMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 17:12:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759504AbaCTVMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 17:12:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEFE57611B;
	Thu, 20 Mar 2014 17:12:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b5j+HaRd1ziQIvRftnmjU1RzCrc=; b=GRtLqO
	2IaRcjCkhC2E+006Z13M8tzYPImM9RKdHC5P2R3dc/NuXDOWKjeIaAglwE4QQVS/
	Xye4tIhQ0OaMHe7lMuee6oiPb5APaqwRLkKmDyol6vQtBOuTmAnyNE6myIjvpW9t
	a9hIarESJP9puOtYRhJ74uZ1UiHsoIm1RfIp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QCkHlNdMdclJRUmTnNdEFZZUDbupjJYq
	/4witDFsPxDcCo8q/2LeXXGsnsepljzKc3V4gTgXWcaLf3K5e9jrXh8CpHKKdmHv
	tmCXjIJLZKhDqjBkNeSc7BZlHKw+ZVJp/q+CZd63ndediqwzNgBZ6XgD3r/xhcBR
	XWB4+3m9sFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBE0D7611A;
	Thu, 20 Mar 2014 17:12:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16C2876118;
	Thu, 20 Mar 2014 17:12:52 -0400 (EDT)
In-Reply-To: <531F902D.4050102@aegee.org> (=?iso-2022-jp?B?IhskQiclGyhC?=
 =?iso-2022-jp?B?GyRCJ1onXSdxJ18bKEIgGyRCJzEnUSddJ1EnZSdZJ2AnUxsoQiIncw==?=
	message of "Tue, 11 Mar 2014 23:37:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65C0364E-B074-11E3-8363-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244584>

Дилян Палаузов  <dilyan.palauzov@aegee.org> writes:

> diff --git a/Makefile b/Makefile
> index dddaf4f..dce4694 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -59,9 +59,9 @@ all::
>  # FreeBSD can use either, but MinGW and some others need to use
>  # libcharset.h's locale_charset() instead.
>  #
> -# Define CHARSET_LIB to you need to link with library other than -liconv to
> +# Define CHARSET_LIB to the library you need to link with in order to
>  # use locale_charset() function.  On some platforms this needs to set to
> -# -lcharset
> +# -lcharset, on others to -liconv .
>  #
>  # Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
>  # need -lintl when linking.

This was unfortunately lost in the noise and I missed it.  I think
the updated text is much more clear than the original.

Thanks.

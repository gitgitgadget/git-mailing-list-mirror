From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve user-manual html and pdf formatting
Date: Mon, 06 Jan 2014 09:20:33 -0800
Message-ID: <xmqqd2k5jace.fsf@gitster.dls.corp.google.com>
References: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:20:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Dr3-0003df-4T
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbaAFRUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:20:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbaAFRUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:20:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9ABA5D929;
	Mon,  6 Jan 2014 12:20:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=An/ceBBD+bS2LAzWjmOq0/lNIKc=; b=ZMgZ7t
	zVzK4pbIEGkTT7MHXg9zod977PXtE1iUOdSSCBa+0n03Z4BqborK1RZIITppP88E
	az3hk7mHPv6E9SkI2WC+jY6r23VSksiBKZ3ZoeEQalh7SWK6Me1FWBORRITj3191
	S3E45VpHCHs+cZR91HINNUrvIhhIS6NEpowAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WrbyjDIWUeakqvPXSopXiAzawcqQjw3q
	NcYrt4e+6WgtVNpSG7RMrh93UnNd3o9NNxPG+LgL+Erv2hXeUaEnTyMZpfx4QGe0
	Jn+UONmgdZfrtErvLKrTERug7BTPLhQE8GufNig2H8/EPhWn/7JGnADLjwmLEGjU
	nM/ycQOueTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D86C65D925;
	Mon,  6 Jan 2014 12:20:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC2995D921;
	Mon,  6 Jan 2014 12:20:35 -0500 (EST)
In-Reply-To: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net>
	(Thomas Ackermann's message of "Sat, 4 Jan 2014 10:07:51 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAF01BBC-76F6-11E3-9168-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240032>

Thomas Ackermann <th.acker@arcor.de> writes:

> Use asciidoc style 'article' instead of 'book' and change asciidoc title level.
> This removes blank first page and superfluous "Part I" page (there is no "Part II")
> in pdf output. Also pdf size is decreased by this from 77 to 67 pages.
> In html output this removes unnecessary sub-tocs and chapter numbering.
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/Makefile        | 2 +-
>  Documentation/user-manual.txt | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 91a12c7..36c58fc 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -324,7 +324,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
>  
>  user-manual.xml: user-manual.txt user-manual.conf
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> -	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book -o $@+ $< && \
> +	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d article -o $@+ $< && \
>  	mv $@+ $@
>  
>  technical/api-index.txt: technical/api-index-skel.txt \
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index cbb01a1..130c2f4 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,5 +1,5 @@
> -Git User Manual
> -_______________
> +&#65279;Git User Manual
> +===============

Will queue after dropping the extra.

Thanks.

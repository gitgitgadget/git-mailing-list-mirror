From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
Date: Wed, 18 Jul 2012 17:13:43 -0700
Message-ID: <7v7gu0wqtk.fsf@alter.siamese.dyndns.org>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
 <5c4e73c3bed1a7c9135a6229d8d66aa2c61e319a.1342649928.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 02:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SreNL-00034c-Hl
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 02:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab2GSANr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 20:13:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab2GSANq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 20:13:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB17383DB;
	Wed, 18 Jul 2012 20:13:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VDeCh227bnZJ4/iDDCIwuip8h+c=; b=ZgaEE4
	5oPwWUeH/2jXjcZmXh0p09nJwvzvG13XqyxS2pzXgQjkwP1+ExNvxLBrwga+Oxt8
	+KksY8g4gzvgFe2xv1SjvJ/fgPnLd09owlwt9Q/7vEqMuqWktIi93TK9rTBAxm2P
	VH13lp3gyNGuiBTCrdzk9x90M10/GAwDFpUjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDffvMbmtIbFeiRUfnS9KUWnavW7ct9Z
	r4kfUEGkz3f3rEgXOE7gt9yWnxvwX3ryB5Nd8swB7+8+i/kSjA8pFZM2elOCqENa
	UtVdmgy+Ct05vTSWBafocC2ej1mKUz3kDwnrxUvpH1wxrB4GGhiuXL1s7v02nED8
	r8Eogs+9CRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D96FE83DA;
	Wed, 18 Jul 2012 20:13:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3ACED83D9; Wed, 18 Jul 2012
 20:13:45 -0400 (EDT)
In-Reply-To: <5c4e73c3bed1a7c9135a6229d8d66aa2c61e319a.1342649928.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Thu, 19 Jul 2012 00:34:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9ABF39E0-D136-11E1-B9A0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201708>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> The new name fits better with the macro signature, and underlines the
> similarities with the autoconf-provided macro AC_SUBST (which will be
> made even more pronounced in planned future commits).
>
> Once again, no semantic change is intended, and indeed no change to the
> generated configure script is expected.
>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---
>  configure.ac | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 14c7960..789926f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -3,10 +3,10 @@
>  
>  ## Definitions of private macros.
>  
> -# GIT_CONF_APPEND_LINE(LINE)
> +# GIT_CONF_SUBST(LINE)

I see that [PATCH 1/7] needs to be updated so that it describes the
new two-argument form of GIT_CONF_APPEND_LINE(VAR, VAL), and this
patch needs to be updated for GIT_CONF_SUBST() with the same.

>  # --------------------------
>  # Append LINE to file ${config_append}

Also the description definitely wants to be updated; it is no longer
LINEness that matters.

Other than that, 1 & 2 looked very nice and sensible.

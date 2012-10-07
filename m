From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 07 Oct 2012 15:32:11 -0700
Message-ID: <7v626lq5g4.fsf@alter.siamese.dyndns.org>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:32:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzOZ-0006YH-VD
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab2JGWcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 18:32:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab2JGWcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 18:32:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502FA8C5C;
	Sun,  7 Oct 2012 18:32:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aYlFHBNXpLvhdAWIXSEaFLbh2/8=; b=Z8UBJd
	fjSJuRdq40HKWkgFhyBLTrzp0wVZZpxAsxoB7b4EycFFplzYc4EPYFeUM5M6Q1C9
	14nfA4Bjox4ZyDQgLFF/3BTEc98wdUJrvBh+05iYwpBscRjixBpM3Y2mjl8ddX8i
	fnUePax+3TjgfoGyMGrQ7hilAC2Ja2Wqk0wT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QM7huo5I0WVbMpoTY6Op57k/nG365iem
	EArLoMPXUuPcSsdq7d9qvadQrat/W2G84glBh1O4GJ8F6+JkG63+grB0LrZIVi4w
	XtUra4r8hDYxNjFV9VE00SWi5sLH5QDhYWc80/ie9s7Ujpo4fjMCmK0GHzIChf7u
	eNbMuxxd8cM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CE6F8C5B;
	Sun,  7 Oct 2012 18:32:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3CCD8C57; Sun,  7 Oct 2012
 18:32:12 -0400 (EDT)
In-Reply-To: <20121007214855.GB1743@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 7 Oct 2012 17:48:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6C08692-10CE-11E2-BC26-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207207>

Jeff King <peff@peff.net> writes:

> Why not do it like this:
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 267dfe1..ca10313 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -152,7 +152,8 @@ endif
>  endif
>  endif
>  
> -all: html man
> +DEFAULT_DOC_TARGET ?= html man
> +all: $(DEFAULT_DOC_TARGET)
>  
>  html: $(DOC_HTML)
>  
>
> which covers both cases? That is also how we handle DEFAULT_TEST_TARGET.

Surely, and thanks.

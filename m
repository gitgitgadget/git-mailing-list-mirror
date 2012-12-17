From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: don't link to example mail addresses
Date: Sun, 16 Dec 2012 18:24:58 -0800
Message-ID: <7vehippg91.fsf@alter.siamese.dyndns.org>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
 <20121215182408.GD2725@river.lan>
 <20121216120405.GA14320@sigill.intra.peff.net>
 <20121216140029.GE2725@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Dec 17 03:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkQOb-0001dE-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 03:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945Ab2LQCZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 21:25:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab2LQCZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 21:25:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19882A1E7;
	Sun, 16 Dec 2012 21:25:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dYBURQc2cKcLJ6yNpbnqGnH4mHc=; b=q66Jds
	Jrkp1HkwrrD5QaPPsDfdIL5++0pDT5eIL7xO4BPIzgQWFUiUlynfrffSzIrZa41r
	W71sHA9OYLXbr/nB6V+vRJx0nUruYM+q2pntK/8GSJP0s8CkDFnlaJS/V5/5AUyG
	D7XazuuK7Q4pMTEOviOBOjPbLtweJBg4uIz2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wu9FmlEp8fB4MxRybK1yCpRnTmbRET95
	bYqStYSB00zfG2V9ktO5h0dGjO043u8ZX8pNnL7g75EaR1Yrrxowk4Dz4vwJgKeT
	Yj61nlfEcwwOIeWQUi3sEjoFbqnV5Gu8iA4ohS55qsjemX9zE5eo0Zzt0wfd9pvV
	xxwV7pg4m9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07768A1E6;
	Sun, 16 Dec 2012 21:25:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59412A1E0; Sun, 16 Dec 2012
 21:25:00 -0500 (EST)
In-Reply-To: <20121216140029.GE2725@river.lan> (John Keeping's message of
 "Sun, 16 Dec 2012 14:00:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F510176C-47F0-11E2-BD00-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211623>

John Keeping <john@keeping.me.uk> writes:

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index d1844ea..68bca1a 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -427,7 +427,7 @@ they made it.
>  
>  Here `<name>` is the person's display name (for example
>  ``Com M Itter'') and `<email>` is the person's email address
> -(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
> +(``\cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)

I seem to be getting

(<tt>`\cm@example.com'').  `LT</tt> and <tt>GT</tt> are the literal less-than (\x3c)

out of this part in the resulting HTML output, which is probably not
what you wanted to see.

I have a feeling that it might be a better solution to stop using
these pretty quotes.  It's not like we use them a lot and a quick
scanning of "git grep '``'" output seems to tell me that many of
them should be `monospace output`, and the rest (mostly references
to section headers) can be "Section".

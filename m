From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v3] git-fast-import.txt: improve documentation for
 quoted paths
Date: Thu, 29 Nov 2012 11:33:19 -0800
Message-ID: <7vr4ncp5kw.fsf@alter.siamese.dyndns.org>
References: <20121129185404.GC17309@sigill.intra.peff.net>
 <1354216293-21921-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:33:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9re-0005mQ-Hs
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab2K2TdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:33:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab2K2TdW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:33:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F13429E8D;
	Thu, 29 Nov 2012 14:33:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8sqgiON8ci/lQ7ImN0vZdycp2fQ=; b=D3Lg/T
	2L4+6SiHyTzyyo0tWmhf7eRwzLHpH7HIEBMZdMeG/iigZpdgKOW6tcnQHY45KIfL
	JzcU3t2PEStLHfaM7m3w6n33JPWOED0C6At3Pn8jwPEEI9TNK/77lS/VZTzEn+J8
	rgJG/C2QZ+DCJKLq07ZC7hLCyFHMDwnhTK0mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9bWaulLfNEzMuqeKTUuvMAUlLyb6fPS
	4hg9kuCAAD7zO3g80vSSa66dKrGr31srHfXwylLrL6AEdh8wrE1PuPNBcBmtt94y
	VufO/NRCkZoyUtl8dAQXMNi5f2eiXMvt3Sk9OM2pP+OomtRNi5sVJjJ+dtUNJZ+Q
	IWGNkb7Z9To=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE3F79E8C;
	Thu, 29 Nov 2012 14:33:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C7329E8B; Thu, 29 Nov 2012
 14:33:21 -0500 (EST)
In-Reply-To: <1354216293-21921-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu, 29 Nov 2012 20:11:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2420664-3A5B-11E2-8279-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210871>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The documentation mentionned only newlines and double quotes as
> characters needing escaping, but the backslash also needs it. Also, the
> documentation was not clearly saying that double quotes around the file
> name were required (double quotes in the examples could be interpreted as
> part of the sentence, not part of the actual string).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> cut-and-paste of Peff's version, adapted from mine.
>
>  Documentation/git-fast-import.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 959e4d3..d1844ea 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -562,8 +562,12 @@ A `<path>` string must use UNIX-style directory separators (forward
>  slash `/`), may contain any byte other than `LF`, and must not
>  start with double quote (`"`).
>  
> -If an `LF` or double quote must be encoded into `<path>` shell-style
> -quoting should be used, e.g. `"path/with\n and \" in it"`.
> +A path can use C-style string quoting; this is accepted in all cases
> +and mandatory if the filename starts with double quote or contains
> +`LF`.

... or backslash?

> +In C-style quoting, the complete name should be surrounded with
> +double quotes, and any `LF`, backslash, or double quote characters
> +must be escaped by preceding them with a backslash (e.g.,
> +`"path/with\n, \\ and \" in it"`).
>  
>  The value of `<path>` must be in canonical form. That is it must not:

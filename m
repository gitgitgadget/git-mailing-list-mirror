From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] apply: Clarify the description of -z
Date: Sun, 22 Nov 2009 09:28:55 -0800
Message-ID: <7v8wdyii3s.fsf@alter.siamese.dyndns.org>
References: <4B09648E.5060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 18:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCGFO-0001P2-Ee
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 18:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbZKVR26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 12:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755519AbZKVR25
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 12:28:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbZKVR25 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 12:28:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9786A82C9D;
	Sun, 22 Nov 2009 12:29:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=DnyZU9gluSHYLHt8W1YjZV55R
	Lo=; b=YKwcgoAhN5ZutjLNw8+ml1TYdv8QMY2hlvpOCDaJyuUy4XHIeRhAnc2jE
	fm1DtZ2N2ZR6fJeoCX0ZvgR4pOmgKYumXpdals3B3PGAegcg6+HAvfmETd+iFEHg
	oVKJQz1DSeU9fUxNRvPTN6pxnuLkZ2+14t9tUjl/Awp4jHOXCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=k1EoCl1MeaAd+c0I44S
	cpmWmSS0tfdtnJFW7wjaGhin6Cog1bCcXrDt+jMxrrt71BQwFpbn78hNnxjx8Gjn
	j70RzroQSiD+VlTxLKMTuafpm09xxsTQ2eRQ1YvwXpQ/qVtsQudkLTTt8YSmO2QQ
	erOS38msvEMKxMXZ9dIxNeNo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 795AD82C9C;
	Sun, 22 Nov 2009 12:28:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C61B582C9B; Sun, 22 Nov
 2009 12:28:56 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85032928-D78C-11DE-BB9C-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133445>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> The description of -z says that a machine-readable format will be
> used "when showing the index information". From that description,
> it is not at all clear which other option it will modify the
> behaviour of. Explicitly state that -z modifies the behavior
> of --numstat.
>
> Also correct the description of the "munging" that takes places
> in the absence of -z, namely that apart from the characters
> mentioned, double quotes are also escaped and that the pathname
> will be enclosed in double quotes if any characters are escaped.
>
> Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
> ---
>  Documentation/git-apply.txt |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.tx=
t
> index 5ee8c91..4f791ee 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -87,11 +87,13 @@ the information is read from the current index in=
stead.
>  	rejected hunks in corresponding *.rej files.
> =20
>  -z::
> -	When showing the index information, do not munge paths,
> -	but use NUL terminated machine readable format.  Without
> -	this flag, the pathnames output will have TAB, LF, and
> -	backslash characters replaced with `\t`, `\n`, and `\\`,
> -	respectively.

I think diff-format.txt has the same description; could you please upda=
te
that to be in sync?

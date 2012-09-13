From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 10:39:09 -0700
Message-ID: <7vzk4t960y.fsf@alter.siamese.dyndns.org>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 19:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDNr-0000ap-62
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 19:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab2IMRjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Sep 2012 13:39:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab2IMRjN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 13:39:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC5580FE;
	Thu, 13 Sep 2012 13:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/zzzhbReFwkC
	s2gc1T3K2aQm0xA=; b=k0H+sr398e9O1H9L1mIUu1JzdDJF2bSMPpOyYJSDjGvj
	fJDPOMtpMeqqP00pymk0FEqbwEmIYhYegguYL9Lw/3s1wSJB8Pb3zUAtMpzWuFf2
	3y5+cBwctWFBCP6+Icq+9h1ZExNHJRLkSR0T7FkpBiuniB6nqxFPj5gqeAjqLk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=F3qjEb
	b9k9UHh2UgeCTsBzsw8JHRL1id1GXmO5VkxA60dOTylT+5ihl3NykCf+B8iTbmzI
	ETf+XwYd+2SLtLyql/D/SsEqDq2mAZop3OmykCwSdaEr3n/SMOjAqYYazYtJ2F/T
	0yUx8iT3oSASlPMWoeDGtLPbX8rIZWdT7JaWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D3AD80FD;
	Thu, 13 Sep 2012 13:39:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D580980F9; Thu, 13 Sep 2012
 13:39:11 -0400 (EDT)
In-Reply-To: <1347545786-936-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Thu, 13 Sep
 2012 21:16:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDDDF124-FDC9-11E1-9C4A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205396>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  Git is still partly i18n-ized, turning a few strings back does not
>  seem a big regression.

More than one people explicitly said that they do not want to see
this in Klingon.  Even if the system is fully internationalized,
these "... (+), ... (-)" should never be localized, just like we
will never localize "diff --git", "index f00f..abcd", etc.

In other words, it is not a "regression" to begin with.  Turning
this back to "C" is a bugfix.  We shouldn't have had marked it with
_() in the first place.

>  If you mean projectlang vs a local language, I looked into that and =
I
>  don't think we could support two non-C languages using standard
>  gettext interface. So it's either "C vs another", or make use of
>  unofficial gettext features, or roll your own.

Yeah, that is true, too.

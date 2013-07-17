From: Junio C Hamano <gitster@pobox.com>
Subject: Re: maintainer question: config http.<url>.* patch administrivia
Date: Wed, 17 Jul 2013 10:35:56 -0700
Message-ID: <7v7ggp6qdf.fsf@alter.siamese.dyndns.org>
References: <68EA6AFC-D90D-4704-AF1A-92AF15617E23@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 19:36:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzVe0-0001SJ-OO
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 19:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527Ab3GQRgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 13:36:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730Ab3GQRf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 13:35:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 977F931261;
	Wed, 17 Jul 2013 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJ9ITeqPLHHDlT9jpGKT7qpsFp0=; b=QS0Lw2
	yRu3JzavtHrOJ2qMFxID93ZyyexM5MOZ4puNTDJyUxYi60tKuuyP01ZobHA7h06W
	9mz18oN/epkszcbqXLO8OF0QU3i1NFHKZArsJcsCZNa/hL1ZdyOYMDIy4PdgnpRy
	JWm+ZzMssqIkiffuPWMgNp5HtAkkiSNbEPxQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J/r1ZaGCi6o1sybjTFJ/mYApYIbsverS
	olRcQoUFk70n6hvgSb1nC2zYlvX2pcJEb9L9BUO3QohZ3Rv33fNDec1WJTrd/bI3
	ejm79opBQJNSOPAo0dnLBTB+y4ECEyQugNYlGiS4t4JKc+hkKvao8TWOc31AMEyf
	xr0JeDWw9KQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BD7431260;
	Wed, 17 Jul 2013 17:35:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3A383125B;
	Wed, 17 Jul 2013 17:35:57 +0000 (UTC)
In-Reply-To: <68EA6AFC-D90D-4704-AF1A-92AF15617E23@gmail.com> (Kyle J. McKay's
	message of "Wed, 17 Jul 2013 08:02:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57020F12-EF07-11E2-9970-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230638>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> However, upon further consideration (I noticed that the preparatory
> patch and v4 of the textual matching patch made their way into pu),

Do not read too much into being in 'pu'.  They are there primarily
so that I won't forget what is in-flight and can be replaced or
dropped.

> perhaps it would be more convenient for you if I re-released the
> following patch series:

Sorry, but I do not understand.  What do you mean by having these
three patch series?  Are they "There are three possibilities, pick
one and discard the other two"?  If so, then as the maintainer, I
personally would not care ;-), as they would be commented upon, and
I won't pick any of them up until there is one list favorite.

If "These build on top of each other in this order", then it is
easier for me to manage if they were in a single series.

If f1ff763a (http.c: fix parsing of http.sslCertPasswordProtected
variable, 2013-07-12) is already solid and need no further tweaking,
it would be wise not to include the patch in any of your reroll in
any case.  Instead, just build your series on top of that commit,
and make it clear that the series is meant to apply on top of that
commit in the cover letter [0/n] of the series, or after "---" line
of the first patch [1/n] in the series.

As to allowing GIT_SSL_CERT_PASSWORD_PROTECTED=no, I agree that it
does not belong to the http.*.<var> configuration series, so making
it an independent patch, perhaps on top of f1ff763a, would make
sense.  If the other patches have any textual dependency, you can
make it [1/n] of your series and we can treat it just like f1ff763a,
that is, make sure it is solid regardless of the rest of the series,
and make it advance before the remainder of the series, so that we
can still replace http.*.<var> implementation on top of these two
freely.

>
> [PATCH v5]: config: support http.<url>.* settings - (1) textual matching
>
> * contains 0001 the same preparatory http.sslCertPasswordProtected
> * contains 0002 the same v5 textual matching http.<url>.* patch
>
>
> [PATCH v2]: config: support http.<url>.* settings - (2) url
> normalization
>
> * contains 0001 url normalization matching with feedback updates
> * contains 0002 url normalization test
>
>
> [PATCH v1]: config: support http.<url>.* settings - (3) any user
> matching
>
> * contains 0001 a new patch that extends (2) to include any user
> matching
>
>
> And drop the GIT_SSL_CERT_PASSWORD_PROTECTED patch as while it's
> logically related to the http.sslCertPasswordProtected patch it's not
> logistically related since independent areas of the file are touched
> and it could be successfully applied before or after the other
> patches.  It can go together with any forthcoming enable-only fix for
> GIT_SSL_CERT_PASSWORD_PROTECTED and other such environment variables
> or just be dropped entirely.
>
> I do not, however, wish to create any additional maintainer work, so
> wanted to check with you before sending out any of the reissues.

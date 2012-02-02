From: Junio C Hamano <gitster@pobox.com>
Subject: Re: General support for ! in git-config values
Date: Wed, 01 Feb 2012 16:27:49 -0800
Message-ID: <7vliom13lm.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
 <20120201184020.GA29374@sigill.intra.peff.net>
 <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org>
 <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:28:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RskWs-000331-6L
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 01:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab2BBA1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 19:27:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab2BBA1w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 19:27:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D7A77B56;
	Wed,  1 Feb 2012 19:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AOiCuohSrLn0
	9N934jOE7jONX7M=; b=ZY1iJcckK5qOQtLH4HAF6pmNgBxVKsUJ4PTiFg7a1CZV
	SW9ukhj3qOzQQatPWnwYYEX0xPj3LV+dwhAvEJp2bnvN/b/iQkMjnYFe+oW9ffku
	PELBYnQ08p9l5ElRWmjn9hG13BuzysWqgHa6P5fHis7Xis9LiD1HVCov1j54/lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sd+A8w
	I4GByi3Olq7Wml78oqz6x9q3nGdGUQwlSScFnBNzsBlNkictTRTiuPH6bDTV2glz
	qSx8Sa5fh/GMSYTCx4w2MtPHU95p+BAoDaPVK6/hFTUVDhM7C8/hOI3tCOxlooH0
	w6QJDy99PJxTly7XSYeCA/bLRtsCTfXaiHuyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C097B55;
	Wed,  1 Feb 2012 19:27:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD0CF7B53; Wed,  1 Feb 2012
 19:27:50 -0500 (EST)
In-Reply-To: <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 (demerphq@gmail.com's message of "Thu, 2 Feb 2012 01:16:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD67F8B4-4D34-11E1-B222-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189561>

demerphq <demerphq@gmail.com> writes:

> If =C3=86var's proposal was implemented without a --with-exec switch =
then
>
> user.name =3D !me
>
> would set your name to the result of executing the "me" command, whic=
h
> likely would have the same result as not having set your name at all,
> but presumably with a warning about a bad command.
>
> user.name=3D!ldap_full_name
> user.email=3D!ldap_email

I didn't get the impression that that was what he was proposing, but
regardless of who's suggesting it, the above does not make any sense,
from the syntax point of view.

When you say "alias.co =3D !git checkout --foo-bar", you are not saying
"instead of usual aliases like 'alias.co =3D checkout' that defines wha=
t
string replaces the 'co' alias, please run !whatever command, capture
its output, and that is the _value_ of alias.co variable, i.e. the comm=
and
line that is going to be run".

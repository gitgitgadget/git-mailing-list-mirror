From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 11:58:17 -0800
Message-ID: <7vehh1gm5i.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
 <20130131191105.GF27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:58:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10HS-0002ab-PO
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579Ab3AaT6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:58:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab3AaT6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:58:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BAE0C596;
	Thu, 31 Jan 2013 14:58:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXp1rzPJOCLiVdOgK448yrpipF8=; b=MicVnC
	QY934+ZIDJQYW0NjBo51PbaK4mZt4/BkIzdr71pT6W1q29MoQR6EbFcapznQrxJ5
	Qckr+V82P7702z2RyguGc6nBEUCKOxtm0v4UykTfrP+Kh04VaiS04Qt4ewf0aQWr
	KdLuUfEZ6A4DpREsyMNdir4cRJzm9JyhAhN3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjXzmGLeF1yUs70W77kPJZmqPjIAxegf
	1N6e16CUZUrYFqRXwQN5kWQLTyHr3QbE4XKvEDSKwsIOfR4JTpuNaqmVsc3I+lQ3
	/kIEPKBQFnoj1dvDsOB29aUK8YocET1H9gJPhPnnChtnYxBPrS/QBVqQKRla5fZf
	RKnBbaadoFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 600D0C595;
	Thu, 31 Jan 2013 14:58:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFE6EC594; Thu, 31 Jan 2013
 14:58:18 -0500 (EST)
In-Reply-To: <20130131191105.GF27340@google.com> (Jonathan Nieder's message
 of "Thu, 31 Jan 2013 11:11:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED8AEC8-6BE0-11E2-9E1F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215158>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> Is the problem that "deprecated" is not precise enough?  For example,
>> would it make sense to say "deprecated synonym for `upstream`.  Will
>> be dropped in git 2.1" or something like that?
>
> Also, if we plan to remove support soon, we should start warning when
> this setting is encountered so people know to update their
> configuration.

I do not think this even needs to be removed.

We deprecate something for one of two reasons. One is when it was a
bad idea to support it, and we would want to remove the support
eventually.  This needs a migration plan.

The other is when there are better ways available but we do not want
to break the old way.  We still do not want to encourage the old way
to new users.

The change from 'upstream' from 'tracking' is the latter.  The
wording will confuse new users when they want to learn what
'tracking' as a concept is, and it is better spelt 'upstream'.  But
the breakage is not serious enough to warrant forcing an old timer
who can explain these two concepts to newbies when needed to update
his configuration files he is not planning to show to newbies.

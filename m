From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Premerging topics
Date: Tue, 23 Apr 2013 08:29:40 -0700
Message-ID: <7vsj2hjme3.fsf@alter.siamese.dyndns.org>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<7vwqrtl2mk.fsf@alter.siamese.dyndns.org>
	<CALWbr2xAxkNMedbuS-+pPy+Zc5MEhoCWk3oW8BXS9db63DoGAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:29:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUfAD-0007S1-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab3DWP3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:29:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983Ab3DWP3o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:29:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF58E199D6;
	Tue, 23 Apr 2013 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aA6d/DYpwlnlBi8dYYvyuhwUOGo=; b=qW7J8y
	b1g9lf4AA71145A8bKG2zrQW+I67su9euwXuyxO0e2eHjRIUFGAA/zcg7TsPNYcD
	nKtgoJ9QmEjloQTBdky7LLwoxcNIF460Tpd1quAcjPUirImPYB3axGCQ+pv1v9VP
	uQ1hqLdsXAQRL3Cu96ZBMpE606VVIaqmv6Jzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OYXs+Ck3wNrg2Z/WIGTEWGv/FNU6cxI3
	40yPWoZGYcv6orSFo2sKf/HdQ/E0F59xZbEYwLMNUcqBGFnF+j6Svc78/eAi1uxT
	qcSF6CFrfdKiXT3LyRaEpDu1wnkl5gU9R/0TKaJITCwXvXgj0KuaawoOTkWzVE3z
	K4qRQko9OHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6EE0199D5;
	Tue, 23 Apr 2013 15:29:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C729199D2;
	Tue, 23 Apr 2013 15:29:43 +0000 (UTC)
In-Reply-To: <CALWbr2xAxkNMedbuS-+pPy+Zc5MEhoCWk3oW8BXS9db63DoGAg@mail.gmail.com>
	(Antoine Pelisse's message of "Tue, 23 Apr 2013 17:17:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F080C3C-AC2A-11E2-AA39-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222181>

Antoine Pelisse <apelisse@gmail.com> writes:

> And I
> have the feeling that "merge-fix/B" or "merge-fix/A" doesn't hold
> enough information to do that accurately.

Oh, you do not have to resort to feeling; these names do _not_ hold
enough information, period.  We already know that, that was why I was
unhappy, and that was why I sent the "annotating a pair of commit
objects" RFD in the first place ;-).

> The idea is then to store the <A, B> pair as a note, and to associate
> a "merge" to that (solving the semantic conflict).

OK, and as the datastore for <A, B> pair you were thinking about
using a specially-formatted blob and Johan suggested to use a
regular tree object?

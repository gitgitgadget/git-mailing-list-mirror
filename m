From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 16:18:12 -0700
Message-ID: <7vd4axwurv.fsf@gitster.siamese.dyndns.org>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>
 <alpine.LFD.2.00.0904271059060.22156@localhost.localdomain>
 <40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com>
 <vpqfxfund0m.fsf@bauges.imag.fr>
 <40aa078e0904271202ye89ebf2wf417c623d8fe5689@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lya5o-0007cJ-5Z
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbZD0XSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755831AbZD0XSY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:18:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZD0XSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 19:18:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F73112EE4;
	Mon, 27 Apr 2009 19:18:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AEA7712EE2; Mon,
 27 Apr 2009 19:18:14 -0400 (EDT)
In-Reply-To: <40aa078e0904271202ye89ebf2wf417c623d8fe5689@mail.gmail.com>
 (Erik Faye-Lund's message of "Mon, 27 Apr 2009 21:02:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B27925E2-3381-11DE-B86A-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117736>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> Yeah, thanks for explaining. But isn't this functionality kind of
> redundant since we have the -E switch?
> As far as I can see, "git grep -E "(bar|boz)" should do the same thing
> as "git grep -e foo --and '(' -e bar --or -e boz ')'"...

With -E, --or is not strictly necessary.

With only -E, however, it is cumbersome to express what --and can.  Once
you learn the handiness of --and, naturally you would start wanting to
be able to say --or (especially if you do not even know about -E).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Sun, 16 Dec 2012 10:54:50 -0800
Message-ID: <7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJMl-0000PZ-9H
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab2LPSyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:54:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab2LPSyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:54:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01254ADCB;
	Sun, 16 Dec 2012 13:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=diRNdI8LiwJw7T9eS/ojQ80gZBc=; b=oOQ0mJ
	fN0QPQrmQD3S7l6GS7qqr6htkS8sW818A6zDqp6DoJM/1RlzG7VwyzcCR5LGfIhR
	LHb3alY7vJy6arkhSvDNrz78+4bISLtVtmPls4Q02jVS7qXNjRWBSRwOE3hw5O3X
	50wVeH/N95kQgmg1z2uTygU321Ct/KnrBeyoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hvqrINI+iYIPIfRIehnMgTNzmVwkeStP
	ApPwQzZha2F3P2cMz86wWybfr/xfHxgJtaxE08ZFz9c33wob6nsTu3QiZnRcddyJ
	qJG4QafigyDXURs0NJSClNirqK2dE1tEJQvOcMgZ/u/PYmXcjL8CIg1KFbSpCzXh
	UjAPGma61uk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E27ADCA;
	Sun, 16 Dec 2012 13:54:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10AE8ADC2; Sun, 16 Dec 2012
 13:54:51 -0500 (EST)
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Sun, 16 Dec 2012 18:28:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12E4A030-47B2-11E2-B5A3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211603>

Adam Spiers <git@adamspiers.org> writes:

> This series of commits attempts to make test output coloring
> more intuitive,...

Thanks; I understand that this is to replace the previous one
b465316 (tests: paint unexpectedly fixed known breakages in bold
red, 2012-09-19)---am I correct?

>   - red is only used for things which have gone unexpectedly wrong:
>     test failures, unexpected test passes, and failures with the
>     framework,
>
>   - yellow is only used for known breakages,
>
>   - green is only used for things which have gone to plan and
>     require no further work to be done,
>
>   - blue is only used for skipped tests, and
>
>   - cyan is used for other informational messages.

OK.

> Since unexpected test passes are no longer treated as passes, the
> summary lines displayed at the end of a test run have enough different
> possible outputs to warrant them being covered in the test framework's
> self-tests.  Therefore this series also refactors and extends the
> self-tests.
>
> Adam Spiers (7):
>   tests: test number comes first in 'not ok $count - $message'
>   tests: paint known breakages in bold yellow
>   tests: paint skipped tests in bold blue
>   tests: change info messages from yellow/brown to bold cyan
>   tests: refactor mechanics of testing in a sub test-lib
>   tests: test the test framework more thoroughly
>   tests: paint unexpectedly fixed known breakages in bold red
>
>  t/t0000-basic.sh | 211 ++++++++++++++++++++++++++++++++++++++++++-------------
>  t/test-lib.sh    |  25 ++++---
>  2 files changed, 180 insertions(+), 56 deletions(-)

Will take a look; thanks.

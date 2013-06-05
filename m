From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Wed, 05 Jun 2013 12:28:08 -0700
Message-ID: <7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
References: <1370455737-29986-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 21:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkJNY-0003jq-I1
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 21:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab3FET2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 15:28:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756549Ab3FET2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 15:28:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F22D725415;
	Wed,  5 Jun 2013 19:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pEacbE5rmDAATOjS3Mm7bkn7R7g=; b=rudmou
	aaLzeL4lW5X/c4e3CLuBlNHqoxwV7eOMY3+VMQl5uN9Id0mgpgNl+WnRctSeLpLz
	eqrjpW8IMHJ7I1tli+UBflflmFL85SZ6XwAWuL2yARGbciLahrYcsibtibAW9yUJ
	RIzOjGnAd2WPnqEJE8N2g+HDzD7SSGsev9Ejg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yATQ3M6CzC67dpCelrmGQ6xw5LlrMLRK
	38BwYtjHAPzx8RqoOGt43Vnk3jQVYtfZQK6SyNlOPwvzzTKEyMHY9NNepRuv8g8E
	2h3s2I0boocBiWUZ0lxRPosaqTKJeJmhxQy3KroaXGnFSrMTD3nbi50egfib54Rq
	jdgySIwf9/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E73F725413;
	Wed,  5 Jun 2013 19:28:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5912225411;
	Wed,  5 Jun 2013 19:28:10 +0000 (UTC)
In-Reply-To: <1370455737-29986-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 5 Jun 2013 21:10:49 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E946570-CE16-11E2-A22B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226465>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> This includes bugfixes related to handling of --suppress-cc=self
> flag. Tests are also included.
>
> Changes from v3:
> 	- v3 submission was missing one patch (1/7). Re-add it.
> Changes from v2:
> 	- add a new test, split patches differently add code comments
> 		 to address comments by Junio
> 	- rename example addresses in tests from redhat.com to example.com
> Changes from v1:
>         - tweak coding style in tests to address comments by Junio

Nice.  This round cleanly applies and the interdiff since v2 looked
sensible.

Will replace and merge to 'next' shortly.

Thanks.

>
> Michael S. Tsirkin (7):
>   t/send-email.sh: add test for suppress-cc=self
>   send-email: fix suppress-cc=self on cccmd
>   t/send-email: test suppress-cc=self on cccmd
>   send-email: make --suppress-cc=self sanitize input
>   t/send-email: add test with quoted sender
>   t/send-email: test suppress-cc=self with non-ascii
>   test-send-email: test for pre-sanitized self name
>
>  git-send-email.perl   | 23 ++++++++++------
>  t/t9001-send-email.sh | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 8 deletions(-)

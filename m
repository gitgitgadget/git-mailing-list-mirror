From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Fri, 21 Sep 2012 15:30:28 -0700
Message-ID: <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
 <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net>
 <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 <m2k3vn9gyu.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 00:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFBk9-0000TD-0W
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 00:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab2IUWac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 18:30:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283Ab2IUWab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 18:30:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B585861E;
	Fri, 21 Sep 2012 18:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IwdtdMZJ9VebNRIBozhDzzq5jrA=; b=BUPGKU
	ZdJfwfT1qfSJhA9uXWyDV9XXVf97SjiNYObTaSfsmz0DN4y155E1eOWtDROxnvKn
	fEy3Fivh7q3A2Vx3Q8dzP//n7AAom4BIr66Ojq9u/j0lZC9zQkQh3FPXUt7NdKXk
	LUoWEtysKrC3kEJU76tQh/OopJe29XQACuGIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DfaYKwcsGA/QOS7lPCTIwnDwYyGgtOvv
	qO1bVPghhoVmpkb4pwgaRsM6gQZsP4kjSr5o9Wih6o5ZKIw7okIIhD0I9zJkhNgk
	DvHMzMkvwJfzkCPzyXQ3oE3zTSPr7RHsgyHKXJaGuca2yzqXBYCs8vJ+yMSWLH2L
	Id+4Tig9K8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED5C7861D;
	Fri, 21 Sep 2012 18:30:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50DE8861C; Fri, 21 Sep 2012
 18:30:30 -0400 (EDT)
In-Reply-To: <m2k3vn9gyu.fsf@igel.home> (Andreas Schwab's message of "Fri, 21
 Sep 2012 23:57:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F324D3D2-043B-11E2-84F4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206176>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> My SHELL_PATH is not set, and I can see SHELL_PATH ?= $(SHELL) in the
>> Makefile.  Which shell is it supposed to point to?
>
> Inside a makefile the variable SHELL is special in that it is never
> imported from the environment.  If not set it defaults to /bin/sh.

Ahh, I forgot about that.  Then the current construct is perfectly
fine.

The reference to ${SHELL-/bin/sh} in the test need to be updated to
SHELL_PATH as Peff suggested in the other subthread.

Thanks.

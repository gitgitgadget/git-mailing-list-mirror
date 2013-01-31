From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 15:11:25 -0800
Message-ID: <7vhalxdk2q.fsf@alter.siamese.dyndns.org>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 00:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U13IM-0005ED-F7
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 00:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab3AaXL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 18:11:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab3AaXL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 18:11:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5811BD714;
	Thu, 31 Jan 2013 18:11:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cHy/msDDJ8PPyik+nDoyl5nf8D0=; b=gTwXg6
	aMyU9vLL2hoy96PdZ+xOBGxl5fWxTFM6LdVcJk8CYwVK2zJkD/8+s/J1ql48+7w8
	nYwrh5iCXl21tZYxtzTHU1dtgH3sxo4M1xZpwqRl/8zzXNewMdnb0FZKUCkP3xRs
	QkW4pnz0/QSSJ3UkLV5Nc3H1bY+4u3Z29fx6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MpElJFHXEzZHGWqGp8fvYWOtqjQuJrJV
	+Ygcmr2gPKmY+DQcRZw2XE73caBf7bSC0o6NJ1QNWSbfMNE+gn2rJK2e5oA/aXpu
	wOHxy1Vwnt+eRCgSj6CSJg8k3W2JPNuQGaSE5T1fRAroI/5cVpaD+EvtGkPWAeYd
	q0gTJC639N4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A58CD713;
	Thu, 31 Jan 2013 18:11:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9F17D711; Thu, 31 Jan 2013
 18:11:26 -0500 (EST)
In-Reply-To: <20130131230455.GN27340@google.com> (Jonathan Nieder's message
 of "Thu, 31 Jan 2013 15:04:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89D458A8-6BFB-11E2-ACA8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215187>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> Maybe it is just me, but the fact that accessing the manpage is now:
>>
>>   man gitremote-helpers
>>
>> feels weird to me. I know it technically follows our syntactic rules,
>> but having the lack of dash be significant between "git" and "remote",
>> but then having a dash later makes it hard on the eyes.
>
> Yes.  I have thought for years that it should be git-remote-helpers,
> that "git help" should be tweaked to look for that, and that the
> existing gitrepository-layout and friends should be replaced with
> redirects.

Because of the "git help" look up rules, we cannot have two pages
that only differ at the dash (or absense of it) immediately after
'git'; e.g. one about the concept of 'frotz' in the context of Git,
i.e. "man gitfrotz", and the other about the subcommand to perform
'frotz', i.e. "man git-frotz".  The way to refer to these two pages
are both "git help frotz".

The simplest way forward may be to teach "git help" to try both
paths?  But some people configure "git help -w" to refer to remote
site, so it won't be access(path, F_OK).  Sigh...

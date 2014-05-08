From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 11:36:26 -0700
Message-ID: <xmqqtx902k45.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<xmqqha515ebt.fsf@gitster.dls.corp.google.com>
	<536adf96f37ec_3caaa612ec69@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 20:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiTBM-0008CF-RP
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 20:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbaEHSgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 14:36:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55278 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbaEHSgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 14:36:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91FDB15716;
	Thu,  8 May 2014 14:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Lf2LOztVI7yiRiGoiP6sSTpNaZ0=; b=wZ9TPeVXkNj8HL3S43ww
	KPzEog3Amhxi1HBEDkU2aTkMVFjRuXL0j1uKNfJM1CduoYi10adDBSQKe2QqsTxl
	HYFKGdt1bp0QLpebU0yy74W2CP/6jIB5AxWGbE7ZDqXYiyE10CJpbSH42Q8AnDuO
	IZn/zcW8F15Fv8ghzOUdnnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QoWPmq9FoXIch/JDqs7r9ra4hgvFTyPiBez+xJCNTRoOQL
	AKekH/fwH4QwjVVYJxJ3XTl4sJiimNzCNSW6oh2PwrJM/JPsrZeKUAtXpVIJ/qlA
	Wg5hNW3gPZnVbwxnubrmc4gjrq5FYox2TiA6zKmtgITPMBIW/AVrV+UaN7/VA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 759B115715;
	Thu,  8 May 2014 14:36:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6897C1570C;
	Thu,  8 May 2014 14:36:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB80B38E-D6DF-11E3-9A4B-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248431>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> There may be some other changes that this series depends on that I
>> may have missed that caused this breakage.  Can you take a look?
>
> I'm such a bad maintainer and I don't take constructive criticism well
> why would you expect me to take a look?

Because this was not about maintainership, but was a simple and
straight-forward breakage report [*1*].  There was no criticism
involved, constructive or otherwise.

In other words, I knew that you are capable enough to track down a
bug in the code you wrote recently that made it violate the
expectation you defined in your own tests.  There was no room for
differences of opinions to come into play, as it was just between
you and your own code.

Why would I expect otherwise?

Do you want to make it a separate follow-up patch with a log message
that explains why it now uses LookupError (not ManifestLookupError),
or do you want to reroll the original by squashing it?  I am guessing
that the reason is because in older versions they used LookupError
but in recent versions ManifestLookupError which is a subclass is
thrown instead, and catching the former would cover both cases, so
if I were to queue it as a separate [PATCH 5/4] fixup, that is how
I would explain that change.

[Footnote]

*1* .... and a very bad one at that, missing any useful details; I
apologize and blame lack of time for its lousiness.

Thanks for working with very little useful information and fixing.

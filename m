From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/5] t4205, t6006, t7102: make functions more readable
Date: Fri, 05 Jul 2013 01:58:07 -0700
Message-ID: <7vk3l58jts.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
	<cover.1372939482.git.Alex.Crezoff@gmail.com>
	<aeb5182a691105600edc181c08020cfaa350c7df.1372939482.git.Alex.Crezoff@gmail.com>
	<7v61wpbj2y.fsf@alter.siamese.dyndns.org>
	<20130705081307.GC32072@ashu.dyn1.rarus.ru>
	<7vsizt8kh4.fsf@alter.siamese.dyndns.org>
	<20130705085112.GE32072@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:58:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1qJ-0006mb-OJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab3GEI6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:58:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167Ab3GEI6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:58:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B7552AE0A;
	Fri,  5 Jul 2013 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iNtAZ7NptEm8W4L/JQbTKrlklPE=; b=iDHUml
	JAsdveQaEeTUaiNJ5u5ZQv1VZclVJM5WzHOZBJCuzFhqn1ngygOipOqncrNE4/Yr
	ZpDD9pBy3pKF8mPh1Vc0m97rKP2miIBuWcbpPGV9iL2zQZu9g2Sj9YgGyzPsbXb+
	1TejYH7e+FRA9PQNSferJ9T+o2jXVDfXb6Uxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yipJbAOx76/RfsFEr2AqHsaWO+nv0JU3
	uEzI1WfrZhpCP9E8yIxgSDC57wIwchp8uYHVZGknOc1ML9v5ctxYpmMnNJjbXKvJ
	KEYNvTTMz4rUx90MJlzt7YE3aHdK1XFE1S2lpo7PC1aaqtLGh6eKzAjw28Wgnw5j
	b5TO0dxNmKg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71D082AE09;
	Fri,  5 Jul 2013 08:58:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3EDD2AE06;
	Fri,  5 Jul 2013 08:58:08 +0000 (UTC)
In-Reply-To: <20130705085112.GE32072@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Fri, 5 Jul 2013 12:51:12 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 039C70C0-E551-11E2-AEC6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229643>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

>> > Could you point me to the coding style guide, please?
>> 
>> Documentation/CodingGuidelines::
> Oh! :)
> thank you

The most important part of the coding guidelines is to match the
style to existing code when writing a new one:

    $ git grep '^[a-z_]* ()' -- *.sh | wc -l
    132
    $ git grep '^[a-z_]*()' -- *.sh | wc -l
    55

We have acquired quite a few violators, but that is no reason to add
more.

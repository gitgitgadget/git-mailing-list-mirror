From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 19 Jan 2016 15:30:26 -0800
Message-ID: <xmqq1t9d87vx.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	<xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
	<xmqqio2p89mb.fsf@gitster.mtv.corp.google.com>
	<20160119230633.GA31142@sigill.intra.peff.net>
	<xmqq60yp8837.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:30:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLfjO-0004ga-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933382AbcASXab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:30:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932702AbcASXa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:30:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AA1B3DA6A;
	Tue, 19 Jan 2016 18:30:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uq55xccWxhq5ogVNheolP7KGM9s=; b=GOz2tn
	A28LBIDQx3PfsjMC44JrlSkTTVQNK4ZhbNSYigWLYMlwBjRyKD0mI4rxnRv3TzcC
	Zgq/d9ZsBI5ieLbtwbe46r7wWZw8L1TccIFIFpC3YnhVh2pZ6zTMk2NDyCKL+rdJ
	kvnk+UNQCf/mfOvyHcNablYapHwJeaiJJDdFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IAmFcoKL8aujKlpjUCcUXAwMt3erwx/S
	wGzbAd2C4w99hwseVauJXCjXVU10jumrjAMsgXBlkHS9SLl4GoZcOR7eZrWP1htZ
	lCTXbiHVUvalyFOYk1n5j0zDz9bP094T6jS4xGS4H5O2qfiRzTh5loYLLItTUgj1
	XkSjupaYrIQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 333673DA69;
	Tue, 19 Jan 2016 18:30:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AFCC73DA68;
	Tue, 19 Jan 2016 18:30:27 -0500 (EST)
In-Reply-To: <xmqq60yp8837.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Jan 2016 15:26:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F41E8C2-BF04-11E5-AEA5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284399>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> You can also note that if we ever delete a test script, it will still be
>> mentioned in prove's state file. I think prove is smart enough to
>> realize it went away and not bother you.
>
> The inverse might be more problematic.  When we add a new test
> script (which we still do from time to time), does prove notice
> that we asked it to run more tests than it already knows about?

Heh, I should have tested before sending it out. It seems that it
does notice what's missing from t/.prove so it is safe.

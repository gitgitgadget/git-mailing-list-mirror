From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 01 Jun 2016 13:48:33 -0700
Message-ID: <xmqq8tyoy6se.fsf@gitster.mtv.corp.google.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
	<xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
	<xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
	<20160601163747.GA10721@sigill.intra.peff.net>
	<20160601183100.GN1355@john.keeping.me.uk>
	<20160601190759.GB12496@sigill.intra.peff.net>
	<20160601191621.GO1355@john.keeping.me.uk>
	<xmqqinxsy9q0.fsf@gitster.mtv.corp.google.com>
	<20160601202852.GP1355@john.keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:48:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8D4E-00080i-9i
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbcFAUsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:48:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbcFAUsh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:48:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A84F203E4;
	Wed,  1 Jun 2016 16:48:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c0UiPLjoQ/M4pNsYURaOvgya6YY=; b=LdM7go
	wSWYSl3wGUvZLwNUoJhao/wQNNhRBjT3jXrWwp6Gr68evlnsGDBvDCB1rIvUvr96
	khmpiF7iLBXt8uD3gXDam/l76ECWhLQSj1hNnxaPzfnWg+2+9RCz0E5eYyNwyEh+
	ed0ywrI1geRUw0I0TsGDRyot4w3HDLq6X1/xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nVozw5jiviWhNbW3mNzpwmxpfcmhEKiy
	xTqoRIPhfYdSWRVUHvPRyaLFAzpyrZul4iDzRpWHK/Sh72JohKuK/iWdQq8eE/Lp
	/88204+2j2am/kOut9xUNXL/0JSjoYNRaq7/nPm4nbb5v7kT46TVG/YouDX2T6m1
	8mZ5jrlH42g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 034C0203E3;
	Wed,  1 Jun 2016 16:48:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84C36203E2;
	Wed,  1 Jun 2016 16:48:35 -0400 (EDT)
In-Reply-To: <20160601202852.GP1355@john.keeping.me.uk> (John Keeping's
	message of "Wed, 1 Jun 2016 21:28:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35B34D70-283A-11E6-8A69-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296160>

John Keeping <john@keeping.me.uk> writes:

> Absolutely, my original point should have been prefixed with: I wonder
> if the reason we haven't had any problems reported is because ...
>
> And we've got lucky because the clobbering of global variables happens
> not to matter in these particular cases.

Ah, I did misunderstand why you were making that statement, and now
I fully agree with your conclusion (which is what Jeff spelled out
in the latest message) that the fact that we saw no breakage report
is not a datapoint that everybody's shell supports "local" at all.

Thanks for clarification.

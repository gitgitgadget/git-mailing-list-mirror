From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/10] support pager.* for aliases
Date: Thu, 18 Aug 2011 21:18:49 -0700
Message-ID: <7vliuq5906.fsf@alter.siamese.dyndns.org>
References: <20110818215820.GA7767@sigill.intra.peff.net>
 <20110818215909.GA7799@sigill.intra.peff.net>
 <7v8vqq72kp.fsf@alter.siamese.dyndns.org>
 <20110819033733.GB2993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 06:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuGXp-0002Cb-EH
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 06:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911Ab1HSESw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 00:18:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1HSESw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 00:18:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9CEA42B6;
	Fri, 19 Aug 2011 00:18:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TVRPnqoajUgCNztGzdxFFbmu9+0=; b=JSRYtY
	OWPReFh/nUcE5+JTDVgzyhXUB8ImozCZri5WB6dLMHkT63tlzLsa2VFNbQGr5iz5
	9Hnw0xw5p4EtZ9kZkuFIp3vt6BYQWbItCxdThHMXrkuQYlJUobhRV1fBKX1IGI3J
	KSeZoFIztr13R8Mqh3twRHOs1/14Yknn3svJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s5MWVIKjoiJXGN0S5YAuNS/Qe9DUGqvc
	aF4m2pbumHUt4JTDfa2Mw1kY2FhXGBbphGj2V0WZdGU5Ms2apT3MgYAPA3DsFeAW
	cLxaNrZC0VKnYg4V3+Dn1B3zQJCCm8YosNQF8gv+OHFqV84x2KYFjDpoqtRXitkf
	G9EyUby0Fy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFB1B42B5;
	Fri, 19 Aug 2011 00:18:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4703542B4; Fri, 19 Aug 2011
 00:18:51 -0400 (EDT)
In-Reply-To: <20110819033733.GB2993@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 18 Aug 2011 20:37:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57DA9E36-CA1A-11E0-BB5D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179671>

Jeff King <peff@peff.net> writes:

>> > Until this patch, doing something like:
>> >
>> >   git config alias.foo log
>> >   git config pager.foo /some/specific/pager
>> >
>> > would not respect pager.foo at all.
>> 
>> Is it a good thing? Looks too confusing and I am having a hard time to
>> decide if this is "just because we could" or "because we need to be able
>> to do this for such and such reasons".
>
> I don't have a particular use for it myself. However, I don't see what's
> confusing about it. Would would you expect the above commands to do with
> respect to paging?

The reason I found it confusing was that I expected the "log" command that
is run as the expansion of the alias to be oblivious to the fact that the
end user called it "foo", and ignore anything specific to "foo", including
"pager.foo".

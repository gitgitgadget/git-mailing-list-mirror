From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: add the test_bash convenience function
Date: Mon, 16 Jan 2012 14:51:57 -0800
Message-ID: <7vk44ruupe.fsf@alter.siamese.dyndns.org>
References: <4F133069.10308@web.de>
 <20120115232413.GA14724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmvPJ-00066K-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 23:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab2APWwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 17:52:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab2APWv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 17:51:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0852C7C51;
	Mon, 16 Jan 2012 17:51:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XZgZnULHAqyTvaTn8hFsPmTRfpM=; b=lpwvoh
	OfR265oqIVIoKjfMxfObaxYGWK3BgXQ3xuyhGTKLd5gHdTDvKBKRghPui6PRIsKI
	4MIrAc525w6Rk3I6d4Puo4IEWRygnjeSPSp/euOcUM9z3qOySV/bW0Me2REFQW4/
	bED/tSTYvChaTh9MTcYY0BN+4hqUrRnirIR+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=alt9HPAxhNzl5zlqOHg4emoci0chQ4cm
	CGOGOTViu/g4MhbxJl3yjKu8/aAXzWWonA46nIynhq8uTPMjFWm8nNQ0zSrops00
	s1Gntnvu/Zn1dWT83EdEp2zB8imyv8ldqFK7S8FViEh765z/BBHp9/lH+mXwP3Aw
	frcIPhnu+wM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B457C50;
	Mon, 16 Jan 2012 17:51:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83FBB7C4F; Mon, 16 Jan 2012
 17:51:58 -0500 (EST)
In-Reply-To: <20120115232413.GA14724@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 15 Jan 2012 18:24:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B21EB09E-4094-11E1-830F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188664>

Jeff King <peff@peff.net> writes:

> Nice. Many times I have added such a "bash" or "gdb" invocation then
> forgotten "-v", only to scratch my head at why the test seemed to be
> hanging.
>
> Two minor nits on the patch itself:
> ...
> 1. It may be worth putting a warning in the comment that this is never
>    to be used in a real test, but only temporarily inserted.
>
> 2. I do this not just with bash, but with "gdb". I wonder if it is worth
>    making this "test_foo bash", for some value of "foo" (the ones that
>    occur to me are "debug" and "run", but of course they are taken).
>
>    Actually, I wonder if the existing test_debug could handle this
>    already (though you do have to remember to add "--debug" to your
>    command line, then).

I wondered the same thing from a different angle. My first reaction was
"Why is this called 'bash' not 'sh'?" which naturally led to the same
direction as yours "why not an arbitrary command 'test_debug xxx'?"

test_pause perhaps?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Tue, 07 Aug 2012 08:41:53 -0700
Message-ID: <7vhasewvy6.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
 <1344315709-15897-2-git-send-email-drafnel@gmail.com>
 <7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
 <7vpq73w9i8.fsf@alter.siamese.dyndns.org>
 <CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
 <20120807060311.GB13222@sigill.intra.peff.net>
 <CA+sFfMc28N2eKNa=GiKHvxOeN3u=-ruFQqTBz7cbCGX-G=TTgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 17:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sylv5-0007uC-MS
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 17:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab2HGPmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 11:42:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860Ab2HGPl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 11:41:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA89B9C1D;
	Tue,  7 Aug 2012 11:41:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IRZlgVMKJrldnoSYvQfOXtyVYmA=; b=d109sR
	wfTXHiX0U0CbFFg/aepel3rozW9W5gL0LZLRtHVFSqTrYXN15kWd0gpRSX0svqLY
	ZB4s9jEaZQd3KM9Akecs0UruflMvx6BDpTPy0xMoNF5YG33S1uyLGXiB4pWX0YSZ
	U3LG8NIYto6Xn2Xmf+gaNMJC8Mj0AtYbgL784=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ENfgtqqrdbJMnvRB+LQiD3nHO65OYRjk
	cLc7TUI6aG/JxYXm4jekFmdzZOcoBuGUKIwvw3ZOuMJQEuk2JzmKJHKcA42E3r3v
	Kv0EWMKotZbaZYif8iwzv7/+cmLlEQdcfxwKno6wQBMaxksfG1bA1LDUyUUGwu/6
	jQKaOWDJyck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A78AD9C1C;
	Tue,  7 Aug 2012 11:41:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 100029C1A; Tue,  7 Aug 2012
 11:41:54 -0400 (EDT)
In-Reply-To: <CA+sFfMc28N2eKNa=GiKHvxOeN3u=-ruFQqTBz7cbCGX-G=TTgA@mail.gmail.com> (Brandon
 Casey's message of "Mon, 6 Aug 2012 23:33:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A51651A-E0A6-11E1-AD6E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203030>

Brandon Casey <drafnel@gmail.com> writes:

> On Mon, Aug 6, 2012 at 11:03 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Aug 06, 2012 at 10:44:07PM -0700, Brandon Casey wrote:
>>> Anyone else? :)
>>
>> Sorry to gang up on you. :)
>
> Heh. :b
>
>> I still think your 2/2 is worth doing independently, though. It is silly
>> that git-prune will not mention pruned objects without "-v", but will
>> mention temporary files. They should be in the same category.
>
> As I mentioned in an earlier message, I think the original thinking
> was that removing a temporary object should be an unusual occurrence
> that indicates a failure of some sort, so you want to inform the user
> who may want to investigate (of course the file's gone, so what's to
> investigate).  Removing a stale object file on the other hand is just
> part of the normal operation.  That is why the former is always
> printed out and the latter only when -v is used.

That matches my understanding, modulo "may want to investigate" is
probably more like "may want to be reminded of an earlier repack
that was aborted".

> That was the original thinking, but I don't think it matters very
> much.  Printing both using the same conditions seems valid.

Yeah, I agree that it does not make much difference either way and
both ways of thinking feel equally valid.

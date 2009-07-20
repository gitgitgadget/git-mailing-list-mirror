From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 2/8] push: add push.default = mirror
Date: Mon, 20 Jul 2009 14:34:09 -0700
Message-ID: <7vhbx7ujhq.fsf@alter.siamese.dyndns.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
 <1248112195-3761-3-git-send-email-bonzini@gnu.org>
 <7vocrfulpu.fsf@alter.siamese.dyndns.org> <4A64DE38.5090805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 23:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT0V7-0000my-1Z
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 23:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbZGTVeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 17:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZGTVeR
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 17:34:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbZGTVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 17:34:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 06E70B928;
	Mon, 20 Jul 2009 17:34:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 43638B927; Mon,
 20 Jul 2009 17:34:11 -0400 (EDT)
In-Reply-To: <4A64DE38.5090805@gmail.com> (Paolo Bonzini's message of "Mon\,
 20 Jul 2009 23\:14\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 131FB908-7575-11DE-882A-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123637>

Paolo Bonzini <paolo.bonzini@gmail.com> writes:

>> I think this patch alone (regardless of the rest which I haven't read)
>> probably makes sense.
>>
>> Except that I think the part below contradicts with the --mirror push
>> semantics (see remote.c::match_refs()).
>
>        if (!send_mirror && prefixcmp(src->name, "refs/heads/"))
>                 continue;
>
> The way I read this, send_mirror will send everything, even if it's
> outside refs/heads/*.  So refs/*.

Ah, ok, thanks.

> If we agree on the semantics, would you harvest it separately or
> should I resubmit?

I do not expect the rest of the series to be near 'next' before 1.6.4, and
it is likely that I'll forget about this patch by the time 1.6.4 finally
ships.

But I realize that without the rest of the series, being able to say
push.default = mirror does not add much value.  A replacement commit log
message I wrote for this patch stand-alone is:

    Instead "git push --mirror $over_there", you can say "git push" after
    setting up push.default to "mirror".

But the thing is, you can already do that with "remote add --mirror".

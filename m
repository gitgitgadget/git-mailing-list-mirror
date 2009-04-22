From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cryptic error messages?
Date: Wed, 22 Apr 2009 14:14:00 -0700
Message-ID: <7vws9c1jdz.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com>
 <20090422203251.GD14146@coredump.intra.peff.net>
 <20090422205006.GE14146@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwjnJ-0006Nv-HG
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbZDVVOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756371AbZDVVOL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:14:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbZDVVOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:14:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6650C11AF0;
	Wed, 22 Apr 2009 17:14:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A6B6411AEF; Wed,
 22 Apr 2009 17:14:04 -0400 (EDT)
In-Reply-To: <20090422205006.GE14146@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 22 Apr 2009 16:50:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8491C4E8-2F82-11DE-ACD5-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117262>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 22, 2009 at 04:32:51PM -0400, Jeff King wrote:
>
>>   3. receive-pack notices that the unpacker failed, and spews
>> 
>>        error: unpack failed: unpacker exited with error code
>> 
>>      to stderr, in case unpack-objects didn't say anything.
>
> Actually, this is not true. receive-pack actually passes the error code
> back to send-pack, which prints it. I think it is doing so because we
> get that status separate from the individual ref status. But if you look
> at receive-pack, it doesn't even bother trying individual refs if the
> unpack failed; every ref will just get the "unpack failed" message.

How could it even "bother" to tell which ref?  The protocol says "Here are
the values for the refs after you unpack the data that follows; here is
the pack data for you", and then you find the error in the pack data.

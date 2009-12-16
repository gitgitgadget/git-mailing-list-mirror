From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ignore unknown color configuration
Date: Tue, 15 Dec 2009 17:25:36 -0800
Message-ID: <7v3a3bwvzj.fsf@alter.siamese.dyndns.org>
References: <20091212122524.GA17547@coredump.intra.peff.net>
 <7vzl5nn9x2.fsf@alter.siamese.dyndns.org>
 <20091212222046.GA25973@coredump.intra.peff.net>
 <7vzl5mjndi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 02:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKieJ-0006jl-VZ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 02:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934421AbZLPBZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 20:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934418AbZLPBZv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 20:25:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934382AbZLPBZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 20:25:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07EBD88D22;
	Tue, 15 Dec 2009 20:25:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w+wYzJGaAwWD2yIlw4MxlBnqtaQ=; b=Eve+2I
	vGUNnuETe6vovuTRgc6IZhZWNdTmX/uF1WZOXMcOXgMOW7iUhMI03nwCSqcBpsh4
	gBLEiexhR9KEle30UQ+ynyO/Gzqo3YE7Y2PeZuaRrYNSPhjSyQsDSpD9y4aByRbi
	bUzHcatwmc6cZK8ERKRefObYpf9J6ZAaGhZno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wxvc0JAHspePiPKGJUacM+n2b3xHllze
	JhPJbaRp0jwG9KnKsI21n+xGi5v16ocJxCTVQ3B7j/ru01F0BT0f4yvdFpujOc24
	gKX21TVcoVBqPUr+HP0XydeqwoeP54i1Q80HYGKrfEY0ke1cyyc2mYEmA1tv3r/E
	K3Q9nhrOZfs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0ACC88D1E;
	Tue, 15 Dec 2009 20:25:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09FB688D1A; Tue, 15 Dec
 2009 20:25:37 -0500 (EST)
In-Reply-To: <7vzl5mjndi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 13 Dec 2009 18\:33\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF3A16C8-E9E1-11DE-BD67-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135314>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Sat, Dec 12, 2009 at 01:45:45PM -0800, Junio C Hamano wrote:
>>
>>> This is a sane thing to do, as "slot" is part of the name of the variable,
>>> and we generally do not warn upon seeing a misspelled variable name (it
>>> makes it worse that "func" is not even misspelled but merely unknown to
>>> older version of git in your scenario).
>>> 
>>> On the other hand, I suspect that most people would apprecfiate if their
>>> git pointed out "diff.color.finc?  What do you mean?"  before they waste
>>> 30 minutes wondering why the new feature in 1.6.6 does not work for them.
>>
>> I would be more sympathetic to that user if this weren't the _only_ set
>> of variables with this property. They don't get warned for diff.externel
>> or color.show-branch.
>
> True and fair enough.  Let's have this in 1.6.6 then.

Actually I think we should have this in 1.6.5.X as well for it to be
useful.  Am I mistaken?

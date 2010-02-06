From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Sat, 06 Feb 2010 09:39:32 -0800
Message-ID: <7v8wb64623.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
 <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
 <20100206035143.GA31784@sigill.intra.peff.net>
 <7v7hqrdkxb.fsf@alter.siamese.dyndns.org>
 <20100206115817.GA11605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 06 18:42:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndofk-00072R-K6
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 18:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab0BFRjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 12:39:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab0BFRjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 12:39:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BFE5979DD;
	Sat,  6 Feb 2010 12:39:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5vRANMU4In8LKFgpgn8Csgufv78=; b=CrQvg1
	VxmHKS8aM5e6nKhGscRA8Z6wC/TxsHDowLen/XWaK+ENJpdO95FrKnpZV0boVUPm
	wcQC68AuWOdtAfF/j4vNhilasMfrJBDM4vL4k6k7qvfhpwX8/GgFDPQ82nF7WO1s
	NtcwEefAKzOJGZxmEA+bfdfhJZXZN/Q35dZbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aJPQs94BjZFi81uO0cplb0gGzKtqnGOj
	h9gJteLBij+DTLmegpKCaK4hkZSLTVO6suss0iXPKVeTaWQdY1pBxjq4HqPB8MpA
	fCoPxl7eNpEuBCKCo9wvcu8gyrDeDmWnanoNtr15bNVk+lCGaH6uP2at2z024gWq
	dHOO2yVqz/o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C18EE979DC;
	Sat,  6 Feb 2010 12:39:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA4C4979D9; Sat,  6 Feb
 2010 12:39:33 -0500 (EST)
In-Reply-To: <20100206115817.GA11605@sigill.intra.peff.net> (Jeff King's
 message of "Sat\, 6 Feb 2010 06\:58\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99753DE2-1346-11DF-87AA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139178>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 05, 2010 at 08:53:36PM -0800, Junio C Hamano wrote:
>
>> >   git grep -- pattern revision -- pathname
>> [...]
>> I don't think if "ambiguous or not" is what we are after to begin with.
>> 
>> I have known GNU extended grep implementations long enough but never saw
>> that "--" used to quote a pattern.  Is it worth supporting to begin with?
>
> I think so. It was the first thing the original poster in this thread
> tried. It is also something I have tried (and still do, then grumblingly
> retype "-e pattern"). And it certainly makes sense from a user
> perspective; it is the same end-of-options signal that most other
> programs take.

Ok, then let's take that (perhaps before 1.7.0 perhaps after).

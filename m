From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Hidden refs
Date: Wed, 13 Oct 2010 10:51:12 -0700
Message-ID: <7vmxqim167.fsf@alter.siamese.dyndns.org>
References: <4CB5CEA3.8020702@xiplink.com>
 <20101013173555.GA13188@sigill.intra.peff.net>
 <7vvd56m1ke.fsf@alter.siamese.dyndns.org>
 <20101013174647.GB13752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 13 19:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P65U6-0001Dq-5e
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0JMRvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:51:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab0JMRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:51:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F359DE8FA;
	Wed, 13 Oct 2010 13:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=33W4XR1cVsLM6ostVoH8xImB99s=; b=x5xome
	y4ekyas8V3Vr1C9+0gihTE8LGU8EylTllRHkQEp7qSilsYsA60pR8thKylFyw0oN
	PIwj2e10A4bxEhXBpQElglzu4foy1S56AZG5Rfs2pFA2/FzsGfJ8H6EEsEY+Awlt
	27YtTZuw/vBe52jM1I3ZBE46H/GAS07Arb4p8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sro89NcCz5zPVWSMt8wrsUzVndNbsU/0
	78KcrxndVlZLf/7OXxqN7oTBvz3vCyrFLVpJEr8luJ+0+s2ubVRng1YES3txpMtQ
	ZGWgYM1c8IkJS6ODmGez2pv3kq3vwTpZ5DSULFAg2kK2yXNcdl9HFmoeecpv3N0b
	O1QMkRQty84=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BA84DE8F8;
	Wed, 13 Oct 2010 13:51:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 896F8DE8F4; Wed, 13 Oct
 2010 13:51:13 -0400 (EDT)
In-Reply-To: <20101013174647.GB13752@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 13 Oct 2010 13\:46\:48 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7AA9BFA8-D6F2-11DF-A094-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158953>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 13, 2010 at 10:42:41AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Yeah, I believe "." at the front of a directory component is explicitly
>> > forbidden by check_ref_format. I don't recall whether there was a
>> > specific rationale, or whether it was simply a can of worms we didn't
>> > want to explore.
>> 
>> Is "log foo...bar" a symmetric difference between foo and bar, or is it an
>> assymmetric one from foo and .bar?
>
> Thanks, I was sure there was a simple example of how it would make
> things ambiguous, but for some reason I couldn't think of one.

Of course, it points at an existing bug as well.  --- the example could
mean an asymmetric difference from foo. to bar ;-)

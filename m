From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 3 failures on test t9100 (svn)
Date: Wed, 03 Mar 2010 12:01:46 -0800
Message-ID: <7vr5o1p42d.fsf@alter.siamese.dyndns.org>
References: <20100302194518.GA12942@vidovic>
 <20100302212806.GA21413@coredump.intra.peff.net>
 <20100303005804.GA17120@vidovic>
 <20100303172302.GA10168@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 21:02:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmule-000667-SA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756468Ab0CCUB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:01:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab0CCUBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:01:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 375DF9E46F;
	Wed,  3 Mar 2010 15:01:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HiW5PEAPsIEUwelyOFmhzageijg=; b=Gr5JDu
	AXO9W5WsNDbzkZNbr+Dg+QzjejXSkzMFnGMzv17uzqNebRgsqzYEj9YDr7hmuvXq
	ZThADv9qKf5IO6TH9wpKK4p9uuEkdweSpvNzwdiOIamJXSb53GZp2Z7YtZoV4uG+
	We4hNrpP2iFGGbPYiHR0BC5/NyK5BqjtZc23w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ruZ0qv82TEIsj0Ex35nFsFQBRYPpoNL9
	SOg41Zyc8FWAv6sYlaN6edvi26eH+yUSEIslXldf3qDkbEBxVLG9FexBJO7iCSAX
	eC2M87pFPZbTXiB1aQEIU3RwjVXCEH2idoa9w0tvcQTck2izE/HcdxSM6Ji2Chij
	RZs5JC+80No=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 036EA9E46D;
	Wed,  3 Mar 2010 15:01:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 420D39E465; Wed,  3 Mar
 2010 15:01:48 -0500 (EST)
In-Reply-To: <20100303172302.GA10168@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 3 Mar 2010 12\:23\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9BFB2654-26FF-11DF-BD6E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141465>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 03, 2010 at 01:58:04AM +0100, Nicolas Sebrecht wrote:
>
>> >   GIT_TEST_CMP='diff -u'
>> >   test_cmp() {
>> >     $GIT_TEST_CMP "$@"
>> >   }
>> > 
>> > which _should_ split the "diff -u" on whitespace.
>> 
>> I've tried with these exact lines without more success.
>
> That's weird. Can you test this in each of your shells:
>
>   foo() {
>     echo "in foo, arg=$1"
>   }
>   VARIABLE='foo bar'
>   $VARIABLE
>
> It should print "in foo, arg=bar". If it doesn't, then the shell is
> broken.

The only other possibility I can think of is if somebody futz with IFS, in
order to e.g. use the "word splitting" logic for "line splitting" (or
"split at colon"), and forgets to restore the original value.

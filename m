From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Wed, 17 Feb 2010 10:31:24 -0800
Message-ID: <7vocjnu32b.fsf@alter.siamese.dyndns.org>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <7vljeyp1rj.fsf@alter.siamese.dyndns.org>
 <4B764B67.1020402@dcl.info.waseda.ac.jp>
 <7vsk95sht6.fsf@alter.siamese.dyndns.org>
 <7v8watg04g.fsf@alter.siamese.dyndns.org>
 <4B7BB437.1060608@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:31:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhogc-0005mw-HQ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 19:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab0BQSbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 13:31:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab0BQSbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 13:31:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB67D9A381;
	Wed, 17 Feb 2010 13:31:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6zYzu+fJeEIWhlW0eWAo2QTBUUI=; b=vXq/lLLd2VHWEAvdhL3C0VY
	NrZLvuKCZ5X8e2Yf/MFNIXc8wQBdV766CKyWUtHx7WDNFPHelkmk+hrBT3nxYhcQ
	Ui5DrrAWrip1hUKzuQL/uqFHZsoIVM9cDkTgyI4Ao0rucM/PsDTlyDsvf786vEIb
	Dbl/PYuihUlkkvDuMGpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FR2NCdrp8izWv5M1n8oJIolIGO6bWP7B24Q5EMbVzlTsPeRRm
	TQVeiL+Hz/pNpltDNKozNfXFxO9ychwDiq2n7qFYvPW3F/ntvSc7tOmqWOlUKLfL
	EgfbHzVuokggJpwbRYeMB9mFHcxEckN73ciO71WGhcFG/C7k8FS3XC6hAQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43A409A37C;
	Wed, 17 Feb 2010 13:31:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EBBF9A371; Wed, 17 Feb
 2010 13:31:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC5AC4CC-1BF2-11DF-A5B4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140242>

Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp> writes:

>     response_64 = xmalloc(ENCODED_SIZE(resp_len));
> should be,
>     response_64 = xmalloc(ENCODED_SIZE(resp_len) + 1);

Good catch.  Thanks for looking it over.

This is _your_ contribution (I only made a minor fix-up or two), so I'll
apply this your v6 under your name.

Thanks.

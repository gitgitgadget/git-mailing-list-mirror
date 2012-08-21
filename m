From: Junio C Hamano <gitster@pobox.com>
Subject: Re: misleading diff-hunk header
Date: Tue, 21 Aug 2012 15:29:08 -0700
Message-ID: <7vwr0rc217.fsf@alter.siamese.dyndns.org>
References: <503385D0.5070605@tim.thechases.com>
 <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com>
 <5033C7D5.1030404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Chase <git@tim.thechases.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:30:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3wxR-0003UB-2H
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 00:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab2HUW3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 18:29:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab2HUW3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 18:29:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F32E691B3;
	Tue, 21 Aug 2012 18:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vmgAMXVGMtDcIx18Fj/YsIQ/vE0=; b=ii2sjj
	j5hlIiK/cGfHsqYz2X9JQQMNkGDz2Wvb79JxJN3IMPuqukdowfhVLCffPYvV7iAg
	hcu8bbNS3T7c+mMHcDuuDomH6wJZfyHq4z7O92dALNRrK+dI+Q5oAbCzycgfcx4A
	vlAZPYayrAp59k/60/v15vu8+hHd5NH6SBMpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1Zo34l8ba8vgRdmzrG8FTyDg3os2eir
	iJg/JZBUhAJfMKKdCi3wucb/xV9P9WxLHONuRcHp8oUVDRUF3AFaW6+Csk94f+7B
	EpPJ1JcadzMk9KkjhaH4vNSWkikdBjiiWJKMwcQlWOcO97i8lo4yoDTMKmlN2Jwq
	LdFkkGuS+fE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFB1B91B2;
	Tue, 21 Aug 2012 18:29:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CD1F91B0; Tue, 21 Aug 2012
 18:29:09 -0400 (EDT)
In-Reply-To: <5033C7D5.1030404@kdbg.org> (Johannes Sixt's message of "Tue, 21
 Aug 2012 19:39:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0347304-EBDF-11E1-94A3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204000>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 21.08.2012 17:42, schrieb Tim Chase:
>> On 08/21/12 10:22, Thomas Rast wrote:
>>>> misleadingly suggesting that the change occurred in the call_me()
>>>> function, rather than in main()
>>>
>>> I think that's intentional, and matches what 'diff -p' does...
>> 
>> Okay...I tested "diff -p" and can't argue (much) with historical
>> adherence.  It just makes it hard for me to gather some stats on the
>> functions that changed, and requires that I look in more than one
>> place (both in the header, and in the leading context) rather than
>> having a single authoritative place to grep.
>
> If it's only for stats, why not just remove the context with -U0?

I actually think you want a way to say -U<sufficiently-large> in
this case instead of unsightly -U99999.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] cherry-pick/revert: add support for
 -X/--strategy-option
Date: Tue, 28 Dec 2010 09:45:13 -0800
Message-ID: <7v7hetyeom.fsf@alter.siamese.dyndns.org>
References: <20101211005144.GA6634@burratino>
 <20101227212515.GA32352@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 18:45:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXdcB-0002Uq-Vv
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 18:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab0L1Rpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 12:45:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0L1Rpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 12:45:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 784DA3931;
	Tue, 28 Dec 2010 12:46:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ubOM131d6iSXtVnaewNZwZeC6rE=; b=i05wDm
	Vz7IlGVP0lBlzkOPpHnHJMJ16mbWoiLjxDRqNuW/unAOVo0HQAunibK/9BMY6X+l
	SoV85dxYwXH4DT449ah64rSZ+RbLS+4XeRwKDFWGjn3youZ/xJCIRUQ0DmAWTH5c
	wypZ5aAkGZ4u6BFx6ymqOxau6SogP+cR5IVJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZP8AYQacxago0+l/AK/4HlwdSa2ZFoKU
	kBKzNMmEAKwuJEcKntn3RVPLnq7b/vgiiDqRl1YR0BAdYr0aBnhkioBBKEw+kcUW
	CccWVlOWHXAwOn8ezK2rD5Sm+5rFiod9CQ777CKULDBLtEX8pJydIpun6NNQZGIw
	Ewtn7WbWdt0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06CC33910;
	Tue, 28 Dec 2010 12:45:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0298C390F; Tue, 28 Dec 2010
 12:45:46 -0500 (EST)
In-Reply-To: <20101227212515.GA32352@burratino> (Jonathan Nieder's message of
 "Mon\, 27 Dec 2010 15\:25\:15 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 528D56F8-12AA-11E0-8CB6-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164277>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> For example, this would allow cherry-picking or reverting patches from
>> a piece of history with a different end-of-line style, like so:
>> 
>> 	$ git revert -Xrenormalize old-problematic-commit
>> 
>> Currently that is possible with manual use of merge-recursive but the
>> cherry-pick/revert porcelain does not expose the functionality.
>> 
>> While at it, document the existing support for --strategy.
>> 
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> Thoughts?
>
> Ping?  I use this with -Xpatience fairly often.  Am I the only one who
> has wanted such a thing?

Pong, if you are pinging me.  I thought you wanted to only discuss it
first with RFC and meant to follow up on a real-for-inclusion patch.

The goal stated in the proposed commit log is a good thing to have, and
exactly the kind of thing -X<strategy option> interface was invented for
in the first place, I think.

I didn't look at the code though.

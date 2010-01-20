From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 13:08:07 -0800
Message-ID: <7veilk1o3s.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Joey Hess <joey@kitenet.net>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:08:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhn9-0001Oo-1s
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab0ATVIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659Ab0ATVIV
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:08:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab0ATVIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:08:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4FD092069;
	Wed, 20 Jan 2010 16:08:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kk6lntlgjqJgLoByff44p1d1HPg=; b=ex9VoD
	FZorN+42+O4xZLyTp1Qz/v4NGSSc5/XJLgLOoNQF5JHBegAmvsgU5/iuGf8fHKUv
	3kMAwj1sfgrAgGb89DDJEzcywbFP34pAZIiPHRuy+39fHOIj3YSwbjchKpj7Ld8v
	+lAdgDf3nUYCHwWvi2VynlD0kRJC7anc1xjGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ppKL64wrmzkHJJ9n5eR1pgBbz3hMf0LO
	J62UVZBKAm29nrNBzFC4CIECivvNlQ+7WLmTQLd+b5HZbUBUVJvd6hCC9LxtSuTw
	yiIvKrVr28LBTQ2IlCosZK30hp1bUzgs7ACuLR4+HmnZnBiTWiE7Tns9nv5m/bbx
	WIsxqM8wKU0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C98592068;
	Wed, 20 Jan 2010 16:08:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8715792065; Wed, 20 Jan
 2010 16:08:08 -0500 (EST)
In-Reply-To: <4B576F5C.2050102@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 20 Jan 2010 22\:02\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBCF2090-0607-11DF-A288-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137582>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 20.01.2010 21:10:
>> Joey Hess <joey@kitenet.net> writes:
>> 
>>> Do you think it makes sense for even git log --format=format:%s to be
>>> porcelain and potentially change when new features are used?
>> 
>> If the series changed the meaning of "%s" format to mean "the subject of
>> the commit and notes information", with or without documenting it, then it
>> is just a bug we would like to fix.
>
> No, but outputting the note as part of the log is the standard. So for
> example, when you do a format-patch | apply cycle, format-patch will
> insert the note as part of the commit message, and apply will *store*
> the note text (including Note:\n) as part of the commit message of the
> new commit.

Thanks; that was the kind of breakage report I was looking for (and wished
to have heard a lot earlier).  Personally I find it is unexcusable that
format-patch defaults to giving notes.

> So, I would say the notes feature is not that well integrated right now,

No question about it.

> I'm not complaining, I actually have this on a maybe-to-do list, but the
> way the series went kept me from investing time.

Hmm, that hints there is a failure in the review and merge process.  Care
to explain how we could have done better please?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: test &&-chain lint
Date: Fri, 20 Mar 2015 10:34:51 -0700
Message-ID: <xmqqoannfu84.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
	<CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
	<20150320013217.GA15302@peff.net>
	<CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
	<20150320020851.GC15302@peff.net> <20150320022532.GA5502@peff.net>
	<xmqqd244go0h.fsf@gitster.dls.corp.google.com>
	<xmqq384zha6s.fsf@gitster.dls.corp.google.com>
	<20150320172406.GA15172@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:35:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0p7-00007N-N6
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbbCTRe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:34:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751381AbbCTRey (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:34:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA21D40768;
	Fri, 20 Mar 2015 13:34:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LweciIngHHcEFLoKPIiO3NVjB7g=; b=R5Cd2w
	+q9SDNG7zyBQ6smzrVNGvY7nuOSrz+feV6rJ/KJVMvjBGuI8BLP4y+tC4efhqWKt
	/+c7R3WNpbO2b6PD/7GK5j23fLwrbJDeVaUZ91iqiIygaAid0zY8nvtnduhSm7DK
	2PWv1FBrivfPsQfB8oS3+OKnO5CKg/rO3ReCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gbQUjTTsgFD8e/DjIGgEHjjSTtLaR0ea
	aVdWkiJANwYyG/wwn+UmY8whHyyJGNj+Ut9ju5lYmghvMGsMDsQcotfk+u3erdSG
	KoROcynJ1bEfUIKQPKnTv6UiAhJ6jeihrmh8oSG/xz1xaqU7sGDedYL5KA84FvWC
	z9obydFNZkw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFF2540767;
	Fri, 20 Mar 2015 13:34:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAB4540766;
	Fri, 20 Mar 2015 13:34:52 -0400 (EDT)
In-Reply-To: <20150320172406.GA15172@peff.net> (Jeff King's message of "Fri,
	20 Mar 2015 13:24:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A9B81DC-CF27-11E4-9295-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265915>

Jeff King <peff@peff.net> writes:

> Your case above is actually better spelled as test_expect_code, but
> there are more complex one-off cases that I solved using a {} block.

Just for the record, test_expect_code expects only one possible good
exit status and it does not allow us to say "0 is OK and 1 is also
OK, everything else is bad", so it is not quite appropriate there.

> ...
> So I dunno. I think "set -e" is kind of a dangerous lure.

Yes, I think we should stay away from it.  &&-chaining is simpler to
see what is going on, even though it is a bit more to type.

Thanks.

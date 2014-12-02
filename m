From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Tue, 02 Dec 2014 09:26:00 -0800
Message-ID: <xmqqd282m09j.fsf@gitster.dls.corp.google.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:26:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrDG-0006tD-Jw
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbaLBR0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:26:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbaLBR0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:26:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63C1423617;
	Tue,  2 Dec 2014 12:26:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eL+8ZKCAXM2fFLY8mpRiDm6AZKM=; b=NxfyBO
	F5P+Dug5vj3K8sAfLKB8As/S0R1kC/sU19nt/aHA5nevuBMR8MLh1W+22q03p6H/
	Qfd8UgDSEvfT8gkx0ZeAX41pm+1JYlHWvN4MKTMAb3A8o4g2NhTepLm8EKnM88zy
	CzoPlLsQNRQbLaagEIM/Xqd8kuxb/kXiHiGmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GAbbMTdbunLKCO/wsFSELoc8kvjolmLV
	0fOuBq5op+/5s8bxc+SlPIvoGSeDlsKkSyte9Bey+lURooUR+PPDMHv+2inj4RK2
	EkwPdcQ4aRuV1POE+wO1M78uF4pYysxpqF4GVVC8KgIWA1fW5tRPleg6mCjBV3lU
	5mf1zscbb8I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56AA223615;
	Tue,  2 Dec 2014 12:26:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 710EA23614;
	Tue,  2 Dec 2014 12:26:02 -0500 (EST)
In-Reply-To: <20141202070415.GC1948@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 02:04:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49FB882A-7A48-11E4-9904-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260581>

Jeff King <peff@peff.net> writes:

> There is also "git var", which is a catch-all for printing some deduced
> environmental defaults. I'd be just as happy to see it go away, though.
> Having:
>
>   git --exec-path
>   git --toplevel
>   git --author-ident
>
> all work would make sense to me (I often get confused between "git
> --foo" and "git rev-parse --foo" when trying to get the exec-path and
> git-dir). And I don't think it's too late to move in this direction.
> We'd have to keep the old interfaces around, of course, but it would
> immediately improve discoverability and consistency.

Yeah, I too think the above makes sense.  I forgot about "var", but
it should go at the same time we move kitchen-sink options out of
"rev-parse".  One less command to worry about at the UI level means
you do not have to say "if you want to learn about X, ask 'var', if
you want to learn about Y, ask 'rev-parse', use 'git' itself for Z".

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Wed, 10 Dec 2014 13:08:57 -0800
Message-ID: <xmqq7fxzgql2.fsf@gitster.dls.corp.google.com>
References: <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
	<xmqqd282m09j.fsf@gitster.dls.corp.google.com>
	<20141204092251.GC27455@peff.net>
	<xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
	<20141204211232.GC19953@peff.net>
	<CAP8UFD2P9P9zL=irZ-7uPD6+bEhxaiABowh0O3RT01Ov3VqT6w@mail.gmail.com>
	<20141205092752.GC32112@peff.net>
	<xmqqoarcn0wm.fsf@gitster.dls.corp.google.com>
	<20141210201057.GC23273@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 22:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyoVP-00036g-VT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 22:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbaLJVJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 16:09:02 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932670AbaLJVJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 16:09:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 859A3234BB;
	Wed, 10 Dec 2014 16:08:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zlC7WM0vPBvE9wxYnHSRgVAreJg=; b=Qs0Qb2
	OLL+lLm67V8t8l3y9hubQOrE4/x5F/wIgHOIbWdssY/Ys0nhbk0Kc+jNw8gh1Ucg
	xUj0yfp42DzmZW+c1Wez+vcEtABvg99csG7DIgWGrVzaxftbeDo12Xw6DvXtkbkV
	5L8im1zjdTBlQ8PvmHXJ3CBvvNu8HDYS8rt+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hx1KUVXV3fI/FV4u4nTdLp1iNLHy0jjB
	Wf+rovTgznISaxHoLdaDeGR3aL6wsNdWxFSsmrB+hyEhtv5oixnicnCaRUJs7lcs
	ATt6yxYL+RKr1TmD4keGzxY4fAxO9GMrGTG+hVJ/qJLYqgkMpKkMPbvjqOcxZjmK
	WscsWFJV8VE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A51E234BA;
	Wed, 10 Dec 2014 16:08:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAC89234B9;
	Wed, 10 Dec 2014 16:08:58 -0500 (EST)
In-Reply-To: <20141210201057.GC23273@peff.net> (Jeff King's message of "Wed,
	10 Dec 2014 15:10:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C243162C-80B0-11E4-8435-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261248>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 09, 2014 at 10:17:13AM -0800, Junio C Hamano wrote:
>
>> This is another tangent that comes back to the original "how to name
>> them?" question, but I wonder if a convention like this would work.
>> 
>>  * When asking for a feature (e.g. "what editor to use"), if there
>>    is a git-specific environment variable that can be set to
>>    override all other settings (e.g. "$GIT_EDITOR" trumps "$EDITOR"
>>    environment or "core.editor" configuration), "git var" can be
>>    queried with the name of that "strong" environment variable.
>
> I'd prefer to create a new namespace. When you set $GIT_EDITOR as a
> "trump" variable, then that is leaking information about the computation
> from "git var" out to the caller. What happens if the computation
> changes so that $GIT_EDITOR is no longer the last word?

Having two classes of variables, ones that have their corresponding
"trump" environment variables and others (and making the users aware
of the "trump" variables) is a way to teach users that they could
use them when they want to tweak the specific aspect of Git.  It of
course casts what variable trumps all others in stone, which is a
prerequisite if we want to have something stable and teachable to
the users.  Casting in stone will hinder future improvements, so the
argument cuts both ways.

Having said that, this was not even a suggestion or a proposal (in
the sense that I would be happier if people agreed on this design
rather than other design).  I'd be happy as long as people agreed on
anything sensible.

> So now you have two classes of variables. Some that look like
> environment variables, and some that do not. What does it buy you for
> the ones that do look like environment variables?

Teachability.  I personally do not care too much about it, though
;-)

I would have used a separate namespace for the ones without "trump"
variables, and would have given aliases in that namespace even for
the ones with "trump" variables, so it does not make much difference
to my mind---we will have the third namespace anyway whether we went
the "trumps can be queried via the environment variable name"
option or not.

So it seems that we agree that a separate namespace that is clearly
distinct from environment or config would be the way to go?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Wed, 18 May 2011 08:28:57 -0700
Message-ID: <7vr57wc9ja.fsf@alter.siamese.dyndns.org>
References: <20110517071232.GA19396@mrq1.org> <4DD369C3.4070806@pcharlan.com>
 <20110518064515.GA29612@sigill.intra.peff.net>
 <4DD390AF.9020705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Pete Harlan <pgit@pcharlan.com>,
	Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 18 17:29:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMigX-0004eI-Oe
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 17:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312Ab1ERP3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 11:29:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1ERP3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 11:29:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C32645DC;
	Wed, 18 May 2011 11:31:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zgmLmQ1LEc48PUQHPh1LMaaz+FU=; b=B4fepr
	oJ47oj8x9xKyFqv1Po09b6qK/9FR35xQ7pvzSnTB3sjEIIPjBAJTPQaK3cXbDTdp
	6bJ0Lcta33A00tUtUmn72SarFmHAVN5kNZ32bowyTRK+ojB4WILhNQicCDupSoyb
	Wo2KAquzpaEvNEzW6BKbtRHwt9he+f63i13Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yP8ozHZz0ybnaaTbLLWAYh5CrICm77+3
	Q9nrWMXuNFpWSiluAqkGQy3Kw1y75DpLlb/DZzJhAQNVwD8fnF/waTH7QjeJACQI
	tGTovpigX8RaqX6+a8peflzibJvKJRJuvxQsd3fXTQKOhM2K8Z0WVV/AEHLckFv0
	r5NcwpFNPRQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3540545D8;
	Wed, 18 May 2011 11:31:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CFD145D4; Wed, 18 May 2011
 11:31:05 -0400 (EDT)
In-Reply-To: <4DD390AF.9020705@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 18 May 2011 11:26:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC700276-8163-11E0-A1B6-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173884>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> We could also allow multiple commands at once, like "yq" (even in
>> single-key mode, this would do the same thing).
>
> So instead of having to
>
> press y press q
>
> I can now
>
> hold SHIFT press q
>
> Seeing the gain in that fails me completely. Also, why doesn't "yd"
> deserve a shortcut? I would expect that to be used more often, as in:
> "Yes, that was the hunk I wanted to add from this file, but what other
> files have changes"?

Thanks, I agree that "Q" as proposed is not very useful and looks too much
like a hack that caters to one special user from that point of view.

I've also been wondering why nobody has asked for "5y", which I often find
lacking.

When you have a set of changes with many hunks to sift through, before
going into an "add -p" session, you often have pretty good idea of hunks
in which part of the files are to go to the commit you are currently
building. I often find myself saying "ah, from here there are many hunks I
want, and it is totally safe for me to apply 5 or so from here without
looking."

I think "single-key" was a poorly designed attempt to improve productivity
the ("y" <RET>)*5 into "y"*5, while sacrificing the safety net when you
are trying to pick and decide one by one (like the accident Thomas had
recently during "checkout -p"). If I can say "5y", think for half a second
to make sure I typed what I meant, and <RET>, to apply 5 upcoming hunks in
one go, I think I would be as efficient as the productivity optimization
the single-key offers, while still protecting me from mistakes made by fat
fingers.

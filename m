From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Making a patch:  "git format-patch" does not produce the documented format
Date: Fri, 02 Aug 2013 16:28:19 -0700
Message-ID: <7vzjszoep8.fsf@alter.siamese.dyndns.org>
References: <201307312131.r6VLVliK028321@hobgoblin.ariadne.com>
	<20130731214818.GP2337@serenity.lan>
	<201308022211.r72MBT9G020153@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Sat Aug 03 01:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Olm-0005ex-Rh
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 01:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab3HBX2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 19:28:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab3HBX2W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 19:28:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBE93360B2;
	Fri,  2 Aug 2013 23:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EgsDm7pGIq2ydAosQzTJME9DWmY=; b=k2ryUm
	AqDgR+G51N/lXA1X22Hz7uQ08WsAXCfJgGVC50AhZHJ9tc4/69HjdCG3NDRu3/Z7
	pj6HU2MOKzV9ouxEyZez7NFu4a/WZbP7Lg9EvfHHyZT7mgSG94M1I56KJdF3Dqt4
	OyqW5PfAL/Juzev/vWYRgp8kiXJNlyHxIjX4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B6tyXhDcM5xkq+AoRIDA9uWzSz8Ac4ji
	hFHVNpe9T1kOXBEvFxhAJK6U8ebwBM38I+skwY9DDHQPcdWZV5t6GLZjnac4PFcZ
	NhvJnlOmf9nQ24QnKvZwt5+2xTvSp7jMqDl7ztLg1buMPu60KeUYa17mPHrSV2ev
	b/BIcRoEq1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF2BC360B0;
	Fri,  2 Aug 2013 23:28:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D5E4360A8;
	Fri,  2 Aug 2013 23:28:21 +0000 (UTC)
In-Reply-To: <201308022211.r72MBT9G020153@freeze.ariadne.com> (Dale
	R. Worley's message of "Fri, 2 Aug 2013 18:11:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 380EA572-FBCB-11E2-9635-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231548>

worley@alum.mit.edu (Dale R. Worley) writes:

> I'm preparing some clarifications of SubmittingPatches to explain
> things that a new person (e.g., me) would not know.

I am not sure if SubmittingPatches is a good place, though.
The document is a guidance for people who contribute to _this_
project.

But the specialness of the first paragraph applies to any project
that uses Git, so people other than those who contribute to this
project should be aware of it.

Originally we literally used "first line", but that made many things
like shortlog output and patch Subject: useless when people write a
block of text starting from the first line without a title.  Also
after resurrecting such a text from e-mail, "am" couldn't tell if
the "first line" on the "Subject:" is meant to be the first line of
the same first paragraph (which is not what we encourage), or it is
properly a single line title, and need a blank line before the first
line of the body.  So quite a while ago, we changed the rule to take
"the first paragraph" and use that in these places where we want to
give a title of a patch.

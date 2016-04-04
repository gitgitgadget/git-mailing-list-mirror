From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: clarify that notes can be attached to any type of stored object
Date: Mon, 04 Apr 2016 09:39:55 -0700
Message-ID: <xmqqy48t5nvo.fsf@gitster.mtv.corp.google.com>
References: <56FE48C6.9050306@gmail.com>
	<xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
	<xmqq8u0xjmxh.fsf@gitster.mtv.corp.google.com>
	<CAHGBnuP71qpOoNAAwXE-nbPbVyK56Up0YpmhhjC5430VwW73kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:40:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an7Xs-0001xV-3F
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 18:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbcDDQkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 12:40:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752744AbcDDQj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 12:39:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7D704ED2E;
	Mon,  4 Apr 2016 12:39:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VORtU5Zu047X2J3fBsKukI4Xx6Q=; b=xE1xuF
	X5SoVBI7Op2+bhwK672Txe1iCZfyRTG8U3r2CwrQISJ10/HfODoESDYPFuOU3nLw
	zcMr+JrKshqwu2uWGg+zPrhRezr7aGVZEdJ7y+tw6NphpSBnlsyYuxYXrA9SHkMm
	LbvZv+QQmPejcc/FilNBRNYXJU1UImqE6zrwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rowpGAHOtbeMBBCNqWpVSVFHFOSEPJfV
	vg5GlLMthwRAT7R+zKL9ci3u7fl4trlhaLdhCkpzhhE4myoUhANYOL/gZzNe+L+G
	hWBmmVypFPl9MGj8n1WxPuOfM+m0Ula7ImZSvS/nP91K3RERf7uTiZq5zTbg55mR
	M7YLFxdYGAc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF7264ED2D;
	Mon,  4 Apr 2016 12:39:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 357E84ED29;
	Mon,  4 Apr 2016 12:39:57 -0400 (EDT)
In-Reply-To: <CAHGBnuP71qpOoNAAwXE-nbPbVyK56Up0YpmhhjC5430VwW73kQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Mon, 4 Apr 2016 10:33:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDBA7780-FA83-11E5-AF0E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290695>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Done, I'll send a patch shortly. But I wanted to list the supported
> object types explicitly, in particular as many guide in the net are
> unclear that only annotated tags are object, and lightweight ones are
> not.

I'd really hate to see an explicit list of what object types there
are, as it is one more place we'd need to update if we ever add new
object types (and we are unlikely to do so anytime soon, which makes
it even more likely that we would forget there is this explicit list
we'd need to update).

-     Adds, removes, or reads notes attached to objects, without touching
-     the objects themselves.
+     Adds, removes, or reads notes attached to any object (not limited
+     to commit objects), without touching the objects themselves.

should be sufficient, no?

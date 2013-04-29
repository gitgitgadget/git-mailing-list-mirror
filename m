From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 13:01:17 -0700
Message-ID: <7va9ohhzsi.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 22:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWuGO-0006rB-FH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 22:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901Ab3D2UBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 16:01:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3D2UBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 16:01:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF8D11A23C;
	Mon, 29 Apr 2013 20:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GT003xVl4Mq8qyLWj06mRCkQPxM=; b=WcCSRn
	sT8QrSaPg4DBt7W3Ix4kpUGxH3jCT5DotQFrvuuUCUZfb9s6yxmMNmyQNq/IEnoX
	6BHkfYY517YZz6D9k0ZUWTRUrdO4WUL0WesLGm8DtbbdYnYEs6gLHrqvrJePCCaM
	SRBp+52msaat9yYerDobmIssXY+a0eKSXTzU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zf9SqlZFBQBQ5r15jJMxh4Y1cj8pQxjp
	MXR3z3qsrlQ+3f6MacKaRRsDPvZAeIN1WNtczN3RVlc1oKOzEnS4YGw0oaee3FWM
	XwABKEUKJeaBo5UBrlp8cEr39ZaENlXHXZRdIt8aAa12tgkZeJ9FPhlESEbiksJQ
	DxH6hBrq3ns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A66141A23B;
	Mon, 29 Apr 2013 20:01:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 159CA1A236;
	Mon, 29 Apr 2013 20:01:18 +0000 (UTC)
In-Reply-To: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 14:35:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8EAABB46-B107-11E2-A789-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222856>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
> remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?
>
> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
> 'master@'.
>
> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
> use 'git show @~1', and all that goody goodness.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> People have complained about the lack of a HEAD shortcut before, and some
> proposals have been made, but I think this one is a clean trick in accordance
> with our current syntax.

Technically the notation would be only valid if you have a reflog on
it, but if we must have such a notation, I think this may end up to
be the least bad one.  I haven't thought things through, though, so
won't stand behind it myself (i.e. when there are corner-case holes
found later, I won't defend the notation myself), at least not yet.

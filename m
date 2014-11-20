From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] parse_color: recognize "no$foo" to clear the $foo attribute
Date: Thu, 20 Nov 2014 11:46:35 -0800
Message-ID: <xmqqd28h3bac.fsf@gitster.dls.corp.google.com>
References: <20141120151418.GA23607@peff.net>
	<20141120152551.GF23680@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 20:46:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrXgh-0000Km-8T
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 20:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbaKTTqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 14:46:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755664AbaKTTqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 14:46:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 704531E5A2;
	Thu, 20 Nov 2014 14:46:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+8NL0VVI2fFdnly4BUg5ZnTKFX8=; b=BfdyyS
	4MI2jv6oC2kalewBaB8wGeebIeBZqGIUOd44GD6Qm8ycntOmWMiEjeJq6QUZcjpl
	sPP6q1JKAN5yL8Tg54x7c2zYFw4UvIk7Hnmate/os7Q5M5XOZaopBlUnsyz9IrDg
	NrZuHC10ihjpRoZzwnbv3pCBijqPmmPsYg4T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UJqd1pq/PKZSN7TBoD/yoz6CEuRjFX7b
	lp9U85vnzLy6aznVGQkOFLI9NLsC9USNnXaaC6u8gC4tcSXsMEO9aaTmpU8926R9
	6AK75vsyPcyDvW+lnsiYVu+WzuxQ4DZnd6us8uogj2Fz3sutHdXfIdWA3MzNQkrw
	u/CP6zwK1/w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6697C1E5A1;
	Thu, 20 Nov 2014 14:46:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A441F1E5A0;
	Thu, 20 Nov 2014 14:46:37 -0500 (EST)
In-Reply-To: <20141120152551.GF23680@peff.net> (Jeff King's message of "Thu,
	20 Nov 2014 10:25:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0C2FA08-70ED-11E4-87A6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You can turn on ANSI text attributes like "reverse" by
> putting "reverse" in your color spec. However, you cannot
> ask to turn reverse off.
>
> For common cases, this does not matter. You would turn on
> "reverse" at the start of a colored section, and then clear
> all attributes with a "reset". However, you may wish to turn
> on some attributes, then selectively disable others. For
> example:
>
>   git log --format="%C(bold ul yellow)%h%C(noul) %s"
>
> underlines just the hash, but without the need to re-specify
> the rest of the attributes. This can also help third-party
> programs, like contrib/diff-highlight, that want to turn
> some attribute on/off without disrupting existing coloring.
>
> Note that some attribute specifications are probably
> nonsensical (e.g., "bold nobold"). We do not bother to flag
> such constructs, and instead let the terminal sort it out.
>
> Signed-off-by: Jeff King <peff@peff.net>

Is "white noyellow" a new way to spell "blue" ;-)?

Thanks.

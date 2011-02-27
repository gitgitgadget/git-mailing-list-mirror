From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Sun, 27 Feb 2011 14:54:59 -0800
Message-ID: <7v7hclulz0.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mart =?utf-8?Q?S=C3=B5mermaa?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Feb 27 23:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtpWV-0002vt-Uv
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 23:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab1B0WzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 17:55:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1B0WzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 17:55:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C7D714150;
	Sun, 27 Feb 2011 17:56:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E2Z6SM1z8aR8WbWsvjd6mzzPyQ0=; b=iQb3Az
	a1iz0QkKVGUjoRZAPfqkc+P4VEL7Uu8xV9VEqLyie612wjCbs74K6e0lflo5T7HP
	R4bTVLbeT6e/Y0ePgrVmjt8cnMPxXEjBo+fEU4e872JdEh4/G4zrcw2BvglW+GuN
	Ypb6TJOQ7yRwkRlowLKvMcvQNh8Es4UowIOCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p6Rl6hg/tGW2kA2y3VOpblItZOtHjWvh
	hcXN9g7Q4Iey7G9yjdzYJLzmSXIEaAfdwyWlQg3jQR604orZYCTaM/lvdMJTXyMn
	h7Y7Q23gSbBi/FZa8kfgKvzGR6Qz1U08fwd9W2R1SDvzRobXHKyRdU6HkgQ9vrxH
	f6fTt9lFO8A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97B7F414B;
	Sun, 27 Feb 2011 17:56:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 91C3B4147; Sun, 27 Feb 2011
 17:56:17 -0500 (EST)
In-Reply-To: <4D6A6291.8050206@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sun\, 27 Feb 2011 15\:41\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB7864E6-42C4-11E0-9CB4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168059>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Wasn't the pager invented for sifting through output which has to be
> several pages, but not not for that which could be more concise? ;)
>
> In fact, -D would be quite analogous to -M and -C in that respect.

There is a big difference: -M and -C lets your recipient reproduce the
state using the change you are trying to convey with the diff output in
either direction (iow, "apply -R" works), but your "-D" would not have
that property.

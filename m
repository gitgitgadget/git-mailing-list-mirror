From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/4] Remove deprecated commands
Date: Mon, 11 Nov 2013 10:25:51 -0800
Message-ID: <xmqq4n7in6c0.fsf@gitster.dls.corp.google.com>
References: <cover.1384098226.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwBT-0005vb-PE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab3KKSZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:25:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753821Ab3KKSZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:25:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A90D4FFF4;
	Mon, 11 Nov 2013 13:25:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=54YDGae9oNfRIl6vTrJ1kdQtfsk=; b=LhxKzr
	PZmDX2931hz+Qv/MRVWqKSUqydo1XtFFm+LwmR5xvbDZKp/JkIKJeLk6kNsoKDed
	COe9x3r2sud+6UtGHOBnke7NyfLd0IOfjGZCnwDQnmCqzn1vAyuBGBmqBHPpISID
	rPvwoDkGGPZUOr2fxbYFZuIdQYiHFlMvMyV3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iKMsaNXaD7L8TFyffOzu5PTw28g6XByl
	odhUJ55ro7ljXcZL6ZxmpIIL1oa4q7Pn330vRn+A52WEe0dZmvr5NEvIUesrlVvx
	RtAPXcJOq9nylPKCGuNt1QtE6uxLPQe9eWiwtngGjxP1BV77QRJQMLbh4BQMBM/6
	P0af/V4mfkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C77B4FFF1;
	Mon, 11 Nov 2013 13:25:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80E3D4FFF0;
	Mon, 11 Nov 2013 13:25:53 -0500 (EST)
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk> (John Keeping's message
	of "Sun, 10 Nov 2013 15:47:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B2EEE2A2-4AFE-11E3-8E15-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237625>

John Keeping <john@keeping.me.uk> writes:

> "git repo-config", "git tar-tree", "git lost-found" and "git
> peek-remote" have all been deprecated since at least Git 1.5.4.
>
> With Git 2.0 approaching, I think that would be a good point to remove
> then completely, which is what this series does.

Probably good material to discuss during the next cycle.

As a totally unscientific sanity check, I asked Google to show these
since Nov 13, 2011:

    [git repo-config] vs [git config]: 136 vs 232

    [git peek-remote] vs [git ls-remote]: 62 vs 133

    [git tar-tree] vs [git archive]: 73 vs 189

    [git lost-found] vs [git fsck --lost-found]: 96 vs 83

So I think 1, 2, and 4 are OK to ship in whatever version that comes
after the upcoming 1.8.5, but we might have to hold onto lost-found
a bit longer.  The command does show a deprecation warning, so there
is nothing to change at this point.

Thanks.

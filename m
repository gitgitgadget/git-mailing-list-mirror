From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] refs: make rev-parse --quiet actually quiet
Date: Fri, 19 Sep 2014 10:52:50 -0700
Message-ID: <xmqqwq8zmr9p.fsf@gitster.dls.corp.google.com>
References: <1411098337-35406-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 19:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV2Mc-0000d5-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 19:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbaISRwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 13:52:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56257 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbaISRww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 13:52:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4062F3AA34;
	Fri, 19 Sep 2014 13:52:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ah4vMxUfjbpVT85Vk/x++1vGLbI=; b=NfGTFD
	7YS5zk9caeRUOf6AzW9slB98btUNv+nm3QRUE5Ejw/ArHpUmaQMn/x2Bx8BLkDap
	jogeMb2opswuYv571zQKK4zUXlO9RPEh6MKU+/WIws9vXqS8sv4kivdPbk+hj/ju
	4SiJo6hR2sblWnGSmxbQoBMvyPZC0kG7mUBA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbwyYF7W+CaSxWFrNfDWI3VW2qR7KKwJ
	mCOkzUukd1padphvO32GxRQTv1ropuunLQSpspzq24Dj+yJaMnG0UC/RM75Jc0z2
	fxaiuP2LnnmewRdM2HCkHmi6VHVnHncsBh6Zy3gS0h+eoKkZDAfv09tyFB1ugsZI
	E4BtsZJBsZI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 353C33AA33;
	Fri, 19 Sep 2014 13:52:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ABE363AA32;
	Fri, 19 Sep 2014 13:52:51 -0400 (EDT)
In-Reply-To: <1411098337-35406-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Thu, 18 Sep 2014 20:45:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C698A104-4025-11E4-94CF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257301>

David Aguilar <davvid@gmail.com> writes:

> When a reflog is deleted, e.g. when "git stash" clears its stashes,
> "git rev-parse --verify --quiet" dies:
>
> 	fatal: Log for refs/stash is empty.
>
> The reason is that the get_sha1() code path does not allow us
> to suppress this message.
>
> Pass the flags bitfield through get_sha1_with_context() so that
> read_ref_at() can suppress the message.
>
> Use get_sha1_with_context1() instead of get_sha1() in rev-parse
> so that the --quiet flag is honored.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is a replacement patch for "refs: make rev-parse --quiet actually quiet"
> from da/rev-parse-verify-quiet in pu.

Looks good; thanks.

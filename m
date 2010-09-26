From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/fetch: print hash of deleted tag when updating
Date: Sun, 26 Sep 2010 14:41:38 -0700
Message-ID: <7vsk0wmbcd.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=KVDRzE3-NW+GTO_CL-KtNZ+BjkErgNKMPPtGf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 23:42:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozyyw-0001xM-Td
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 23:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616Ab0IZVlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 17:41:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab0IZVlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 17:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64357D9223;
	Sun, 26 Sep 2010 17:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/7fqFdj4XInLBSZJQLBrNOYADwk=; b=vf5Jz9
	rFHPBAMe75Krj09ieCSVImfwTKHhu3gVN5TXGn9Jzp4xjYDUZCwbZPqDoOPsRfzt
	e2ITCzL+7n43seS1ct6/Ym4FWs830xK6bdvpJMaTMOqG2xW1ovoEE6sbTxOLYm+o
	emaBTpW8dWDLmBSUjuCwXISIKM3x0WCWqNFeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AKgEqg4Lhwc08WqFeMttNg1BAYvCkJ6S
	4pmuc/XVE99MlSfhgABN1HQKsx9p0lkSehwOW0zTuLX1cYTepR0c6jhHkDd1kexc
	wiAUYt8fBQNNdLTIfxIZlmcOU2iMaQ0bZ9mF77ZRHR4sMXdV+BihFTFmWgglxSOO
	Q4PJmwJ6AbI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF5FAD9222;
	Sun, 26 Sep 2010 17:41:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56BE6D9221; Sun, 26 Sep
 2010 17:41:40 -0400 (EDT)
In-Reply-To: <AANLkTi=KVDRzE3-NW+GTO_CL-KtNZ+BjkErgNKMPPtGf@mail.gmail.com>
 (Knittl's message of "Sun\, 26 Sep 2010 18\:10\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA629198-C9B6-11DF-8B26-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157260>

Knittl <knittl89@googlemail.com> writes:

> From b1c2b07aa1f5db25ebdf190aa12ccb66a17f131a Mon Sep 17 00:00:00 2001
> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> Date: Sun, 26 Sep 2010 11:29:16 +0200
> Subject: [PATCH] builtin/fetch: print hash of deleted tag when updating
>
> `git fetch --tags` will unconditionally update (and thus overwrite)
> existing tags, which is especially annoying for annotated and signed
> tags.

The first question is why s/he is running fetch with --tags if overwriting
is unwelcome/annoying.  "--tags" is meant to be used when the auto-follow
behaviour of normal fetch is not sufficient and the user actively wants to
get the latest (potentially updated) ones; would it be possible that you
are solving a wrong problem?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log: invert --author and --committer
Date: Mon, 23 May 2016 14:26:32 -0700
Message-ID: <xmqq1t4s8nzr.fsf@gitster.mtv.corp.google.com>
References: <CAP=KgsSdX3pCRzeUVobrFWVGOGGSrwkO0MjFhUWruiajAxn38Q@mail.gmail.com>
	<xmqqmvngaedn.fsf@gitster.mtv.corp.google.com>
	<xmqq37p8a84y.fsf@gitster.mtv.corp.google.com>
	<CAP=KgsSNgKY5gR3uSSMZdOxZ1687YRnQRQFsV22UwCXqmdfB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:26:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xN3-0003Ar-KB
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcEWV0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:26:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751810AbcEWV0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:26:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D46B11D3FF;
	Mon, 23 May 2016 17:26:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OyKGCcRUKy8IsC9cnwMWQt2X9JE=; b=qxnkyh
	/BCDgZqZ/7dOKxC2PhYG2U4PLNNeQPjW2/YnrE/ZNrrOB5isGAL0JgbuMuQQ/GIg
	thAq8oDKv7hmkp0IVYjMIWpL3d8RFMnSIFUXCe/V1SoBSopoWnKlcVkEOhRcdDMk
	iz9mDMtbjfKfoSW3BlVQdv73jqXcYZhNpS7G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G0026yPU5gvzd59OuFQc7KKz46uGMFcz
	S5NdzVMYyKV85a9tpd6CghdwUGXjAaVj6Qg4uItw49gz6ZZY1tJNEZpMpfnjFOOW
	S7qR8uh+bVSNfz1quJUm4H0Q21SmxyAzS0SqRUqiaoUEh6xcJsF2ePR8PEpYJ1q0
	4eLAmzT+9+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA6211D3FE;
	Mon, 23 May 2016 17:26:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 432CF1D3FD;
	Mon, 23 May 2016 17:26:35 -0400 (EDT)
In-Reply-To: <CAP=KgsSNgKY5gR3uSSMZdOxZ1687YRnQRQFsV22UwCXqmdfB9g@mail.gmail.com>
	(Per Cederqvist's message of "Mon, 23 May 2016 23:21:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 06D08A54-212D-11E6-932A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295395>

Per Cederqvist <cederp@opera.com> writes:

> "can also be used to affect", right? (I think the word "to" is missing.)

Correct.

> That wording would however make me assume that --all-match could also
> be used, so that
>
>     git log --all-match --author ceder --author cibot
>
> would list nothing (since there are no authors that match both
> "ceder" and "cibot" in this codebase).  That isn't the fact, though.

That is because "--all-match" does not affect "how a regular
expression match is performed".  The option affects the way how the
results from these multiple regular expression matches are combined.

> It seems to list all commits that have either ceder or cibot as author,
> just as if I had not used --all-match.
>
> As a reader of the man-page, I would prefer to have the exact list
> of options in the documentation.  (I realize that it will make it harder
> to maintain.)

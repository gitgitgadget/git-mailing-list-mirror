From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #01; Tue, 3)
Date: Fri, 06 Sep 2013 09:28:20 -0700
Message-ID: <xmqqr4d1zzh7.fsf@gitster.dls.corp.google.com>
References: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
	<CANYiYbGHKDENMCnWaRtb_=HmpenxWA95H-bfHdWM8f6098sT6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 18:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHytc-0007QJ-5B
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 18:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504Ab3IFQ21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 12:28:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab3IFQ20 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 12:28:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B3923D3C0;
	Fri,  6 Sep 2013 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e1n7FIbpwQT9bdRZCV3WDR8faug=; b=xrYq2i
	tsjq5ksLsoYXVIjoSxGdtYO4aM52l9PEjKcOT9Ew5z3R4DeSfzN4UWGh5gGAzYtT
	3nXg34r9zGFZkK9bgi5OnqstXKq9TVaaexE+CQHeugmKA0/PywOLCe3PglHB8f4l
	gQ5JZ3XrsxgnQk/o2l6AF6xogXTsHqsCnUjGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmB622JVxnYFfD+UnFLr2l015WFQdXB4
	3txL88ADkn1qILpy8Fh2dDltu+H/cmeUTU1smu3oeEBNf5KbFat4x7xbboWdMmRW
	dxN1Rqnmh2eaM4BLva1KFdX0jj8X9QDhWa1i/7dqx57J4yeoIEsCyVwM0mZPhuuZ
	vLu1caO/6W4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD403D3BD;
	Fri,  6 Sep 2013 16:28:24 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A9103D3AA;
	Fri,  6 Sep 2013 16:28:22 +0000 (UTC)
In-Reply-To: <CANYiYbGHKDENMCnWaRtb_=HmpenxWA95H-bfHdWM8f6098sT6g@mail.gmail.com>
	(Jiang Xin's message of "Fri, 6 Sep 2013 10:11:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58F9759E-1711-11E3-93CE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234057>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/9/4 Junio C Hamano <gitster@pobox.com>:
>> * jx/branch-vv-always-compare-with-upstream (2013-08-26) 2 commits
>>  - status: always show tracking branch even no change
>>  - branch: report invalid tracking branch as gone
>>
>>  "git branch -v -v" (and "git status") did not distinguish among a
>>  branch that does not build on any other branch, a branch that is in
>>  sync with the branch it builds on, and a branch that is configured
>>  to build on some other branch that no longer exists.
>>
>>  Am I waiting for another reroll?
>
> No more reroll if no more votes for “absent" vs "gone", and
> "in sync with" vs "up-to-date with".

I re-read the thread and the way I read both of these choices is
that they were merely "this other word is also possible, may be
better, but may be not." and not meant as strong recommendations.

Since that seems to be the only remaining issue, let's unchock and
merge the topic to 'next'.

Thanks.

> Currently, we choose "gone”
> and "up-to-date with", such as:
>
>         $ git branch -v -v
>           master    e67ac84 initial
>         * topic     3fc0f2a [topicbase: gone] topic
>
>         $ git status
>         # On branch topic
>         # Your branch is based on 'topicbase', but the upstream is gone.
>         #   (use "git branch --unset-upstream" to fixup)
>         ...
>
>         $ git status
>         # On branch feature1
>         # Your branch is up-to-date with 'github/feature1'.
>         ...

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/17] Port branch.c to use ref-filter's printing options
Date: Tue, 17 May 2016 10:52:35 -0700
Message-ID: <xmqqtwhwwp0c.fsf@gitster.mtv.corp.google.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
	<xmqq4m9x1wl2.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ5nUazL61eqj34-v06rueyjzvvJHzp8du7HHGi5=7TMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:52:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jAj-000098-0I
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbcEQRwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:52:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875AbcEQRwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:52:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BDA41C7FE;
	Tue, 17 May 2016 13:52:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BLBVF7zzFwV/kApYo8gPq6pLnSA=; b=Y9SGMl
	EuBJ2rfqleMF5QKwkamSBh0EQ2Ky34CSVDjLFHSK6cJijMJ/R6mitThE+5VkNxSB
	Y0fzNsrO39wUvuzXhUBQYBM0swuGXKdj28MiOd8E2qxcTYY4WXiD6IucrG22f0Ov
	Q/wdKp8WO8vQ4FmeSZnQTo6+Ivnfcw5FJRKCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1g7PF49EMw4BV1/khgFFZTv9qbTObYI
	nIDxUpma9Y64FA1wSxXnBtup6kMV2mZ6Ys7vtbvSgkAgw1HiNQOEHK04ngPghY34
	IKnSC/mTnOSLNZqIOnXF6xOXHiwuOrxMF1rlbmrgFobhnknGQWrzE/C3p6tr0TJu
	LxOLo9wTDNk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 513D11C7FB;
	Tue, 17 May 2016 13:52:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B801E1C7FA;
	Tue, 17 May 2016 13:52:37 -0400 (EDT)
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)Git <git@vger.kernel.org>
								     ^-missing end of address
In-Reply-To: <CAOLa=ZQ5nUazL61eqj34-v06rueyjzvvJHzp8du7HHGi5=7TMA@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 17 May 2016 13:34:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2492B488-1C58-11E6-B4DB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294885>

Karthik Nayak <karthik.188@gmail.com> writes:

> Hello, sorry for the confusion, it's built on top of 'next' which contains
> f307218 (t6302: simplify non-gpg cases). The merge conflict is due to the
> commit made by you 1cca17df (Documentation: fix linkgit references).

That is not "confusion", but an "incorrect piece of information".

The series does not seem to apply on 'next', either.

Where did you exactly rebase on top of?  It is not on f307218, it is
not on 'next', 'next@{1}',... 'next@{8}'.

f3072180 (t6302: simplify non-gpg cases, 2016-05-09) was merged to
'next' at 9fcb98b2 (Merge branch 'es/test-gpg-tags' into next,
2016-05-10), but the series does not seem to apply there, either.

$ git co 9fcb98b2
Applying: ref-filter: implement %(if), %(then), and %(else) atoms
error: patch failed: Documentation/git-for-each-ref.txt:181
error: Documentation/git-for-each-ref.txt: patch does not apply
Patch failed at 0001 ref-filter: implement %(if), %(then), and %(else) atoms
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Not that a series built on top of any 'next' is directly usable.
You are forcing me to identify which topics in 'next' you depend on,
and build a topic that does not contain anything unrelated that is
in 'next' before starting to apply these patches.  Can you pick a
more appropriate place to base these patches on, please?  Why isn't
this based on 'master', for example?

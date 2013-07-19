From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 19 Jul 2013 15:55:57 -0700
Message-ID: <7vip06tb0i.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan> <871u6v93a8.fsf@igel.home>
	<7vmwpj3g0l.fsf@alter.siamese.dyndns.org>
	<7vvc471x1s.fsf_-_@alter.siamese.dyndns.org>
	<CAPig+cTXn4hdKoCjnNXmybNxYt0Bt_QuxsfFxiA5b0J1FxUUmQ@mail.gmail.com>
	<7vy592wmcs.fsf@alter.siamese.dyndns.org>
	<CAPig+cQEtKc+tfDgqVWYL2JtxXc=wvS=P7_O=XJzizz1BN=n4A@mail.gmail.com>
	<7vzjtitco6.fsf@alter.siamese.dyndns.org>
	<CAPig+cT83Zv5aDDTYhfLOQ-ymCckwHDhxE6ChHUQKWQbfPdG6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 00:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Jao-0007FF-LX
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 00:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364Ab3GSW4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 18:56:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab3GSW4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 18:56:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9AC832BED;
	Fri, 19 Jul 2013 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qn9UTY4VxH4soOnTAJeTpvbov6Q=; b=MDRcNG
	Y4S+36ffJDbN0kdJ0AU5F4S5ZXntNTl9Lb8J5e4JRMnh3HthTLkjHydok76+h7kI
	pQp7tOsOBD3wW9CW7RlFmj74fjki1fKih1U/wzH91TldTIAVH73jNF8Rarr+QNsV
	c7jJNEY/rmUGhxyxqspNAusbon4I5o4KTdIBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PiAA+Y9tvHk5p2KqBEVeGt4FoNsJFvgg
	FDOIr/qasRXjyamAY3I0o+ttXc2//AOXPEzMPZgLgO/c7U2HOmj+k7+62aabWI1J
	EZvguYUd4m7Dc4bCz7w8nK99m6KlZYW+cPxCZgL2M67tGxv5NYvfl1rMVSrCMS8o
	Yk6wnhW8EuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C04B532BEB;
	Fri, 19 Jul 2013 22:55:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C71A32BE9;
	Fri, 19 Jul 2013 22:55:59 +0000 (UTC)
In-Reply-To: <CAPig+cT83Zv5aDDTYhfLOQ-ymCckwHDhxE6ChHUQKWQbfPdG6A@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 19 Jul 2013 18:30:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60B78328-F0C6-11E2-A906-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230856>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>     With no repository or branch on the command line, `git pull` needs
>>     to be told how to integrate the changes with your history.
>>
>>     This can be done via either `--merge` or `--rebase` option, but most
>>     people would want to decide which method matches the workflow of the
>>     project once, and set the configuration variable `pull.rebase` or
>>     `branch.<name>.rebase` to stick to it; see linkgit:git-config[1].
>
> At this point, I'm probably just bike-shedding. Perhaps?
>
>     With no repository or branch on the command line, `git pull`
>     needs to be told how to integrate the changes with your history,
>     via either `--merge` or `--rebase`.
>
>     To match a project's workflow and make the choice of merge or
>     rebase permanent, set configuration variable `pull.rebase` or
>     `branch.<name>.rebase` (see linkgit:git-config[1]).

I agree with the bike-shedding aspect of your comment, and actually
I like my version better.

It makes it clear that a single-shot --merge or --rebase from the
command line is not recommended.  "To match the project's workflow"
is not optional in most projects, and it is preferrable to decide
once and set the choice in stone.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 19 Jul 2013 15:20:09 -0700
Message-ID: <7vzjtitco6.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 00:20:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0J2D-0006Xp-93
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 00:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab3GSWUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 18:20:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab3GSWUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 18:20:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6E4132C44;
	Fri, 19 Jul 2013 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gyvzVaFN8LzPogyknJD/RPTdgc8=; b=lLxOeg
	HYCriQaSxicsN34W5EQ62OzJ7b4flFdN6xG8UQNpTvXNeO+m6nzCuKSNpRCBMv63
	2SVIZ1dsJRaxbUMVGSOQLeYcD9LCeO4TSh5/2HQtxp9AABYr4f+1DS9LtCOaO7fa
	z82XbidVw26NCHpvwsv+6LaCDJRVL7QoBOpT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBjABvQoCZpxzJlXrduF6w/w1tsgOSho
	K63Aea5KKr7ScwqTmF3l89BElHXlT17B7cyHpB/Twbhs56OPRWHm30lckSAMGnvM
	kL2Js/bfS8IJI03S/Uhl11BsAwRNWN4dYCcKVLHm8cpzvKwpFGXSJjJvG6EZ1J30
	GN1dLZkeUDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D7A932C42;
	Fri, 19 Jul 2013 22:20:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF0C832C3D;
	Fri, 19 Jul 2013 22:20:10 +0000 (UTC)
In-Reply-To: <CAPig+cQEtKc+tfDgqVWYL2JtxXc=wvS=P7_O=XJzizz1BN=n4A@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 19 Jul 2013 16:29:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 604B996A-F0C1-11E2-A1A8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230852>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Dropping the parenthetical comment might improve flow slightly:
>
>     Without repository or branch on the command line, `git pull`
>     needs to be told how to integrate the changes with your history,
>     via either `--merge` or `--rebase`.
>
> With or without mention of the configuration options, either phrasing
> seems pretty easy to digest.

Yeah, that reads much better, but I do prefer to see something that
explains this is often "just make sure you use the one that suits
your project and always use that".  How about something like this?

    With no repository or branch on the command line, `git pull` needs
    to be told how to integrate the changes with your history.

    This can be done via either `--merge` or `--rebase` option, but most
    people would want to decide which method matches the workflow of the
    project once, and set the configuration variable `pull.rebase` or
    `branch.<name>.rebase` to stick to it; see linkgit:git-config[1].

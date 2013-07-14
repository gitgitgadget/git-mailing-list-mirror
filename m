From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 12:17:46 -0700
Message-ID: <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
	<7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org>
	<7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org>
	<7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org>
	<7vwqougwec.fsf@alter.siamese.dyndns.org> <51E1B5DB.9080904@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 14 21:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyRoB-0002t3-0q
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 21:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab3GNTRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 15:17:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013Ab3GNTRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 15:17:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 603222F412;
	Sun, 14 Jul 2013 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y7LG9h7eiiDkPE626OfHhZ5PUxY=; b=kwavNs
	SPSDlbWgUtQ7GX55fYVJmRQtiJ3NTsAHml6ZzlYicbNRq5JiF64cYQINv05JJIrp
	hbBVS0tIPwKfcwLS/5ydmFko5tVqKNFHF0JaBSNyKsOlJZ7yBOtF/B/j+kpHg/ed
	NBAWTn4UkJDUOsTJnIcmt1zaDPIWS85OaUPqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CR9CZlxNbWCN8NHfWDh30FN4z2qJh0cY
	CrYjEjVDLZZaaICfKox4h3Zg0Ze2wjBPJNXMWQ2OhVZIR55AiYzBaL5Zl+VCkBiw
	ny6XZHoYK2eYY06cMvIdein49R/tu9gpNyZnk6Ij++xjisf2D9ey01BnEov0Ipi1
	rsgXMvWTC64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54A0D2F410;
	Sun, 14 Jul 2013 19:17:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7222F2F40F;
	Sun, 14 Jul 2013 19:17:48 +0000 (UTC)
In-Reply-To: <51E1B5DB.9080904@kdbg.org> (Johannes Sixt's message of "Sat, 13
	Jul 2013 22:17:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1202725C-ECBA-11E2-A763-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230384>

Johannes Sixt <j6t@kdbg.org> writes:

> All you have been saying is that you find your
>
>    git push --lockref there topic
>
> is more useful than my
>
>    git push --lockref there +topic
>
> You are trading crystal clear semantics to save users ONE character to
> type. IMO, it's a bad deal.

Think how you would explain the option in a tutorial for those who
use the push.default=simple semantics.

"""
	You usually do

		$ git pull [--rebase]

	to integrate with the shared branch and push it back with

		$ git push

	Sometimes the project wants to rewind the tip of such a
	shared branch (perhaps a bad commit included inappropriate
	material that should not be in the history).  You cordinate
	the decision to do such a rewinding with others in the
	project, you "git rebase [-i]" to prepare a replacement
	history, and then try to push tthe result out.  However

		$ git push

	will fail, because this does not fast-forward.  But you and
	your colleagues agreed that the project wants this new
	history!

        With older Git, the only way to make this push go through
        was to "--force" it.  That will risk losing work of other
        people who were not aware of the collective decision to
        rewind this shared branch [discussion of lockref safety
        comes here].  Instead you can use

		$ git push --lockref

"""

How does the last line look with your "--lockref does not override
must-fast-forward" proposal?

"""

	If your current branch is configured to push to update the
	branch 'frotz' of the remote 'origin' (replace these two
	appropriately for your situation), you would say:

		$ git push --lockref origin +HEAD:frotz

"""

How is that crystal clear?  You are just making things more complex
and harder to learn (I was tempted to add "for no good reason" here,
but I'd assume that probably you haven't explained your reasons well
enough to be heard).

> The crystal clear semantics would be:
>
>  - to override no-ff safety, use +refspec;
>
>  - to override "mismatch" safety, do not use --lockref/use --no-lockref;
>
>  - do not use --force unless you know the consequences.

Alternatively, this is also crystal clear

 - to use the full safety, do not use anything funky

 - to push a history that does not fast-forward safely, use
   --lockref

 - do not use --force unless you know the consequences.

and that is what the patch does.

> I actually think that by implying allow-no-ff in --lockref, you are
> hurting users who have configured a push refspec without a + prefix:
> They suddenly do not get the push denied when it is not a fast-forward
> anymore.

Of course, that is why you should not use --lockref when you do not
have to.  It is a tool to loosen "must fast-forward" in a more
controlled way than the traditional "--force".

 For example, when you have
>
>     [remote "ko"]
>         push = master
>         push = +pu
>
> and you accidentally rewound master before the point that is already
> published, then
>
>    git push --lockref ko
>
> will happily push the rewound master.

Yes, and I am not (and I do expect nobody is) stupid to use --lockref
in such a situation where there is no need to do so.

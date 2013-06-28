From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 28 Jun 2013 13:52:38 +0200
Message-ID: <vpqmwqa8nax.fsf@anie.imag.fr>
References: <20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130627201032.GF9999@odin.tremily.us> <vpq1u7magky.fsf@anie.imag.fr>
	<20130628090917.GG11985@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Jun 28 13:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsXEv-0004t0-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 13:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab3F1LxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 07:53:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58751 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab3F1LxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 07:53:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5SBqb3I006432
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Jun 2013 13:52:37 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UsXEF-0005BY-4I; Fri, 28 Jun 2013 13:52:39 +0200
In-Reply-To: <20130628090917.GG11985@odin.tremily.us> (W. Trevor King's
	message of "Fri, 28 Jun 2013 05:09:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 28 Jun 2013 13:52:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229189>

"W. Trevor King" <wking@tremily.us> writes:

> On Fri, Jun 28, 2013 at 08:34:53AM +0200, Matthieu Moy wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>>
>> > Or they may not even realize that they've just merged an unrelated
>> > branch at all, dragging in a thousand unrelated commits which they
>> > accidentally push to a central repository without looking,
>> > contaminating future branches based on the central repostitory without
>> > drastic rebase surgery ;).  I just saw one of these earlier this week.
>> 
>> I don't understand how the change would solve this. If "pull" would drag
>> a lot of commits in the current branch, the "rebase" will rebase the
>> current branch on a totally different history, and pushing the result
>> would be equally bad.
>
> I want the warning that they had not made the required config choice
> between rebase/merge needed to handle a non-ff case, not the default
> merge (or rebase) behavior.  The warning gives them a chance to
> realize that this was not an appropriate time for a `svn update`
> analog, and that the project may not to want to have the branches
> joined at all ;).

You're assuming that the config is not made, but this is supposed to
happen once initially. Then, the user will chose either merge or rebase,
and whatever is chosen, the result will be bad.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

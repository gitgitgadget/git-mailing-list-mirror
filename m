From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Wed, 13 Aug 2014 12:56:48 +0400
Message-ID: <87mwb8ahtb.fsf@osv.gnss.ru>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 10:56:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHUMb-0001lZ-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 10:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbaHMI4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 04:56:53 -0400
Received: from mail.javad.com ([54.86.164.124]:43289 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbaHMI4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 04:56:52 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 9695460C01;
	Wed, 13 Aug 2014 08:56:50 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XHUMS-0002xt-UN; Wed, 13 Aug 2014 12:56:49 +0400
In-Reply-To: <xmqqzjf94f5n.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Aug 2014 13:38:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255191>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So I think the reasoning (i.e. "is a descendant" is not quite right)
>> is correct, but the updated text is not quite right.  Changing it
>> further to "only the committer timestamps and identities would
>> change" is probably not an improvement, either.  "Force the rebase
>> that would otherwise be a no-op" may be a better phrasing that does
>> not risk going stale even if we update what are preserved and what
>> are modified in the future.
>>
>> Also I notice the sentence "Normally non-interactive...in such a
>> situation" is not helping the reader in this description very much.
>> I wonder if we should keep it if we are rewriting this paragraph.
>
> How about doing it this way, perhaps?

[...]

>  -f::
>  --force-rebase::
> -	Force the rebase even if the current branch is a descendant
> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
> -	exit with the message "Current branch is up to date" in such a
> -	situation.
> -	Incompatible with the --interactive option.
> +	Force a rebase even if the current branch is up-to-date and
> +	the command without `--force` would return without doing anything.
>  +
>  You may find this (or --no-ff with an interactive rebase) helpful after
>  reverting a topic branch merge, as this option recreates the topic branch with

It's OK with me, as in fact I think that there is no good explanation
for current git behavior, and thus it's git behavior that should have
been changed, not the documentation. I.e., git must not rebase anything
when "Current branch is a descendant of the commit you are rebasing
onto", unless -f is given. Simple, reasonable, straightforward.

The version you propose at least does not lie, so it's definiteley an
improvement. However,

"Force the rebase when the command exits with "Current branch is up to
date" message."

reads even more simple and clear for me.

-- 
Sergey.

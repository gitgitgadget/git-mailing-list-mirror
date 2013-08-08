From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 08 Aug 2013 12:27:17 -0700
Message-ID: <7v1u649e5m.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
	<vpqk3jwcb1q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Damien Robert <damien.olivier.robert+gmane@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 21:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Vru-00052s-6W
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 21:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966236Ab3HHT10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 15:27:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966205Ab3HHT1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 15:27:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6437A3794D;
	Thu,  8 Aug 2013 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mh0ymr5VfHDt7i9rrh9anC3Twcs=; b=KCrW4J
	MtEdYm/oiYkuFT/Wj1tmPI+ktk4yRf+cID5SKEz5u+xQ6lD8duH3JCPeoU2pS+br
	C22nMbJwcwvw7sHnSCr/vgG+FeiDrathr6XgzCYoo4RiDhIFw2MoNaX/xT9jcggr
	Jx/lKEmwEqVcLrTZbh/7XUnI3Xkc48gzC3A9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NTHZgrL/g5uPV5AypZ8C2WQ88Y8cUz9j
	3O7SKBEb5rr2pSUhGAlAgt4Hc808sGz4+h66Wv7OMVTxB9hPq8DgMUgl2nlY9++G
	4HwtEWqxvTWPMJFswegFgI6ySQt6rr/tAzRY2x7iJ3vONTYSrgZipfWCxVNE5648
	zZ5JQYEXSZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3F43794B;
	Thu,  8 Aug 2013 19:27:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CB273793B;
	Thu,  8 Aug 2013 19:27:20 +0000 (UTC)
In-Reply-To: <vpqk3jwcb1q.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	08 Aug 2013 20:06:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BC92270-0060-11E3-BA1A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231925>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Damien Robert <damien.olivier.robert+gmane@gmail.com> writes:
>
>> Matthieu Moy  wrote in message <vpqfvukdy39.fsf@anie.imag.fr>:
>>>> that confuses users.
>>> 
>>> ... but I do agree that the doc is really confusing. It would be much
>>> better if the doc could be reduced to:
>>> 
>>> "This is a synonym for linkgit:git-log[1] --raw --some --other ---options.
>>> Please refer to the documentation of that command."
>>
>> If I may chime in as a user: what really confused me about git whatchanged
>> is this part of man gitcore-tutorial:
>
> Indeed.
>
> How about applying this, to reduce the number of references to
> whatchanged in the docs?

I fully agree with the change to git.txt

I am slightly negative about the rest.

gitcore-tutorial is about teaching people who want to script around
plumbing to do their own Porcelain.  It is *not* about teaching them
"if you want to see the history, use 'git log'".

It is meant to teach them "if you want to do your own 'git log', you
can do so with 'rev-list' piped to 'diff-tree --stdin'".  Changing
'whatchanged' to 'log' in the latter statement is an improvement,
but dropping 'can be done by combining rev-list and diff-tree' goes
against the objective of the whole document.

If we were to be spending more braincycles to update the latter, I
think we should enrich it by finding ways to resurrect good examples
that were lost over time due to "rewrite in C and make them builtin"
process.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 3bdd56e..486a58b 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -818,7 +818,7 @@ for further details.
>  'GIT_FLUSH'::
>         If this environment variable is set to "1", then commands such
>         as 'git blame' (in incremental mode), 'git rev-list', 'git log',
> -       'git check-attr', 'git check-ignore', and 'git whatchanged' will
> +       'git check-attr', and 'git check-ignore' will
>         force a flush of the output stream after each record have been
>         flushed. If this
>         variable is set to "0", the output of these commands will be done
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> index f538a87..c6a1677 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -532,12 +532,7 @@ commit, and you can tell it to show a whole series of diffs.
>  Alternatively, you can tell it to be "silent", and not show the diffs at
>  all, but just show the actual commit message.
>  
> -In fact, together with the 'git rev-list' program (which generates a
> -list of revisions), 'git diff-tree' ends up being a veritable fount of
> -changes. A trivial (but very useful) script called 'git whatchanged' is
> -included with Git which does exactly this, and shows a log of recent
> -activities.
> -
> +'git log' can also be used to display changes introduced by some commits.
>  To see the whole history of our pitiful little git-tutorial project, you
>  can do
>  
> @@ -550,7 +545,7 @@ with the associated patches use the more complex (and much more
>  powerful)
>  
>  ----------------
> -$ git whatchanged -p
> +$ git log --raw -p
>  ----------------
>  
>  and you will see exactly what has changed in the repository over its

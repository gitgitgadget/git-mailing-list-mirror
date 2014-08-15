From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Fri, 15 Aug 2014 10:51:45 -0700
Message-ID: <xmqq38cx1w0e.fsf@gitster.dls.corp.google.com>
References: <87bnrq22uf.fsf@osv.gnss.ru>
	<xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
	<xmqqzjf94f5n.fsf@gitster.dls.corp.google.com>
	<87d2c22cnx.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:52:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XILfc-0005ES-H5
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 19:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbaHORv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 13:51:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64138 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbaHORv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 13:51:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A090D30846;
	Fri, 15 Aug 2014 13:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n7E650j25lEDtjyS9Pg7qDoqZtk=; b=MEnFen
	rhTmPzxivrlOp/k7UK8ivoHry+s9VN9sLP/zRh9ZZ1LmlRVaqth4OCHPtIgvsGCQ
	ROdyiK9EamI/ABB3GTOvisGiktl0+WiV5Z2kcwLftj+oBw7tDMUMDP3Cvc2XAwWl
	4BuCtsU9sutGQXLXzJjKkT4nIc+Ffay4RMrZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=moJoEJB0wfgN8lrnhDIIs11qemvukgwG
	4KCRHotCaQHRP7+nssKgddhBd+4Q/G3YLiWzrVBSWhBjvc1YF8ktXWySlWc+HcQk
	6PNYScc0Ug4NYabHLvveVX3EsLW8O25LTvLKX8SivqLZ164mOOCtyO158lDhqvSc
	UxKz51WAOwA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9676F30845;
	Fri, 15 Aug 2014 13:51:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1829630829;
	Fri, 15 Aug 2014 13:51:47 -0400 (EDT)
In-Reply-To: <87d2c22cnx.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
	15 Aug 2014 15:52:02 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D397243A-24A4-11E4-8FA9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255297>

Sergey Organov <sorganov@gmail.com> writes:

>> ...
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 2a93c64..f14100a 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -316,11 +316,8 @@ which makes little sense.
>>  
>>  -f::
>>  --force-rebase::
>> -	Force the rebase even if the current branch is a descendant
>> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
>> -	exit with the message "Current branch is up to date" in such a
>> -	situation.
>> -	Incompatible with the --interactive option.
>> +	Force a rebase even if the current branch is up-to-date and
>> +	the command without `--force` would return without doing anything.
>>  +
>>  You may find this (or --no-ff with an interactive rebase) helpful after
>>  reverting a topic branch merge, as this option recreates the topic branch with
>
> I dig more into it, and that's what I came up with, using some of your
> suggestions as well.
>
> Please notice new text on essential interaction with --preserve-merges.
>
> I also thought about "Force the rebase that would otherwise be a no-op",
> and while it is future-changes-agnostic indeed, it doesn't actually
> explain anything, so I put some explanation back.

A sentence "--force has no effect under --preserve-merges mode" does
not tell the readers very much, either and leaves them wondering if
it means "--preserve-merges mode always rebases every time it is
asked, never noticing 'ah, the history is already in a good shape
and there is no need to do anything further'" or "--preserve-merges
mode ignores --force and refuses to recreate the history if the
history is in the shape the mode deems is already desirable."

I think the root cause of the issue we share in this thread, when
trying to come up with an improvement of this part, is that we are
trying to put more explanation to the description of --force, but if
we step back a bit, it may be that the explanation does not belong
there.  As far as the readers are concerned, --force is about
forcing a rebase that would not otherwise be a no-op, but the real
issue is that the condition under which a requested rebase becomes a
no-op, iow, "the history is already in the desired shape, nothing to
do", is different from mode to mode, because "the desired shape" is
what distinguishes the modes.  Preserve-merge rebase may think that
a history that is descendant of the "onto" commit is already in the
desired shape while plain-vanilla rebase does not if it has a merge
in between, for example.

The sentence that follows "Otherwise" in this version encourages the
readers to be in a wrong mind-set that rebase is only about "making
the branch a descendant of the 'onto' commit", which isn't the case.

The desired outcome depends on the mode (and that is why there are
modes), and not saying that explicitly will only help spread the
confusion, I am afraid.  Isn't it a better solution to explain what
that no-op condition is for the mode at the place in the document
where we describe each mode?

E.g. under "--preserve-merges" heading, we may say "make sure the
history is a descendant of the 'onto' commit; if it already is,
nothing is done because there is no need to do anything" or
something along that line.  The description for the plain-vanilla
rebase may say "flatten the history on top of the 'onto' commit by
replaying the changes in each non-merge commit; if the history is
already a descendant of the 'onto' commit without any merge in
between, nothing is done because there is no need to".

That would make description of the modes more understandable, too.
The users can read what kind of resulting history they can get out
of by using each mode in one place.

Hmm?

> -- >8 --
>
> From: Sergey Organov <sorganov@gmail.com>
> Date: Tue, 12 Aug 2014 00:10:19 +0400
> Subject: [PATCH] Documentation/git-rebase.txt: fix -f description to match
>
> "Current branch is a descendant of the commit you are rebasing onto"
> does not necessarily mean "rebase" requires "--force". Presence of
> merge commit(s) makes "rebase" perform its default flattening actions
> anyway.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-rebase.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 2a93c64..9153369 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -316,11 +316,10 @@ which makes little sense.
>  
>  -f::
>  --force-rebase::
> -	Force the rebase even if the current branch is a descendant
> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
> -	exit with the message "Current branch is up to date" in such a
> -	situation.
> -	Incompatible with the --interactive option.
> +	If --preserve-merges is given, has no effect. Otherwise forces
> +	rebase even if the current branch is a descendant of the commit
> +	you are rebasing onto and there are no merge commits among
> +	those to be rebased.
>  +
>  You may find this (or --no-ff with an interactive rebase) helpful after
>  reverting a topic branch merge, as this option recreates the topic branch with

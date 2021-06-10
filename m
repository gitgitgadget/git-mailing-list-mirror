Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA1C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DFA613CF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 23:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhFKABP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:01:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54347 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFKABO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 20:01:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0CB7CA065;
        Thu, 10 Jun 2021 19:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eEOguqrxcu2zab4aKoMNsRZF8BQbck5261cCkI
        MikBg=; b=q3U51amkp5L9xIO5SVFs97pPl+T1jD7yPFEpKhfEKz7EZGBde/6fBR
        fX2Sl99A63Y2T4aV6Rog68Fm9AubFiFJ7pdBoBQgMAQh5r/E5jDqMEE6+EyTeOjr
        2OEGkHT2Uk5NDKFRWRnyOiGhsDqc0Uk+O/JRjOgYG/eaXDP3yVQrs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A81BFCA063;
        Thu, 10 Jun 2021 19:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3198ECA062;
        Thu, 10 Jun 2021 19:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] *: fix typos which duplicate a word
References: <20210609102641.3531183-1-rybak.a.v@gmail.com>
        <20210610072406.10203-1-rybak.a.v@gmail.com>
Date:   Fri, 11 Jun 2021 08:59:16 +0900
In-Reply-To: <20210610072406.10203-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Thu, 10 Jun 2021 09:24:06 +0200")
Message-ID: <xmqq1r99e0ff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD79EFFA-CA47-11EB-8732-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Subject: Re: [PATCH v2] *: fix typos which duplicate a word

I think Derrick started this use of "*:" prefix to mean "not limited
to any particular area, but applies to everything" and it makes
sense.

> Fix typos in documentation and code comments which repeat various words.

Thanks.

> These typos were found by searching using scripts like this:
>
> 	for w in $(grep '^....$' /usr/share/dict/words)
> 	do
> 		git grep -P "\b$w $w\b"
> 	done

This is clarifying and somewhat puzzling at the same time.

It says that doubled words that span across line folding, and
doubled words that do not have exactly a single space in between,
have gone undetected (which is fine and may be useful information)
by showing that it grepped for lines that has doubled words.  But it
also says that you only looked for four-letter words, which I do not
believe is the case (you fixed "the the", for example), which is
misleading.  The "like this" part can be an excuse for that
inaccuracy, but then the whole thing pretty much has already been
summarized nicely with your first line already, i.e. "which repeate
various words".  If you update it the end part of the sentence to
"which repeat various words on the same line", then the entire
paragaph can go without losing clarity.

Not a huge deal, though.

The changes themselves all look good to me.  Thanks.  Will apply.

> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>
> Thanks to Felipe Contreras for review.
>
> Changes from v1:
>
>   - added "*: " as area prefix to follow example of Derrick Stolee
>     https://lore.kernel.org/git/c40ad4a058a75d57adc97b8252ad0f57600b8d86.1623085069.git.gitgitgadget@gmail.com/
>   - Dropped change in t/t6416-recursive-corner-cases.sh where I misread a
>     sentence and the duplicated word "that" is used correctly. Quote for
>     reference:
>
>       ... so we use one path whose name is arbitrary in the virtual merge base X
>       between D and E" and then further let the rename detection to notice that
>       that arbitrary path gets renamed ...
>
>     where first "that" is a conjunction between clauses "we let" and "path gets
>     renamed" and second "that" is a determiner to qualify "arbitrary path" to
>     refer to "one path" mentioned in the first clause
>
>  Documentation/technical/protocol-v2.txt | 2 +-
>  attr.c                                  | 2 +-
>  builtin/log.c                           | 3 +--
>  git-compat-util.h                       | 2 +-
>  git-cvsserver.perl                      | 2 +-
>  remote.c                                | 2 +-
>  t/t5505-remote.sh                       | 2 +-
>  t/t9100-git-svn-basic.sh                | 2 +-
>  8 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index a1e31367f4..1040d85319 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -540,7 +540,7 @@ An `object-info` request takes the following arguments:
>  	Indicates to the server an object which the client wants to obtain
>  	information for.
>  
> -The response of `object-info` is a list of the the requested object ids
> +The response of `object-info` is a list of the requested object ids
>  and associated requested information, each separated by a single space.
>  
>  	output = info flush-pkt
> diff --git a/attr.c b/attr.c
> index 9e897e43f5..d029e681f2 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -685,7 +685,7 @@ static struct attr_stack *read_attr_from_array(const char **list)
>   * Callers into the attribute system assume there is a single, system-wide
>   * global state where attributes are read from and when the state is flipped by
>   * calling git_attr_set_direction(), the stack frames that have been
> - * constructed need to be discarded so so that subsequent calls into the
> + * constructed need to be discarded so that subsequent calls into the
>   * attribute system will lazily read from the right place.  Since changing
>   * direction causes a global paradigm shift, it should not ever be called while
>   * another thread could potentially be calling into the attribute system.
> diff --git a/builtin/log.c b/builtin/log.c
> index 6102893fcc..516a1142dd 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1968,8 +1968,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	} else if (rev.diffopt.close_file) {
>  		/*
>  		 * The diff code parsed --output; it has already opened the
> -		 * file, but but we must instruct it not to close after each
> -		 * diff.
> +		 * file, but we must instruct it not to close after each diff.
>  		 */
>  		rev.diffopt.no_free = 1;
>  	} else {
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a508dbe5a3..df7dae9be1 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1368,7 +1368,7 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
>  	(type *)container_of_or_null_offset(ptr, offsetof(type, member))
>  
>  /*
> - * like offsetof(), but takes a pointer to a a variable of type which
> + * like offsetof(), but takes a pointer to a variable of type which
>   * contains @member, instead of a specified type.
>   * @ptr is subject to multiple evaluation since we can't rely on __typeof__
>   * everywhere.
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index f6f3fc192c..ed035f32c2 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -2149,7 +2149,7 @@ sub req_diff
>                     ( $meta2->{revision} or "workingcopy" ));
>  
>          # TODO: Use --label instead of -L because -L is no longer
> -        #  documented and may go away someday.  Not sure if there there are
> +        #  documented and may go away someday.  Not sure if there are
>          #  versions that only support -L, which would make this change risky?
>          #  http://osdir.com/ml/bug-gnu-utils-gnu/2010-12/msg00060.html
>          #    ("man diff" should actually document the best migration strategy,
> diff --git a/remote.c b/remote.c
> index 6d1e8d02df..dfb863d808 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1592,7 +1592,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  			else
>  				/*
>  				 * If the ref isn't stale, and is reachable
> -				 * from from one of the reflog entries of
> +				 * from one of the reflog entries of
>  				 * the local branch, force the update.
>  				 */
>  				force_ref_update = 1;
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index c7b392794b..e6e3c8f552 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -182,7 +182,7 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
>  	)
>  '
>  
> -test_expect_success 'rename errors out early when when new name is invalid' '
> +test_expect_success 'rename errors out early when new name is invalid' '
>  	test_config remote.foo.vcs bar &&
>  	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
>  	test_must_fail git remote rename foo invalid...name 2>actual &&
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 1d3fdcc997..ef35a54885 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -330,7 +330,7 @@ test_expect_success 'git-svn works in a bare repository' '
>  	git svn fetch ) &&
>  	rm -rf bare-repo
>  	'
> -test_expect_success 'git-svn works in in a repository with a gitdir: link' '
> +test_expect_success 'git-svn works in a repository with a gitdir: link' '
>  	mkdir worktree gitdir &&
>  	( cd worktree &&
>  	git svn init "$svnrepo" &&

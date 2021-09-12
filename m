Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF1EC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C60061027
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhILWX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:23:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54628 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:23:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4D16F5AF4;
        Sun, 12 Sep 2021 18:22:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mwZw5nDUB4sy
        aVL+5dvtmqkQZf1XoNHLlvWAIj7woz0=; b=os1yE4UK6TDNbOOx6xDigQa8wspc
        mvDd3URFUzSDdOBTwmBNvoxBNx5oBHOjrCv4ZfX4Zu/s0FxWhSAtLFWaKi/Zxmto
        ByQH7iE6fz1nrWIHnlY3tgkdVf+wOHKCZBk8FQ3dNyF2YV1UCPxO17ZBcqSbziJD
        3nfpPiMSxf0IaNc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99C25F5AF2;
        Sun, 12 Sep 2021 18:22:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 049DFF5AF0;
        Sun, 12 Sep 2021 18:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/6] blame: replace usage end blurb with better
 option spec
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
        <patch-v3-2.6-036eb0efb5b-20210911T190239Z-avarab@gmail.com>
Date:   Sun, 12 Sep 2021 15:22:39 -0700
In-Reply-To: <patch-v3-2.6-036eb0efb5b-20210911T190239Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 11 Sep
 2021 21:09:01
        +0200")
Message-ID: <xmqqtuipjuxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1837D26-1417-11EC-8170-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "git blame -h" output to be consistent with "git bundle
> -h"'s, i.e. before this we'd emit:
>
>     $ git blame -h
>     usage: git blame [<options>] [<rev-opts>] [<rev>] [--] <file>
>
>         <rev-opts> are documented in git-rev-list(1)
>     [...]
>
> Now instead of that we'll emit:
>
>     $ git blame -h
>     usage: git blame [<options>] [<git rev-list args>] [<rev>] [--] <fi=
le>
>     [...]

What we take are options that rev-list takes, not arguments like A..B,
so the updated text seems to be more wrong.

It does not even make much sense as a goal to make "blame" and
"bundle" similar to begin with, does it?  It may make sense for
"bundle" to be more similar to "pack-objects", in that the
information the command needs ultimately is about what is needed by
"rev-list --objects" (i.e. object enumeration), while "blame" is
more similar to "log", in that it is interested in walking commit
DAG but not about the trees and blobs connected to the commits in
the DAG.  From the end-users' point of view, they do not care if
"bundle" and "blame" are explained using similar terms.

Also, not all <rev-opts> you can see from "git rev-list -h" would
make sense in the context of "git blame".  "--no-merges" and any
options that are related to the number of parents make no sense,
--all, --branches and the friends, when used to give multiple
positive ends (i.e. starting points) of traversal, would not make
sense at all, options about ordering and formatting output of
rev-list of course would not make any difference.

At the very least, we should say <rev-list-options> there, or we
should just drop the mention of "we also take some options meant for
rev-list" from here, leaving:

	usage: git blame [<options>] [<rev>] [--] <file>

and nothing else?

I am sympathetic to the original reasoning why we wanted to add a
parenthetical "by the way, we also take (some) options rev-list
takes" here.  This is because not all relevant options are described
in the options[] array we have there (we delegate what we do not
know to parse_revisions_opt()), and it is sort of understandable
that they wanted to leave a hint that the list of options given here
is not exhaustive.

But in the longer run, if we really wanted to make the -h output
useful to end users, what we should aim for is not to make it
similar to "git bundle", but to ensure that the option summary
includes the relevant options shared with rev-list (in other words,
make the list of options cover all the options the command takes,
not just the ones in today's options[] array).

When that happens, users do not have to care which ones happen to be
parsed by us via our call to parse_options_step(), and which other
ones are given to parse_revision_opt().  There won't be any need to
say "we also take some options..." with <rev-opts> in the original.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 641523ff9af..e469829bc76 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -29,12 +29,8 @@
>  #include "refs.h"
>  #include "tag.h"
> =20
> -static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] [=
<rev>] [--] <file>");
> -
>  static const char *blame_opt_usage[] =3D {
> -	blame_usage,
> -	"",
> -	N_("<rev-opts> are documented in git-rev-list(1)"),
> +	N_("git blame [<options>] [<git rev-list args>] [<rev>] [--] <file>")=
,
>  	NULL
>  };
> =20
> @@ -1107,7 +1103,8 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
>  				    nth_line_cb, &sb, lno, anchor,
>  				    &bottom, &top, sb.path,
>  				    the_repository->index))
> -			usage(blame_usage);
> +			usage_msg_opt(_("Invalid -L <range> parameter"),
> +				      blame_opt_usage, options);

"invalid -L <range>" is fine, but can't we parrot what the user gave
us here?  You can give more than one -L to specify two ranges in the
same file that are not contiguous:

	git blame -L1,10 -L100.112 master..seen -- foo.c

and it would be helpful to tell which one is broken.

>  		if ((!lno && (top || bottom)) || lno < bottom)
>  			die(Q_("file %s has only %lu line",
>  			       "file %s has only %lu lines",

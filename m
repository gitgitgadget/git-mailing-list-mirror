Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E29520188
	for <e@80x24.org>; Thu, 11 May 2017 03:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbdEKDQZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 23:16:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36859 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKDQY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 23:16:24 -0400
Received: by mail-pg0-f67.google.com with SMTP id 64so1784426pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 20:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AdHOzHTEBsB+Wi8I/TPC6WLVxI+5aMdYJlDpY3H91qQ=;
        b=RsN+wZ8eqSXVSjGQsRuMQ2QtC/5W2tlUJ3ZGciER4NAGlPikZ8O4hun6Mo6oRDPcI/
         4dI4e8R217CMPcAmgc/CyRVaOsCHEaYx1Oa3jK0KMNvralP0Pzo+kwFMpTJ8AGCAWX7b
         updXUhCglh5955z+5gpyyiHJwUFlj1SL7oy8y8u63ZZgkIQkj/pqzgCZVIORcxX8iOhi
         dRU/FolJ/MqtC/yRW6vnt5F3v8km4HO1iMMez1EcJBODxoBH19l5R+6dnXPOPim6U6rx
         HUzbXDMWmFkvZr/3VAHlp8PFEe48DTAJWxSxvGqM9W0FrJmE9wEdZtlb2L+0NRw9IwY3
         j6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AdHOzHTEBsB+Wi8I/TPC6WLVxI+5aMdYJlDpY3H91qQ=;
        b=Wt3ewjp3PvjyYuSc5uro0VDa0hmdY2BMbuMxZspkVoOD8sWuL4l65CYc1ekwh/DX2o
         EiRmzshhX2EXSWGADAfgVcrsWlDXu4s8ncKm0C10oc7kiUu99GJSKroxuqXZZl83bZ9F
         VH3gKttehzuCic7NJ2OqkL913TL7ihT8ozYO13KUm29I2QmZZ8FtfnBJIlSJyhVT950x
         iOcTFsK9oCwCpzsFuiRDAm17KNe/Fv5UJMCajYmMzenmzT0ogQFghs52G+GPphJh+t/V
         1nE4oUwVlOIW4RkTzJ5tq1okzswoTqsevzfR/VbalxEuIcpWGkpTWdMNYhqA59V4wIAF
         BxmQ==
X-Gm-Message-State: AODbwcBxGm9oMr/eY89Zjp+doMr52eWqAe6TEFNnfi/3FYJ0EtVRrRS8
        TwhRmUB0r2MOeqet49g=
X-Received: by 10.84.142.101 with SMTP id 92mr12975746plw.112.1494472583789;
        Wed, 10 May 2017 20:16:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id b68sm474095pfa.127.2017.05.10.20.16.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 20:16:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, rashmipai36@gmail.com
Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply is required
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170503210726.24121-1-jn.avila@free.fr>
Date:   Wed, 10 May 2017 20:16:21 -0700
In-Reply-To: <20170503210726.24121-1-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Wed, 3 May 2017 23:07:24 +0200")
Message-ID: <xmqqa86kccca.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noel Avila <jn.avila@free.fr> writes:

> diff --git a/builtin/am.c b/builtin/am.c
> index a95dd8b4e..f5afa438d 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1312,7 +1312,7 @@ static int parse_mail(struct am_state *state, const char *mail)
>  	}
>  
>  	if (is_empty_file(am_path(state, "patch"))) {
> -		printf_ln(_("Patch is empty. Was it split wrong?"));
> +		printf_ln(_("Patch is empty. It may have been split wrong."));
>  		die_user_resolve(state);
>  	}

While I do not belong to "we should feel free to ask rhetorical
questions" camp, I do not mind this particular rewrite.  An obvious
alternative is just to stop the sentence with "Patch is empty."

At this point in the code, we do not even know why we are seeing an
empty patch, and "perhaps it was incorrectly split" is not a
particularly useful idle speculation that would help the user who
sees it.

> @@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
>  
>  	if (unmerged_cache()) {
>  		printf_ln(_("You still have unmerged paths in your index.\n"
> -			"Did you forget to use 'git add'?"));
> +			"You might want to use 'git add' on them."));

This case is *not* an "rhetorical question is the most succinct way
to convey the information" situation; I think this rewrite is a
definite improvement.  "You might want to 'git add' them" may be
more succinct, though.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bfa5419f3..05037b9b6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1287,7 +1287,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  		 */
>  		if (opts.new_branch && argc == 1)
>  			die(_("Cannot update paths and switch to branch '%s' at the same time.\n"
> -			      "Did you intend to checkout '%s' which can not be resolved as commit?"),
> +			      "'%s' can not be resolved as commit, but it should."),

I am not sure a firm statement "but it should" is an improvement.
This message is given when the user says:

    $ git checkout -b newone naster

And "but it should" is appropriate when it is a mistyped "I want to
create and checkout 'newone' branch at the same commit as 'master'
branch", i.e.

    $ git checkout -b newone master

The reason why the message begins with "Cannot update paths and ..."
is because it could be a mistyped "I want to grab the file 'naster'
out of 'newone' branch", i.e. the user meant to say this:

    $ git checkout newone naster

IOW, the current error message is hedging its bets, because it does
not want to exclude the possibility that "-b" is there by mistake
(as opposed to 'naster' is the typo).

If we ignore that possibility and assume that 'naster' is the typo
(iow, the user did mean "-b"), then your updated message makes
sense.  But if we commit to "the user meant -b", we could make the
message even more helpful by being more direct, e.g.

	die("'%s' is not a commit and a branch '%s' cannot be created from it",
	    argv[0], opts.new_branch);

> diff --git a/help.c b/help.c
> index bc6cd19cf..4658a55c6 100644
> --- a/help.c
> +++ b/help.c
> @@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	if (SIMILAR_ENOUGH(best_similarity)) {
>  		fprintf_ln(stderr,
> -			   Q_("\nDid you mean this?",
> -			      "\nDid you mean one of these?",
> +			   Q_("\nThe most approaching command is",
> +			      "\nThe most approaching commands are",
>  			   n));

With "closest" or "most similar", as others pointed out, I think
this may be an improvement.

Thanks.

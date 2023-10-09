Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFFBCD6125
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378172AbjJIStW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378115AbjJIStU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:49:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24599D
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:49:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 016351A0817;
        Mon,  9 Oct 2023 14:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=HGSSttD2rpTrBYnBdfqcy3xTgWmMyyXN0uWLhg
        l1aNo=; b=TbBgp9LuuoF5oUI3QumRSZrPCPQqMYqrRioua5fiDcsXCCvJa0Biqi
        CVbG3RdlF0WqJ5+jrGM8y6UiLgzrGuxgthKTvKiMjRJWrmoa597tQcvETHelBI+a
        FYPOzDHrJr8wvrRl1EHf99x4zZag3Elrfc9jxh/laWBjrZxdqTXZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E985F1A0816;
        Mon,  9 Oct 2023 14:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FDCF1A0814;
        Mon,  9 Oct 2023 14:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to
 guidelines when using die() listed in issue #635
In-Reply-To: <20231009011546.509-1-naomi.ibeh69@gmail.com> (Naomi Ibe's
        message of "Mon, 9 Oct 2023 02:15:45 +0100")
References: <20231009011546.509-1-naomi.ibeh69@gmail.com>
Date:   Mon, 09 Oct 2023 11:49:17 -0700
Message-ID: <xmqqlecbzl5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D2E8246-66D4-11EE-9DC3-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Naomi Ibe <naomi.ibeh69@gmail.com> writes:

> Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines when using d

Subject: [OUTREACHY][PATCH 1/1] builtin/add.c: clean up die() messages

> From: Naomi <naomi.ibeh69@gmail.com>

The name and address on this line come from your commit object,
which in turn would have came from your configuration.  You have

    [user]
	name = Naomi
	email = naomi.ibeh69@gmail.com

somewhere in your configuration file, perhaps in $HOME/.gitconfig or
somewhere.  When contributiong to this project, you want that "name"
line to also include your family name, as it should match what you
write on your Signed-off-by: line.  A focused way to do so without
affecting your author identity for other projects is to add

    [user]
	name = Naomi Ibe

in .git/config of the repository that you use to contribute to this
project, e.g.,

    $ cd ... to the working tree of your clone of git you work in ...
    $ git config user.name "Naomi Ibe"

The space above your Sign off is to fill the details you omitted on
the title of the message (which would say something about "conform
to guidelines" or "clean up" without mentioning what rule the
original violates), making the whole thing something like:

    builtin/add.c: clean up die() messages

    As described in the CodingGuidelines document, a single line
    message given to die() and its friends should not capitalize its
    first word, and should not add full-stop at the end.

    Signed-off-by: ...

> Signed-off-by: Naomi Ibe <naomi.ibeh69@gmail.com>
> ---
>  builtin/add.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks.  Otherwise the patch looks good.

>
> diff --git a/builtin/add.c b/builtin/add.c
> index c27254a5cd..5126d2ede3 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -182,7 +182,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>  
>  	if (repo_read_index(the_repository) < 0)
> -		die(_("Could not read the index"));
> +		die(_("could not read the index"));
>  
>  	repo_init_revisions(the_repository, &rev, prefix);
>  	rev.diffopt.context = 7;
> @@ -200,15 +200,15 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>  		die(_("editing patch failed"));
>  
>  	if (stat(file, &st))
> -		die_errno(_("Could not stat '%s'"), file);
> +		die_errno(_("could not stat '%s'"), file);
>  	if (!st.st_size)
> -		die(_("Empty patch. Aborted."));
> +		die(_("empty patch. aborted"));
>  
>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
>  		     NULL);
>  	if (run_command(&child))
> -		die(_("Could not apply '%s'"), file);
> +		die(_("could not apply '%s'"), file);
>  
>  	unlink(file);
>  	free(file);
> @@ -568,7 +568,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  finish:
>  	if (write_locked_index(&the_index, &lock_file,
>  			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
> -		die(_("Unable to write new index file"));
> +		die(_("unable to write new index file"));
>  
>  	dir_clear(&dir);
>  	clear_pathspec(&pathspec);

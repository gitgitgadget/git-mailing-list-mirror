Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3764C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619A32067C
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 15:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wcSO1gNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgJLP5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 11:57:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61775 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgJLP5e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 11:57:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E584F00C4;
        Mon, 12 Oct 2020 11:57:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WZaI+FJDbaYtekJVdWq2LpmgQjQ=; b=wcSO1g
        NBZ0/4aMcRVbRp9Uakf2c5AYKsI/TFz2O+sDeAPa5g9IiM622cuZczKx216JTaLX
        sTu4SQB2l0VHcYIJXo2JvpUN9MnNFbeCdXoRUK3GN3zCN1YPes+45jFRVz2mtjeC
        04RYgQVpHlJil+jygS0189Eb81Cq0Qij5QV3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CMejL4SY+JoO71TqoAW3J3qbxQavyGWB
        Y9kiGFlDIwBmR4GhVmbKJeoK/zhOM/v8KqojCN/F9C0QxPE4+CACqc2QPr93MxIs
        IZ9WC++6HYkRb52TOSNhQG+cI7o2Ok1XkjppA3KSxW8ATQWa8ORb3byIHbSNgI8+
        gwGA9ow7+h8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FF8BF00C1;
        Mon, 12 Oct 2020 11:57:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 684DDF00BE;
        Mon, 12 Oct 2020 11:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [Outreachy] Introduction
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
        <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
        <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
        <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
        <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
Date:   Mon, 12 Oct 2020 08:57:27 -0700
In-Reply-To: <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
        (Sangeeta NB's message of "Sun, 11 Oct 2020 17:00:56 +0530")
Message-ID: <xmqq362jsahk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A18B6D46-0CA3-11EB-9CB9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta NB <sangunb09@gmail.com> writes:

> A fix for making this as the default behaviour can be:
>
> --- a/diff.c
> +++ b/diff.c
> @@ -422,6 +422,7 @@ int git_diff_ui_config(const char *var, const char
> *value, void *cb)
>         if (git_color_config(var, value, cb) < 0)
>                 return -1;
>
> +       handle_ignore_submodules_arg(&default_diff_options, "untracked");
>         return git_diff_basic_config(var, value, cb);

This function is called for each and every element of configuration
item in your ~/.gitconfig and .git/config; by definition, the
default behaviour is what is used when the user did not specify
anything so what is usually done is to do that kind of defaulting
before the code calls git_config() with a callback function like
this.

And more importantly, the users may have

    [diff] ignoresubmodules=<value>

in their configuration file.  After calling handle_ignore_submodules_arg()
with the value the user desires, the above code will overwrite it with
a hardcoded default---at that point that is no longer "the default"
to be used when the user didn't specify.

I am wondering if the init_diff_ui_defaults() function is the right
location to add the above call.

>  }
>
> But this would also involve a lot of changes in the way tests are
> written as 12 out of 19 tests in t4027-diff-submodule.sh failed after
> adding this patch.

If the tests expect that the -dirty suffix is added at the end of
"Subproject commit 2f256705..." when the submodule directory has a
untracked file, it is expected that such tests need to be updated
to the new world order you are introducing, which is "just like 'git
describe --dirty' does not consider having an untracked file does not
make otherwise clean checkout a dirty one, 'git diff' should not
show that a submodule is dirty in its output if its working tree has
an untracked file but is otherwise clean".



What follows is a note for more experienced developers, but I notice
that over the years, we seems to have done a shoddy job adjusting
the implementation in diff.c file in the hope of adding support to
work in multiple repositories; most file-scope static globals like
default_diff_options and diff_detect_rename_default are still only
read while in the main repository, yet repo_diff_setup() pretends as
if an invocation of the diff machinery in a different repository can
use settings that are repository specific.  Again, this is not
something you need to be worried about.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16495C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A740364E53
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhBJHSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:18:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58191 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhBJHSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 02:18:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FCC01105DD;
        Wed, 10 Feb 2021 02:17:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fjxFrU/+qX+NSmqcb+PlMy1IGDw=; b=FckxNx
        wTL3TPG9FDMnbfXjSQyhgpOdUJVpv18rG5ceWBR4dbpGkVOcltVJTL3ML+Dc5Zy7
        JioBGrqnklO9Z37qDBgykI2tabsYcpdvpafW+m7cZWJ5/7yDWfdMl7HF1BMO/U4O
        zQSeanRufRWg2fl3KpspPOvoPErfP5V7/MRkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lLCulwyCsdu+roZZKPvKlxNURvdnfKlg
        5EPcCfwYNkk51m9iStAZ0FZBLdyyPpkB/aNVKYtd2RCzCtR7lhU1BsT3gww1vbow
        z8z009+2fcboz4F6YHKZNaMXNbh4IGFHOqwMDCNjnk8l6qHvDuAhnFuOjBHReZrx
        Jf+1FhJ+9mU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7853C1105DB;
        Wed, 10 Feb 2021 02:17:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C508A1105DA;
        Wed, 10 Feb 2021 02:17:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/9] git-stash.txt: be explicit about subcommand options
References: <cover.1612258145.git.liu.denton@gmail.com>
        <cover.1612855690.git.liu.denton@gmail.com>
        <5697f14f1c67abbb529b450c8f2a02f2bc59963f.1612855690.git.liu.denton@gmail.com>
Date:   Tue, 09 Feb 2021 23:17:54 -0800
In-Reply-To: <5697f14f1c67abbb529b450c8f2a02f2bc59963f.1612855690.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 8 Feb 2021 23:28:47 -0800")
Message-ID: <xmqqv9b04cil.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1933179C-6B70-11EB-88C9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Currently, the options for the `list` and `show` subcommands are just
> listed as `<options>`. This seems to imply, from a cursory glance at the
> summary, that they take the stash options listed below. However, reading
> more carefully, we see that they take log options and diff options
> respectively.
>
> Make it more obvious that they take log and diff options by explicitly
> stating this in the subcommand summary.

Makes sense.

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 31f1beb65b..04e55eb826 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -67,7 +67,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
>  	Instead, all non-option arguments are concatenated to form the stash
>  	message.
>  
> -list [<options>]::
> +list [<log-options>]::
>  
>  	List the stash entries that you currently have.  Each 'stash entry' is
>  	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
> @@ -83,7 +83,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
>  The command takes options applicable to the 'git log'
>  command to control what is shown and how. See linkgit:git-log[1].
>  
> -show [<options>] [<stash>]::
> +show [<diff-options>] [<stash>]::
>  
>  	Show the changes recorded in the stash entry as a diff between the
>  	stashed contents and the commit back when the stash entry was first

This makes me wonder if we should also update the SYNOPSIS that
talks about the "list" and "show" operations taking a generic
"<options>", though.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4121F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 18:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbcJESHL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 14:07:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754577AbcJESHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 14:07:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8580544E87;
        Wed,  5 Oct 2016 14:07:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gGn6TnbSOPTnVbjVcD+dfD9lHDc=; b=a2Mliv
        gRJAfeB/+uf+jpdLvPZZESVJpunR5um0vwlVNfavTNyCZ5fw4ToCSQnP7YLYpJye
        8nM4aY/iOEO3bBG61Nuv8y2FQssStMzRe5dakBpkkNbOfs8k2ljzAYWZOKJrnHf3
        YDnHtXWqhXyzJEqYdWOhKkq1ME7F5RMgAXKcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ncDCP1mol2DvgUI9tcrV+NR2ePsyiobx
        Fjv4XA5aRBWyOl267ntPl5bckSl03whRGscQTLsVZiKq7BXCyOvNlqW8l2ZFeN/3
        59pnvvHTeZX+1Gcnyz81F/sfZ1XZVakpLJVIsCSJEChifPcIigbQNlHPxRvJVovi
        zHnzxu33f+A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EF5B44E86;
        Wed,  5 Oct 2016 14:07:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF20044E85;
        Wed,  5 Oct 2016 14:07:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     sorganov@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
Date:   Wed, 05 Oct 2016 11:07:07 -0700
In-Reply-To: <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        (sorganov@gmail.com's message of "Wed, 5 Oct 2016 17:46:23 +0300")
Message-ID: <xmqq60p6pt4k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 881C643A-8B26-11E6-9C6F-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sorganov@gmail.com writes:

> From: Sergey Organov <sorganov@gmail.com>
>
> Old description had a few problems:
>
> - sounded as if commits have changes
>
> - stated that changes are taken since some "divergence point"
>   that was not defined.
>
> New description rather uses "common ancestor" and "merge base",
> definitions of which are easily discoverable in the rest of GIT
> documentation.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-merge.txt | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index cc0329d..351b8fc 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -16,11 +16,16 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Incorporates changes from the named commits (since the time their
> -histories diverged from the current branch) into the current
> -branch.  This command is used by 'git pull' to incorporate changes
> -from another repository and can be used by hand to merge changes
> -from one branch into another.
> +
> +Incorporates changes that lead to the named commits into the current
> +branch, and joins corresponding histories. The best common ancestor of
> +named commits and the current branch, called "merge base", is
> +calculated, and then net changes taken from the merge base to
> +the named commits are applied.
> +
> +This command is used by 'git pull' to incorporate changes from another
> +repository, and can be used by hand to merge changes from one branch
> +into another.

Content change together with re-flowing the text makes it more
costly than necessary to review a change like this.  Please avoid
doing so in your future patches.

I like what the updated description says very much.  I however
wonder if "and can be used by hand..." is still appropriate, or
needs a bit of modernizing.  It feels a bit awkward by making it
sound as if 'git merge' is primarily an implementation detail of
'git pull' but it can also be used as the first-class command, which
used to be the case in the old days back when "git pull . other" was
also perfectly good way to merge the 'other' branch from your own
repository, but I think your update is meant to clarify that we no
longer live in that old world ;-)

> @@ -31,11 +36,11 @@ Assume the following history exists and the current branch is
>      D---E---F---G master
>  ------------
>  
> -Then "`git merge topic`" will replay the changes made on the
> -`topic` branch since it diverged from `master` (i.e., `E`) until
> -its current commit (`C`) on top of `master`, and record the result
> -in a new commit along with the names of the two parent commits and
> -a log message from the user describing the changes.

> -Then "`git merge topic`" will replay the changes made on the `topic`
> -branch since it diverged from `master` (i.e., `E`) until its current
> -commit (`C`) on top of `master`, and record the result in a new commit
> -along with the names of the two parent commits and a log message from
> -the user describing the changes.

> +Then "`git merge topic`" will replay the changes made on the `topic`
> +branch since it diverged from `master` (i.e., `E`) until its current
> +commit (`C`) on top of `master`, and record the result in a new commit
> +along with references to the two parent commits and a log message from
> +the user describing the changes.

Content change together with re-flowing the text makes it more
costly than necessary to review a change like this.  Please avoid
doing so in your future patches.

I had to re-flow the original you removed to match how you flowed in
the updated one and stare at it for a while to spot that the only
change was to rephrase "the names of the parents" to "references to
the parents".  I do not know if the updated phrasing is better.  The
"name" in the original was meant to be a short-hand for "object name",
and I would support a change to spell it out to clarify; "reference"
can be a vague word that can mean different things in Git, and when
the word is given without context, most Git people would think that
the word refers to "refs", but that is definitely not what the new
commit records, so...

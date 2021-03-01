Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9728CC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5731165094
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhCAQvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 11:51:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62433 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhCAQs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 11:48:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E941122367;
        Mon,  1 Mar 2021 11:48:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jzhyheL2KcmAcPbTiTiFPd5AFDM=; b=upMaoc
        FI9F0ZrQCOu/LRCUkw9QkvoILM6VlXuUnTLJJKSKijNzhogghYJihbDBm4+5wDKn
        8RbOpuQUREL8v1rv+L05QKgbgWdxFsAgwF9fSdJ1ex/Cfp5SUgj3vLVk2rlSFpmT
        2z9dGpPhufFIWmfDq1YwedSKKL8kGKeHDu7lM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=McJc17e3dNMf521MF7LS7DARihiDLobH
        +6mHTWljRy4/rhWx3KRYvpuYpZEdqhZWSkwCVVrHm0tb3PAVvyucOxPbIs9XNC4f
        UaUcZHJr9tOoU2HQssphTfkwV1LNZtt4scwSCikQxDpxwnOQCDku+BNPPKYcbwco
        Fb0tKfDwx8c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3778E122366;
        Mon,  1 Mar 2021 11:48:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7BD2D122365;
        Mon,  1 Mar 2021 11:48:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>
Subject: Re: [PATCH v2 1/2] githooks.txt: Replace mentions of SHA-1 specific
 properties
References: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
        <294fb32de2681dfeac836d2b64c7e0853721d1a3.1614591751.git.ps@pks.im>
Date:   Mon, 01 Mar 2021 08:48:04 -0800
In-Reply-To: <294fb32de2681dfeac836d2b64c7e0853721d1a3.1614591751.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 1 Mar 2021 10:43:47 +0100")
Message-ID: <xmqqsg5estvf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E59E5C28-7AAD-11EB-98F3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Subject: Re: [PATCH v2 1/2] githooks.txt: Replace mentions of SHA-1 specific properties

Looking at "git shortlog --no-merges -200 master" output, I'd
suggest to please downcase "Replace" to match.

> The githooks(5) documentation states in several places that the hook
> will receive a SHA-1 or hashes of 40 characters length. Given that we're
> transitioning to a world where both SHA-1 and SHA-256 are supported,
> this is inaccurate.
>
> Fix the issue by replacing mentions of SHA-1 with "object name" and not
> explicitly mentioning the hash size.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/githooks.txt | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 1f3b57d04d..4dad80052e 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -138,7 +138,7 @@ given); `template` (if a `-t` option was given or the
>  configuration option `commit.template` is set); `merge` (if the
>  commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
>  (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
> -a commit SHA-1 (if a `-c`, `-C` or `--amend` option was given).
> +a commit object name (if a `-c`, `-C` or `--amend` option was given).
>  
>  If the exit status is non-zero, `git commit` will abort.
>  
> @@ -231,19 +231,19 @@ named remote is not being used both values will be the same.
>  Information about what is to be pushed is provided on the hook's standard
>  input with lines of the form:
>  
> -  <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
> +  <local ref> SP <local object name> SP <remote ref> SP <remote object name> LF
>  
>  For instance, if the command +git push origin master:foreign+ were run the
>  hook would receive a line like the following:
>  
>    refs/heads/master 67890 refs/heads/foreign 12345
>  
> -although the full, 40-character SHA-1s would be supplied.  If the foreign ref
> -does not yet exist the `<remote SHA-1>` will be 40 `0`.  If a ref is to be
> -deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
> -SHA-1>` will be 40 `0`.  If the local commit was specified by something other
> -than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
> -supplied as it was originally given.
> +although the full object name would be supplied.  If the foreign ref does not
> +yet exist the `<remote object name>` will be the all-zeroes object name.  If a
> +ref is to be deleted, the `<local ref>` will be supplied as `(delete)` and the
> +`<local object name>` will be the all-zeroes object name.  If the local commit
> +was specified by something other than a name which could be expanded (such as
> +`HEAD~`, or an object name) it will be supplied as it was originally given.
>  
>  If this hook exits with a non-zero status, `git push` will abort without
>  pushing anything.  Information about why the push is rejected may be sent
> @@ -268,7 +268,7 @@ input a line of the format:
>  where `<old-value>` is the old object name stored in the ref,
>  `<new-value>` is the new object name to be stored in the ref and
>  `<ref-name>` is the full name of the ref.
> -When creating a new ref, `<old-value>` is 40 `0`.
> +When creating a new ref, `<old-value>` is the all-zeroes object name.
>  
>  If the hook exits with non-zero status, none of the refs will be
>  updated. If the hook exits with zero, updating of individual refs can
> @@ -550,7 +550,7 @@ command-dependent arguments may be passed in the future.
>  The hook receives a list of the rewritten commits on stdin, in the
>  format
>  
> -  <old-sha1> SP <new-sha1> [ SP <extra-info> ] LF
> +  <old-object-name> SP <new-object-name> [ SP <extra-info> ] LF

<???-object-name> is a tad longer than the original as a
placeholder, but this line does not look so bad.

Thanks.

>  The 'extra-info' is again command-dependent.  If it is empty, the
>  preceding SP is also omitted.  Currently, no commands pass any
> @@ -566,7 +566,7 @@ rebase::
>  	For the 'squash' and 'fixup' operation, all commits that were
>  	squashed are listed as being rewritten to the squashed commit.
>  	This means that there will be several lines sharing the same
> -	'new-sha1'.
> +	'new-object-name'.
>  +
>  The commits are guaranteed to be listed in the order that they were
>  processed by rebase.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4331F461
	for <e@80x24.org>; Thu, 20 Jun 2019 18:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFTSXM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:23:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57064 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfFTSJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:09:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3FCD6B37C;
        Thu, 20 Jun 2019 14:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=INzyQdnlmcH7a2/jE+Q9dT75pLA=; b=EQXPI2
        Dk63+YLeep48et8YckYPJwihCKj+eBw9ptT9Xx86o6Nt64ZRaVWBvRM68ti9iEGA
        Ri0EebyQJqD8tnaOMS4o7vfkIt2KzMQS/5D+7nvSVJd91ix6uvxGZZvnZ3uC9u+M
        gKyyFOFwBkBfDd9ldmNjvrXdX4WCe8VXFUFT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X7IGpWt2udKWUL5Dy8QSWf789Wy1OH3C
        ynZv05DQQIpQUeiKiXR0cNNuph8ChhntHHP8JbybeXwX1tiS3P3lD7gdZqerV5+c
        qhWHnc8V/DqLKA4IXZyJZn9R2izOz1hvBTgSdRYm+A7mGTJbJBI6DT9YEctrjz8v
        uzyV86570Xk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAFDD6B37A;
        Thu, 20 Jun 2019 14:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6B8F6B378;
        Thu, 20 Jun 2019 14:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: mention that 'git submodule update' fetches missing commits
References: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
        <0102016b72a55a7d-fb4ecdb7-9f2b-4204-b888-0000f209c3ff-000000@eu-west-1.amazonses.com>
Date:   Thu, 20 Jun 2019 11:09:39 -0700
In-Reply-To: <0102016b72a55a7d-fb4ecdb7-9f2b-4204-b888-0000f209c3ff-000000@eu-west-1.amazonses.com>
        (Philippe Blain's message of "Thu, 20 Jun 2019 02:09:27 +0000")
Message-ID: <xmqqsgs4nn6k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93600F8E-9386-11E9-BF3E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> 'git submodule update' will fetch new commits from the submodule remote
> if the SHA-1 recorded in the superproject is not found. This was not
> mentioned in the documentation.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/git-submodule.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 2794e2978021c..930bfcee50e4c 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -132,7 +132,8 @@ update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--forc
>  +
>  --
>  Update the registered submodules to match what the superproject
> -expects by cloning missing submodules and updating the working tree of
> +expects by cloning missing submodules, fetching missing submodule commits
> +and updating the working tree of
>  the submodules. The "updating" can be done in several ways depending
>  on command line options and the value of `submodule.<name>.update`
>  configuration variable. The command line option takes precedence over

The additional text may not be wrong per-se, but isn't it fairly
obvious that there is no other way than to fetch, in order to
"update the registered submodules to match what the superproject
expects", aka "if the commit object name recorded in the
superproject is not found".  How else would the subcommand come up
with the missing commit out of thin air?

IOW, I have to wonder if this is worth saying, or if these new words
are just adding more things the readers need to scan on the page
without adding that much information.

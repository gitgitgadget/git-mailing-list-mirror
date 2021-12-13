Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D80C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbhLMVoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:44:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60648 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbhLMVoh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:44:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DEEE15E302;
        Mon, 13 Dec 2021 16:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OVDfHHO78mfYJnlQDpgKXXl0X/8vIjV4hmyRPf
        iZesQ=; b=rzHnkroC19ACHnOYAOcCEqXDMMbIfkw/ptb8smVASzqK8w/Nrogzfb
        PCWYStEErVSF/FKTzTw8++bkcVLrLXYM/yUMJ8JecNcVV/0Orgfum5M9mBv/j2Q/
        o8LDaNeaHp3X1OKDLABt5g264TFkg2rwzIVth1UzOxABp0BxtxBNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05D1A15E300;
        Mon, 13 Dec 2021 16:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 612F815E2FF;
        Mon, 13 Dec 2021 16:44:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V4] git-apply: add --allow-empty flag
References: <20211211031343.15818-1-jerry@skydio.com>
        <20211213202826.7051-1-jerry@skydio.com>
Date:   Mon, 13 Dec 2021 13:44:31 -0800
In-Reply-To: <20211213202826.7051-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 13 Dec 2021 12:28:26 -0800")
Message-ID: <xmqqlf0ob2o0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBFCCFD2-5C5D-11EC-AFCB-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index a32ad64718..b6d77f4206 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -14,11 +14,11 @@ SYNOPSIS
>  	  [--allow-binary-replacement | --binary] [--reject] [-z]
>  	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
>  	  [--ignore-space-change | --ignore-whitespace]
>  	  [--whitespace=(nowarn|warn|fix|error|error-all)]
>  	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
> -	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
> +	  [--verbose | --quiet] [--unsafe-paths] [--allow-empty] [<patch>...]
>  
>  DESCRIPTION
>  -----------
>  Reads the supplied diff output (i.e. "a patch") and applies it to files.
>  When running from a subdirectory in a repository, patched paths

Applying: git-apply: add --allow-empty flag
error: patch failed: Documentation/git-apply.txt:14
error: Documentation/git-apply.txt: patch does not apply
Patch failed at 0001 git-apply: add --allow-empty flag

Hmph....  Where did that "| --quiet" thing come from?



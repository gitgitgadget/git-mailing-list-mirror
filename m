Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16F0C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 22:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiFBWuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbiFBWuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 18:50:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B889037A81
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 15:50:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DDDF125C51;
        Thu,  2 Jun 2022 18:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OwbDN8v7pcBuzid30t8S8yieaDwikc8yPmb7QY
        3iumk=; b=IksoVHWfZgXgK27z+QEo8/Fkms6JELIUhgtYfkausg5bSAM8qz/3JZ
        +sJNjjp+HZ9in/v9skFmuRa4V6mbGAvcT7+qdCgKnxxy5Hy8jwO6Pp1b7UAvDSh+
        vCPAeeRm16JLSPQ8kEZMDQlRxTq4M8JImshv7c1WFliL6UrJifLag=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68D49125C50;
        Thu,  2 Jun 2022 18:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4873C125C4C;
        Thu,  2 Jun 2022 18:50:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v2] git-prompt: make colourization consistent
References: <20220601134414.66825-1-joak-pet@online.no>
        <20220602145935.10512-1-joak-pet@online.no>
Date:   Thu, 02 Jun 2022 15:49:59 -0700
In-Reply-To: <20220602145935.10512-1-joak-pet@online.no> (Joakim Petersen's
        message of "Thu, 2 Jun 2022 16:59:35 +0200")
Message-ID: <xmqqilpiistk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 566F88F6-E2C6-11EC-89EF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> Range-diff against v1:
> 1:  e235caa7a8 = 1:  e235caa7a8 git-prompt: make colourization consistent
>
>  contrib/completion/git-prompt.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 87b2b916c0..dfd6cef35f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -286,6 +286,7 @@ __git_ps1_colorize_gitstring ()
>  	if [ -n "$u" ]; then
>  		u="$bad_color$u"
>  	fi
> +	p="$c_clear$p"
>  	r="$c_clear$r"
>  }

Has this been tested?

It seems to break a handful of tests in t9903 for me.


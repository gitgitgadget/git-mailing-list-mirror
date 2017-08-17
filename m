Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872B920899
	for <e@80x24.org>; Thu, 17 Aug 2017 19:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbdHQT7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:59:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52753 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752820AbdHQT7B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:59:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 649E88E2BD;
        Thu, 17 Aug 2017 15:59:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dB2uJVn88ScOzqzzOFkFoDU7hLA=; b=CnNQv3
        fqJehTZSfZspDLV8AqfpKeKuLYk5hXT6dXX1pnbiVu+TnDQxI1CA5wrf2VVTDHa6
        YQClNtpIWzhbLOnfUZ8SS1M2pDuzZpnzXFL7hRahRJorikowX6Nvdj1TBwecM8K9
        WRnosq+7tTwrTCc1q+656qdlNB4SlYlFklOlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JhCxPAEwtrl5pIWBVFgpFcius9uCvtrc
        tOns8SDLOUoLayDfANStpGORDRm7U2LjDysHRg0i2R2FNJLREfMctyto4AeroRIt
        TmtlB/rBidbvJ1feE8pCJDMHzshrnfKI0Um+MSYOXI8YG8H5tcx27DvR0vsLjDEK
        sLmOk6LKFUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F00E8E2BC;
        Thu, 17 Aug 2017 15:59:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75AF48E2B9;
        Thu, 17 Aug 2017 15:58:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     martin.agren@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of --set-upstream option
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
        <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
        <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
Date:   Thu, 17 Aug 2017 12:58:58 -0700
In-Reply-To: <20170817025425.6647-2-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 17 Aug 2017 08:24:24 +0530")
Message-ID: <xmqqo9reezjx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 826A94C2-8386-11E7-A31D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 81bd0a7b7..948d9c9ef 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -195,10 +195,10 @@ start-point is either a local or remote-tracking branch.
>  	branch.autoSetupMerge configuration variable is true.
>  
>  --set-upstream::
> -	If specified branch does not exist yet or if `--force` has been
> -	given, acts exactly like `--track`. Otherwise sets up configuration
> -	like `--track` would when creating the branch, except that where
> -	branch points to is not changed.
> +	As this option had confusing syntax it's no longer supported. Please use
> +	--track or --set-upstream-to instead.
> ++
> +Note: This could possibly become an alias of --set-upstream-to in the future.

I'll tweak `--track` and `--set-upstream-to` in the updated text
and remove the 'Note:' thing that does not give any useful
information to the end users while queuing (no need to resend). 

Thanks.

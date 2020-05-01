Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB61C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B727F20787
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2kCQQMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgEAGU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 02:20:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59747 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgEAGUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 02:20:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CEEC63D8A;
        Fri,  1 May 2020 02:20:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wRYaVE4RBwyrc5OR0wHE/ZDQwiY=; b=V2kCQQ
        MpXYsEMJeWF4r6ugUsLV+xTmANbcAeLFpED8VXIIY1jP/8dHJWg/qZ74fng/Ovm6
        EpoYeU1e6sxljCRz3NHKO64yWWQJhNjTFvpGS4PDkEKiSRvxIW+qIU4y9c8wlttn
        pCZnNFLfWxD/glXiaC6CmJ5Pehe0WlV8S02gY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VuIQw50taosRUkaFocjru2Zf6HNF/C5+
        clMktXaqm0fvn9r2qmByeqGmrUPFGo5P4820va9+19FpPFXcMwDtMM2ap2SVI6hT
        2+5+dIgBBheXZdRUIV3GgPQZokSBlhwfhlQZBKKc9h/6DLqaIvwehcAuaxadO/cK
        BwwcK64V1/U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82F6963D89;
        Fri,  1 May 2020 02:20:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E599B63D88;
        Fri,  1 May 2020 02:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: fix quoting bug in credential cache example
References: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
        <xmqqr1w4sv5t.fsf@gitster.c.googlers.com>
        <20200501055738.GB23665@coredump.intra.peff.net>
Date:   Thu, 30 Apr 2020 23:20:52 -0700
In-Reply-To: <20200501055738.GB23665@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 1 May 2020 01:57:38 -0400")
Message-ID: <xmqq368kp457.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8B0A8D2-8B73-11EA-9224-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we can either clarify that with a note at the beginning of the
> list, or we can just present it as config, like:
>
> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> index 1814d2d23c..c756ecb8fd 100644
> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -216,20 +216,25 @@ Here are some example specifications:
>  
>  ----------------------------------------------------
>  # run "git credential-foo"
> -foo
> +[credential]
> +helper = foo

I like this style of "clarification"; it makes it clear that we are
explaining the value in the config-file syntax.

>  # or you can specify your own shell snippet
> -!f() { echo "password=`cat $HOME/.secret`"; }; f
> +[credential]
> +helper = "!f() { echo \"password=`cat $HOME/.secret`\"; }; f"

But I do not think the "tentative shell function" trick is
necessary.  I personally think it is oversold ;-)  For this
particular one,

    [credential]
        helper = !echo \"password=`cat $HOME/.secret`\"

should be sufficient, perhaps?  You do not even need to understand
how shell functions work to understand it.

Also, "git config" indents the "var = value" lines, so it would look
more natural if we indented our examples in a similar way.

Thanks.

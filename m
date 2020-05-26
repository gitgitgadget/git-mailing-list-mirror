Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AEEC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5673C20870
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aQVL1Utn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390503AbgEZS7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 14:59:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62583 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389758AbgEZS7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 14:59:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02989756E0;
        Tue, 26 May 2020 14:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kq4YFFdsdghRm8dDyJfogbENLLc=; b=aQVL1U
        tn2to75wXarQo8RqG37q6NCCjLVuKv2gR0JGa1GsZQbtP+BoUV78wAj/s2PMzlxG
        hynDnrxzRyLP8uJQXISKS1upH//wK9MUgsSm6w10P0RH9c0mstEGdPyyiacYM2j4
        aWWnt4GBepVGHti75G02Lg/VvFi7Zs/tVpFaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ROHqZRFrUBT3pKiMKLLexFbHHdkP3SZv
        sicr/Tn3jQLWrUj3Pkw3EktRivf8cjunOwGvdSy/ZdYC0nZeeWYyBPmqPZlcE9Oj
        EoLVpKK1LeMtlcTx/CkPm+uB1ZpnlJgVLm+dvT3wa98R+cE3aHtxUDNFhxfvkptd
        mSMTCAMKrMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8283756DF;
        Tue, 26 May 2020 14:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 468FE756DA;
        Tue, 26 May 2020 14:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@his.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] doc: Tell the glossary about core.hooksPath
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <20200525232727.21096-1-keni@his.com>
        <20200525232727.21096-2-keni@his.com>
Date:   Tue, 26 May 2020 11:59:15 -0700
In-Reply-To: <20200525232727.21096-2-keni@his.com> (Kenneth Lorber's message
        of "Mon, 25 May 2020 19:27:22 -0400")
Message-ID: <xmqqmu5umsjg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF1FFE2E-9F82-11EA-A764-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Lorber <keni@his.com> writes:

> Subject: Re: [RFC PATCH v2 1/6] doc: Tell the glossary about core.hooksPath

Perhaps

    Subject: [PATCH] glossary: describe core.hooksPath

Please separate this one patch out and send it again without the
rest of the series, as this is quite different from the rest of the
6-patch series and an obvious clarification, unlike the others.

> -	operation is done. The hook scripts are found in the
> -	`$GIT_DIR/hooks/` directory, and are enabled by simply
> -	removing the `.sample` suffix from the filename. In earlier versions
> -	of Git you had to make them executable.
> +	operation is done. The hook scripts are found in `$GIT_DIR/hooks/`

You accidentally lost 'the', and because you did an unnecessary
line-wrapping, such a change became harder to spot.  

I am not sure if .sample scripts should be a topioc of this glossary
entry at all to begin with.  And I think it outlived the usefulness
to describe what was in versions of Git that is more than 10 years
old.  I wonder if it is a better idea to take your new description,
but remove everything after "The sample scripts are enabled..."
except for the "see ... for details" link?

> +	or in any directory specified by the `core.hooksPath` configuration
> +	variable.  The sample scripts are enabled by simply
> +	removing the `.sample` suffix from the filename.  In earlier versions
> +	of Git you had to make the sample scripts executable manually.
> +	Hook scripts must be executable.  See linkgit:githooks[5] for details.

>  [[def_index]]index::
>  	A collection of files with stat information, whose contents are stored

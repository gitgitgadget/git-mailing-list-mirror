Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2438CC00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 02:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B224F22265
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 02:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MsJiFX7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgKCCuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 21:50:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52211 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgKCCuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 21:50:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C41431041D1;
        Mon,  2 Nov 2020 21:50:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aIaPeNKkDP7sGoODeUwZCWGKGeo=; b=MsJiFX
        7T+Y3bkjbi7BgM5fAsZhJD9FZWtxUgntQGDIPQytibdWxGePVYPnKSi3tP2dyLwc
        PREOrEbtsYgulVJdUfK4kMWu16JJsn+HAT/FWg8dAd6PpsPDWKOv2Zgj2siWFEmN
        PaFBFPVmRXQxaeM31bXPCcS3TAqVdmpAYCI88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X3p7mj+vHA99iMhrDTqXmVXI5KkGAihk
        gA8Y0nRDo3rCbmrYJ0kyYLMweZT6rn/hbxn8qqC06D7GfdOcymRNleYcepW13VO6
        m08qb9VoUkMuFHjmrQc4yAD5T0lNQcl/QlUENSHEj5HKiNDFaTrjH/im9eGdDBCI
        ustJrLoOKwg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCAC31041D0;
        Mon,  2 Nov 2020 21:50:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00CDC1041CF;
        Mon,  2 Nov 2020 21:50:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
        <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
        <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com>
        <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
        <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
Date:   Mon, 02 Nov 2020 18:50:40 -0800
In-Reply-To: <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 3 Nov 2020 02:04:45 +0000")
Message-ID: <xmqqtuu7rw5b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CD12762-1D7F-11EB-B86F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> How are you installing sparse? (I am using Linux Mint 20, based on
> Ubuntu 20.04, whose sparse package version is 0.6.1-2build1 - which
> is to say too old; you require version 0.6.2 or greater. Building
> from source, I am currently using v0.6.3-76-gf680124b).

Built and installed in ~/$arch/gitstuff/bin which is on my $PATH

[remote "origin"]
	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git

> My concern was more about how the CI system obtains/installs/builds a
> sufficiently new version of sparse. Otherwise, 'make sparse' won't do
> very much. ;-)  As I said, I don't know what's involved in getting
> that to work.

Ah, yes, it would be a disaster to trigger false positive by using
old version like 0.6.1, so we may end up having to bring our own
version in, which is more work X-<.

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E244C433DB
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5ED164E63
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBFSxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 13:53:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63643 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhBFSwn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 13:52:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4DBA111D59;
        Sat,  6 Feb 2021 13:52:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2LrIuXKlJdHIwHjIow4hx38PTZQ=; b=PXX/Xv
        mJf7GIw1s2HCrk0loJpTiDNQGEUPljkKSC8a0/KdSLj/N9rQj9wZmUisA4nL/Ezx
        0iExmHC7Ho489jUsDZtb8/9sa36IB0N2XZlmougNIryxVz+58UbXD8fyPIoOka8+
        tR1I8D3PQS1VET/OqBfVClOnBOjKHDjEy6kg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OJuiE5/wEb/NEKCPAh4uNaK5Cbunrk4g
        NrMoR5Flboy4JtmyAD51wwWgWVUx1zb2HNe3eFY2c53LFuRVn6wbssx/wqoOuk0X
        CyuQvaFkhIF8kmJwnzov58ivJa3++q5pgr886p3SqLWGMN8wvaBijXIOMjM0w1sL
        560bnedidok=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEC95111D57;
        Sat,  6 Feb 2021 13:52:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00DDF111D56;
        Sat,  6 Feb 2021 13:51:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v8 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1612557937.git.jonathantanmy@google.com>
Date:   Sat, 06 Feb 2021 10:51:56 -0800
In-Reply-To: <cover.1612557937.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 5 Feb 2021 12:48:46 -0800")
Message-ID: <xmqqmtwh9ghf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63A28F40-68AC-11EB-98AD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Peff sent a review (which I don't see in lore.kernel.org/git, but I do
> see it in my inbox); here's v8 in response to that.
>
> As you can see from the range-diff, there are just minor changes to v7
> (wording in documentation and a memory leak fix).
>
> Jonathan Tan (3):
>   ls-refs: report unborn targets of symrefs
>   connect, transport: encapsulate arg in struct
>   clone: respect remote unborn HEAD

Queued and pushed out, but with vger.kernel.org seem to be delaying
messages randomly, I'll hold off for a few days before merging them
down to 'next'.  To me this version looks good (at least good enough
to cook in 'next' and details can be tweaked incrementally).

Thanks.

>  Documentation/config.txt                |  2 +
>  Documentation/config/init.txt           |  2 +-
>  Documentation/config/lsrefs.txt         |  9 +++
>  Documentation/technical/protocol-v2.txt | 11 +++-
>  builtin/clone.c                         | 34 +++++++++---
>  builtin/fetch-pack.c                    |  3 +-
>  builtin/fetch.c                         | 18 +++---
>  builtin/ls-remote.c                     |  9 +--
>  connect.c                               | 32 ++++++++++-
>  ls-refs.c                               | 74 ++++++++++++++++++++++++-
>  ls-refs.h                               |  1 +
>  remote.h                                |  4 +-
>  serve.c                                 |  2 +-
>  t/t5606-clone-options.sh                |  8 ++-
>  t/t5701-git-serve.sh                    |  2 +-
>  t/t5702-protocol-v2.sh                  | 25 +++++++++
>  transport-helper.c                      |  5 +-
>  transport-internal.h                    | 10 +---
>  transport.c                             | 23 ++++----
>  transport.h                             | 29 +++++++---
>  20 files changed, 240 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/config/lsrefs.txt
>
> Range-diff against v7:
> 1:  2d35075369 ! 1:  8b0f55b5e4 ls-refs: report unborn targets of symrefs
>     @@ Documentation/config/lsrefs.txt (new)
>      +	protocol v2 capability advertisement. "allow" is the same as
>      +	"advertise" except that the server will not advertise support for this
>      +	feature; this is useful for load-balanced servers that cannot be
>     -+	updated automatically (for example), since the administrator could
>     ++	updated atomically (for example), since the administrator could
>      +	configure "allow", then after a delay, configure "advertise".
>      
>       ## Documentation/technical/protocol-v2.txt ##
>     @@ ls-refs.c
>      +
>      +static void ensure_config_read(void)
>      +{
>     -+	char *str = NULL;
>     ++	const char *str = NULL;
>      +
>      +	if (config_read)
>      +		return;
>      +
>     -+	if (repo_config_get_string(the_repository, "lsrefs.unborn", &str)) {
>     ++	if (repo_config_get_string_tmp(the_repository, "lsrefs.unborn", &str)) {
>      +		/*
>      +		 * If there is no such config, advertise and allow it by
>      +		 * default.
> 2:  d4ed13d02e = 2:  f09bd56d5f connect, transport: encapsulate arg in struct
> 3:  a3e5a0a7c5 = 3:  a5495a42f1 clone: respect remote unborn HEAD

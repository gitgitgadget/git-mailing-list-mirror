Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56846C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2118F23120
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 06:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbhAQG06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 01:26:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64745 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbhAQG0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 01:26:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74ABDB26AF;
        Sun, 17 Jan 2021 01:25:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PeLsgDHlwXi+RqezN4zCh50UU/M=; b=Ix+mN2
        kJXm01ESDd+6p9KjWuHh5VGvLjF1Sw96n0faviA146zPqQK10owUFU8kPRbCBINM
        R+WAARtp/lELzkk/sHqLTEkj5Os9db6k2ILg2K2/Xxma/KrLcT881mBkqFFqXoMh
        UimDZBtXusoYkcdkahOhv8xkhCAIb2/TB78Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gn5tUH8/hRKFO9vDrZE2bvbZQJURbyEV
        EtR526MAXBSQhZhY6RejL+4DKfEOOwUgt2ujAIW9mT0hZA8d+o7EwvW4sEOJgGmi
        HqW4NSBZYRTWELomgqUs6Bmle+ESCOFkty195oy/KBVxmw1GHplH4aIWi68qESkL
        XpDbfGY142E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D0C3B26AE;
        Sun, 17 Jan 2021 01:25:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 008B3B26AD;
        Sun, 17 Jan 2021 01:25:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Subject: Re: [PATCH v4 3/3] ls-files: add --deduplicate option
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 22:25:35 -0800
In-Reply-To: <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sun, 17 Jan 2021 04:02:16
        +0000")
Message-ID: <xmqqr1mkm65c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF38662E-588C-11EB-A535-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -		}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
> +			}
> +		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))

The preimage shows a style violation "}else if" introduced by an
earlier step in the series, and this fixes it.

Please make sure to proofread your patches before you show to others
to pretend that you are perfect coder and do not need "oops what I
did earlier in the series was wrong and here is a fix-up".

Thanks.

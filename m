Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A0C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 16:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7AD60F42
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 16:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbhH0QE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:04:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhH0QEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 12:04:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20A731525AF;
        Fri, 27 Aug 2021 12:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hbEa0HQutSypWUMXEKEc39LyDc6AlWgHZzWlVb
        kVuew=; b=AxQXMm0L13xB5foS8EY2BaDt/ZWBKMs4WfliuNKWcilm3CUXeA3lzy
        v9+VYOaGxqRw7UdELwbuaPYVUJKX5UYV2y1wgufph3V+8rfhGSaJ33lzUULSIH/D
        aDchvb3/8/mI7TtbR6e+HK8GSMK06WFNaCqPBqnS35Z9fQkvC2zC0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 037B21525AE;
        Fri, 27 Aug 2021 12:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37B6D1525AD;
        Fri, 27 Aug 2021 12:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2021, #08; Mon, 23)
References: <xmqqo89nq1sa.fsf@gitster.g>
        <1690c9c8072211ecb75c0026b95c99cc@oschina.cn>
Date:   Fri, 27 Aug 2021 09:03:31 -0700
In-Reply-To: <1690c9c8072211ecb75c0026b95c99cc@oschina.cn>
        (lilinchao@oschina.cn's message of "Fri, 27 Aug 2021 18:32:32 +0800")
Message-ID: <xmqqfsuuc1t8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5429AE7A-0750-11EC-B7AB-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

>>* jc/trivial-threeway-binary-merge (2021-07-28) 1 commit
>> - ll-merge: teach ll_binary_merge() a trivial three-way merge
>>
>> The built-in merge driver for binary files learned to resolve
>> trivial three-way merges (e.g. apply change, which turns A into B,
>> to content A) by itself, which would help "git apply --3way" used
>> when there is no need to use "--3way".
>>
>> Will discard.
>> Replace with a trivial-merge logic in apply.c::try_treeway() or
>> apply.c::three_way_merge().
>>
> This patch seems to have missed several merge cycles, hope it can go to next stage as soon as possible.

The posted patch that is queued will not go to any stage as-is.  The
basic idea in it may be sound but it needs to happen at a different
layer, but no such updated patch exists and I never had time to do
so myself.


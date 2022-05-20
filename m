Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B681C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbiETSX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiETSX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:23:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C65190D0C
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:23:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DA81124D2E;
        Fri, 20 May 2022 14:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0jH6ape1J297/wTEIxu2aDYbqpjIS0LHXYxH4+
        CBNrM=; b=L3jPdWVGWb/2Hf12sJzwcrxMsHCz+1Mjfa9UGwTDRZwngOBnG2PhJW
        UwPCitWlGOZALHY4O7oPpp05XrVulZPAFZGQaTFs5vnWV6UKFJM3NTWvr0Ews2jU
        vUPUhPFdne8WbYYP4v7p95UDVj4nEnY4yecqel3HVRFsEBbR+tg34=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73D41124D2D;
        Fri, 20 May 2022 14:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCEF9124D2C;
        Fri, 20 May 2022 14:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 04/10] sparse-index: introduce partially-sparse indexes
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <269c206c331bb43006678beaa20832a75754c3df.1652982758.git.gitgitgadget@gmail.com>
        <xmqqleuxmgof.fsf@gitster.g>
        <0b2215e1-7f12-ed0d-b7bf-03648b19e30a@github.com>
Date:   Fri, 20 May 2022 11:23:54 -0700
In-Reply-To: <0b2215e1-7f12-ed0d-b7bf-03648b19e30a@github.com> (Derrick
        Stolee's message of "Fri, 20 May 2022 14:05:09 -0400")
Message-ID: <xmqq4k1khxl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0259EEE8-D86A-11EC-A7C0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> Also these names being in cache.h and visible everywhere is somewhat
>> worrying.  Other CPP macros and enum constants in the file have
>> names that are prepared to be truly global, but COMPLETELY_FULL and
>> COLLAPSED do not hint that they are about sparse-index state as
>> strongly as PARTIALLY_SPARSE does.
>
> Would prepending with "INDEX_" be sufficient?

Yeah, index-collapsed, index-expanded, etc., sounds distinctive
enough.  Sorry, but I cannot think of a good phrase for partially
expanded case that is short, succinct and would go well with the
fully expanded and fully collapsed cases.

Thanks.

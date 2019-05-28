Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323491F462
	for <e@80x24.org>; Tue, 28 May 2019 16:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE1Q3y (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:29:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51529 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1Q3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:29:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A4BC6BC41;
        Tue, 28 May 2019 12:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yDfgD90bVzDkKBpNDLctaq7tgqw=; b=MdeFAJ
        E90B6vTt+jlIfmiOT3Fj2YAGHK/raDhlC3C1770S6UzfeQ/LET4ru8yeAlru12AP
        KZs7baJo3l2RAmq7GuzY5cB2iANkXYTlbDwVAZsCWMKbrZNyB0gQs8+vswjp5wuz
        m9+T/3IjA4dijM/d5/exG+C3Oqk7h7IqGeAMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FZING3q1p59b1M51PduRjbCIGPw5RVyc
        VgPF5/7CunOrGoPtBnw4bYCJrZRujrIVtkA49vYQt3PkO6SCMJgmMhNqOvA4duHg
        8ILyXTCcVpu2ghT/b5BHLOOUQ4HK+OtOjr6C80TdBmPBhzAyKI2W9IYRfy/LfUPY
        iRPdQQ7n5fw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2350D6BC3F;
        Tue, 28 May 2019 12:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50E8A6BC3E;
        Tue, 28 May 2019 12:29:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/3] packfile: close_all_packs to close_object_store
References: <pull.208.git.gitgitgadget@gmail.com>
        <0e948f639fb5209f07f8e3eb356b5886c41ff2be.1558118506.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1905201141000.46@tvgsbejvaqbjf.bet>
        <0c13a91f-e45e-d177-758a-30e9517a664f@gmail.com>
Date:   Tue, 28 May 2019 09:29:47 -0700
In-Reply-To: <0c13a91f-e45e-d177-758a-30e9517a664f@gmail.com> (Derrick
        Stolee's message of "Mon, 20 May 2019 07:55:10 -0400")
Message-ID: <xmqqy32q4k5g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0099820-8165-11E9-ADCD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/20/2019 6:01 AM, Johannes Schindelin wrote:
>> Hi Stolee,
>> 
>> *really* minor nit: the commit subject probably wants to have a "rename"
>> after the colon ;-)
>
> I did put that there, but then the subject line was too long. I'm not
> opposed to putting it back.

Let me locally amend what I queued in the meantime, then.  Thanks, both.

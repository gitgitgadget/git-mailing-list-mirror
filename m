Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC454C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9799C61073
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 01:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFHBHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 21:07:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52556 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFHBHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 21:07:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83CD7DBB7B;
        Mon,  7 Jun 2021 21:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8eX0tEetO0ImHWZjvGtNP1mm70ACfcBS4oBpX+
        2C164=; b=Ra7v+K05GtxT9vIo5mMRzW4u4CFiNQAphBW8kO+1ZpfHDmZ2i8Vgrd
        GWWEpHlm8MYda25D2Gx5SE6OuHPhf33XQd7HgMyz7D2+9FZ2x0R8G0Z6NxD5LeIj
        1E5EAV2dUEEgySASz1Ez+yQ2JAvbaVh+5M6JKQu72v8QEsPdIZex0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79CEDDBB7A;
        Mon,  7 Jun 2021 21:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3B45DBB79;
        Mon,  7 Jun 2021 21:05:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
        <b2ce649a-00d0-8418-2a3f-9172ff69eccf@gmail.com>
Date:   Tue, 08 Jun 2021 10:05:51 +0900
In-Reply-To: <b2ce649a-00d0-8418-2a3f-9172ff69eccf@gmail.com> (Derrick
        Stolee's message of "Mon, 7 Jun 2021 11:26:03 -0400")
Message-ID: <xmqqmts1rwr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB48BBB4-C7F5-11EB-9F91-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/7/2021 8:34 AM, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
> ...
>> +			old_entry = make_transient_cache_entry(
>> +					entry[0].mode, &entry[0].oid,
>> +					old_path, /* stage */ 0);
>
> I didn't realize this before I started integrating with
> v2.32.0 (which I should have done before submitting v5) that
> make_transient_cache_entry() has changed its prototype to
> include a memory pool parameter.

Sorry for the trouble---these are usually all known to me for topics
I happened to have picked up in 'seen', since I try to make it a rule
that 'seen' must be a descendant of 'master'.

How can I usefully communicate the conflicts I find out during the
integration cycles to topic owners, I wonder.

Thanks.

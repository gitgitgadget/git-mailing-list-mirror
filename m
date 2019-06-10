Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01EC91F462
	for <e@80x24.org>; Mon, 10 Jun 2019 16:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfFJQeX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 12:34:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52787 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfFJQeX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 12:34:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EBD1161AEC;
        Mon, 10 Jun 2019 12:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e8zwqApllCw/GJmvNhsCXLcdB2s=; b=mpbDyh
        pGjxXW7HOPKq8RjEoV7SyeSoW8wG/VV0QRV75QyeY4j8xLJDl11tOi1nvwgwUE1x
        +Sk70c0ougNuusUZMl61zKLdgKefkLKIHOAHK7ESPNC7tLzRw8I7EWz+4h9/PeST
        2/h7TTuL3M/wvep+zK5170xag3G/xU0xF4/Go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q2Cwz8lO32dYeKFvap0mABPFdhXsk3RJ
        srBJzNicLvSj9i7FLt0DWfM+WJk1fe5IPpqvCH8qEL4skLxCsB5KtI2e/RNE4HUX
        j7JUpNp87Bl7UUdKxgKv+XJc9mtyO637l85DsmCEPFNT7sr6XvUkaN6VMOgpZdgI
        X84AuNqa/wk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 460E2161AEB;
        Mon, 10 Jun 2019 12:34:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4822161AEA;
        Mon, 10 Jun 2019 12:34:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>, git@vger.kernel.org,
        newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 1/3] sequencer: add advice for revert
References: <2007ef79-1791-4f77-f9e4-34c59b4f0c36@gmail.com>
        <20190610051313.16222-1-rohit.ashiwal265@gmail.com>
        <d59c078c-61da-1c3a-d215-80c9e3d08896@gmail.com>
Date:   Mon, 10 Jun 2019 09:34:19 -0700
In-Reply-To: <d59c078c-61da-1c3a-d215-80c9e3d08896@gmail.com> (Phillip Wood's
        message of "Mon, 10 Jun 2019 11:39:58 +0100")
Message-ID: <xmqqk1dto0vo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99241CB2-8B9D-11E9-8F4A-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Firstly, signature of `create_seq_dir` doesn't allow us to call
>> `sequencer_get_last_command()`. Changing that for the sake of a
>> better error message is too much task for this patch as it is a
>> subject of discussion on its own.
>
> There is only one caller and it already has a struct repository pointer
> so it is a two line change, one of which is the insertion of a single
> character to change create_seq_dir() so it can call
> sequencer_get_last_command(). It is normal to change function signatures
> (especially for static functions like this) when making changes, it is
> part of improving the code base. The quality of error messages is
> important to the overall user experience. It's when things go wrong that
> users need accurate advice about what to do.

Thanks for guiding a new contributor in the right direction gently.
Very much appreciated.

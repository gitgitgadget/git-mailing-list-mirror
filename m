Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE0A1F45F
	for <e@80x24.org>; Tue,  7 May 2019 02:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEGCgQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 22:36:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51595 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfEGCgP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 22:36:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3E584D6D0;
        Mon,  6 May 2019 22:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AT/L0B9Pgox+B6JzJAsbD5D5+BE=; b=XZFSj1
        o97QtgNKt8AJgXvVYIadGAY52DL0JAn2navHIdxoojwPdPzI2Q7cf/6eizXBvOM3
        +hmfXln1HeGB8hPaVR91rB0iz/MnwOvn0/jqkRdbLy/PCYaga2CgozOk26/AlZAR
        exldW2DmXArCBuncfpLAsYWEdjgcJweLKIEMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kdOYPyOqXBIUWYHzkQvaDQjjhvHiosy3
        54qGX8B5XKtG5kTA3pxCtM7a/nDKQIM9rdSNvCrtYlMbpw/3jHXSHQaWjdYnmUOA
        EiS3OSATv3yK2NF4AqI2I4J4b5jr5UJgwn9mTWtXb5eTcEu8vXTP0GFO6q1DwTwm
        J028AoY+cho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBFFF4D6CF;
        Mon,  6 May 2019 22:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B35C4D6CC;
        Mon,  6 May 2019 22:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DcaxBLCa2vK=MfoxkaHS0gDmdUsmamyqE2yOaoG_Esog@mail.gmail.com>
Date:   Tue, 07 May 2019 11:36:08 +0900
In-Reply-To: <CACsJy8DcaxBLCa2vK=MfoxkaHS0gDmdUsmamyqE2yOaoG_Esog@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 6 May 2019 16:11:30 +0700")
Message-ID: <xmqqd0kvng87.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E02DA7CE-7070-11E9-BC4A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Apr 25, 2019 at 8:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/config-move-to (2019-01-14) 7 commits
>>  - config.h: fix hdr-check warnings
>>  - config: add --move-to
>>  - config: factor out set_config_source_file()
>>  - config: use OPT_FILENAME()
>>  - config.c: add repo_config_set_worktree_gently()
>>  - worktree.c: add get_worktree_config()
>>  - config.c: avoid git_path() in do_git_config_sequence()
>>
>>  Needs review.
>
> Please drop this for now. I still want to make it work (because I need
> it). But I'll try again with a full series of submodule/worktree
> support. Hopefully that will catch some reviewer's attention.

Will do; thanks.

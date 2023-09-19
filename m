Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4CCE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 20:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjISURF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 16:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjISURD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 16:17:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1777BF
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 13:16:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 409ED19BD90;
        Tue, 19 Sep 2023 16:16:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=E1UFeaBpxJ9w1eze4vNf4AcmG617GNCLngpfXU
        dgC+4=; b=qoYcrmIr9nyPwDxakPaTPcl9kgvOZmA6vw/bzSyfvTiCjVMtWGld7W
        PNJPjVfgYdZrhbK7ZSe9A3neHtxpJKnCgY8PN7uMBORX8vmEI3lhJW9gKLI2aepi
        tQwtMviEeIrkon3BxN5sUDXHb9BiAlTAJoRCReluhiqQ11s3nRIuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27E7B19BD8D;
        Tue, 19 Sep 2023 16:16:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C1DD19BD89;
        Tue, 19 Sep 2023 16:16:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
In-Reply-To: <owly7comj5ll.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Tue, 19 Sep 2023 13:00:38 -0700")
References: <xmqqmsxmdhdw.fsf@gitster.g>
        <owly7comj5ll.fsf@fine.c.googlers.com>
Date:   Tue, 19 Sep 2023 13:16:55 -0700
Message-ID: <xmqq7colgbpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B144B82-5729-11EE-AA08-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> [Cooking]
>>
>> [...]
>>
>> * la/trailer-cleanups (2023-09-11) 6 commits
>>   (merged to 'next' on 2023-09-12 at 779c4a097a)
>>  + trailer: use offsets for trailer_start/trailer_end
>>  + trailer: rename *_DEFAULT enums to *_UNSPECIFIED
>>  + trailer: teach find_patch_start about --no-divider
>>  + trailer: split process_command_line_args into separate functions
>>  + trailer: split process_input_file into separate pieces
>>  + trailer: separate public from internal portion of trailer_iterator
>>
>>  Code clean-up.
>>
>>  Will merge to 'master'.
>>  source: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
>
> This isn't ready yet (still need to reroll).
>
>> [...]
>>
>> * la/trailer-test-and-doc-updates (2023-09-07) 13 commits
>>  - trailer doc: <token> is a <key> or <keyAlias>, not both
>>  - trailer doc: separator within key suppresses default separator
>>  - trailer doc: emphasize the effect of configuration variables
>>  - trailer --unfold help: prefer "reformat" over "join"
>>  - trailer --parse docs: add explanation for its usefulness
>>  - trailer --only-input: prefer "configuration variables" over "rules"
>>  - trailer --parse help: expose aliased options
>>  - trailer --no-divider help: describe usual "---" meaning
>>  - trailer: trailer location is a place, not an action
>>  - trailer doc: narrow down scope of --where and related flags
>>  - trailer: add tests to check defaulting behavior with --no-* flags
>>  - trailer test description: this tests --where=after, not --where=before
>>  - trailer tests: make test cases self-contained
>>
>>  Test coverage for trailers has been improved.
>>  source: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
>
> Did you forget to add "Need more reviews"? Not sure what the status is
> for the overall series (modulo your targetd comments for some of the
> patches).

I do not have status comment for this one because I do not know what
its status is.

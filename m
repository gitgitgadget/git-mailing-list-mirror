Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902BAC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7863C61152
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbhIWU3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:29:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53359 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhIWU3G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 16:29:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA176D80B6;
        Thu, 23 Sep 2021 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g/Kz7dOuH3btW9xFpH9E4RxHY1wdXqG1KBYpJP
        XOBhs=; b=madXUmIs6qGgl3CLA22UeMwiuCJJKY1tOfd6oqvoqgzx4jbYgH+A3b
        zbyA9o7P4VvPPlHUMA3sz5pYqHqjgyXjVYMxhsAQj//HvnNbJndz/XD/elAOy487
        siHEp7XA+pEw9Im+SzRFOtcbATsIAlDxNSJePO2a0emM2XAdchBrk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C07FAD80B5;
        Thu, 23 Sep 2021 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E6FBD80B4;
        Thu, 23 Sep 2021 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] doc/technical: remove outdated MIDX default note
References: <20210922221342.6867-1-e@80x24.org>
        <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
        <YUy9HzRgHU2zvI4P@nand.local>
Date:   Thu, 23 Sep 2021 13:27:31 -0700
In-Reply-To: <YUy9HzRgHU2zvI4P@nand.local> (Taylor Blau's message of "Thu, 23
        Sep 2021 13:45:03 -0400")
Message-ID: <xmqq8rznyr4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEAB521A-1CAC-11EC-97C8-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Sep 23, 2021 at 09:47:03AM -0400, Derrick Stolee wrote:
>> On 9/22/2021 6:13 PM, Eric Wong wrote:
>> > Multi-pack-index files are used by default since
>> > commit 18e449f86b74bab35b150549c8342d252fe7ae00, so the
>> > outdated note was misleading.
>>
>> You are correct that the note is misleading, but it is still correct.
>>
>> A user can _disable_ reading MIDX files by setting core.multiPackIndex
>> to false. If this was in the user-facing docs, not the technical docs,
>> then I might push back on trying to make that distinction.
>
> It may present a fuller picture to instead say:
>
>   The core.multiPackIndex config setting must be on (which is the default)
>   to consume MIDX files. Setting it to `false` prevents Git from reading a
>   MIDX file, even if one exists.

Do you want to replace the one-line sentence with that paragraph,
instead of removing it, in a replacement patch?


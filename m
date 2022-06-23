Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9038DC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 22:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiFWWIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 18:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiFWWIl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 18:08:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DC4B1DF
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 15:08:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB67F1A7CEF;
        Thu, 23 Jun 2022 18:08:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+Fvz/zuozzA+
        1ulp3lUDdhwysUkG7uPQCOrn5XDkMmY=; b=HFfML1cmsUvXXefVdhexeL9hLASm
        2atnQEPNVkb6pmKszMAW8Og+Dnk0CP7wpmlftHsC78xIoPX2QMJBaDgVtuk6JkON
        RWt5UIKFe1nRACPH0onXzyoFDYqhElU8VGTAquj5LwxDOO8ThWf1jp8s/wLBc2ug
        pIboshZ4ggag6eM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D50431A7CEE;
        Thu, 23 Jun 2022 18:08:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F36B1A7CEB;
        Thu, 23 Jun 2022 18:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>
Subject: Re: hx/unpack-streaming
References: <xmqq7d584hqb.fsf@gitster.g>
        <220623.86o7yjk5l2.gmgdl@evledraar.gmail.com>
Date:   Thu, 23 Jun 2022 15:08:35 -0700
In-Reply-To: <220623.86o7yjk5l2.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Jun 2022 12:59:11 +0200")
Message-ID: <xmqqwnd7xcbg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07780BA2-F341-11EC-BA06-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jun 22 2022, Junio C Hamano wrote:
>
>> * hx/unpack-streaming (2022-06-13) 6 commits
>>  - unpack-objects: use stream_loose_object() to unpack large objects
>>  - core doc: modernize core.bigFileThreshold documentation
>>  - object-file.c: add "stream_loose_object()" to handle large object
>>  - object-file.c: factor out deflate part of write_loose_object()
>>  - object-file.c: refactor write_loose_object() to several steps
>>  - unpack-objects: low memory footprint for get_data() in dry_run mode
>>
>>  Allow large objects read from a packstream to be streamed into a
>>  loose object file straight, without having to keep it in-core as a
>>  whole.
>>
>>  Will merge to 'next'?
>>  source: <cover.1654914555.git.chiyutianyi@gmail.com>
>
> I've thoroughly reviewed this topic both now & in the past, and I think
> it's ready to be merged down.

I was involved in reviewing its earlier rounds but didn't read the
last round too carefully.  I'll give it another read-over before
merging it down.

Thanks, all.

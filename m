Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391CC47096
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01391613F6
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhFDBFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 21:05:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54452 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDBFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 21:05:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9750A12B134;
        Thu,  3 Jun 2021 21:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d2RzrUYCEsAoL5E3F81hVZgUmr11t38csZpoY2
        YWnaM=; b=rRsxue40TWg6OeiyakOwIikYt150LgYJW0xOqjLCUPV3ForfleBor5
        fnqB4aD3rWMG1632Ygen3ZfWZ5oVDkuLyFvmo8KghiHx/ctJxe5LyZigsuEkNDzH
        jvved1hOqe/MoL1c9n0bWVgJXx4Pr5tdbRFqQaQKI9fw6yy0Vo+ZE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9090E12B133;
        Thu,  3 Jun 2021 21:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DDFCF12B12E;
        Thu,  3 Jun 2021 21:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, gitgitgadget@gmail.com, git@vger.kernel.org,
        tao@klerks.biz
Subject: Re: [PATCH] Remove warning that repack only works on non-promisor
 packfiles
References: <YLffyI3rp9hSZZdy@nand.local>
        <20210603213558.453725-1-jonathantanmy@google.com>
Date:   Fri, 04 Jun 2021 10:03:43 +0900
In-Reply-To: <20210603213558.453725-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 3 Jun 2021 14:35:58 -0700")
Message-ID: <xmqqy2bq30gg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5EB4884-C4D0-11EB-AB45-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> On Wed, Jun 02, 2021 at 11:47:26AM +0000, Tao Klerks via GitGitGadget wrote:
>> > From: Tao Klerks <tao@klerks.biz>
>> >
>> > The git-repack doc clearly states that it *does* operate on promisor
>> > packfiles (in a separate partition), with "-a" specified. Presumably
>> > the statements here are outdated, as they feature from the first doc
>> > in 2017 (and the repack support was added in 2018)
>> 
>> Yeah, this all originally comes from Jeff H.'s design document in
>> 637fc4467e (partial-clone: design doc, 2017-12-14), but probably should
>> have been updated in 5d19e8138d (repack: repack promisor objects if -a
>> or -A is set, 2018-08-08).
>> 
>> This looks good to me, but I'll add Jonathan Tan to the CC list to
>> double check.
>> 
>>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks, Taylor. Yes, the patch is correct.

Thanks, all of you.  Will queue.

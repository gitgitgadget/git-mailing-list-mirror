Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B94C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD0A230F9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbhAGGlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:41:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59018 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbhAGGlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 01:41:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AE6D11512F;
        Thu,  7 Jan 2021 01:40:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IOLHih0ZIZDi7uDEKWl03SNUhqk=; b=DLByfP
        cCI9xe40Mlp7fBYtKbBSUYyA0mPcnQTIyt0l7o5OGrPiQkDfHZKGfjsOmmtGGZL6
        y4bKG1nQo5Ap7JOkh2Bg2QasUvylCeqNR+9aevbnGSTWTZH0XBW5FX2+pyL3qRYC
        PYvcT5ZkydY2GQNPm9AaEMGiO8wLdgqJiHgI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gG3zcSI1AY0YTahMKAXsTrEcSKYjAvmE
        2ZsCu0FSR8J8EPwv+kKiqiYkehHMYMHJKyogTg3BANsGphesaZ+26v1TwZiB1V7V
        5xPATxs+4twSSjGJNu50o0Qr5EOuL+8/KqWoFSaUmkub1hF0Pg4MYOvzH0RYJ1Vm
        BV7yUyZbYEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13B8411512E;
        Thu,  7 Jan 2021 01:40:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B23811512D;
        Thu,  7 Jan 2021 01:40:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?6Zi/5b6354OI?= via GitGitGadget 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] builtin/ls-files.c:add git ls-file --dedup option
References: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
        <CAPig+cTY0qGkYZ_OjvFUhopoioCPzaWEk=AX1mNgcOsF60hwAg@mail.gmail.com>
Date:   Wed, 06 Jan 2021 22:40:34 -0800
In-Reply-To: <CAPig+cTY0qGkYZ_OjvFUhopoioCPzaWEk=AX1mNgcOsF60hwAg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 7 Jan 2021 01:10:22 -0500")
Message-ID: <xmqqturtmeql.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FC08160-50B3-11EB-BD6C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +                               if (show_deleted && err)/* you can't find it,so it's actually removed at all! */
>
> Add space before `/* comment */`.
> Add space in "...it, so...".

Avoid overly long lines.

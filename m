Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABBEC47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A0A613C5
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhEZXee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:34:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56014 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhEZXee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:34:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 229D0139817;
        Wed, 26 May 2021 19:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1pVW0S3HfzW8
        4uWFqoE/qR+1tQ1IB0HpAVMdapOzvqw=; b=s5K21Nat9EKHib1FP/mSucdH6TLu
        UEbXsSjT0DqYPUPLV4hhFjHQ0z00IkQ8V4/IQg4N1SEt001gKMrG+1oycPqeEUN4
        +/4F/t993S2r/UwMuMtx4XDJXgX8hXfDQ3bn4m/PDIzwyiY0v+AMY3UbPUDDh1kw
        ZFvLaFObZucd7sw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C0C7139816;
        Wed, 26 May 2021 19:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8556139812;
        Wed, 26 May 2021 19:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
Date:   Thu, 27 May 2021 08:32:56 +0900
In-Reply-To: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
        (yuri@rawbw.com's message of "Wed, 26 May 2021 15:47:15 -0700")
Message-ID: <xmqq35u9ax5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3F95824-BE7A-11EB-BFFB-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> I have the file that contains the "=E2=88=9E" character in its name.

"git config core.quotepath no"?

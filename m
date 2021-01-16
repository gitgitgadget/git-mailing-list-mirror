Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7FC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 05:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85F1208A9
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 05:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbhAPFod (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 00:44:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62803 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhAPFoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 00:44:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CBD7C108203;
        Sat, 16 Jan 2021 00:43:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=luBULT72Uciy
        pL+ax+NUXATeMDo=; b=pM0gGuEmm3Myy23cBqEO2CqI9JHzF4YjqH6DfEKinDa1
        ZnYLftJEh5trz8AZuqDZeOB3+NX0U1MHZB/baVhSyOBLRvqDUXynfP7xNFOtJZqH
        mHRXav1f5XIu5hjAhU8n3q2l/8FKb6VFYFXwQjctKp5cVJy8XBgxlZrskjicrio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qwu6Oj
        zyr/SPcOQxY6Ncs+LvH8SjXr19KBKD0etmoIPit3u/EH6qmZ/ytq+TOm18JgE5yU
        QSL7+r6aZXIp5WWDgDmLumr2kq4Uda4NMzF5lhCAUh5jQLPXmgwfuOr1VdLDpKuR
        Bi5tAnohd3XoSc7hmfyOFv3iFfIrYrArTsW3M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3DA9108200;
        Sat, 16 Jan 2021 00:43:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18CB51081FF;
        Sat, 16 Jan 2021 00:43:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2021, #03; Fri, 15)
References: <xmqqbldpr90k.fsf@gitster.c.googlers.com>
        <CANYiYbGxFt_Yxyk83-rSzXdUMHuK9+tRBtf3BTU8HnmzGrGudQ@mail.gmail.com>
Date:   Fri, 15 Jan 2021 21:43:46 -0800
In-Reply-To: <CANYiYbGxFt_Yxyk83-rSzXdUMHuK9+tRBtf3BTU8HnmzGrGudQ@mail.gmail.com>
        (Jiang Xin's message of "Sat, 16 Jan 2021 12:21:16 +0800")
Message-ID: <xmqqzh19phbh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDFB242E-57BD-11EB-88E1-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:02=E5=86=99=E9=81=93=EF=BC=9A
>> * jx/bundle (2021-01-11) 3 commits
>>   (merged to 'next' on 2021-01-14 at 749a907dd2)
>>  + bundle: arguments can be read from stdin
>>  + bundle: lost objects when removing duplicate pendings
>>  + test: add helper functions for git-bundle
>>
>>  "git bundle" learns "--stdin" option to read its refs from the
>>  standard input.  Also, it now does not lose refs whey thy point at
>>  the same object.
>
> s/whey thy/when they/

Thanks.

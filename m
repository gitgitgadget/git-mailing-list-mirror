Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FACC433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5118123BF0
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395444AbgLKGAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:00:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58127 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395447AbgLKGAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 01:00:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A35FF10DA7B;
        Fri, 11 Dec 2020 00:59:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4zB7RqV3Vc0UvqqqsK5dpZlnsDM=; b=dTcrmeDUeP7oa6rOHZIq
        KEBHvQS+LZ8ADSytoAPRJb9IIdfs/svMA9sIm6WpTfY5TQoQtpyR+UOLOAYR0D28
        h2RJXNDKKKGLGvpiRou2N8KxiQY8ij5pbN89vlH0mpwi24caRgdmcBXhq+O0lSs/
        LlcvIHt5Mpv4zwhrn1Yvpy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=XICQmGMoUYailaBCk0k7XXG6Z725N4NiVo7bjGKDKBS1hu
        TqItXBbAN0VSPpEYmvtPe+LGM29kT8Z7eqIQGPeH+P16Xx4D8TH5bJREAzWao4Tq
        Wy19VtihClpNZAeHvS0zoQDfMVe/fVFjZdt+CqP+9EeFg7kY6cwiO9cCYGB0M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BF4F10DA7A;
        Fri, 11 Dec 2020 00:59:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E3C0710DA79;
        Fri, 11 Dec 2020 00:59:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/4] init: document `init.defaultBranch` better
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
        <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
        <483e490349165223a80a0bdf7716c5189560c977.1607637517.git.gitgitgadget@gmail.com>
        <CAMP44s3mtCd9RnZdW7-HLcKVG13UW8u_1VNC0_7jByQRv61+vw@mail.gmail.com>
Date:   Thu, 10 Dec 2020 21:59:55 -0800
Message-ID: <xmqqsg8cnaqs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1893E49E-3B76-11EB-9875-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Dec 10, 2020 at 3:58 PM Johannes Schindelin via GitGitGadget
>
>> +repository.  If not specified, fall back to the default name (currently
>> +`master`, but that will be changed in the future; the name can be customized
>> +via the `init.defaultBranch` configuration variable).
>
> Wait a second. The advice warning said "this is subject to change",
> and the documentation says "that will be changed in the future". Which
> is it?
>
> "I might give you a fine", and "I will give you a fine" are most
> definitely not the same thing.

I think we say "this is subject to change" in other places, and I
agree that this part should match to avoid confusing readers,
especially the non-native ones like me.

    If not specified, fall back to the default name (currently
    `master`, but this is subject to change in the future; ...

would be more consistent.

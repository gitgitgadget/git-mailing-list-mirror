Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12A3C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6936E22CB8
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgLOVHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:07:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62701 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgLOVHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:07:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77B9EF37CB;
        Tue, 15 Dec 2020 16:06:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TT8QRj/OELjp1PItWf5j9R5k14s=; b=mUkkvJ
        YNAm1i5BsyLPHjYQ6df2qWCE+n7/zmbFCj7H8wDS1snoH2Jwf+dPKH1rgwacJy1w
        UNv9HZX8BDy0colYmL15Bx5L+RRayRufOjvluofLV2TkL+9ESMfh/aLiXLUH1x7W
        KchdCEua14AUQe//Xjs2alhTTSn/MRdwfLS90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P7mlDtxo6LTE0ylz79hMgv5smph4i1Tn
        ch6oKsNL+cKdU5lEKMscj8On6IT6zbnCIIPkse2iIN+4/MTKDXBDpTzOPk41zV83
        Rk2ClEdlWOiyPVEaAz6YBUZHAqGmcDiE7009QZSd80k3n5nyv3QOhnx1vVEvOTfJ
        52tB8f/nN8c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FF3CF37C9;
        Tue, 15 Dec 2020 16:06:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42F16F37C6;
        Tue, 15 Dec 2020 16:06:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] doc: mention Python 3.x supports
References: <20201210143017.24615-1-congdanhqx@gmail.com>
        <xmqq4kkoat8v.fsf@gitster.c.googlers.com> <X9j0pf1lQQHZifvw@danh.dev>
        <CABvFv3JjipUqchLAhyvMax=s4z3VhPyKvSAPqtbj3W4pNOmzvg@mail.gmail.com>
Date:   Tue, 15 Dec 2020 13:06:48 -0800
In-Reply-To: <CABvFv3JjipUqchLAhyvMax=s4z3VhPyKvSAPqtbj3W4pNOmzvg@mail.gmail.com>
        (Yang Zhao's message of "Tue, 15 Dec 2020 09:54:36 -0800")
Message-ID: <xmqq8s9y93tj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 731C0A62-3F19-11EB-90DF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yang Zhao <yang.zhao@skyboxlabs.com> writes:

> Caveat: I am relying on memory here. I haven't looked at this code
> since my last round of PRs...
>
> Yes, git-p4 use the p4 executable, and not an integration library. p4
> has a "serialize for Python" mode which outputs in a python2.7 pickled
> format, which is still supported by python3, and this is what is used
> to receive data from the app.

Ah, OK, the mention of "not 3.x" referred to the fact that its
pickle output format is native to 2.7, but 3.x can be made to read
it (and that is how we can run with 3.x).  That makes sense.

>> Not related, but Perforce's official Python bindings supports Python 3
>> from at least 2013 [p4r13]. And they still maintain in [PyPI].
>> That binding requires compiling with Python Development files, though.
>
> Compilation from source is only required on the latest version of
> python3. p4python has wheels on PyPI, but it's consistently a minor
> version behind. At the moment wheels for 3.8 exist for all major
> platforms, but not 3.9.
>
>> > The change to INSTALL just drops the mention of 3.x; do we want to
>> > specifically say that any version of 3.x is OK, or is it generally
>> > accepted that Python 3.x is "later" than "Python 2.7"?
>
> Any 3.x is OK, as long as we are staying with interfacing with the p4
> executable directly.

It makes it a lot simpler that we do not have to say anything.  So
the patch under discussion is good as-is without any tweaks, then.

Thanks.  

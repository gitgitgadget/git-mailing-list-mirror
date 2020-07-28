Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C0C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7249207E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZVyfJ05Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgG1Xbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:31:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62495 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbgG1Xbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 19:31:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25632836B4;
        Tue, 28 Jul 2020 19:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XmNuGvhst2vhCyrupIzaywyykYg=; b=ZVyfJ0
        5YFdKHbDega+Ae0808Jv/pHyGv4omfRJnypD4r0HiHU8Czg2LtNah7V+LACdaBqt
        Dk93a6UYZ3tyiosPhVwb4XsUyFbGVhEsENHm2AKwBkaDR3d6dS6+KmCUP7scdrV2
        shGfDQOSp/9xyoyER4a4blonli2osF6gokHyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QXZplH1pWAOP/JFbnEq8vDJlWVkgZWlZ
        eoZzbfeDyYyocbVec4Ih6gfF1brW5+41hF+sa+wG8xf4Dfw11k+iaxPUzNx7Q1xh
        W6TaXkEp/EvwVGGOZNOjL1ZzBS4DHn8KxE6Zi07H7Stw57yaPrRg6v+xUu0djM6Q
        JcCdkz5Sfms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EDBB836B3;
        Tue, 28 Jul 2020 19:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92EFD836B2;
        Tue, 28 Jul 2020 19:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 08/11] strvec: fix indentation in renamed calls
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <20200728202631.GH1021513@coredump.intra.peff.net>
        <CA+P7+xq08K3MNn7jLoVS8Sqnj79yOSqnXeXU6uob=SKJYKmBxg@mail.gmail.com>
Date:   Tue, 28 Jul 2020 16:31:38 -0700
In-Reply-To: <CA+P7+xq08K3MNn7jLoVS8Sqnj79yOSqnXeXU6uob=SKJYKmBxg@mail.gmail.com>
        (Jacob Keller's message of "Tue, 28 Jul 2020 15:43:59 -0700")
Message-ID: <xmqqwo2nb4it.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BECEB6E-D12A-11EA-92CA-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Jul 28, 2020 at 1:29 PM Jeff King <peff@peff.net> wrote:
>> Let's fix these up to align the arguments with the opening paren. I did
>> this manually by sifting through the results of:
>>
>>   git jump grep 'strvec_.*,$'
>>
>
> I haven't seen this before. Some sort of alias that lets you open each
> grep spot in an editor?

in contrib/

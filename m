Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1DC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3C220CC7
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zb4ai5fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDJQVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:21:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDJQVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 12:21:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EF14C3377;
        Fri, 10 Apr 2020 12:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SXGSBdtzjLEr
        cNKhaIVJmrAtDHc=; b=Zb4ai5fl7+uxU17pUhslbexT5El+KDwUE+KlMBhEq1fK
        5sW434VVvVLUi2halEtzKcHlpqaAni8A+R549N4/rzfTmceXGUhec7TgyFMlxSGe
        umNfKFiIywCc9P+MizWIEzrnsJdAnzC0w+IIsLg2jd2EeFdG/y2nyWg2ATRvcQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ienZ0e
        zvpKyAmMxepADnvJ2JwjDZ+ORLE3Vm/I1eFNSGqC6L8d9yU4zJR7X5iCrkeAN2iR
        m4oZQ4YcDzyxd/MJBoE60xmkSYEi+Gs7LLgyCvUVAhWKuW0crrq2VqKapA7fBySl
        Ow6gsGrHOZEI1iGW6Um/7ETjCL13gumtQthCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56CF0C3375;
        Fri, 10 Apr 2020 12:21:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F45FC3374;
        Fri, 10 Apr 2020 12:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 05/12] ci: explicit install all required packages
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586309211.git.congdanhqx@gmail.com>
        <4f80724641e17bf0d1937dbad77f987fbf86cd64.1586309211.git.congdanhqx@gmail.com>
        <20200410155322.GN2224@szeder.dev> <20200410160741.GA12360@danh.dev>
Date:   Fri, 10 Apr 2020 09:21:08 -0700
In-Reply-To: <20200410160741.GA12360@danh.dev> (Danh Doan's message of "Fri,
        10 Apr 2020 23:07:41 +0700")
Message-ID: <xmqqwo6njoqz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4A2A015E-7B47-11EA-B12D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-04-10 17:53:22+0200, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> ...
>> Furthermore, this doesn't install 'make', though in other jobs it is
>> installed explicitly.  Note that the StaticAnalysis job requires
>> 'make' as well.
>
> I copied them from Azure Pipelines declaration.
> I think it's better to list make explicitly in all jobs.
>
>> Also note that we have a 'linux-gcc-4.8' job as well...
>
> Will do in the re-roll.
> ...
> No, this patch shouldn't change it.
> I will remove apache2 from $UBUNTU_COMMON_PKGS

Thanks both for working together to trim excess bits and add back
missing bits to polish it.

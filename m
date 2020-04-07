Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC69C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C78F2075E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cvsd1WWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDGTZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:25:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52784 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgDGTZV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 15:25:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44351567CF;
        Tue,  7 Apr 2020 15:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JEg7NQdBcsTh
        fVILqiYdjhtACFU=; b=cvsd1WWzPapxeQDR4cJDz0siNcTmiLi5xq/rCEvvtgNv
        Cn/uj3SHSnZaiGMCKEy/yj9OpK2+18f8CZCVm4Sl1G5o/A44OaKSAWk+9Ouv9nCJ
        cB7vGP/BvWSg4N0gw7dl5vntMatkas4tNaylQCDgQLuyd4vWuOGGIW3cTOr1GDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AQAX3w
        FNixGAlNgCnOuLwhht2j7NwS21wDWK6n8ReG7ejdZZ82kagaqMz7QANjooIANgdj
        5LX2atVgDJDucakOo6RRjCY6ELjRDJgYV7nYw+P+Nj8gjCtSgVywR/X/08k/N3uS
        I+M6ECSSa5KDzg3B27CHjP8lPfaQJfMp8f+Lo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36F06567CE;
        Tue,  7 Apr 2020 15:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6747B567C3;
        Tue,  7 Apr 2020 15:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Travis jobs for linux with musl libc
References: <cover.1585474409.git.congdanhqx@gmail.com>
        <cover.1585961568.git.congdanhqx@gmail.com>
        <xmqq5zedy8dj.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004071654170.46@tvgsbejvaqbjf.bet>
Date:   Tue, 07 Apr 2020 12:25:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004071654170.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 7 Apr 2020 16:55:03 +0200 (CEST)")
Message-ID: <xmqqd08jt7xn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7EA9F2C0-7905-11EA-B83C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Sun, 5 Apr 2020, Junio C Hamano wrote:
>
>> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> wri=
tes:
>>
>> > The series for GitHub Actions will need to be rebased on this series=
 again.
>> > 6/6 in that seriess will have UD conflicts.
>> > Please "git rm azure-pipelines.yml" to fix conflicts.
>>
>> If you want to keep doing this, please take over the ownership of
>> both series and build one on top of the other.  I asked you and
>> Dscho to coordinate and work together, but Dscho seems to be
>> comfortable with the idea of letting you touch his series, so doing
>> so would still count as you two working together ;-).  I do not have
>> a strong opinion which parts should come first (it is something that
>> can be decided between you two which way is cleaner).
>
> For the record, Danh and I _are_ working together, and yes, I am totall=
y
> comfortable with him taking the lead on submitting the patch series'
> iterations.

Good.  Thanks, both.

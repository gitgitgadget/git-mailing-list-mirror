Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E349C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiCBTXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiCBTXr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:23:47 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7612E583BC
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:23:03 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BF2811AA5C;
        Wed,  2 Mar 2022 14:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=b2KU/5zZZuqb
        Vw3IvxhL2WD2JHXLSDRJ2JuVAnRwXPA=; b=rN2LIaYKlg81iQRkEaJ8SRAPkzit
        QtNby69lOW46Rn5sqxnWgOjRig6NzlSd6KZCuv62qhk/SqdMzOPdegw1Yocb3COD
        MiHM9TazQf3g7Ecekj7TNN3bz388NHVchY9CXkkEqJw8HtoW+qgjSuBxyf8ll5ne
        o6nDvGy2fbOSeZk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 418D111AA5B;
        Wed,  2 Mar 2022 14:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D42E11AA59;
        Wed,  2 Mar 2022 14:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>,
        "Lessley Dennington" <lessleydennington@gmail.com>,
        "Derrick Stolee" <stolee@gmail.com>
Subject: Re: [BUG] fetch/pull -h ABORT out of a git repo
References: <2022030218445028804916@oschina.cn>
        <2022030219025261342425@oschina.cn>
Date:   Wed, 02 Mar 2022 11:22:59 -0800
In-Reply-To: <2022030219025261342425@oschina.cn> (lilinchao@oschina.cn's
        message of "Wed, 2 Mar 2022 19:07:46 +0800")
Message-ID: <xmqqczj4kvl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D06DEFC-9A5E-11EC-8F46-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

>>Apparently, the process aborted unexpectedly.=C2=A0I think this is a BU=
G.
>>
>>This was introduced after v2.34.1, the related commits are:
>>
>>5a4e0547e2386f9bf0565316d7b751fe9459898b
>>44c7e62e51e504c060844360fc56b613cfc1beea
>
> Since I found more commands will abort, I think the main relevant
> commit is 44c7e62e [1]
>
> [1]:
> https://lore.kernel.org/git/fd28be71ca47a71b224a5b08cb81f903ada6a2bd.16=
38806161.git.gitgitgadget@gmail.com/

Thanks; I think the fix 059fda19 (checkout/fetch/pull/pack-objects:
allow `-h` outside a repository, 2022-02-08) is already in the
'master/main' branch.




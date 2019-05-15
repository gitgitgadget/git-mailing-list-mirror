Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0371F461
	for <e@80x24.org>; Wed, 15 May 2019 01:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEOB2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:28:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61175 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOB2d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:28:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E8A4142C4C;
        Tue, 14 May 2019 21:28:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t07sl5aQKXgBWxSK98ugLHDMJXg=; b=lMd8Qa
        PQgZ5zTTDVxKngOFweWuSS3IkVCp0pJKX2LszRDsiUewWXCFIoHWXmGu1cIa96fx
        as/oaQ3RmUnrQh5zyOyTYZPEr1lLjdQzXRjShVilE3X2LSGRCdw9tAxSX5nQVFqu
        m+oXuVJyBsRcIGjq7aIBe/MTe8CcpNgzYTHx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MXUJuMjspw7lmJ5x8mK/63D2DUgrrr/L
        yw3tXLhl3YoMKT01I+xZ761Qq2AE3ZqUv+/X0kCrw0CHVK5EkyFp1sSKVbmTKQeD
        6wGlACNGiIOF5YE4UXVgRivYYXLlVnuYzs701Tkx8YsSgCtSunZDLNw39qMeP7cU
        sdcCHEyHqp8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05A28142C4B;
        Tue, 14 May 2019 21:28:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F26D142C47;
        Tue, 14 May 2019 21:28:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/difftool-no-index, was Re: What's cooking in git.git (May 2019, #02; Tue, 14)
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet>
Date:   Wed, 15 May 2019 10:28:29 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 14 May 2019 11:54:26 +0200 (CEST)")
Message-ID: <xmqqef508q0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF251C88-76B0-11E9-B8FD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 14 May 2019, Junio C Hamano wrote:
>
>> * js/difftool-no-index (2019-05-09) 1 commit
>>  - difftool --no-index: error out on --dir-diff (and don't crash)
>>
>>  The "--dir-diff" mode of "git difftool" is not useful in "--no-index"
>>  mode; they are now explicitly marked as mutually incompatible.
>>
>>  Will merge to 'next'.
>
> Seeing as the following is a part of v2.22.0-rc0's release notes:
>
> 	 * "git difftool" can now run outside a repository.
>
> maybe we could get this to `master` instead of `next`?

There is no 'instead of'.  Topics advance one step at a time.

I do not recall seeing you respond to my review comments on the
"error out" patch <xmqqv9ykdr1w.fsf@gitster-ct.c.googlers.com>, but
thinking about it further, assuming that my rephrasing of your
justification in my review was correct, I wonder if it is even more
correct if we do not error out but simply behave as if "--dir-diff"
option were not given.

That is, if there were some way to distinguish tracked and untracked
paths in --no-index mode, --dir-diff would copy only the tracked parts
to temporary directories and run tree comparison.  Since there is no
"untracked paths" by definition in --no-index mode, we do not even
have to make copies but just compare the two directories given using
the same tree comparison tool.

Wouldn't that be more useful behaviour than telling the end users to
run the backend tree comparison tool themselves?

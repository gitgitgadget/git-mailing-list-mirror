Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB07C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BBD2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CwHRxBEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbgEMX7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:59:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51270 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbgEMX7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 19:59:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09B99568E9;
        Wed, 13 May 2020 19:59:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wKpF658Lm/Zf
        +iepDwfwbJdOtBY=; b=CwHRxBEnbk6t9nw7ssMx7BttxiPZyzBHbzP+Z+siLzDQ
        RqcGV/W2d01LOEVA0hcqATemeu/UBpG0+JaYbTlbe1PFW/LV8feNzmwWnbkFoIM3
        m9MZbzfPPoEdU/Kn/+1JmWkX45DzmlaqBThVUjyIk8rlsXfrj8O/sD8gCPvOZDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=maZwbF
        8BFLh7sFeH8TQ5o5hZ7wiedhSWp9E82UeE/XmUtXTpz4foNrh+H49CZRq+T01aaK
        JKnDvBjZ9GY0He0+6C3IoYNB6wiN9XRczkTzt0ie8j1QV0WtxmPKitqJQoua3R0U
        XFAEf02Jh+nUJeDYJslxiCyhXDYGw6yLGaVjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 014DA568E8;
        Wed, 13 May 2020 19:59:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76CC5568E6;
        Wed, 13 May 2020 19:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] CI: enable t1509 in Travis and GitHub Actions
References: <cover.1589375923.git.congdanhqx@gmail.com>
        <fa2e1f7b44262eac1fa26161fc5d3f3b9b6bdb47.1589375923.git.congdanhqx@gmail.com>
        <xmqq8shvvkur.fsf@gitster.c.googlers.com>
        <20200513235215.GA10618@danh.dev>
Date:   Wed, 13 May 2020 16:59:42 -0700
In-Reply-To: <20200513235215.GA10618@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Thu, 14 May 2020 06:52:15 +0700")
Message-ID: <xmqqo8qrqtch.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0CCF85E-9575-11EA-81D2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> > =20
>> > +chmod a+w /
>> > +
>> >  # Build and test
>> >  command $switch_cmd su -m -l $CI_USER -c "
>> >  	set -ex
>> > @@ -68,6 +70,7 @@ command $switch_cmd su -m -l $CI_USER -c "
>> >  	export GIT_TEST_CLONE_2GB=3D'$GIT_TEST_CLONE_2GB'
>> >  	export MAKEFLAGS=3D'$MAKEFLAGS'
>> >  	export cache_dir=3D'$cache_dir'
>> > +	export IKNOWWHATIAMDOING=3DYES
>> >  	cd /usr/src/git
>> >  	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
>> >  	make
>>=20
>> Big EWWWWWWwwww.  Do we need to do this for _all_ tests, not
>> selectively only while running t1509?  This makes me worried as a
>> test by mistake can easily corrupt the VM and invalidating the
>> tests; I know we get a fresh one every time, so there is no
>> permanent harm done by corrupting it, but having one fewer thing we
>> have to worry about is always better than having one more thing.
>
> Perhaps pass this variable all the way down from ci/lib.sh?
> Adding another variable into t1509 (except T1509_*) doesn't make it
> less risky.
> Or should we add T1509_ prefix to this env var?

I was not worried about any environment variable, but the "let's
make the root directory writable by anybody during _all_ tests",
when we need such a crazy permission bits on the filesystem only
while running t1509 and not any other time, stood out as extremely
yucky.




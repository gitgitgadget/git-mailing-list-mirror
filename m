Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5AC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9317C20772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wL5YzVT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbgDAVXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:23:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58387 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVXK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:23:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81C7EC15F5;
        Wed,  1 Apr 2020 17:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sJ7Jks7lAOmT
        4oGYzSEuLUEJtjI=; b=wL5YzVT5z0uV9PoTa2llA4kfDAPl87J+DhOL6GgVktGq
        Qt/bu5KVdjy75t/rbo16osOlFG35wMuao3uQPrHJLGufCzpHrA0+ERdm16RiYnIU
        wNvMr+wLZMbcffHF9TPoiQTKRbaBvPCrFfxx6g3Qg/j580cK583A8AZcWynPfeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L/8JcP
        6PipKQlaKO0AuYIMQ95cjnHa5R3/jSgQTPsUWZtNXagIDkZ+Zw9JFkr65d47ULwL
        697RbADF/i3chNInClHJj87+8Qb9ecxDzKJmtWC1BUUaKIzwqJXj4cLPZHz4IeHh
        j6X3kWKjjL0siPbAoiE9NwXdMEVEsqFIobKm0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AFFAC15F4;
        Wed,  1 Apr 2020 17:23:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB4A6C15F3;
        Wed,  1 Apr 2020 17:23:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 0/6] ci: replace our Azure Pipeline by GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1585756350.git.congdanhqx@gmail.com>
Date:   Wed, 01 Apr 2020 14:23:01 -0700
In-Reply-To: <cover.1585756350.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 1 Apr 2020 22:55:02 +0700")
Message-ID: <xmqq7dyy6gui.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F82F5384-745E-11EA-8A10-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> This series is based on work started by Dscho,
> I started to work with this series since there're merge conflicts
> with my series at dd/ci-musl-lib, and Dscho said he was busy for a whil=
e.
>
> Changes frome Dscho's version:
> * Based on dd/ci-musl-libc
> * Move artifact extraction out of Test phase of windows-test
> * Move ci/print-test-failures.sh out of build-and-test phase
> * set TERM environment variable if not exist
> * add linux-musl job
> * v1 doesn't report failure on linux32, fixed
> * run linux32 directly inside container
> * install development file of curl in documentation job because "curl-c=
onfig"
>   will be called in pu's Makefile
>   + Other approach could be call make CURL_CONFIG=3D: in test-documenta=
tion.sh
>
> Sample run:
> * of this series: https://github.com/sgn/git/actions/runs/68291472
> * pretend compile failure: https://github.com/sgn/git/actions/runs/6829=
2112
> * pretend test failure: https://github.com/sgn/git/actions/runs/6829305=
6
> * merged to pu: https://github.com/sgn/git/actions/runs/68301122

When I look at

    https://github.com/git/git/actions

it appears that every time I push[*1*], we are running _two_ sets of
the same tests, one says "Pu nu bu?" and the other says "CI/PR".

In addition, the former refers to "Pull request #nnn synchronize by
gitster", with #nnn part made clickable, but clicking on it results
in 404 page, as there is no such pull request.

Does this series need some help from me (i.e. changing my workflow)
to make the CI tests run more smoothly?

Thanks.


[Footnote]=20

*1* I always push to github.com/git/git and github.com/gitster/git
almost at the same time---the latter has all the topics that gets
merged to 'pu' separated out.  But the latter push does not say
anything about anybody asking to anybody else to pull anything.

Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A7C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720E12074F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDDzDr4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgDIVTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:19:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58241 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDIVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 17:19:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40FE8C20A2;
        Thu,  9 Apr 2020 17:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ruXcbc0uzWGh
        iUuq7yu6qShEZAc=; b=CDDzDr4rzxJlKv+hJ/RV3GR3lKkatHingtp/NLUKlFQ0
        ZJo2CSdjlXWsy8frqlng2RNvykXAjTjEmRMgflQey4QhjhzbplzShDG6OaeesSek
        /HUA4Um3H49Vaf0uBDm5kKA0+a9O+964OzwL9gOcufoCKOcYRvtdASLuwwaUzVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sFvoA2
        wNiHfkEZVpIDdeRg+m1T7/6B5mPMSqSTmA9aiG0uSJY+mk+j9TeeX8+RaQLSugew
        P9XnqhCnviDp8e288Hx6OWt8mEppiTHI7GU5pMrxQ+pk3s223+AXQM/EPj9oa7fo
        qX0YH6aC9R2+NGldeIwLNJn0yWR913HGPXtTg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A30AC20A1;
        Thu,  9 Apr 2020 17:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80B1DC209D;
        Thu,  9 Apr 2020 17:19:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586309211.git.congdanhqx@gmail.com>
Date:   Thu, 09 Apr 2020 14:19:36 -0700
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 8 Apr 2020 11:05:31 +0700")
Message-ID: <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D1C07C4C-7AA7-11EA-98E1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Our Azure Pipeline has served us well over the course of the past year =
or
> so, steadily catching issues before the respective patches hit the next
> branch.
>
> There is a GitHub-native CI system now, though, called "GitHub Actions"
> [https://github.com/features/actions] which is essentially on par with =
Azure
> Pipelines as far as our needs are concerned, and it brings a couple of
> advantages:
>
>  * It is substantially easier to set up than Azure Pipelines: all you n=
eed
>    is to add the YAML-based build definition, push to your fork on GitH=
ub,
>    and that's it.
>  * The syntax is a bit easier to read than Azure Pipelines'.
>  * We get more concurrent jobs (Azure Pipelines is limited to 10 concur=
rent
>    jobs).
>
> With this change, users also no longer need to open a PR at
> https://github.com/git/git or at https://github.com/gitgitgadget/git ju=
st to
> get the benefit of a CI build.
>
> Sample run on top of dd/ci-musl-libc with dd/test-with-busybox merged:
> https://github.com/sgn/git/actions/runs/73179413
>
> Sample run when this series applied into git-for-windows
> https://github.com/git-for-windows/git/runs/568625109
>
> Change from v3:
> - Use build matrix
> - All dependencies are install by scripts
> - stop repeating environment variables
> - build failure's artifacts will be uploaded

I did not see any particular thing that is bad in any of the three
series involved; do people have further comments?

I am not exactly happy that these had to be queued on top of a merge
of two topics in flight, which makes it cumbersome to deal with a
breakage in these two other topics, though, but that would be a pain
only until these two topics prove to be stable enough to build on.

Judging from two CI runs for 'pu' ([*1*] and [*2*]), among the
topics that are cooking, there are only a few topics that these
tests are unhappy about.  Perhaps those on Windows can help these
topics to pass these tests?


[References]

*1* https://github.com/git/git/actions/runs/74687673 is 'pu' with
 all cooking topics.

*2* https://github.com/git/git/actions/runs/74741625 is 'pu' with
 some topics excluded.

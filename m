Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DAAC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiCASIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiCASHy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:07:54 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5353163BC9
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:07:13 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83B7D10F767;
        Tue,  1 Mar 2022 13:07:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/nzRUdRkv2Am
        znYIMhT/T79Bly+tjSy0RB8e4Xai2Qc=; b=pOo5R+UUmh8svHnF9BRiz8NJ5DCA
        Nd4HrybrdqP8yrrYjreMpY2uJTHHCVRfBCRWSrcQOFjSOnWqsg6uV6n1Rz8XRS6M
        XG5mFnXmN4/AYaygxmosS4Q+P0NslX8aYZamM2LPn/hcIjTlcf3zKW5uCPs7SjC8
        gr2FCh29oOVJXLM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ADA410F766;
        Tue,  1 Mar 2022 13:07:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C189110F765;
        Tue,  1 Mar 2022 13:07:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: ds/commit-graph-gen-v2-fixes (was Re: What's cooking in git.git
 (Feb 2022, #08; Mon, 28))
References: <xmqqmti9ssah.fsf@gitster.g>
        <a296c8fc-9701-15bd-4459-e49f157adb56@github.com>
Date:   Tue, 01 Mar 2022 10:07:10 -0800
In-Reply-To: <a296c8fc-9701-15bd-4459-e49f157adb56@github.com> (Derrick
        Stolee's message of "Tue, 1 Mar 2022 09:26:51 -0500")
Message-ID: <xmqqbkypr1gx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6ACEB676-998A-11EC-8B83-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/1/2022 8:42 AM, Junio C Hamano wrote:
>
>> * ds/commit-graph-gen-v2-fixes (2022-02-28) 4 commits
>>  - commit-graph: fix generation number v2 overflow values
>>  - commit-graph: start parsing generation v2 (again)
>>  - commit-graph: fix ordering bug in generation numbers
>>  - test-read-graph: include extra post-parse info
>>=20
>>  Fixes to the way generation number v2 in the commit-graph files are
>>  (not) handled.
>>=20
>>  Will merge to 'next'.
>>  source: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
>
> Please hold for a re-roll on this one. =C3=86var has some feedback

Thanks, will do.

> on these patches that merit a new version. His comments are
> mainly about test structure, but they will help get extra
> coverage in the 32-bit case.
>
> Patrick also had some concerns about upgrading from older,
> buggy versions of Git. I think this isn't an issue [1] because of
> how those older versions would ignore existing corrected
> commit dates, but it would be good to get a common understanding
> of the scenario before merging this.
>
> [1] https://lore.kernel.org/git/f50e74f0-9ffa-f4f2-4663-269801495ed3@gi=
thub.com/
>
> Thanks,
> -Stolee

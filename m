Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A76C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 04:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DEC61378
	for <git@archiver.kernel.org>; Thu,  6 May 2021 04:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhEFEaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 00:30:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50208 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhEFEai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 00:30:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E533D46EB;
        Thu,  6 May 2021 00:29:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KvRm9Xn8L+o2
        ZgT5bNR/XPHUNFID5D3z/jXBS70M29o=; b=EY6INeFRcHX6NBLdWlgrEWXmMzMi
        kiY+AnmuSosw39Bm1Qu+dWTdF+Se7xFl8A9CKdGOIbXTfJZ/7koYbZltEleb9QK9
        GuAuYtMDqcs2fBAKmmqogC7fnS1d4JwIr2MQcYTACcmwvJWMbFrrU/c2OoZjR6qu
        qRHQwGOVSt2aOAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06D58D46EA;
        Thu,  6 May 2021 00:29:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84709D46E9;
        Thu,  6 May 2021 00:29:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
References: <xmqqr1itfo41.fsf@gitster.g> <87im44xerh.fsf@evledraar.gmail.com>
        <xmqqeeepbpig.fsf@gitster.g>
Date:   Thu, 06 May 2021 13:29:38 +0900
In-Reply-To: <xmqqeeepbpig.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        02 May 2021 15:47:51 +0900")
Message-ID: <xmqqsg30zdql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABDFFEF2-AE23-11EB-B452-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> * ab/test-lib-updates (2021-04-29) 11 commits
>>>  - test-lib: split up and deprecate test_create_repo()
>>>  - test-lib: do not show advice about init.defaultBranch under --verb=
ose
>>>  - test-lib: reformat argument list in test_create_repo()
>>>  - submodule tests: use symbolic-ref --short to discover branch name
>>>  - test-lib functions: add --printf option to test_commit
>>>  - describe tests: convert setup to use test_commit
>>>  - test-lib functions: add an --annotated option to "test_commit"
>>>  - test-lib-functions: document test_commit --no-tag
>>>  - test-lib-functions: reword "test_commit --append" docs
>>>  - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>>>  - test-lib: bring $remove_trash out of retirement
>>>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>>>
>>>  Test clean-up.
>>>
>>>  Waiting for an Ack before merging them to 'next'.
>>
>> Is the ack a reply to
>> https://lore.kernel.org/git/xmqqo8dx7dv4.fsf@gitster.g/ (or here, I
>> suppose)?. Sorry about the in-flight hassle.
>
> No, what I meant was that v4 had review comments and v5 was done in
> response to that, so I wanted to make sure that reviewers are happy
> with the delta between v4 and v5 before taking v5 and declaring it
> good just by myself.

... and this hasn't happened yet.  Can you ping them yourself,
please (distributed processing at work ;-)?

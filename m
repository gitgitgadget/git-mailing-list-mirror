Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2710EC433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF03261358
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhEBGst (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 02:48:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54716 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBGss (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 02:48:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A339F1346D0;
        Sun,  2 May 2021 02:47:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x9pdLrjhfPcl
        KEvYUX5CUNah/V/2++B6q9JdtefFqms=; b=sp6hRWqJGYJCHL4FPaQqabSR8gEs
        eF0OWbTXKal4DB+hgLDvgqbXwki6DLqx/d394C8ST4zb+7rEPirU62MqPj24cbAV
        7vtPCXpQiJ8lBnAJtGUjfhOZ2hEELaF9idBj4jj/Opsg0NyOZ5qNbIF+mjouzgKi
        iTqeu4azLDdKobE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A1001346CF;
        Sun,  2 May 2021 02:47:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71E7F1346CD;
        Sun,  2 May 2021 02:47:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
References: <xmqqr1itfo41.fsf@gitster.g> <87im44xerh.fsf@evledraar.gmail.com>
Date:   Sun, 02 May 2021 15:47:51 +0900
In-Reply-To: <87im44xerh.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 30 Apr 2021 11:34:39 +0200")
Message-ID: <xmqqeeepbpig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51C8E7C6-AB12-11EB-AE97-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/test-lib-updates (2021-04-29) 11 commits
>>  - test-lib: split up and deprecate test_create_repo()
>>  - test-lib: do not show advice about init.defaultBranch under --verbo=
se
>>  - test-lib: reformat argument list in test_create_repo()
>>  - submodule tests: use symbolic-ref --short to discover branch name
>>  - test-lib functions: add --printf option to test_commit
>>  - describe tests: convert setup to use test_commit
>>  - test-lib functions: add an --annotated option to "test_commit"
>>  - test-lib-functions: document test_commit --no-tag
>>  - test-lib-functions: reword "test_commit --append" docs
>>  - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>>  - test-lib: bring $remove_trash out of retirement
>>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>>
>>  Test clean-up.
>>
>>  Waiting for an Ack before merging them to 'next'.
>
> Is the ack a reply to
> https://lore.kernel.org/git/xmqqo8dx7dv4.fsf@gitster.g/ (or here, I
> suppose)?. Sorry about the in-flight hassle.

No, what I meant was that v4 had review comments and v5 was done in
response to that, so I wanted to make sure that reviewers are happy
with the delta between v4 and v5 before taking v5 and declaring it
good just by myself.


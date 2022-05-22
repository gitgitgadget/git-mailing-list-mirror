Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B657C433F5
	for <git@archiver.kernel.org>; Sun, 22 May 2022 23:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiEVX1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 19:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiEVX1i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 19:27:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498B387A2
        for <git@vger.kernel.org>; Sun, 22 May 2022 16:27:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 679BC135F9E;
        Sun, 22 May 2022 19:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9/V4m5Or//GA
        Nx/P5FFK9DprfLlXDhcV5yv8fhBgrEg=; b=lDsKybrBeBBNAsUKNPJzs/v5LF83
        vdYEJz6gsNZaSAo54+TgXvYpiOclawjR5kQ23jSfWMdnxfNcJiIv7NLIF5YRaI3G
        SYEGoOXglfc/GX/nsE0g/R1s9vS5s8bbyPEGD5JNe7eV3X5/2Sg80cICYS3VB1eu
        Hsx8ZQG/kU8QkPw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EE86135F9D;
        Sun, 22 May 2022 19:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C77C9135F9C;
        Sun, 22 May 2022 19:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
        <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
        <xmqq35h2cwrm.fsf@gitster.g>
Date:   Sun, 22 May 2022 16:27:34 -0700
In-Reply-To: <xmqq35h2cwrm.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        21 May 2022 16:05:01 -0700")
Message-ID: <xmqqee0l9mhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3173C90-DA26-11EC-A807-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Which makes a great guinea pig for the CI output improvement topic.
>
> So, I created two variants of 'seen' with this linux-leaks breakage.
> One is with the js/ci-github-workflow-markup topic on this thread.
> The other one is with the ab/ci-github-workflow-markup topic (which
> uses a preliminary clean-up ab/ci-setup-simplify topic as its base).
> They should show the identical test results and failures.

The two runs to look at have been updated.

 - The one with =C3=86var's change was missing the primary "workflow
   markup" topic (it only had preliminary clean-up topic), so it is
   not a fair feature-to-feature comparison to begin with.

 - The other one with Johannes's change was done with the version
   before the latest round from yesterday, which has improvements.

With all the other in-flight topics (including the one that shows
failures in linux-leaks job) merged to the same base in the same
order, I prepared two variants of 'seen' that resulted in these
logs:

 - https://github.com/git/git/runs/6546816978
 - https://github.com/git/git/runs/6546750379

One is with both of the required topics from =C3=86var (with a fix-up [*]=
),
and the other is with the latest from Johannes's series.

I do not want to taint other folks' eyes with my observations, so I'd
send my impression in a separate message as a response to this
message after waiting for some time.

Thanks.

[Footnote]

* 76253615 (ci: optionally mark up output in the GitHub workflow,
  2022-04-21) added references to ci/print-test-failures.sh and
  ci/print-test-failures-github.sh to the workflow file, while the
  latter script does not exist, but it appears that these references
  want to run the same script, so I've made a stupid and obvious
  fix-up today before pushing the result of merging all out.

  This prevented "make test || ci/print-test-failures.sh" from
  running correctly [*], ever since 76253615 (ci: optionally mark up
  output in the GitHub workflow, 2022-04-21) was queued, and it
  seems that nobody noticed nor complained.  Sigh.

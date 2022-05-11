Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E321C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 21:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiEKVax (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiEKVaw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 17:30:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99EA2AC71
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:30:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B2981108EB;
        Wed, 11 May 2022 17:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VYGvL86vN+aB0Qd71NY8pXo38jW/qgc9A1X4ro
        qZYIM=; b=dl7jQih1nlYQfJaPUGlFKRJOjVc8w+Kk1bDjWiJyawOASdLBnabFm4
        ffaSMnGUSJshH9EwCoav+yaMpFhJk+h4TQf73PR8uq/U7Xpr0zr4aEMXVjx3Ib1Q
        JNvP+1iLNyv59GgOv0Dsux9ggRqcx5PdfC6uvS1ezdBkakVHaUo3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 322E71108EA;
        Wed, 11 May 2022 17:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F5C11108E9;
        Wed, 11 May 2022 17:30:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 1/5] MyFirstContribution: add "Anatomy of a Patch
 Series" section
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
        <YntVo0G8G2mQYCLZ@debian.me>
Date:   Wed, 11 May 2022 14:30:47 -0700
In-Reply-To: <YntVo0G8G2mQYCLZ@debian.me> (Bagas Sanjaya's message of "Wed, 11
        May 2022 13:20:19 +0700")
Message-ID: <xmqqh75viwoo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FEA220E-D171-11EC-B501-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Wed, May 11, 2022 at 01:47:30AM +0000, Philippe Blain via GitGitGadget wrote:
>> +We can note a few things:
>> +
>> +- Each commit is sent as a separate email, with the commit message title as
>> +  subject, prefixed with "[PATCH _i_/_n_]" for the _i_-th commit of an
>> +  _n_-commit series.
>> +- Each patch is sent as a reply to an introductory email called the _cover
>> +  letter_ of the series, prefixed "[PATCH 0/_n_]".
>> +- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
>> +  v3]", etc. and sent with a new cover letter, itself a reply to the cover
>> +  letter of the previous iteration (more on that below).
>> +
>> +At this point the tutorial diverges, in order to demonstrate two
>>  different methods of formatting your patchset and getting it reviewed.
>>
>
> In case of single-patch series submissions, the anatomy is simple: first
> the email subject is commit message title prefixed with "[PATCH]" or
> "[PATCH v_n_]" (in case of n-th iteration), then commit message and the
> actual diff.

Correct.  There is no single-patch topic in the summary view shown
in the document, so it does not belong to the above "We can note a
few things" list.  But I agree that there should be a mention for a
single-patch topic somewhere in this document, both for a patch and
(the usual lack of) cover-letter for such a topic.

The sample topic this tutorial uses is a multi-patch series and
everything in the document revolves around handing a multi-patch
series, so finding a good place to fit it may be a bit tricky,
though.

> Regarding n-th iteration series, sometimes it is desirable to break the
> threading so that the original thread (of previous iterations) doesn't
> get too long, by sending the series as completely new thread. Some
> contributors (including myself) prefer that way. In that case, the link
> to previous iteration is provided to aid reviewers.

This is often not very friendly to reviewers, unless the "new topic"
is so different that it is almost totally unrelated to the old one.

Even in a "in earlier round, we perceived X as a problem and tried
to solve it, but it turns out it is better to solve Y instead" case,
it often helps to learn the reason why we ended up not addressing X
after you use "git blame" to find a commit that solved Y in a later
iteration and wonder why an approach to solve X was not taken.  It
is a very good idea to mention the need to add a link to a previous
thread if the submitter decides to break the thread.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B27EB64DC
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 23:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjFVXNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 19:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjFVXNU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 19:13:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26DD1992
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 16:13:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D9A18816D;
        Thu, 22 Jun 2023 19:13:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+wVztWItKNgBCVzqq/MhkWP3p2PCUkhglk11df
        AUYKk=; b=ceTD8n1EVkvHP2VVJ1I5BkipSwdDxaofO4mNGiTSANgCn5btKj/x2F
        OWSi4C/Uffe/9BMksFI6vQC7HSe+GQTPO/fgq6KUrY86aosqLYPmYkFeZ6ctZ3rq
        3/Q69W9mqwj1kkfZP+XvCTBNkU6xZtHK3cykvtPbnFc4GdWcj3z/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D36518816C;
        Thu, 22 Jun 2023 19:13:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93DFA188169;
        Thu, 22 Jun 2023 19:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] docs: add git-hash-object -t option's possible values
References: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
        <ZJRAsU6LfSwFIdbw@nand.local>
Date:   Thu, 22 Jun 2023 16:13:16 -0700
In-Reply-To: <ZJRAsU6LfSwFIdbw@nand.local> (Taylor Blau's message of "Thu, 22
        Jun 2023 08:38:28 -0400")
Message-ID: <xmqqfs6jccqb.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F23050C-1152-11EE-A994-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jun 22, 2023 at 12:46:34AM +0000, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>>
>> For newer users of Git, the possible values of -t in git-hash-object may
>> not be apparent. In fact the current verbiage under NAME could
>> lead one to conclude that git-hash-object(1) can only be used to create
>> blobs.

While I do not oppose to the patch text that lists four object types
explicitly, I am not sure if the above is a reasonable justification
to do so.

I think the phrase "default:" in front of explicit singling out of
"blob" in the description is sufficient to hint that "blob" is
merely one of the types it can create.  Also why do we expect that
newer users of Git would be playing with hash-object before even
learning there are other three types (or only after reading the
one-line summary without description)?  It almost smells like asking
for trouble.

Verbiage refers to uses of too many words or excessively technical
expressions.  I do not think a single-line summary of the command
qualifies for one.

So, I like the patch text, but not the way it is sold with its
proposed log message.

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B60CDB466
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 17:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjJKR3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjJKR3h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 13:29:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47888C4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:29:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D37CF30174;
        Wed, 11 Oct 2023 13:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=j5LwjYAs9f4ObMzrz6+b0TdHnAvHpcz+f6fpS+
        hKGgc=; b=gaQAHkGVi4dJobFyusUeG63rFlPErvb+1u2B+xIh0TjOYz9PLuv/Xk
        ZHueXUxOb79OJMh78sYvuJesR2BZcEsJ9nvvtbw/EYmicNFawDvO097K7VBsFbQS
        ji8+Ks1EHXVVFxUf62dbMn4v6juoOC0zth9SmRqZyfcjvLGdMNA7w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE58430173;
        Wed, 11 Oct 2023 13:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C30F830172;
        Wed, 11 Oct 2023 13:29:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isoken June Ibizugbe <isokenjune@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] branch.c: ammend error messages for die()
In-Reply-To: <20231011152424.6957-2-isokenjune@gmail.com> (Isoken June
        Ibizugbe's message of "Wed, 11 Oct 2023 16:24:20 +0100")
References: <20231011152424.6957-1-isokenjune@gmail.com>
        <20231011152424.6957-2-isokenjune@gmail.com>
Date:   Wed, 11 Oct 2023 10:29:29 -0700
Message-ID: <xmqqa5spm5ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC74BB64-685B-11EE-9871-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isoken June Ibizugbe <isokenjune@gmail.com> writes:

> Subject: Re: [PATCH 1/1] branch.c: ammend error messages for die()

"ammend" is misspelt, but more importantly, it has less information
contents than other possible phrases, e.g.,

  Subject: [PATCH 1/1] branch.c: adjust die() messages to coding guidelines

In any case, the title of a commit has insufficient space to
describe what the amendment is about, or which exact guideline
these messages violate and needs adjustment.  This space before your
sign-off is where you write it.

Other outreachy candidates have already been given pretty much the
same pieces of advice.  It may help candidates to learn from the
responses given to other candidates.  For example, I said the same
thing in https://lore.kernel.org/git/xmqqlecbzl5e.fsf@gitster.g/

> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
> ---
>  builtin/branch.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

Not a fault of this patch at all, but it is somewhat surprising that
we do not break any existing test with this many messages changed.
Did you run the test suite before making this commit?

Make it a habit to always do "make test" before committing your
work.  I am not saying "do not commit what does not pass the tests".
What I mean is "be aware of what is still broken (when fixing a bug)
or what you broke (when adding a new feature, perhaps as an
unintended side effect), before you commit, so that you can describe
them in your commit log message".

Thanks.

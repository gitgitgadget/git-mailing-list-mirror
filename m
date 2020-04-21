Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC165C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD292071C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xyvF7NfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgDUSAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:00:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62698 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUSAI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 14:00:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0F93528D4;
        Tue, 21 Apr 2020 14:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Zj7moQhTwiqCFMfOdS/pDcQ9vA=; b=xyvF7N
        fBXW7+3kwuw/FNrC3ldGfg4HF6ElxSTQxxI0094gwMThRQUe+4KJfelFdgw0B2Ub
        uRxJ8nq7cNYzsCI1SVzY+iXJGi83vP+wGt19/UPizzXE3RLSNmy4bvWuaBDo4odo
        j689MFXkw58rYndLi64/mnrdmLmEDSjO20Wvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uTqiz442NwSbilduGe1HW17PWXvph7hJ
        MA824jLepzGehntGY8GGySt/ZvYJroppwPoOxu/Kf6kTO1uxOQ2W+Bh0bKfmsJA4
        cQ7xj5laGt9fLEyKvxkQglXmrHAZo1jNVzP3GgyVroKIV4BdfCKbUOcLXeo23diS
        1yc9F7RHZu4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23876528D2;
        Tue, 21 Apr 2020 14:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA838528CB;
        Tue, 21 Apr 2020 14:00:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
        <20200413140918.4778-2-shouryashukla.oo@gmail.com>
        <xmqqsggxpseq.fsf@gitster.c.googlers.com>
        <20200421083820.GB11800@konoha>
Date:   Tue, 21 Apr 2020 11:00:00 -0700
In-Reply-To: <20200421083820.GB11800@konoha> (Shourya Shukla's message of
        "Tue, 21 Apr 2020 14:08:20 +0530")
Message-ID: <xmqqo8rkoh27.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECAE8930-83F9-11EA-96BC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> I thought it would be OK to describe a maybe *unorthodox* way to do
> this. I will remove it in the next version.

The thing is that it is not just unorthodox but it is wrong and
broken.

Imagine that your 'origin' fetches from upstream that is controlled
by me (e.g. at https://github.com/git/git/) and pushes to your
publishing repository controled by you.  After you fetch from me
after my 'master' branch advances, of course, remote/origin/master
would be updated in your repository.  When you work on your own
changes on your 'master' (perhaps you do "pull --rebase origin") and
push the result to your publishing repository, which you also call
'origin' because you configured the remotes in your "unorthodox"
way, the remote-tracking branch remotes/origin/master would also be
updated from your 'master' (i.e. we pretend that we fetched the
remote-tracking branches from the same remote immediately after we
pushed out).  But if you actually fetch from 'origin', I wouldn't
have your changes on my 'master' yet, and you won't be seeing your
commits in your remotes/origin/master.  

I.e. the "unorthodox" way breaks your remote-tracking branch, and
not recommendable for any usecase.

Having said all that, because this is a single-topic FAQ entry that
covers only the "remote", we should clarify the existing description
in Documentation/git-remote.txt and also possibly config variables
the subsystem uses so that anything readers would learn by
understanding these three bullet points we just discussed are
covered there.  And then have a small paragraph that has only the
question and "see that section on that manual page" reference, and
no duplicated explanation, in the FAQ file.


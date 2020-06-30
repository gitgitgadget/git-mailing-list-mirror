Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C11C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 23:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56FC2073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 23:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LaplAmWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgF3X6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:58:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3X6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 19:58:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 373377EECA;
        Tue, 30 Jun 2020 19:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lDBHDmS9UQk6U/5PvtDSfC/xst0=; b=LaplAm
        Wy+oIODwm4GUUj0sDmsbx0KULFtZ+EBGe2xkklHISA6uIfpkJZ5H0Xc95JNCaVjw
        gmsIoDq67mzFc0eJ26swBGh/zBNrNCJJwHmpFUnxRKVPqJgCAZlIh3MjrS4KsDpp
        2uJ8NEX+XThivYyn0jcfB4kGfDBbLJKuJZPfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BRtDPPt9eNaN2y/g5ubB8R4JRE1yxiV/
        2rYqhQosk5dWEQ3SfZXGUUGtLOIFq29MS4S9v+a4RoqNDWv01larFd16GmQKofou
        JwgsMiXtAFyJ802j+lLAlBpn78z5GY9hhclZ8RU9yuvz260OpxCimb/0W1hR2v1A
        NGEF9GfmjbM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F6F47EEC9;
        Tue, 30 Jun 2020 19:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD3527EEC8;
        Tue, 30 Jun 2020 19:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v19 03/20] checkout: add '\n' to reflog message
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <125695ce92218ca2ddb9868880db542acb0d2a79.1593457018.git.gitgitgadget@gmail.com>
        <xmqqmu4lfxet.fsf@gitster.c.googlers.com>
        <CAFQ2z_MuD0e+a_r0_-GMpjr1mV==hdh2=0gyVrT7f8tDbXC6xQ@mail.gmail.com>
Date:   Tue, 30 Jun 2020 16:58:37 -0700
In-Reply-To: <CAFQ2z_MuD0e+a_r0_-GMpjr1mV==hdh2=0gyVrT7f8tDbXC6xQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 30 Jun 2020 10:30:23 +0200")
Message-ID: <xmqqftacds2a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D6C0BB6-BB2D-11EA-BE33-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Most places that write a reflog message use a message that ends with '\n'.
>
> Some places (the one mentioned here) do not append a '\n'.

Just to make sure I am following, I see

	if (update_ref("initial pull", "HEAD", merge_head, ...

in bultin/pull.c; this is supposed to be written with "\n" under the
new world order?

As reflog messages are supposed to be a single liner (due to the
nature of the original storage format), I have a feeling that it is
cumbersome to the programmers to requre "\n" at the end.  It would
not add much value to the readability of the resulting code, either.

If the places that have hardcoded messages like the above have to be
written like so:

	if (update_ref("initial pull\n", "HEAD", merge_head, ...

it makes the code worse.

Let's see if I can come up with a coherent "rule" that we can follow
to improve the current situation that is an undisciplined mixture as
you found out.

    ... goes and looks the current code ...

So, what happens is that update->msg in each ref transaction (in
refs.c::ref_transaction_add_update()) gets verbatim copy of what the
caller gives the refs API, but when it is written out as an reflog
entry, the message is cleansed by calling refs.c::copy_reflog_msg()
that squashes a run of whitespaces (not just SP but including LF and
HT) into a single SP and then trims whitespaces at the end.  

Then to the result, a LF is unconditionally added.

I would consider the massaging of the application-supplied message
done in copy_reflog_msg() as normalization, which turns possibly
invalid data (like a message that has LF anywhere in it) into an
acceptable form.  Which defines the kosher form of a reflog message
as not having any LF (or excess SP) in it, and the terminating LF is
not part of the message.  From that point of view, if we were to do
something, I would rather standardize on not having the final (and
only) LF.

But some callers that prepare a message in a string buffer may find
it easier not having to strip the trailing LF, or even depend on the
fact that they can feed a string split into multiple lines and the
result becomes a single line.  So I do not see a point in "fixing"
the existing callers that gives an extra LF at the end or other
not-so-kosher form of data---these will be normalized by calling
copy_reflog_msg() anyway.  

If they are easy to fix, like sending a constant string with LF at
the end, we would want to fix them to improve the readability of the
resulting code, though.  If the update_ref() call in builtin/pull.c
were sending "initial pull\n" as its first parameter, it would be
worth fixing by removing the LF, as the result would be easier to
read and it is not too much work.  On the other hand, if the message
that eventually becomes a reflog entry comes from outside and if the
existing code relies on the sanitizing done by copy_reflog_msg(), I
do not see a point in carefully removing the LF at the end on the
caller's side, either.

> I initially thought we could or should fix this across git-core, but I
> think it will be a lot of work to find all occurrences.

I think we are on the same page, even if the definition of which is
correct might be different between us.  As long as all the refs
backend does the same sanitizing (which is probably easy---just call
copy_reflog_msg() from them, or perhaps we may want to move the call
to where update->msg are queued for each step in a transaction,
which would relieve individual backends from having to worry about
this issue at all), they would all behave the same for the same
reflog data.

Thanks.


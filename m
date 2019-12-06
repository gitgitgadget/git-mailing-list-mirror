Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37521C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D788020659
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e8IlB8ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLFQ1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:27:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59300 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLFQ1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:27:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B34E3A0E2F;
        Fri,  6 Dec 2019 11:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+wHS50Cf3SqL
        q5BA6wJImMFOxHo=; b=e8IlB8ejKx17IsuP+owe4KD99rO6ruyvQSf1dDEqPLJA
        3MPfw/jdQZZ/0VfD0+47eqH8Ts7eaCGc4CoGgx/3PxWLrDd7ULlVoQq6ZMvhJs16
        Rdka4letFk6e5oV5AmUPi5CMFyWNs1FrH0QAO12dnPMz60F29hTA05DLHo/XlJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Oa9xl1
        rp4tLNRwE8LO8iy7Mwqp7yZomiqL1DVWA9RVRHUATcgYrTnHZtGh9ThXHuR8jSfb
        Ls3DtRGUEVsQhckUvYRe17o20QYSrCJ1GM3z+ANU3/wy3o4I/IJFR4L5yop+ULUN
        B5A029mWbgW4fG888N27UClnlqgNsBKpWI1so=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABB9FA0E2E;
        Fri,  6 Dec 2019 11:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2DB1A0E2D;
        Fri,  6 Dec 2019 11:27:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: es/pathspec-f-f-grep, was Re: am/pathspec-f-f-checkout
References: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1912061618440.31080@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1912061622220.31080@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Dec 2019 08:27:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1912061622220.31080@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 6 Dec 2019 16:23:03 +0100
        (CET)")
Message-ID: <xmqqeexhxvv3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CD0E3B0-1845-11EA-A930-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Oops, I was talking about `es/pathspec-f-f-grep`, not about
> `am/pathspec-f-f-checkout`, sorry for the mixup.

Thanks.  Yup, these uninitialized variables give a sign of
carelessness.  Will put on hold.

> On Fri, 6 Dec 2019, Johannes Schindelin wrote:
>
>> Hi Junio & Emily,
>>
>> On Thu, 5 Dec 2019, Junio C Hamano wrote:
>>
>> > * am/pathspec-f-f-checkout (2019-12-04) 7 commits
>> >  - checkout, restore: support the --pathspec-from-file option
>> >  - doc: restore: synchronize <pathspec> description
>> >  - doc: checkout: synchronize <pathspec> description
>> >  - doc: checkout: fix broken text reference
>> >  - doc: checkout: remove duplicate synopsis
>> >  - add: support the --pathspec-from-file option
>> >  - cmd_add: prepare for next patch
>> >  (this branch uses am/pathspec-from-file; is tangled with es/pathspe=
c-f-f-grep.)
>> >
>> >  A few more commands learned the "--pathspec-from-file" command line
>> >  option.
>> >
>> >  Will merge to 'next'.
>>
>> G=C3=A1bor noticed that this breaks Travis, and I provided a patch tha=
t
>> initializes those new variables. Please squash that in before merging =
to
>> `next`.
>>
>> Thanks,
>> Dscho

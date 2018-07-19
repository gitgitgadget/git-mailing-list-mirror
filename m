Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFC81F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeGSRuk (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:50:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51473 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731442AbeGSRuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:50:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id h3-v6so6501374wmb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+zADDSjY+P9arq122/eJ6V7Z5HDCdr/pUAnmJU41Gfo=;
        b=IJh1y7E9MPVW1WgVJaAvdeTnk00tdkHiyxrvkDk5rEMhZyy17+bZUI7S/LWjZtC2Qm
         oKT4KTI6/1miDW4B4RNMFlkk3VDVxiadwUecK1W8IXQz8rB4NGgj0BNQta9r3duMQhY2
         B2GZSpO55L4He8WaoR1776XnMjLbjylCeLw5FHRwZKX17xnWi/Qx33zOqY66t7XIJGmv
         WWmCFxtymFfa/u0FJShD61oWePyEAs9Jn2eQhiGl3qNEDNRymkBCDkoHK96RISoKt+sR
         XrsF5Pl6mpJbJylGeWR7kmHHnAjm5JncnPk9vqRuKjB1eXV+1vDbMiExYpybWUBF8YIj
         3sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+zADDSjY+P9arq122/eJ6V7Z5HDCdr/pUAnmJU41Gfo=;
        b=bmIlJZc7J3Ldb4fIw84x0tWesqlWx/8BTgf5z+EMs3rbiCuNkgcv9cTLruZ/7zM/H0
         7Hazp03Erutdn1WeeyUg7tDkBtT/lRk1qeNgVsUm8Y5+j3vqibJxiAo3hoTXKzyOoALC
         Q65u535ebziSEQD2BXmRWKCq8QXZeDn5/FWAS0gxPpNTjOrY5f9Sp59Lrm4zmyrkNI9H
         UZdg0QnPBJCWXRGmX6bDCK7w3GTlMzYIyZRepviyOMoeVpaM90AnIftcVHmmCv1bKsu2
         +lpMr4NGH2/FsIzsI0s8Wjv0yZbWkTbBIa9OMv1qZdWVJTnSS2N+Uw6eDECcjMDA+M4C
         BOdA==
X-Gm-Message-State: AOUpUlHU2fO74WA3C8qh5BzipZrNG7Lk7jQvLnS2EEBQNu+xhxKIPOuw
        +bnx8jZoSOZhUH5CyeZjG0BAjKem
X-Google-Smtp-Source: AAOMgpcTdYRztc6BQc4zZJ6kLGUszBywLwbL6aT6z6lDMy43DyEV54sIkw+xarFjUi+1I+uOV62bAw==
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr4467506wme.135.1532019994240;
        Thu, 19 Jul 2018 10:06:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t13-v6sm7717055wrr.74.2018.07.19.10.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 10:06:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
        <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
        <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
        <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Jul 2018 10:06:32 -0700
In-Reply-To: <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 12 Jul 2018 09:59:36 -0700")
Message-ID: <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> I would like to ask you to reinstate the post-rewrite hook, as it still
>> improves the situation over the current one.
>
> Without post-rewrite I seem to be getting correct amlog entries for
> commits created by "git rebase"; do our rebase--am backend still
> trigger post-applypatch hook in its "am" phase to apply the patches
> created with "format-patch"?

That was a wrong line of thought that led to a dead end.  format-patch
won't recreate Message-Id to its output from notes/amlog, so even if
the "format-patch --stdout | am" pipeline inside rebase-am triggered
the post-applypatch hook, it would not have a chance to carry the
notes forward that way.

What was really happening was I have

	$ git config --list | grep amlog
	notes.rewriteref=refs/notes/amlog

and that ought to be sufficient to carry "commit-to-original-msg-id"
entries across rebases.  And it seems to correctly work.  I however
suspect that "cherry-pick A..B" may lose the notes, but I haven't
checked.





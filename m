Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB916208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeHFRVh (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:21:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40560 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHFRVh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:21:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so12722324wrs.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E3SRk83F+YFj82FfT+8EGcMxTqa9kuWWDXEztzE0Aic=;
        b=Gaeq9KEfd9HvaShPLGLgWDNCGG666vCH15V10/+I3z3ovsaDvdq9JUVLx6kdAsXYra
         OCGMfbUziRp7CQpSYlx54+qCThUqNry0T6ubzViiUQFyKDGpLIpHV/K5YRexdj396OjR
         qU7RCcOHu+z3Tw50t4asYCmNP5DMz0wTrL05alFk0uKMfH6ZYn8+Hau3UR10SKUI70XD
         /PVM/7iUXW9/eM1hQj9WAzfT4Z0V/aOg2vC9nAEr9vOtCUfecTOXHlfyZqNueDI5Mz+8
         WO4m7Wr8FuQqWYzr0Mj5PbAwBJNtcfRgqml88F8BNSArTtQz+N1EkAC51Jq0AGmw9wRY
         qUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E3SRk83F+YFj82FfT+8EGcMxTqa9kuWWDXEztzE0Aic=;
        b=Of6xxXor729sHP/v5rPzL+JxlZAmwJl9fIbvVCyN+N8R726AO9RgBrRYtQoWE+VbW7
         jFPSayrIesc7zrZ5nCB3tnC5I/cBrzZHgVriB1FSPcxxRgBAeoJFHAKycKKbVqG13yC+
         9tX+Fa+qyJgYL0n6qsTLYlj66ZAXhfnPs7hXfORP2VS2/x7OUTd1RXDfZPDEzYLNILZa
         rHNlK3TafCBUdqWVmJWYr8+VakioUzPf/SZReZAM6JfYSJtBOF0e2xTOzkf+EIZbSgTE
         q6PGiI1sq/3D/WlAY+nfY3LijLYYELveXzB7d/+2+HTiv7K/LpdpzwSXzCU7FE5gsBME
         2+Ew==
X-Gm-Message-State: AOUpUlHV8kPrFj8EMbxyrfDiwg8gv4o9mePNf3cV8SP6MgBCyk4pv8kI
        /nG8bvSEVpMhJbq23kEck1E=
X-Google-Smtp-Source: AAOMgpfXAQaRdH6ZKlZI4/VNUe9rZsaqCyVZUTsuSSc/iBtiAvtSVMmvCznlhlbvCce4pVzgjjLe2w==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr10338463wrq.156.1533568323033;
        Mon, 06 Aug 2018 08:12:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t186-v6sm11976382wmf.14.2018.08.06.08.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:12:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase --exec: make it work with --rebase-merges
References: <pull.13.git.gitgitgadget@gmail.com>
        <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com>
        <xmqq1sbfxq1x.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808061136180.71@tvgsbejvaqbjf.bet>
Date:   Mon, 06 Aug 2018 08:12:01 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808061136180.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 6 Aug 2018 11:50:51 +0200 (DST)")
Message-ID: <xmqqlg9jr0la.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If we ever see a todo-list without any pick/merge, then insert_final
>> is still 1 when we leave the loop and we will add one single exec at
>> the end.  Which may or may not make sense---I dunno, as I do not
>> offhand think of a reason why the user would give us such a sequence
>> in the first place, so it probably may not matter in practice.
>
> Think of the `noop` command. It was introduced specifically to allow
> rebasing patches interactively to an upstream that already applied the
> local patches. In that case, an `--exec` should still run at least once,
> to avoid negative surprises.

Ah, yes, it probably makes sense when you have `noop`; even if there
is no picks and merges that change the history from previous state
(which presumably matches the state the user started running the
current "rebase -i" session), after the whole sequence you would
want run it one iteration.

In any case, if the current code without this change works like so,
there is no point in redesigning that part of the semantics at all.

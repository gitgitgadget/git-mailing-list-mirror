Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AB020A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 03:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeLKDoH (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 22:44:07 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38200 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbeLKDoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 22:44:06 -0500
Received: by mail-wr1-f45.google.com with SMTP id v13so12592242wrw.5
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 19:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f0chhTEdaDlvsrNWEdvWugN33TQMEITHfW4Gw8pybJg=;
        b=nm7zILg1H16ypGWmLi+gh0lbUYoYwPjqxdEBi4bPSfBzlzRuq8/pS5S8jR8V6aQb/I
         jeAX7Nl+/zbQHGn54jZexF+ct7/9V9/Cx8cJEZEIvnReKNMfiHvlWVovp93bruyV8NeX
         gkk1lfd7/wgVveWUCk8fckqeauxmu5nHdRaSpOEh/QxywvvmvKZYu11djb1Y9LQa/7b1
         JLdTepni9lOcVSSqJt0hlQJD895j44BZVy9dS7FjOVqN1h5AKoRWYp76uEGwlGrD2B/W
         YpM5uJwhAL2C/xgAFNAr5ZZrh8Fe52/A3mYYKmKA62VTtDIIBbxYDX8Eit7v7spVh0ZJ
         eB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f0chhTEdaDlvsrNWEdvWugN33TQMEITHfW4Gw8pybJg=;
        b=qVDJfd8JjFbZfJgEQyAy0VFOz9lYw5eGGflbQCAjWYft6N2AnKcAgd7YJ/yjAfCb6R
         rR1hLWXGeuXqgKbby0O4qvIhy6MplbCKzkChWNhGKQFFGMy7hlmC02fgCNvDUwTJAevl
         9vdbeECsCKkEsfh1I+ZdIomnIFyjWoxAsHaAvz9qEpdM2YiQsTAtEtA/sz1c/RAYi3wI
         swX9ILKLMqrzyj7lgSefNhRwcN2zFYHGvNgUTIJ466G2c9YEU08XmbCLZSCHPCSADMvS
         MvmfgCSFtVsTkTkLlhMdaDraz7O9B4yXpv8bsXuApEqeeDTntp94Nv1io1PdUv24VC54
         713g==
X-Gm-Message-State: AA+aEWZilj5+/KB72XZ2TQirTrCG8DmVcf9smj8Tac3qtKxIxBuUze87
        3BkH7kw9U05JjT2AqMvOx90=
X-Google-Smtp-Source: AFSGD/XPTouD4hpLcmdeyfm1YnGwsyLa1A5R6zS+DELv9n9ggRiuiPiC7ENQAmcoOfGVXBRsmWn7fQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr11442816wrm.328.1544499844703;
        Mon, 10 Dec 2018 19:44:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h16sm37736267wrb.62.2018.12.10.19.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 19:44:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: silent_exec_failure when calling gpg
References: <CAJdN7Kj5RaAsTstx_G14a_bR5Y92M3rtWAiMNPnQWgmz4JgEOg@mail.gmail.com>
Date:   Tue, 11 Dec 2018 12:44:03 +0900
In-Reply-To: <CAJdN7Kj5RaAsTstx_G14a_bR5Y92M3rtWAiMNPnQWgmz4JgEOg@mail.gmail.com>
        (John Passaro's message of "Mon, 10 Dec 2018 17:32:18 -0500")
Message-ID: <xmqqlg4wlocc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Passaro <john.a.passaro@gmail.com> writes:

> I've noticed that in v2.19.1, when using git to pretty print
> information about the signature, if git cannot find gpg (e.g. "git
> config gpg.program nogpg"), it prints an error to stderr:
>
> $ git show -s --pretty=%G?
> fatal: cannot run nogpg: No such file or directory
> N
>
> When I build from master, that no longer happens:
>
> $ ../git/git show -s --pretty=%G?
> N
>
> Is this intentional behavior, i.e. something I can count on being the
> case in future releases? Or should I treat this as a bug report?

In general, behaviour of Porcelain commands like "git show" can and
will be changed to match interactive use by humans, and should never
be relied on in your scripts.

Having said that, I think we did not mean to kill the diagnositic
message.

> This behavior makes sense in a lot of ways. If you're interested in
> verifying commit signatures, it's hard to imagine needing a reminder
> to install the program it depends on (though the error might help you
> identify bad configuration for "gpg.program").

Quite the contrary, from a single "N", you cannot immediately tell
if the commit is not signed, if your GPG is misconfigured, or if you
have a stray gpg.program that points at nowhere.

I think the uninteded behaviour change was in 17809a98 ("Merge
branch 'jk/run-command-notdot'", 2018-10-30).

Thanks for a report.

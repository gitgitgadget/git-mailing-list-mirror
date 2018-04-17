Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 101AD1F424
	for <e@80x24.org>; Tue, 17 Apr 2018 08:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeDQIpi (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 04:45:38 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:40581 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeDQIph (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 04:45:37 -0400
Received: by mail-wr0-f169.google.com with SMTP id v60so29245114wrc.7
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N3T0RLmDS63np0raLk3uAwZoHaWoXV+hE+I8o0WfIPU=;
        b=JIVD+KmFrYmUzfxESmFqcMKTmMVcCAJvNddRsdx+xanAOj+tUztQZ3oJVW0vD+EWbg
         R2Fc1jSptV3S1BjyM3+sBpMoedzQWLhsidLt2CzvXZDMNaMFxz7ew9VFuVBHSnpmnXN7
         K9HFHMlHKHXqNlGa3WcluPii+UI2CJU6+BsWbLTpauOqk6h1sdPlJwF+ek1/ErtGgYTI
         2P+iZV7F+VEP9ABS6rKiIHaBpRzV5xB+pJtrFuz5F7K/zfNdUJTJXQHtw0/Y7gYB+tZY
         9vraIyc4/E/HDPiOPb2yxYusxlVBm+Ke4fZvR0Ls4vHgGvjbpPkXXE3BpXI951Dzhscv
         VRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N3T0RLmDS63np0raLk3uAwZoHaWoXV+hE+I8o0WfIPU=;
        b=RuNAfjw09fGODQV9E7hJ8XnDPgyBmOxTj2CjqPjPusS9g1v5suPPMTCBrNvQJaMMTP
         LpgmddRx5laBiMFoYVUXPAA7Th/fh5yx9X0T7uB0YJEurssmDY1fimynNVMl1aOHWQa8
         RuI4prDy4dhxUea5EbmWlSn7czbMt6ESN9f9oqGvTrWA7ZxlafCH+O/f1WWIkcRW+2YG
         wCBBeKS8ZkUQRpGoPUtrRrEJdfMYB+MFgv63r4+JtDfFi0QX4GeAMVWMw5gF9+LlFa+P
         qr1y3oNEgUX2p2EKpXvJvtxoJ/Vgvc/vujx6rTFA4EYQwqhqftY6CLm9Wdh4ZTI1vBhR
         BAiQ==
X-Gm-Message-State: ALQs6tC5jq1D6ycnHNLJWx0BKodiFL9pqfaZBtkt/IOTTG17nCiWoz1P
        0Ko+Y/yBPxfgaUEAQXfE88wPeluK/98=
X-Google-Smtp-Source: AIpwx48cNDNevMln7NTzoa4BJTPYd9gta0gej5MMHXvxFJ2UkRAnIbv9Z7Npz8fGa6HlPS0fJcd3eQ==
X-Received: by 10.28.135.9 with SMTP id j9mr318396wmd.68.1523954735617;
        Tue, 17 Apr 2018 01:45:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j89sm9908462wrj.86.2018.04.17.01.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 01:45:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Haralan Dobrev <harry@hkdobrev.com>
Cc:     git@vger.kernel.org
Subject: Re: git-checkout -B resets branch not showing last revision
References: <CANu1nimmRCkudQyW8fksg9LRu3tdoSV93S6PD7U_tJ82Vk4kZA@mail.gmail.com>
Date:   Tue, 17 Apr 2018 17:45:34 +0900
In-Reply-To: <CANu1nimmRCkudQyW8fksg9LRu3tdoSV93S6PD7U_tJ82Vk4kZA@mail.gmail.com>
        (Haralan Dobrev's message of "Tue, 17 Apr 2018 11:31:37 +0300")
Message-ID: <xmqqlgdmkyq9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Haralan Dobrev <harry@hkdobrev.com> writes:

> I recently had the following case:
>
> 1. I have a local branch called `foo` which I haven't checkout recently.
> 2. Due to a bad alias I ran the following command:
>
>     git-checkout -B foo
>
> This checked out and reset the foo branch. Which is according to the
> documentation.
> However, the output of the command does not show the previous state of
> the foo branch
> unlike what `git-reset --hard` does for some time.
>
> The previous revision is not present in the `reflog` either as I
> haven't checked it out.

A reflog entry is a record of Old and New object names, with
timestamp of the transition and a comment left by the tool.  You may
see only one record in "git reflog foo@{now}" output, but that
record actually knows both the new commit (i.e. the HEAD when you
ran "checkout -B") and the old one (i.e. the one you are asking to
know).  It is only the stupid "git reflog" output that only shows
the "new" side of the entry.

So if you do

	head -n1 .git/logs/refs/heads/foo

you'll find the "Old" state at the leftmost column.

I personally do not think it is a good remedy to add more cruft to
the output from checkout etc. like we do for "reset --hard" (if
anything, I think we should actually remove it from the latter, and
show it only asked for --verbose, or something).  These ephemeral
output messages can easily be missed and not get noticed until they
scroll away out of the terminal window.

Teaching "git reflog" to show one extra "fake" entry using the "Old"
side of the oldest reflog entry would be a much better solution.

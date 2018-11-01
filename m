Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC93E1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 23:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeKBI5l (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 04:57:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37318 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBI5k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so206245wru.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8c4d3Uz6hZMkPPLLc89jqJZ8ZpuBhJrWzCrhGQX9Jx8=;
        b=vaMHtSlEk+hrIqZ0BomNFsM1RbtJczlIVbJrm2WdRIzVxc0VX1UaoTp+A2gSA3Ro7F
         v7Du6eswnVdq2xi/v4nuj/ODBle151+5ZRfyYGnxaVt9p5gzBuPghv4Td+pq+ZV1o51g
         s6Hm3V3w9q9Xm7/CHd6z+clY7zckGV5FyuseiUv1MtPPBdS2aMYJm5yU9tl2e8ZovMrP
         118vlF6X4TQCszqD+X71AvS0cIWNDJ07S6RSz7etBCkeW56FXuKmVXXbTtN7Z/xV9lrx
         5ts2nl5F13BLu4sutxeWnk2sSgulk1FNm3g0ArMeU1DOTxJRm9kKEZ91PTMNaYAR/eqI
         p2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8c4d3Uz6hZMkPPLLc89jqJZ8ZpuBhJrWzCrhGQX9Jx8=;
        b=Muy8gB6pJUEQ9zfU0Zcmf/yHsgy61pN/r0r4a6aAKsN/5RYoiv+nadIQfjkqFeecI1
         HFy1yCiYY03Z+BkT8VAf05f57H5SptMBrt99H31uLl1yajau3jCcyx++GJJP/Z0G/e8N
         mcrqDKEQYMd4nQ8/runG9MmWeoyZ/i6C8SOrXpzWGjnPQVe+MKoq1P5Mt4CSZ1tN5Awb
         axH6j3DVvcfaSszPwOPDs4UWs3gyizIdFs4pi4M6wYH+ljZcuD/AY5YaGuILD7I/S/SC
         o5NtyKBAaWimZnjG2VDj878hQ/5eGhJFY9IhS/C4jYqrRAaKCambciQdN8mQVIy3lFKd
         N4fg==
X-Gm-Message-State: AGRZ1gLNVwfJMe9BxFSxkKKqPD/+lDZrPtaDGp1zvS2VAxe/VVYIwT8i
        luEa/9yFWRljZTFLrCOL21s=
X-Google-Smtp-Source: AJdET5cVuhMy+bezytVqLBDd2nalRHVzrXqs2c3lE5xTEUJndjTtiMjZuq9n4Mgp7+1fK3W9+PKS1Q==
X-Received: by 2002:adf:ab50:: with SMTP id r16-v6mr7803317wrc.62.1541116351969;
        Thu, 01 Nov 2018 16:52:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y4-v6sm13320575wrd.61.2018.11.01.16.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anmol Mago <anmolmago@gmail.com>, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
        <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
        <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
        <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AowaAW91wGMYbC8aTOB1NoqQN-5NGx=qUCHp0i6zQRDA@mail.gmail.com>
Date:   Fri, 02 Nov 2018 08:52:30 +0900
In-Reply-To: <CACsJy8AowaAW91wGMYbC8aTOB1NoqQN-5NGx=qUCHp0i6zQRDA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 1 Nov 2018 16:40:54 +0100")
Message-ID: <xmqqzhuss6dd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> > I have no comment about this. In an ideal world, sendemail.perl could
>> > be taught to support --git-completion-helper but I don't think my
>> > little remaining Perl knowledge (or time) is enough to do it. Perhaps
>> > this will do. I don't know.
>>
>> So "all", "attach", etc. are added to this list while these similar
>> options are lost from the other variable?  Is this a good trade-off?
>
> Not sure if I understand you correctly, but it looks to me that the
> options in git-send-email.perl are well organized, so we could...

Yes, but I wasn't commenting on your "sendemail should also be able
to help completion by supporting --completion-helper option" (I think
that is a sensible approach).  My comment was about Denton's patch,
which reduced the hard-coded list of format-patch options (i.e. the
first hunk) but had to add back many of them to send-email's
completion (i.e. the last hunk)---overall, it did not help reducing
the number of options hardcoded in the script.

If it makes sense to complete all options to format-patch to
send-email, then as you outlined, grabbing them out of format-patch
with the --completion-helper option at runtime, and using them to
complete both format-patch and send-email would be a good idea.  And
that should be doable even before send-email learns how to list its
supported options to help the completion.

> --git-completon-helper in that script to print all send-email specific
> options, then call "git format-patch --git-completion-helper" to add a
> bunch more. The options that are handled by setup_revisions() will
> have to be maintained manually here like $__git_format_patch_options
> and added on top in both _git_send_email () and _git_format_patch ().
>
> So, nothing option is lost and by the time setup_revisions() supports
> -git-completion-helper, we can get rid of the manual shell variable
> too. The downside is, lots of work, probably.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C5B1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 19:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfAVTHf (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 14:07:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37624 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfAVTHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 14:07:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so15339411wmd.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 11:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wPCs5u2ri+1kbgD4uYvnhfELiHc2QeIVW08AfYqZkEc=;
        b=IM9sn974Mi0O0pguxlmasRKH6PxVquOoizpzITUe1AIVaHQGmbT4DzJ04PpqmjVaIP
         2cIenpbn6GI0GAYdclQxjamPu38rk5Rhe6iOyU8h9Qu4g7GCY8ILNTcDJ6ps+mShYDq3
         jZ20utSDXE2z0EL0AsStmWt63WbJP42K8jeVEHMZ0IqeDssgm6WangFyyAGmrMQKlki3
         J8vzrN6ZrIb+PR/uwy2XisSpyBXuefWoPLNGJU/kxcj6kO8UiVANc25ipuid6yNBeotK
         MmLF8On4ijJpnMNuLFxcP+nGb/EeT+GfwTRBWNC1xeekSLnRsxMyAzmA5Z90ObuB2XRP
         RDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wPCs5u2ri+1kbgD4uYvnhfELiHc2QeIVW08AfYqZkEc=;
        b=ckpepjjFd7yxjStYbjwg8E9PhGSpirAkH3TDrl76AFC5TI1qQKKjMdWVzIR/7q4uL/
         1/qbK3lvgJc1Y7dXdXsjLetPJaTjCDyXwjx9wdj9gxiDhHSyDtE2fvAkaPB7DMa/lJF/
         ewXL6tcKX5D5F91wGMYcP1LtbxNSOnvMhWn6/xjk1vecTmSjML9o/INauDOxPMXI0oct
         EUDUupMb9IFG8VcxdVi9LSJgFjh9C8EbO8VoWVd3xYXjEeTxcMyXhIDPdrU89Bpni3aX
         6dJ894ztgLP3lNelko/xAu0fus1bt37lH0XzUU/AOywGqUNq9NqZhOEB+kjpLgqXqEe/
         V9yQ==
X-Gm-Message-State: AJcUukcNDU20PJVV6Gy21HDriawXmN4sy4aOntx0tIAXDXhqoN0jws0a
        7Ac/IFB9UHKnjIq3xdeZUss=
X-Google-Smtp-Source: ALg8bN5jmiKfn4Zq3W14K8mZ5TeUf+CupQcDny+EO408L3HpnYQ+zokQaPWGtgs9JHmE2I6CjsEAmw==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr4946138wmc.50.1548184053172;
        Tue, 22 Jan 2019 11:07:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a17sm90968467wrs.58.2019.01.22.11.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:07:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Brandon Richardson <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] commit-tree: add missing --gpg-sign flag
References: <20190119232334.31646-1-brandon1024.br@gmail.com>
        <20190119232334.31646-2-brandon1024.br@gmail.com>
        <CAN0heSr3a9H46j3wiTwwbw7HFh4+4aFs5-qe=gtxYB3vC73KAA@mail.gmail.com>
Date:   Tue, 22 Jan 2019 11:07:31 -0800
In-Reply-To: <CAN0heSr3a9H46j3wiTwwbw7HFh4+4aFs5-qe=gtxYB3vC73KAA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 20 Jan 2019 10:02:03
 +0100")
Message-ID: <xmqqzhrsfr4c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>> +       echo 11 | git commit-tree --gpg-sign HEAD^{tree} >oid &&
>> +       test_line_count = 1 oid &&
>> +       git tag eleventh-signed $(cat oid) &&
>> +...
> Let's see if there any opinions from others about this more verbose
> construction, vs placing the oid in a variable and quoting it. We
> obviously went several years without realizing that using $(...) as an
> object id risked falling back to HEAD and that a completely broken `git
> commit-tree -S` would pass the test. So being over-careful and extra
> obvious might very well be the right thing.

Sorry, but I am not sure what issue you are worried about.  If the
"commit-tree" command failed in this construct:

	oid=$(echo 11 | git commit-tree ...) &&
	git tag eleventh-signed "$oid"

wouldn't the &&-chain break after the assignment of an empty string
to oid, skip "git tag" and make the whole test fail, with or without
'$oid" fed to "git tag" quoted?  It is wrong not to quote "$oid" for
the "git tag" command (the test should not rely on the fact that the
object names given by "git commit-tree" have no $IFS in them), but
that is a separate issue.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB561F453
	for <e@80x24.org>; Tue, 23 Oct 2018 00:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJWIxY (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:53:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34466 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeJWIxY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:53:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so10366387wmf.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/VjQuShwDUqAC9c9DnqO+Nk98Z5EcUqN22phzGGZo8U=;
        b=piDNkFU7w1pusBNsn5EqIzYFAJvF4yH0c4+JykOA8csn4Lr6ajUaFoDzdrloxSg+XZ
         asfT87cHrN6hAv8/qBe/IT1DEbOzG1uBX/Kv7d40HjV4Zl2hMAs13U8nVU9zihTwM2vT
         qnFR4N0SPEXc1alKhVz54bOH4Rkg4RRjIL9s1hvF11JAvNcLDp5QtURiqLpNpYziVl4Q
         8BkBwmmD0aj+iIyREwF+uVMG0NMc88OIiNuDtmMld/KOZotDaUx+vIBV7Ra5gKCJjRBs
         UJk6cTs1Uwwj2i5fs92U+JKPStyliFxxSmVrI7dQ2vzNxEVNli9xNI9bZ0QsD01lCbOh
         hiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/VjQuShwDUqAC9c9DnqO+Nk98Z5EcUqN22phzGGZo8U=;
        b=AsleCAZptpyPJhS3FAN56gR8Nyys6erYskV+H23aibf1vv7I/9ERksRHyJc/7CVknU
         LUMdu8BNRA45ZrNru3/mY2H8szAQSXNhuHDYuLJBib+gepgiBPZTm0EaaHHxfGjaDNEZ
         wvjEZE0qVUAXIycgoaTXBk9QYwRP/7n1vdjbb0su7kci+RBggIuF9PMjRbW9VCz7Au/q
         Vav0ZWn3pqlDdIctmhpScsjQewK69f+gcnF1rl8Zs8Fz5gMhwNHUgsml7bvAfC0bMQ20
         of0Q5rMecsWB7Sut9CtxWp4ktpZvm8ZF5tn1nBPVuGlhBB61FdAeOyo3NvUS0f3BCaW5
         3JYg==
X-Gm-Message-State: AGRZ1gKiDdppBaxpzUQ0zGCzyS/YQ+0H3J5RyVj1PDzkxVahQmrLMkme
        QSzgg5HujkPVIX7iLPV1qZs=
X-Google-Smtp-Source: ACcGV61Xu8q87aGdYF66Ktj18AFsLVZmNxpA6HX47V7TZivJ5s546qwVtGSt0GZPPzv94P/nuvD4Ig==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr17566906wmd.90.1540254751828;
        Mon, 22 Oct 2018 17:32:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z4-v6sm1810763wrh.33.2018.10.22.17.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 17:32:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joshua Watt <jpewhacker@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: explicitly disable authentication
References: <20181018211527.25597-1-JPEWhacker@gmail.com>
        <20181022175248.3940-1-JPEWhacker@gmail.com>
Date:   Tue, 23 Oct 2018 09:32:30 +0900
In-Reply-To: <20181022175248.3940-1-JPEWhacker@gmail.com> (Joshua Watt's
        message of "Mon, 22 Oct 2018 12:52:48 -0500")
Message-ID: <xmqqd0s1tsdd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Watt <jpewhacker@gmail.com> writes:

> It can be necessary to disable SMTP authentication by a mechanism other
> than sendemail.smtpuser being undefined. For example, if the user has
> sendemail.smtpuser set globally but wants to disable authentication
> locally in one repository.

I wonder if it would be more productive to introduce a mechanism
that can be used to address that use case more directly.  For
example, would it help to teach "git send-email" that
sendemail.smtpuser set to a particular value (say '!', or empty
string if you prefer) is equivalent to the variable unset at all?


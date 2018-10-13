Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6304A1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 08:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeJMPj1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 11:39:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35911 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeJMPj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 11:39:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so15710249wrw.3
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=g4Kp11sVj0p5T+lSa2Ne39+33mnGCsgWif7RNQ2C5WA=;
        b=eRz/Ocsv996G4C72k4DEl/gFzrH5XlnAGRwvND6sURUV3YovOnsxU3igrrBcVmNaH0
         rEz/bzN2ehFkJcTaSepehgBcUiHNPZSnh4of+19WR/HfITkV5ZvJNp+c9adCUyFrlm5d
         xkxFMHSg10zulclFskjq69RcinPTvEudRO5pRSqj/J064QglMxjA7XIAL/+G8ZfxRHVQ
         mhD5EZnOxuA80Pgma+0Fdg03nMoytaXOWx55S/2qlYosXlfCfDe/yU/Ib8hYDKyH53B0
         RnlPR57htyIH8nN2iZeWbxXo4dNWHSSET9RGk6Ssa1tvYRpCd2I4uoAek4mg2pdG/3BC
         83AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=g4Kp11sVj0p5T+lSa2Ne39+33mnGCsgWif7RNQ2C5WA=;
        b=ppCasZ+Oa+CqX4q71DUtRf69nk0rzDkFBl7WhSVogk8io/yeAHLy894nVNlJLh5u6S
         KifkINoyshide2zTBBo4PTDXWbl7BP6Uwh6ACJzYoXma1NKVlNpoeXjXou9Evm+FLBq5
         HV7hhUUBRLgsvr3M6X7u/12YWHbMl32lqzHGYBVSsFUcgSgWvb1In+6xqbrtJbhGO5pS
         tENHzlNCUucr29ciwqCycmylF52g2gMlWkIJemx0eIa5gVtHFk11igCpBdQDMESp/fJp
         jDFjqaGKZ9VkMJI9olYlsQ5BGmY6jySwVk/R3+ho97TfQkLNJ8OwJfaOoI8CD1h/gmYR
         Gniw==
X-Gm-Message-State: ABuFfojosmxz3SPyN3G4YpwFBf6Q+WQlXiU9qV+N7hJyWv5ew29728p5
        AyPIIqg0azTEwOxlfNYrOXM=
X-Google-Smtp-Source: ACcGV63CV8iR1hLBB9N3S3jDe8kzHiL6gI2RtwjORw5bqBSHHQ6wiYp5rW+19LQmadAUVNfLiPrKkQ==
X-Received: by 2002:adf:cd0c:: with SMTP id w12-v6mr8116490wrm.67.1539417794956;
        Sat, 13 Oct 2018 01:03:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w2-v6sm2627505wre.57.2018.10.13.01.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 01:03:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lily Ballard <lily@sb.org>
Cc:     git@vger.kernel.org
Subject: Re: Bug: manpage for `git ls-files` uses <file> instead of <pathspec>
References: <1539228001.1758106.1538051752.20CB6C51@webmail.messagingengine.com>
Date:   Sat, 13 Oct 2018 17:03:12 +0900
In-Reply-To: <1539228001.1758106.1538051752.20CB6C51@webmail.messagingengine.com>
        (Lily Ballard's message of "Wed, 10 Oct 2018 20:20:01 -0700")
Message-ID: <xmqqzhvi8e9r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lily Ballard <lily@sb.org> writes:

> I haven’t checked any other commands that the glossary lists as
> taking pathspecs (except `git add`, which does properly list it as
> taking pathspecs), so I don’t know if any of the other commands
> incorrectly list themselves as taking files when they take
> pathspecs.

I do not offhand think of a command that only takes pathname,
including "ls-files".  New users would think "git cmd README" is
taking a single filename "README", and "ls-files" doc uses "file"
in a misguided attempt to be "newbie friendly", but it always has
used that "README" string as a pattern to match paths against.

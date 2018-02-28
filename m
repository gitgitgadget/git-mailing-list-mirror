Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B107A1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935225AbeB1WAo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:00:44 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35406 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935105AbeB1WAn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:00:43 -0500
Received: by mail-qt0-f172.google.com with SMTP id z14so5053392qti.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ntNCN5UG1CDb3Ex+nUXIVe/p8lewVekp2xIjSepOxeY=;
        b=VlbOGxeuiJV3D/xhjTDhNUR29NUOFFBvH707NCpu5RQUwnr4FKTu0+Ic8Udv2awgPw
         W2GCe8x6LdHLSZ6kvEEIXUwEpoILWCdTwh9YibIvcQeJQIDGgC20bx1WD0dFTxzX/CIc
         I5xkqx7rmgkh9JI7zpf8qUGiWPlRUbE6pwV+EXZdW3IhmQzpSnwqNtwffY22D0e6P0Me
         cTpUn+Q56OwsyY7AC+1VLne6cG2Zv5aYHXLlGeDjGfM6bTsTk7ET9yJuxqTgsN357i4R
         q2RzBDGZYE4L+f21kxPQg8mlizEp27GHbkj514mkzZWVQrRNG/eWBVXajrk3Ei8bY8vd
         gzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ntNCN5UG1CDb3Ex+nUXIVe/p8lewVekp2xIjSepOxeY=;
        b=ijQiIhTWuZAoBlPqFR4S6RDJN+8xW3QmlGc0aA92i8PfFfvyKRDlxFm2rbv+raGIdU
         /OUr61RfnMGLt0r/kYO3mS9rV/gsim9SdZhxxpdHNORhYQBnupKTnZ5qMMjSgVie0tSt
         6Up286t8HljZuPjamWQ5avQ4ialQYniMiyhqgjoOUUkODeCID9CAE+zPvHDxUu+Nvjvk
         gdEozEthS/uDJ2rF33jAeNJ4D3CTY7kcyqQ62mkGuApRp1Z63wXCYwfhczN47YYbFRgU
         ar90oIph1PR5r+LbvMezwc/XEJ+PIyB7BSRq/kRmwLQbvYCvvBOsWug5552aUS/lQ6n8
         Lbpw==
X-Gm-Message-State: APf1xPCAXBD2EQ9HaDSlLhfDYyu58QssxN6ccI8ZDW1Ci8pyJlxyNqbe
        xhAjl3GK/MJyKsjTzE2+eVbUPQ7DaP1WAlYNsWs=
X-Google-Smtp-Source: AG47ELuBOvVGbfwThLkmqOTw25frzbuejOVg0Jtp4HHR1bK3hRRDYkYG3YU7nqjPWuDCrUTY1tZCQ0LYYWBlAXWtkro=
X-Received: by 10.200.36.189 with SMTP id s58mr31374405qts.0.1519855242869;
 Wed, 28 Feb 2018 14:00:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Wed, 28 Feb 2018 14:00:42 -0800 (PST)
In-Reply-To: <763c5ee4-0bee-7f76-1e2a-4ad07a813e29@gmail.com>
References: <20180228172906.30582-1-alban.gruin@gmail.com> <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
 <763c5ee4-0bee-7f76-1e2a-4ad07a813e29@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Feb 2018 17:00:42 -0500
X-Google-Sender-Auth: dIt_ONmzjduItnpjE3dmx7NtjZI
Message-ID: <CAPig+cQ6awH8KfX3C+=OwE3qJLJPQyAt_dmQvMw1NLNnCT73RQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] userdiff: add built-in pattern for golang
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 4:31 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>>> diff --git a/userdiff.c b/userdiff.c
>>> @@ -38,6 +38,15 @@ IPATTERN("fortran",
>>> +PATTERNS("golang",
>>> +        /* Functions */
>>> +        "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
>>
>> Why is the brace (and possible following whitespace) optional?
>> Considering that the language demands that the brace be on the same
>> line, I'd think the brace should be mandatory.
>
> I did this to support non-standard formatting. It's a niche case though,
> maybe we could only support the standard formatting and modify the doc
> to reflect this change.

As noted, unlike 'struct' and 'interface', the brace for a 'func'
_must_ appear on the same line; that's a requirement of the language.
Placing it on a line is not an option.

    % cat >foo.go<<\EOF
    package foo
    func foo() {
    }
    EOF
    % go build foo.go

Versus:

    % cat >bar.go<<\EOF
    package bar
    func bar()
    {
    }
    EOF
    % go build bar.go
    ./bar.go:2:6: missing function body
    ./bar.go:3:1: syntax error: unexpected semicolon or newline before {

So, the regex probably ought to be strict about expecting the brace on
the same line as 'func'.

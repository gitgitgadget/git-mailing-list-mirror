Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705411F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeAZTUC (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:20:02 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39046 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeAZTUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:20:01 -0500
Received: by mail-pf0-f196.google.com with SMTP id e11so883963pff.6
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=k5jULqZTuRwvgg9MG9HgTIITEBk6ilZixuA05+CPklg=;
        b=KEGGBxPkFrmQbD2MTFDHQMuf4r9tJlOSY0jIdk8odv7TvCukfuVl03g8ZWhGf5317k
         Puc+ydQwMgc3a6+Rji6PxbdGw3wWvt2m4KVrMEFlw73XfNggobqT4rcj7oaljpSXvTpo
         z4svyj2Lvi5iF0Sa8QSVbC6YvmtGHE3fHzvXVU5o8Nh3iaiB0pEPn8gkl/naHLRT+GZU
         +MT8+zyBuBJttEZwdKucxqd9W3TFrzitMkZuraaVASPDn9sf/ois12hQqdD6Vf06rTN9
         FX5unOG+g1i0kiXbbv/62rRJSb7fiuCh6RrEFCacxm1IwbENNVKn0ncMmoWbLXG8HCqt
         0Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=k5jULqZTuRwvgg9MG9HgTIITEBk6ilZixuA05+CPklg=;
        b=mUfhUzzl8DfGAgU8IrmQRWCUZ9ppLXcsqpkPv/7ZtpqmJmZ5Rc5Ra20dT2VzoVcaPP
         VDA35UQ9Sh4/WATU9kLTrXQjV4k/wwWAMbX6QSTvi68v24YSY4Te267qkTnOYfvH9e2I
         ebgjGxfXFMfpjZiKApV0HuxmBqLsmy4WmjitK7foXGv0qK1R9q1cJjGgEZxIo9roiUlp
         gCvRjz5ERqtMKvIXMZZ06rqmAwVFzWVoz9Yp5U7AXEGFV5mN16D89U1/KKFadGnS0o7b
         N8P4OJGMD4i8QTGvZ3jAat02+D8fhyeFwugShUYeavZKrtJh2Oe2el0EqEE0lJ1HAGw4
         2ipA==
X-Gm-Message-State: AKwxytepucJ4ftaZto1yVnnY1nG7D7tt19XTYtXSF7jho2qocj6Y959T
        wogIigsdIWbkDO8bTZj0Csk=
X-Google-Smtp-Source: AH8x227pTc60qc+x/gzyuDulXMC4QgLx3euwbbbHh5qgFO2Od/0ehaGdrJjEf633BBNnhTTZE3G8uw==
X-Received: by 10.99.188.2 with SMTP id q2mr12539198pge.67.1516994401032;
        Fri, 26 Jan 2018 11:20:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id p20sm16163318pfh.100.2018.01.26.11.20.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 11:20:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] t: forbid piping into 'test_i18ngrep'
References: <20180126123708.21722-1-szeder.dev@gmail.com>
        <20180126123708.21722-9-szeder.dev@gmail.com>
        <xmqq1sic8omp.fsf@gitster.mtv.corp.google.com>
        <CAM0VKjn401p4fbF-mJrpaQrgOHGHZ1HtRNx9n+CV+jn4n2a1Uw@mail.gmail.com>
Date:   Fri, 26 Jan 2018 11:19:59 -0800
In-Reply-To: <CAM0VKjn401p4fbF-mJrpaQrgOHGHZ1HtRNx9n+CV+jn4n2a1Uw@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 26 Jan 2018 19:51:56
 +0100")
Message-ID: <xmqqo9lg77hc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> With 'test_i18ngrep' outside the 'test_expect_success' block!?
> Definitely too contrived. :)

Well, I think you got the idea.  The point is that test_i18ngrep may
not be the only thing that is redirected into, but can just be a
part of a block of commands, and the "probing" read will hurt.

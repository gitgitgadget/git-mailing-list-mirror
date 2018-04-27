Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0EF1F42D
	for <e@80x24.org>; Fri, 27 Apr 2018 06:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757324AbeD0GGD (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 02:06:03 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35998 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeD0GGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 02:06:02 -0400
Received: by mail-qk0-f182.google.com with SMTP id a202so573135qkg.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 23:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U2u1zSlb6pt7kQ6Ovbkc7Kp8kgGXzYRFa3fPxthZgb0=;
        b=X6KIuWJ0L0GfzWHSP/lJHPpm99l6s/38A6M/sunO7zexbtV5Nc0QcSNo6Dvjtr93fr
         nF+TBNc2j6fwtUb0+LbnYMwS4dCasne0r7q6QqSt7g1ECNlU+dZ+1RztifqTlFcBwly/
         52Rf6aio3UY4YDIPTJIqYZOHofh7J8/YT+7mSzxzZr5fIwGn1aBYHy37G2RafjU5V6il
         Ac5UJGyRPen5+5i7JSkXjJmCGU7MWTM0pX729VCglWy4ZbgNZsrVruEh0iNkp+e4W5RX
         fr4atcCdzkFSrT98YsQau7JXzo6M2j9oeyGaUybrAAnqVKeEO+prS511uzE5Aztg4CIY
         DlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=U2u1zSlb6pt7kQ6Ovbkc7Kp8kgGXzYRFa3fPxthZgb0=;
        b=R3ndDvUYGEUB7Z4WiCXqZexOtdgAy9sZV9PUi00UpJu7rqpr7a7ar2iNVnXK8queqg
         ErG7o+tZpNsnrDlq2sYNHOuITR47tKj/c9XjjVKFKEVciTzzWwhs95UhbXEFl1oZMgk0
         mmFvI8ZtFr/B7bzIzZIQhQV776C+pRZcvnZphXxZ2IaI1N7cOlzH4pW8Cg1pPCCftE0J
         85hjZdrbLTdJqKxZZDYndcrmCCvcoWjWRKMzqrUkSwTJ02nFSorNXyEi4OU0VOgHMaRc
         eHeVUFb/SnvidXO7cemdGL9POrTS1Jpklp3uPxua7GqmEarsQsvLpsClj6/TO0KglZZu
         7P1A==
X-Gm-Message-State: ALQs6tDdCDTJzUEGv+76wXS4KIUeBeFAhvpw7YdpHXLk4OAA8WajBL/E
        CjgKO42peD+V9QWsEfvO1Z8R4zFnSqv2O16bh5c=
X-Google-Smtp-Source: AB8JxZor5yPb1Xf0Hd0ykp1h2A8klWiCk+gm/3tWfQoDXZygtzld5W49r5kFLhLQtk+fs1Tgg7AZny8s972Lvg1cJdY=
X-Received: by 10.55.111.6 with SMTP id k6mr67513qkc.145.1524809161719; Thu,
 26 Apr 2018 23:06:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 26 Apr 2018 23:06:01 -0700 (PDT)
In-Reply-To: <20180426060023.GA39448@syl.local>
References: <cover.1524716420.git.me@ttaylorr.com> <1bc42a611089a2552b1d8bc83ff229be0a5136ff.1524716420.git.me@ttaylorr.com>
 <xmqq7eou35ev.fsf@gitster-ct.c.googlers.com> <20180426060023.GA39448@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 02:06:01 -0400
X-Google-Sender-Auth: -0qv5-y-IJd2FXxl6VQVc9EVWKY
Message-ID: <CAPig+cQwwsLSRUDqvM2LSv-DJDJQwv+MY5ANVhEiv6oBpXuvHw@mail.gmail.com>
Subject: Re: [PATCH 2/5] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 2:00 AM, Taylor Blau <me@ttaylorr.com> wrote:
> On Thu, Apr 26, 2018 at 02:25:44PM +0900, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > Subject: Re: [PATCH 2/5] builtin/config.c: support `--type=<type>` as preferred alias for `--type`
>>
>> I'd retitle while queuing, as the last 'type' is a placeholder for
>> concrete types like <type> above.
>
> Good idea. I amended v2 in this fashion.

Suggested previously[1], as well.

[1]: https://public-inbox.org/git/CAPig+cTw5ZXKGOcnombwiM4P+9iRpbYUvOagQ0XujLB0ttXsOg@mail.gmail.com/

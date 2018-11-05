Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3825C1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 03:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKENKV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 08:10:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42724 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727288AbeKENKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 08:10:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id u68so12484822qkg.9
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 19:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdXAeLroFZqRqfEm8LlZ6F6A35GGd7JfFoYjv/WuwJQ=;
        b=N940LZCnUh9Kco7OCsyyjSYk6NbyMEbg2hK9gUTAuJfF57iSBv3a5KXAwZn3YYsi0G
         ChE0GmFv61rY8OjZhAImpa/pZlfh/GZiGQFKsq0ZOmCZkHLa2+vTSFtY2P6+szTax5On
         YxlB3+DeMnBQYzkjYobinWeaPKyyiHhUs3xrpMlrgw3/2bkZfcIscH11P3pde8WpA920
         BVeSQdBQqKYcmA6RgeuUDnTe6EW4E56MTkoQuVYsZQVKXxwktZddc+s1bU1eU6EQkEuY
         yMCwcxJnlrcxI/i2LD7XfzKAHck0sHyQ66uKxsFTc/5BjGjxzd22gB4J0u+ne9Xb1JhT
         tw7Q==
X-Gm-Message-State: AGRZ1gIcjyHqAqUgDBxCrh3M3gKLZf3BXrtoJ+CjTp0Ee6f7JJWm7SKc
        IKHmN1Ctzkmwa4rZHclax9vLd34KsHTndk3kpas=
X-Google-Smtp-Source: AJdET5e+WgFBAC21zRMdpjVY2c6NLyjIERQILY6X7eSM0SKVKHQLXVb5BjYxvWh3aYlpkCVk0MH/wkt52wMuISvFRlw=
X-Received: by 2002:ac8:36ba:: with SMTP id a55mr19312621qtc.236.1541389966061;
 Sun, 04 Nov 2018 19:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20181028125025.30952-1-anders@0x63.nu> <20181104152232.20671-1-anders@0x63.nu>
 <20181104152232.20671-3-anders@0x63.nu> <CAPig+cQeUxxvgNGVc_iZ4v0U77obFu6-q0QbtzTJdnEep8eq+Q@mail.gmail.com>
 <xmqqa7mojibg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7mojibg.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Nov 2018 22:52:35 -0500
Message-ID: <CAPig+cS8-7-6MzuUcTTPMOUBEGuJiPPui5hCECOAu7vDx0irLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pretty: allow showing specific trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     anders@0x63.nu, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 10:48 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Does the user have to include the colon when specifying <val> of
> > 'key=<val>'?
> > Does 'key=<val>', do a full or partial match on trailers?
> > What happens if 'key=...' is specified multiple times?
> > Thinking further on the last two points, should <val> be a regular expression?
>
> Another thing that needs to be clarified in the document would be
> case sensitivity.  People sometimes spell "Signed-Off-By:" by
> mistake (or is it by malice?).

The documentation does say parenthetically "(matching is done
case-insensitively)", so I think that's already covered. Or did you
have something else in mind?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 419581F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeGLQYo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:24:44 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:46270 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeGLQYo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:24:44 -0400
Received: by mail-oi0-f46.google.com with SMTP id y207-v6so56818584oie.13
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mE5mpR7Z0w8cj51r5egmX5AwKhkDzE9xKY1jZ55s6u0=;
        b=feYkSeIrfPPVBqGhReJ6V3apGOnQJbHpmviScBeH7mUDe8lera2eoAxwCaiOWWo+zr
         L6TuANEtgLGwsWQR/wpHGuetaJ1xHSPdIDWidTGNNoAnK1I8OvVixHUxZXrftNQGkJB6
         /06UE7VF7qznyT0xcb9LdkqgIMWH0Eh2Iwu6r/LuxR6G3IfjOfS43Jb47+Hifk2WvSF8
         JJf7jX+w7NNHx6uRCUsbDcf5y5noVMcWdQA9U8atUNBfPLJLtDzzQeCuIvUv50VIV/ye
         k+54QdbI5Ub7ZvlFNtzBo0wG8gi8hNK4vhX380ykx7v0ZHc3IPNMa/EnPvfvCgmmyoMI
         sT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mE5mpR7Z0w8cj51r5egmX5AwKhkDzE9xKY1jZ55s6u0=;
        b=Af02SQ3uZwH0urCW1dTqMFhplX96p38FCox4cA4sPI4pY2SiW80VaHEBZnOO/vNEgw
         vU6lVwu5gPoP/YyR8Bn5es76dvkGGvGSniJuK+3mIcP9yKouawIj6P4GqRAv+i7gN6g6
         mmJ8gC8BEPO0rhFGVNiUwOp/WmAz8GJ/BfKZB6vouY3JLn7B5A8MxpV7ca1hL50M0Zd/
         EX+aTq861UrSbiG5Lyw1Y41CI667ORUri2E1cxr7hqS3xFs8dR3gfP/ShOYx5a7VZ2Ps
         zEfUDKahKjctGoImbaNXfY7kWYIhMObTwAKs7uY+agVeva7b9PxIFO1AdB4ytGQsDYRl
         yG0A==
X-Gm-Message-State: AOUpUlFusGO4F2f0yOjgUx6LEr2ADEVdEJ61P+D5+EvG9KZdBtBc/zvg
        07ZM6albb5oYZtPYUhQRe/ALNUzMpEhkhceFUzs=
X-Google-Smtp-Source: AAOMgpfROPSYsfF4wBTKeVgTeJxjrQGURZSRn3NoKLT0XL/Ul/Q20QxgfhPX1nMVG3Vb0WJbS80mjfMCDlRCAYuAtgU=
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr2881181oia.294.1531412071245;
 Thu, 12 Jul 2018 09:14:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 09:14:10
 -0700 (PDT)
In-Reply-To: <xmqqva9kzbhi.fsf@gitster-ct.c.googlers.com>
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
 <20180712054909.29077-1-wchargin@gmail.com> <xmqqva9kzbhi.fsf@gitster-ct.c.googlers.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Thu, 12 Jul 2018 09:14:10 -0700
Message-ID: <CAFW+GMAp2bA2=_BZ2S0HLO2x2aLE01zXigHrY3QtCmWxRuyAtA@mail.gmail.com>
Subject: Re: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As we discussed during the review on v1, ":/<substring in commit>"
> is *NOT* pathspec (that is why having these tests in t4208 is wrong
> but we are following existing mistakes).

Ah, I understand the terminology better now. Thanks. I'll change the
commit message wording to use "extended SHA-1s" instead of "pathspecs".

> Now you have Peff's sign-off for the one-liner code change, the last
> one is redundant.

Okay: I'll remove the "Based-on-patch-by" line.

> Other than the above two nits, the patch looks good.  I would have
> broken the line after "including HEAD.", but the slightly-long line
> is also OK.

Happy to change this while making the above edits. :-)

Best,
WC

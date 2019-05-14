Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A7F1F461
	for <e@80x24.org>; Tue, 14 May 2019 13:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfENNbW (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 09:31:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35223 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENNbW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 09:31:22 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so4698658ith.0
        for <git@vger.kernel.org>; Tue, 14 May 2019 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jm5KzPzfp5iQZr3CKIgCtB9g/SxTRLXgs4Lde5wlNB4=;
        b=sO8RckDykV3b9DnBn3RG2Zl860FmLQXtfQXAxAwbnpxC/nyTQ1Nfxdum0lLk24qYkk
         Vwwt3E5R+0B+f5yyN67nD3vjLnal4+uWwTQRNYl4udil93H0M+CAe28XCTJlow72f8Zr
         KX8zcLQ7thwWrnd6KywEZll6mBQhzWI9HYqsxVQoL7b2iVfQ7xYYH2dEdQRXsrPZz7+l
         vPaVYvlXpBsPhQsGHFzLOMfHVD7yyemiab37VznKLnMHXZmi/ZAi7xCr05KVPNGdXB1U
         /g+uOr3I+MV2bShFyniB6zQmUdC3aZrUKfJqVoWqCoUPz3HLUxWB0ps/npaB9BOiYmFJ
         ezLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jm5KzPzfp5iQZr3CKIgCtB9g/SxTRLXgs4Lde5wlNB4=;
        b=M3PTf8o39lgwxJSnfjirpwt8gfQjpyuyS308tiuVVCpI2IOHD7Avhqo41kZe9FoBdO
         Q1NJFRHj7bSYOiKk9izYTJ525o0gPo92/l+8jm7ch+uDIIAmLbvsKjO02S2UAO4cyAeZ
         KP8v3kFz5BbeGpgc3LaxzvG4EQqr1wdxxnOV2kO4QyECR+F8Gn//FTl3Vce+WVWnEEcr
         3KnBdjx7axYveUcQt53V9tufIj6i8oatg/DoB9lbVRlpP+vcglcaGoP1rk0evDoqxZ4y
         mmlQCABaYmF6Tfyiz5QMDFq0qg4M/xkgZNQDJbFnknkqS0YgRroy2BNNksiJm0fe29KV
         ZbtA==
X-Gm-Message-State: APjAAAVjzN91WPE6rBY0NscGC4FYd27Ykp3oTfCMcJNgpikXrbtZJ3mw
        q/gjywxSXmjOkJhaojBwl5Rl8NAIbyqlW+Zt26Y=
X-Google-Smtp-Source: APXvYqwJae68fjkiov67qoGtwTpSbGUbNeg42ODJqm+QWnxWnb8T2nZ0tp4RgJhJhhh/GP6mcHN4o3iHW+lEvxXtOCA=
X-Received: by 2002:a05:660c:34e:: with SMTP id b14mr3091162itl.10.1557840681444;
 Tue, 14 May 2019 06:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
In-Reply-To: <20190514002332.121089-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 20:30:55 +0700
Message-ID: <CACsJy8DH5MzqM+8sn7Wi04KxUTxJjnWhEBMk2RVrXUDMwB9sTg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Multiple hook support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 7:23 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This series introduces multiple hook support.
>
> I've thought a lot about the discussion over whether this series should
> use the configuration as the source for multiple hooks. Ultimately, I've
> come to the decision that it's not a good idea. Even adopting the empty
> entry as a reset marker, the fact that inheritance in the configuration
> is in-order and can't be easily modified means that it's not likely to
> be very useful, but it is likely to be quite surprising for the average
> user.

Can we just do like we do with hooks-in-directory? Ignore the config
variable order. Sort them all alphabetically. The user then has to
prefix a number or something to control order. Easier transition from
hooks-in-dir to hooks-in-config too.

> I think a solution that sticks with the existing model and builds
> off a design used by other systems people are familiar with, like cron
> and run-parts, is going to be a better choice. Moreover, this is the
> design that people have already built with outside tooling, which is a
> further argument in favor of it.
-- 
Duy

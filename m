Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2397A1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbeLTVnK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:43:10 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33749 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbeLTVnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 16:43:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so3018579eds.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 13:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0p9Yz8Drrn4Z8K+rhgz0QYI7qLMUDPqY86fA9VLssBY=;
        b=OsoOnMeq+Z1WjsnVCYIUS7R2V19CcmYh/rvZsJOVuYT3ZDP/+2cPH1QRk335Wb3axD
         mww63E4rEd9hTPyJ2oeMFBaX+/a+HIdQWONHKCG3tngsOTi05nUT1shcoHLoCpyKQni1
         81Dmvia/0J61pUeNqvXckol41IZ4JjJ9GfxxL/9//Tf+iG5pOddyzjQqyq1piD1/W9+f
         qtbT0V2GPhlxnBasG4lrghAbpWfjcCz2kTlrgpRdwTtNpZg2jT318KMHKt6CgZ+4Eide
         m+oW/kvZvQV4M1ZQyVtePo0EAp/NOiE2bq5vxwDFXswnysdZWG5LgQeo80sV4P0E6jrm
         A0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0p9Yz8Drrn4Z8K+rhgz0QYI7qLMUDPqY86fA9VLssBY=;
        b=qrCc1mdqqA9kaw1mSgCxLa/1ks2+emKXZ4Saa4GGAmCYpC0NIxF0cHRCAw/b1b/HfY
         nJyXkri0NyUlyRWOjjBCXIyxQQJaF18HJnyf02srJV9WokgQQR9FmphqRpd3uYlvrkJr
         gesDs1lXW71ot5aHcsWrLEyvbiGMrCnbKN8ndPZapjvaNsvpDVqiqRzzjIrnZA85VC+4
         M3hfziPsGFGC2F/vWYFdETkVzlNmkFZBO4UqGC/OnC+TxlndCO8Hkd3vP+4o30k8KzrL
         g7nIgdyIu5SlTvMgKGTbfvNYeRCvupXzQtkhiGF49hn7v2352bfJ/ti0aZ3v/Y6fLWxE
         IGSA==
X-Gm-Message-State: AA+aEWZ2u5CGY4LMnlQ8uEMD4odzkcCihVl9bNNlrqhbE2r/2hE17aOm
        VC/9Jcyejo/YU9vmZBfKbhY=
X-Google-Smtp-Source: AFSGD/Usfwf1XP82jWJFZ+WMQkhyAaDooV9UGpHLbvzY62cHU/+n0Hy7MOqPEB6M5u24PYLT6dbTaQ==
X-Received: by 2002:aa7:c352:: with SMTP id j18mr223639edr.295.1545342188160;
        Thu, 20 Dec 2018 13:43:08 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s36sm3688550edb.43.2018.12.20.13.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:43:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] diff: add support for reading files literally with --no-index
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181220002610.43832-1-sandals@crustytoothpaste.net>
Date:   Thu, 20 Dec 2018 22:43:06 +0100
Message-ID: <871s6bg9hx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 20 2018, brian m. carlson wrote:

> We don't include a test for the pipe scenario because I couldn't get
> that case to work in portable shell (although of course it works in
> bash). I have, however, tested it on both macOS and Linux. No clue how
> this works on Windows.

You can (and should) add tests using the PROCESS_SUBSTITUTION prereq
Dennis used in an earlier version of this:
https://public-inbox.org/git/20170113102021.6054-3-dennis@kaarsemaker.net/

Even if that wasn't possible a bash-specific test is better than no
test, and can be had by including t/lib-bash.sh in your test, see
e.g. the completion tests.

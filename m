Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76914C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336F520863
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj63ajEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKZASW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:18:22 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45942 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKZASV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 19:18:21 -0500
Received: by mail-lf1-f45.google.com with SMTP id 203so12495777lfa.12
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 16:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OIdRnMt5eKujEsygucQdwEfAbUVTrMalsAj7poTRYM8=;
        b=gj63ajEM8IjFKXs6fCUj1DE2xmv3qn576w+gaPwr6cgfiPzomOr4KtQ9GCHHkgivtX
         1rXOLBjZ+o9/rZRb88GfjtN6tebpQobms6qzUHUrjnA1cOXwOf5Y9bLpAdHbqsTdtnUN
         wGTDBLf+BG7HVEWCOc20JnWobmiTSFRCLhJ47tq7wfm9EXGGTHfnRKuveSZB4zbfxrst
         32e8jMnjboeObacWJEqqtUIaASa3rtob4qe90UYPP/jGOCkpSGMl+sfisnByPR2AlnXF
         fjj9vyI0F8u8jtwJVlcaSO2tOONcPfj/n1IX1xtFNu0UUcyVcNLrBL8o83yPNGf3W6WL
         l/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OIdRnMt5eKujEsygucQdwEfAbUVTrMalsAj7poTRYM8=;
        b=OZ7tZXuv8SOu7p8GJv5faND7BMd80SRWC64Z3vFXiumUtoH6txnoSnHQ1cStv4kSYb
         +9VVi8ksWqhvjuvh9FciztYjb7f3Eo5nrMv/Vkzv35fC9CnKItn5G76j+URe0jAe9CWN
         H2FVNZY9UzZtnBRDGZ4xrXFXBAsziCM6kgxgTE7N9lf3QWZgPy2t82OI4RzSKQIfhrJC
         Sb2yxk2uyVbPQp0WJjSwt7PNb3gjvLjmn9PclpnCEfUxQxtZq0dfEok9w92fd61ciYar
         b44IH8LZ5/YdCFb79+VAHVWhBnG1/siUrNMXO3oSZsWHUR+fE2YuMgPxraRf57v1Ex8f
         bX9g==
X-Gm-Message-State: APjAAAWR79aRPbp5kumckB3oAC5rWqzHdhAJDathRvEr4c2gTjmXYvSp
        bRpvUZteJ13iOy1aFPea4WbRxr3pRkK/CIoy4o0eeAif7Y8=
X-Google-Smtp-Source: APXvYqxwQhBUkU5S9vmidSt0OVgKCmA9KKXx1AnVJKzQcf2koS4GoBOcdsNma4q6N8p6ziGvUGR2Zr9GgTJ/OJePVTs=
X-Received: by 2002:ac2:4643:: with SMTP id s3mr17468483lfo.23.1574727499617;
 Mon, 25 Nov 2019 16:18:19 -0800 (PST)
MIME-Version: 1.0
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Mon, 25 Nov 2019 19:18:08 -0500
Message-ID: <CALnO6CDvGjVo=s2QDwXU_hEoYQqGgPXu=fqroN5Rv2iaxvwXqg@mail.gmail.com>
Subject: Timing this week
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Not sure if this is the right place/way to ask this, but:

Background

I have some information I would like to share and discuss with the git
developers regarding the performance of git-status, especially with
respect to (possibly large numbers of) submodules.

I've gathered a significant amount of data, and have actually given a
presentation on the performance problem (as I see it) and a quick fix
(not one I am comfortable with long-term). [Long-term, I would be
willing to work on a fix for the problem, if we agree it is one. That
said, I'm not very well versed in git's codebase.]

/Background

I would like to get this information out and a discussion started
soon=E2=80=94and of course, Thanksgiving is coming up in the USA, so I expe=
ct
"timeliness" will be difficult over the holidays.

TL;DR

I'm still drafting the mail for this information, but when I have it
ready, when would the list prefer to see it? Should I hold it until
next week? Or would you all rather see it over the holiday weekend?

Best,
D. Ben Knoble

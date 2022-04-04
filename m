Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFCBC433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380048AbiDDVVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379568AbiDDRe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 13:34:57 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC671615E
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 10:33:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id b7-20020a633407000000b0038413d39ca9so5943319pga.4
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d809+LFYH6TQGEoG1tzsAcwWUacU6cvo6UprS5/JePo=;
        b=k64fftgVcWVAlex66US8JQMG9YOp4khQvgg9MZe60cR9P0qdSIbRMFHGKVQw5eyyjm
         ZHIBL4+E9LiYL0gxTe3cFQZB0wYAe7PnOe3rSmuPc4EwSwjoZDA3klJRV219WXPNVPXv
         lZCmu1rbsHKb3x/tNCh7R+73WqrJUUdCrpHL6ebizYwt89QoSuJ1qv/OYNClEcUJvCZ/
         Lu0YYyVpZOPK/FrzR0J/Gdhuz4khj++9Gv4N5BBxtjzvZP3VfcPri+YNmia+3V9892a+
         CNcjOXQdPJesPuBjGPVXcad5y0WtZ5Y1ehxOKMifbOzX2qwnJMbHvJZl/MNfRu5zfxYj
         /6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d809+LFYH6TQGEoG1tzsAcwWUacU6cvo6UprS5/JePo=;
        b=J2msZeC3KtE5dJpwqz351dcn0IwjxKqs0hYtYgnYkgcwZI7TOk2qiQY4jHoj68M8K/
         jkd1JBg6+l4neVKpkkXzxvvHop9DBurfVcc+Vq47pJ0qcZNSPIayYv/h/2JaKHctiFqU
         YEy9Mj1nXM88FpvKXGMn1WFBrsM9Eee5l28dDwQbwmV19nC9UaqRwN4OMC0j9ZJVjR1f
         6aS6GNLd5UhoJ8vr1VE8p08ExQxShQwe+ynxlbMpVl7OvaRfW1brf4sbDW7WiaZs9Iw0
         M51xyrtpY78gedXmL1fMVcaAhNkCOHbt5FhpFbnaw/4diJIqZrvy4lSl3xhjsaAnLBdi
         uMNg==
X-Gm-Message-State: AOAM530kpyYvqpAAm3tyJX+D7agNoXO44iwtGeftqlBZO+rX7pIL8QdM
        nB37pgE8aDh01XMGrzQpl1AZmwKAlrcBfQ==
X-Google-Smtp-Source: ABdhPJwj6KJ5D7AtElGF3k/2Hfuu2waInZK95O9m1UesPpxomTYzvgoxHBoeKqY2x1BlclCujoeR9KRkZN9cRw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:2242:b0:1c6:80e3:71b6 with SMTP
 id hk2-20020a17090b224200b001c680e371b6mr289130pjb.152.1649093580169; Mon, 04
 Apr 2022 10:33:00 -0700 (PDT)
Date:   Mon, 04 Apr 2022 10:32:58 -0700
In-Reply-To: <20220403132508.28196-1-a97410985new@gmail.com>
Message-Id: <kl6ly20kycs5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com> <20220403132508.28196-1-a97410985new@gmail.com>
Subject: Re: [GSoC][PATCH v3] Add a diff driver for JavaScript languages.
From:   Glen Choo <chooglen@google.com>
To:     xing zhi jiang <a97410985new@gmail.com>, git@vger.kernel.org
Cc:     j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I'm pretty happy to see follow up on this patch, I think it'll be very
useful. Thanks! I think this patch has a fairly consistent direction
now; though I'm undecided on whether or not I agree with the direction,
I won't block this from going through.

So treat these comments as suggestions and additional JS info for the
folks who actually matter :)

xing zhi jiang <a97410985new@gmail.com> writes:

> In the xfunction part that matches normal functions,
> a variable declaration with an assignment of function, the function declaration
> in the class, named export for function in ECMA2015, CommonJS exports for
> named function, and also the function is object literal's property[1].
> The special match is this would match the popular framework test case
> pattern(most is same as regex for matching function in class).

With this paragraph and..

> 2. "^[\t ]*(QUnit.test\\(.*)\n"

this pattern, it looks like the direction we've chosen to take is
"support popular libraries, even if this might detect the wrong thing in
vanilla JS", which sounds reasonable enough to me. I think the
experience would be a bit inconsistent for vanilla JS folks, but the
worst thing I can imagine is that we are a bit overeager to detect
headers.

As an aside, this is my first time hearing of QUnit, but I guess the JS
landscape is huge and changes too often for me to keep track.

>    I oberve there are many test case pattern in JavaScript. And most of popular JavaScript
>    unit test framework's test case pattern is function call can be matched by the regex, which
>    match "function in class". So it is no problem. But `QUnit framework` don't matched by that.
>    Then add this regex into JavaScript userdiff.
>    And the reason includes test case pattern has two
>    1. This is inevitable. Because we can't distinguish that with function in class.
>    2. This can help the user understand what change is happening in which test case. And if 
>       don't match the test case, it has the large possibility to match no related function.

Nit: since we're adding a pattern just for QUnit, it would be nice to
have a test for it. This would also have the nice benefit of showing why
QUnit can't make use of the other patterns.

> +	 /* popular unit testing framework test case pattern. Most of framework pattern is match by regex for "function in class" */
> +	 "^[\t ]*(QUnit.test\\(.*)\n"

This wasn't entirely clear to me on its own, but reading your ---
description, I believe you mean that other unit testing frameworks are
covered by another regex.

Wording suggestion, perhaps:

  /*
   * QUnit (popular unit testing framework) test case; most of the other
   * frameworks are matched by "function in class".
   */

As a technicality, there is no guarantee that the user will import the
QUnit library as the variable `QUnit`, though most users will probably
use `QUnit` out of convention, so I don't think this a problem [1].

[1] In case some additional context becomes useful to other reviewers:
 most JavaScript module systems do not enforce variable names when
 importing a module, so there is no guarantee that QUnit will be
 imported as the token 'QUnit', though this is often true by
 _convention_ because library authors often stick to a single name in
 their documentation.
 
 In 'old school JavaScript in the browser', libraries are often exported
 as single global variables. Those do have well-enforced names, because
 otherwise the globals would be unusable.
 
 In native ES modules (aka standardized, modern JavaScript supported by
 modern browsers and most frameworks), the library author can suggest a
 name using named exports, but with the caveats 1. the importer can
 alias the variable to a different name and 2. many authors use
 anonymous exports - either using a default export or asking users to
 import the entire library as a single, anonymous object.
 
 In CommonJS (typically used in NodeJS), one cannot name exports IIRC;
 an export is always a single, anonymous object.

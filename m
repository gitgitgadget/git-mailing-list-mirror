Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDB520248
	for <e@80x24.org>; Sun,  3 Mar 2019 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCCQvJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 11:51:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43361 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfCCQvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 11:51:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so2920900wre.10
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 08:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dp7+bjDqutbBFg50YN386Y6IXKvE6qSNkQUYBtmoakE=;
        b=ksopdLprZOvcxo8Jz8yIvV7LDR7S7I4CtqlXEWubjpmY7V/Qyx60SDQCp9ptnTcc/A
         gqni0hpl0KCikPxQjmWqJ9IDIl6FyxucrhnHA8NY9/Zl7sAvQKLRtLr9WwgIl4a0IIit
         NQlEY08CgZGIzNzjKCqDMEyXYBcQCSM/hjGT/ELEupM8djF9j3aC8PExi6ExIMqR7HH1
         0jB+BAvIyKRwT/ht38h0hu5wfXrxm4q5qN2N+v31Q3ga5817xyRPse2H6SCiJP1lEfF2
         iGZ6rX8tqmeojoAcn6a4oKY6u3v2Pxw6J+vTR7wXQO3vqr16bjpMJAZ/SVq0lc208Egg
         RuOw==
X-Gm-Message-State: APjAAAUX8fGtPjbSirwCgdF8PxHWtcnLwJpTIBGsFmriyIbfZmj0XfI2
        EOlz6QHSJA3p3FZt6ny8Hgo9oc8cKWWZd1bTmWQ=
X-Google-Smtp-Source: APXvYqx912szqMe7b0MmLkwGMT7bcR7Vs6z8CbHTS/m2FCBnCE/QeAo6iWFe8gB5b3m0go8iysRFDF4MxL8K3FUU7jU=
X-Received: by 2002:adf:dc10:: with SMTP id t16mr10256539wri.40.1551631866967;
 Sun, 03 Mar 2019 08:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20190303164008.3928-1-corentin.bompard@etu.univ-lyon1.fr>
In-Reply-To: <20190303164008.3928-1-corentin.bompard@etu.univ-lyon1.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Mar 2019 11:50:54 -0500
Message-ID: <CAPig+cRTHV27pC-87rNhgVEFqadXBGVXdrUtNo9xOqK0Pyw2rw@mail.gmail.com>
Subject: Re: [PATCH v2] doc: format pathnames and URLs as monospace
To:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Cc:     Git List <git@vger.kernel.org>, nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 3, 2019 at 11:41 AM Corentin BOMPARD
<corentin.bompard@etu.univ-lyon1.fr> wrote:
> Updating the documentation to use monospace on URLs and pathnames because it makes more sense
>
> Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
> Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
> Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
> ---
> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> @@ -48,10 +48,10 @@ repository root, i.e. be all under a single parent repository (but see also
>  projects' root" subsection).
>
>  -----------------------------------------------------------------------
> -our $projectroot = '/path/to/parent/directory';
> +our $projectroot = `/path/to/parent/directory`;
>  -----------------------------------------------------------------------

For the same reason explained in [1], don't do this. Due to the "----"
lines surrounding this text, it is already formatted using a monospace
font. More importantly, however, changing the quotes like this
actually changes the meaning of the code snippet, and not in a good
way (in fact in a potentially bad way since it tries to execute code
inside the `...` rather than just assigning the content of '...' as a
literal string to the variable $projectroot).

[1]: https://public-inbox.org/git/CAPig+cSkpUCm0=TZ-T2Lv5F0bxhGhyMMS6Nxj42JFbNupgpf0A@mail.gmail.com/

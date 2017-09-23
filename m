Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962C2202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 00:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdIWAEz (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 20:04:55 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38384 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdIWAEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 20:04:54 -0400
Received: by mail-pg0-f67.google.com with SMTP id m30so1453066pgn.5
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=braMob9JPO+AbLA3Cvdx+I9+kwVdEDnq8/6z9H1yUXg=;
        b=TXBrPH3OexQj8xttic2+cAC1r55qO/iUt5Ua2OxOG4TrRwr+Vngivo/7v99yw40RYL
         UpWaggyYr+wbBgD4N7rvk0zTo9+9NZKzjfxii+obuiYqvvTpjyz5OaxFm8JY9AKQ2ggg
         vfYqg8KaA8olA8BoFlAs9PoZYpvUcNQ0F+7uzv+AGZtPgaGJhsWtIkZgp40mBmZPEm3C
         mw1+4oTbFrNzdsRuq2YKPMJO/TzhhG/hsN+5v6sk4gvLKqBkPMD3wzywRTHg49WPj+sY
         ituD63Ta4X4wH44XW/F/UMDmjfkGBNTbYbPBet8wqRruKoqQa9EE63qrq4aeHVVw8gyg
         iQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=braMob9JPO+AbLA3Cvdx+I9+kwVdEDnq8/6z9H1yUXg=;
        b=OZrtwKR94BLExbeIt1DtM0YprjVzuawWTm7IkcCfVrl6T0pJbLqqkhGS0yu9dWjifg
         K0o5RlB2WAreQo901qAnlqId+bxzqlVVDcWjD0nS7+zHgyRQaXfTaolIYrXgxBQJgeRs
         tgUlij0xSZk9/Cq3ImbBgin35PuS4X6i1dOmby8Gq0aLkazEs7VlG+mbXO/IafXAaoII
         6yYQhiU3qDJZIRIApXPs9OGiISNqomI6uOL87DO7k5/WjjqVw/j5hZMwDxepAhXk17p+
         GOhoNq6dmAgm5t39rEzjKzPBRBHc9PMOShHQPmtdMqKyQdq2NRcIKloBM31qr6ZyZMIr
         HV7A==
X-Gm-Message-State: AHPjjUicH8pkMn2QTf6gZthrQd7oB4mqjDUxQfx+pqZJVUL1KFfATgsB
        VnT6n+26v9mUbZQBGsgqAwca1dNAA7/Sg5On3kk=
X-Google-Smtp-Source: AOwi7QB4qSwRrvPqgC3lNvGaUeRgiBPPxbe72kcDKwcy4ypmv9/Vs0XTNhEZOOJqc8F6bnHPj279mdLIgo67BMYaT9Y=
X-Received: by 10.101.81.135 with SMTP id h7mr696105pgq.48.1506125094003; Fri,
 22 Sep 2017 17:04:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.137 with HTTP; Fri, 22 Sep 2017 17:04:53 -0700 (PDT)
In-Reply-To: <053ce92e978aff511667669682c9a71830008605.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu> <053ce92e978aff511667669682c9a71830008605.1506081120.git.git@grubix.eu>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 23 Sep 2017 02:04:53 +0200
Message-ID: <CAN0heSo5AE=Z2yoZmtcvnPc_7h3wWn4yMrzB7kDXPyhB_CsLQw@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-merge: Honor pre-merge hook
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 September 2017 at 14:04, Michael J Gruber <git@grubix.eu> wrote:
> From: Michael J Gruber <git@drmicha.warpmail.net>
>
> git-merge does not honor the pre-commit hook when doing automatic merge
> commits, and for compatibility reasons this is going to stay.
>
> Introduce a pre-merge hook which is called for an automatic merge commit
> just like pre-commit is called for a non-automatic merge commit (or any
> other commit).
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
[...]
> diff --git a/templates/hooks--pre-merge.sample b/templates/hooks--pre-merge.sample
> new file mode 100755
> index 0000000000..a6313e6d5c
> --- /dev/null
> +++ b/templates/hooks--pre-merge.sample
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +#
> +# An example hook script to verify what is about to be committed.
> +# Called by "git merge" with no arguments.  The hook should
> +# exit with non-zero status after issuing an appropriate message if
> +# it wants to stop the commit.
> +#
> +# To enable this hook, rename this file to "pre-merge".
> +
> +. git-sh-setup
> +test -x "$GIT_DIR/hooks/pre-commit" &&
> +        exec "$GIT_DIR/hooks/pre-commit"
> +:

Won't this always exit successfully? Is that wanted? If this sample hook
is activated but can't find an executable pre-commit hook to call out
to, should it complain in some helpful way rather than exiting silently
(whether successfully or not)?

Martin

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA8B1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 21:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeDVVtm (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 17:49:42 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39617 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeDVVtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 17:49:41 -0400
Received: by mail-wr0-f179.google.com with SMTP id q3-v6so25975760wrj.6
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TVBmxBp7B6ebT3dzoXq1W3fJcKdfith4oyWwItvYjWU=;
        b=aVeybHr2UPmKhnjCYKYpo821WixpgGHOpGeGoPMJUZGb4Pjqe+bijY8trPsrAgwkUa
         wbIsvDTKfje6wB2RdC5dULGPziSX2a/+FE+zJpO7vQpVjWakcnf8VFF5/yE/w0Xj9Z0u
         H4Iqwjrb3HQhkMMzBwFOhPwlqUD1si6cCy+2XD9aB+XkEH47laS7LzupdXhZs7CCQYyu
         uOWFp4LuAdeGKbIGlZYYZcI+9VduUNxGNw9Oxxp/S0LNh6PGoha3okj1ysgzMVC0T3Tq
         ei3z728Z9+CMvfRNXhfdewUT0JcybKvH1UwKAOVP5L+UgRitUWWl3jZwSKwUJa7agiKu
         EqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TVBmxBp7B6ebT3dzoXq1W3fJcKdfith4oyWwItvYjWU=;
        b=uBAFWkXY1zeiXjwLt+V4ezp7lJcuXUL4IdDDiTEKHD3fzIwevXpGi/ESuuVXIOBXuI
         Zi4Zm7X9ksXc0Eg3l8Th6bhfyXNfQ6ZNqzJ3ByXloNZHoHkklk/4kz8h++vjsxxbu2nV
         jWVP4bDBeWNOT+Fp81qXN+mrdBz4JZDz3zpfvw/ObgJ3/MnUMyMK8W6GWUYhaUm59Xw5
         62Iwg4sYZZS45GZA3gtO4eIE6gFs++ujvgxaY2XTnhVaQqcsdSbkelJiB948Ih5J2ZEX
         DFNz5rr72mvDqa51btpE3rs8d7OZ3SY02+DblmkBSJrN53n/FDZYLDinw9Z307/O3/Gc
         lNLQ==
X-Gm-Message-State: ALQs6tBkS+w6bW+2WiHKCXin1GfJM5C1cYxr2+9nsi3YMaJTB1wS0sCz
        FGfFayq43kgTjUBabBnNThI=
X-Google-Smtp-Source: AIpwx492j+p0oGDkBDlY6CHS8de/ddVeq2JeLMmN6tajXwUHwN/AvDn9P9eY/ZHRC7syZCHH4oMHAA==
X-Received: by 10.80.173.235 with SMTP id b40mr25030999edd.203.1524433780724;
        Sun, 22 Apr 2018 14:49:40 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o61sm6654175edb.88.2018.04.22.14.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 14:49:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 6/6] contrib/git-jump/git-jump: use column number when grep-ing
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com> <b9d2578d8dc644e68a09445e14156d789bfe395b.1524429778.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <b9d2578d8dc644e68a09445e14156d789bfe395b.1524429778.git.me@ttaylorr.com>
Date:   Sun, 22 Apr 2018 23:49:39 +0200
Message-ID: <877eoyewss.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 22 2018, Taylor Blau wrote:

> This patch adds the '--column-number' synonym '-m' to the default
> grep command so that callers are brought to the correct line _and_
> column of each matched location.
> [...]
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 80ab0590bc..2706963690 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -52,7 +52,7 @@ mode_merge() {
>  # editor shows them to us in the status bar.
>  mode_grep() {
>  	cmd=$(git config jump.grepCmd)
> -	test -n "$cmd" || cmd="git grep -n"
> +	test -n "$cmd" || cmd="git grep -n -m"
>  	$cmd "$@" |
>  	perl -pe '
>  	s/[ \t]+/ /g;

So this re-roll doesn't have the alias -m anymore, but this makes use of
it. Seems you just forgot to update this from v1, unless I'm missing
something while skimming this...

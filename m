Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FBA20248
	for <e@80x24.org>; Sun, 24 Mar 2019 12:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfCXMnA (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:43:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35321 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfCXMnA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:43:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so7110363wrp.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q0EL8KtJK8xYltzWNoSOkoyoWksE52qSN7KZ8vYn7Ss=;
        b=d/muyIZ61kR3chYdslXHb3WweHLcaJwS5SH67b0eWBYT5HPxz+ZGmrf5zkCd7bt54z
         xqz10E8PgYB7uVelxK6aImRajZhhLhcmponBqHrQ0NMfy/Npf6SMRmI6Y47pNLx0R0tO
         qGaduDgOwrTS79UZ2SQTUjtpDK30JFIAqTkRdqHkZVeRE8/V2p5rDJxkvQotMLky5XDm
         1Vtyxd+w0Q4Vktw5LCkQ3X2nU/VpY+QNZ22hh3qDntpKSToowg3D6fUtnYhRcbEDPwX/
         uCa7EUHlDeiTXUHAIcpqaEMctyWGnoUXA3ks4frw3JpVvs65pYOJWTVQ7EK+zAexdFO7
         pi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q0EL8KtJK8xYltzWNoSOkoyoWksE52qSN7KZ8vYn7Ss=;
        b=PHRENr19nWGDE7WEMA1y6V9cGQ0nqzxNzZA18RAkrsNoCNxoaYhGIfO86BDQM9EObC
         VXfGceCP+Qjdr2Eu3mwZPWirO1XGRLT4GxSIqhKz5epiX/8pfBzqgqalMJX6Ezgigezm
         RAJ8qphDgbVJ4S5xzajsVfl56XaUw9dIhBxAQPdUjYEHx/MKJVfbDY/lidGfisxiL7Pb
         hOHeugVHhGwlNZ+YROH/qx72rOOzLPrk0EGw6q3PGDwR18jnLUyrViHJTK1YiXhh+g5B
         N/y4/9/mQebhxlO5vlXwAbybjKZyE0nza40YSgYFWvz/viPvTrXqc7Od5q6+PBDhz5y8
         rtTw==
X-Gm-Message-State: APjAAAXKgXp2YscB4lg5NiutXiWH3ORDlS2dOf1mXpy+eJEoS6BeHE52
        TvdxCsoCzgdMoy4B1rtOu2Y=
X-Google-Smtp-Source: APXvYqyUnH3Qm9wp8ouSkTg7KDKiW3072i3z5MT1PhQ9/bpNh3IA+sHx9mzOgtNqkzAptyRACEjpqg==
X-Received: by 2002:adf:91c7:: with SMTP id 65mr12831662wri.191.1553431378364;
        Sun, 24 Mar 2019 05:42:58 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id i28sm19662558wrc.32.2019.03.24.05.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 05:42:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Keith Smiley <keithbsmiley@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Make stashing nothing exit 1
References: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com>
Date:   Sun, 24 Mar 2019 21:42:57 +0900
In-Reply-To: <01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com>
        (Keith Smiley's message of "Fri, 22 Mar 2019 23:12:34 +0000")
Message-ID: <xmqqh8bsphny.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keith Smiley <keithbsmiley@gmail.com> writes:

> In the case there are no files to stash, but the user asked to stash, we
> should exit 1 since the stashing failed.
> ---

Sorry, but I fail to see why this is a good change.  Did you have
some script that wanted the exit code from "git stash" to indicate
if it had anything to stash and change the behaviour based on it?

Is it a big enough hassle to figure out if the "stash" command did
something yourself that justifies forcing existing scripts that rely
on "no-op is merely a normal exit" behaviour other people have
written in the past several years?

>  git-stash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 789ce2f41d4a3..ca362b1a31277 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -318,7 +318,7 @@ push_stash () {
>  	if no_changes "$@"
>  	then
>  		say "$(gettext "No local changes to save")"
> -		exit 0
> +		exit 1
>  	fi
>  
>  	git reflog exists $ref_stash ||
>
> --
> https://github.com/git/git/pull/587

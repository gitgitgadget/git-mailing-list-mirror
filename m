Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E8E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 06:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJVObB (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 10:31:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38638 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJVObB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 10:31:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so3884384wrs.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HmvVVPkNQe2RGYFhQtyrTPJvb1o6XmuDe2RGnvryyxI=;
        b=E5TgyG5f0fakw5Qc1f/CIIkFoTIw29CvHYD3Efiu8IoQbunduNTzflCfgdMrdMTvyY
         VYlud/56MFz+9QtwY4C4u4niByy4d6+xgqfY3/pQNNSnrn9iUSWdotGVYOUHHLIhBKaC
         0a2jDfDtVzOMYWI+cygOtRnsCf7VEkBUweS26Gw2XQV48KooU7ZM2L5aF1LiDshF4KJ/
         +/L8pg8QzfaVpo2LBUXxLw4hOwT0WMKS0xKsqfhwVxvuY4VgshTUIfXMcs+N21KpIEEq
         1J7pweJe7xfGv+YqHpMVKzkg89ZbcdqbwF4Z+r6Y6lCsUlU4t5pU+nXr4lIuboZjbtdR
         HHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HmvVVPkNQe2RGYFhQtyrTPJvb1o6XmuDe2RGnvryyxI=;
        b=PWX4F26SYNutRsPHJHhrOPJYWvZd76Jtc8EiSXpzsZr8+/WjCNc653Vtw0FmQivVEe
         ClSl/Fl+Fc1Ps0Kqj9msFZY+LUa+cuwVv5N4AbhBfRbsgX56CwLcO3vGQyDT+qTVbM27
         4e/8qrZn3XYT3vOmlFkfvjIR4uS4yohcMtbB0OvNLO7+XeV8kcyINRZt3mX+9GIK3Qb2
         rIOGyyjvG/Cv+Bs2YAaE4JmAFS2vEvTs33dMJQfLaCxsJs0J2kYnYSO0D44gcBFxtxKI
         UBA746hx2eSGM4QucNUp9zu3mzLLdWg5nGpSuBiYsCX3sMfTiNJeY0eI8riwVf9YE2yU
         BKVg==
X-Gm-Message-State: ABuFfohgd2P/iytH70I9YnO1wFPqh+ytppaPwULHoBOEeC5GgTlFR8c0
        IXnftw5kFGSo3X9+XdzJDtjBgbs+lBY=
X-Google-Smtp-Source: ACcGV62pzWkPmI1EUQQtcpjGiq6ytyz738NVz8dMnt39tzsH1xOfiGL1NI/NKmfckHytcvCn5esF1g==
X-Received: by 2002:adf:dfcb:: with SMTP id q11-v6mr38354405wrn.253.1540188833048;
        Sun, 21 Oct 2018 23:13:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 2-v6sm29420261wro.96.2018.10.21.23.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 23:13:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH 2/3] git-compat-util: define MIN through compat
References: <20181022053605.81048-1-carenas@gmail.com>
        <20181022053605.81048-3-carenas@gmail.com>
Date:   Mon, 22 Oct 2018 15:13:51 +0900
In-Reply-To: <20181022053605.81048-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 21 Oct 2018 22:36:04 -0700")
Message-ID: <xmqqin1uv78g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> this macro is commonly defined in system headers (usually <sys/param.h>)
> but if it is not define it here so it can be used elsewhere
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---

I am between "meh" and "moderately negative" on this change.

 - Definition of MIN without matching MAX makes me worried about
   longer-term maintainability.  If we were to add MIN() we should
   also add MAX() to match.

   However, "git grep -e '#define MAX(' -e '#define MIN('" tells me
   that we do not use these anywhere and Brian's use of a single
   MIN() is the only thing that makes this patch interesting.  That
   is the primary reason why I am very close to "meh" on this.

 - We need to make sure that this is enough in "git-compat-util.h".
   Ideally, this should be after all "#include" of the system
   supplied header files, and before any use of MIN() macro
   ourselves.  I am reasonably sure that the place this patch chose
   to insert the definition satisfies that criterion within the
   context of the today's code, but I am unsure if it is even worth
   having to worry about it in the first place, given how rarely if
   ever the macro is used.  I think Brian's reroll of the sha256
   series even gets rid of the use of the macro, as it had only a
   single place that used the macro anyway.

So...

>  git-compat-util.h     | 5 +++++
>  sha256/block/sha256.c | 3 ---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5f2e90932f..7a0b48452b 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -218,6 +218,11 @@
>  #else
>  #include <stdint.h>
>  #endif
> +
> +#ifndef MIN
> +#define MIN(x, y) ((x) < (y) ? (x) : (y))
> +#endif
> +
>  #ifdef NO_INTPTR_T
>  /*
>   * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
> diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
> index 0d4939cc2c..5fba943c79 100644
> --- a/sha256/block/sha256.c
> +++ b/sha256/block/sha256.c
> @@ -130,9 +130,6 @@ static void blk_SHA256_Transform(blk_SHA256_CTX *ctx, const unsigned char *buf)
>  	}
>  }
>  
> -#ifndef MIN
> -#define MIN(x, y) ((x) < (y) ? (x) : (y))
> -#endif
>  void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
>  {
>  	const unsigned char *in = data;

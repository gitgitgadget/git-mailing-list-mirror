Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238B01F45F
	for <e@80x24.org>; Thu,  9 May 2019 07:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfEIHcX (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 03:32:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37307 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfEIHcX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 03:32:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id w37so1117052edw.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YkD6xXnQw6Ko9uLniWSA7RliaXcFCpAp+XLxpmYbhiQ=;
        b=pFoyHDYWptQssaHGtHqVBo9VlVOmPBE69sqK6o+9bw/ZvaGAmmvfr1pz1yY6cfma+t
         WJ3ZyOgOAGyfGKifd95KlP6euCQYvvQ+rIBfMBJbdIc34MutqO3yZDUbdJl6tx4RwfCH
         53OX4YLSJG/idmTsWKI/C8KqBPpx9LT5blfvda8AqSMT3Kds++tsGke+FCyxLM9ufO8c
         Gd9LKmS7nOA0NgK6iOI1A2C/qJMQUqlY6LgahGiqh5BPBP05e0uSQpcY+uVrPXDTrdbS
         gPLE8sUPJIrilzwzDHD0uDaV3FJfnO+e9k3Ng9brJv9E30NE2ntfrf+Mc0T3A+IW/Qcq
         fE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YkD6xXnQw6Ko9uLniWSA7RliaXcFCpAp+XLxpmYbhiQ=;
        b=h5u+/ZToFM5WSVbOoaQOWU3iZ3q5g6+IJ79uVehjEGZfLpnhDwGfDJZnsQK+Ne+9dC
         OXXK6+DLpJurueOLUV2K1Lz61PUfDYX+poIFtd9CMdAqngldhrJGuHl/9ds0jC1TkDRE
         i9UjU6kru3egbHOM9Ho9B6lx57eg3rHEQtLbblDarmDGGiIplC3ZXw8yS2cwGjfnIi7g
         2NUzVK6SX8gvoPfb7owyVQIf9bts0QfcyS2b/0+ImVd2AplBupMFN7ED8yi6rycHB/Or
         QodTZKf0NGAgXKEHNhNqyVqDCzf2f9tz2/ipl62rrKOQSY5xxGuv7jfaKQg8s5aEJRRh
         74Zg==
X-Gm-Message-State: APjAAAUUxaKgfOKF433NBiqZk3mbPIB6d8PTomF88cOIku5xIA26q+/M
        1qKf3j4aIqjB3b9OdH4AC/zTnVTA
X-Google-Smtp-Source: APXvYqyFFxMObbnv6jRettR9m5afF/4zTtTDXnXFBW8B9EHu7lbQ3uaXovkTbqrfKwajw4Kr9gpSqw==
X-Received: by 2002:a17:906:6c5:: with SMTP id v5mr1893021ejb.214.1557387142131;
        Thu, 09 May 2019 00:32:22 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id p52sm360851eda.79.2019.05.09.00.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 00:32:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Osipov\, Michael" <michael.osipov@siemens.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Improving HP-UX support
References: <603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com>
Date:   Thu, 09 May 2019 09:32:20 +0200
Message-ID: <87lfzggk1n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 08 2019, Osipov, Michael wrote:

> Hi folks,

Hi see Documentation/SubmittingPatches for how to submit patches inline
instead of as attachments.

For the sha1dc change it seems trivially correct, but we import that
upstream project as-is, could you please submit a pull request at
https://github.com/cr-marcstevens/sha1collisiondetection then we can
update our version?

> diff -ur configure.ac configure.ac
> --- configure.ac	2019-02-24 16:55:19 +0000
> +++ configure.ac	2019-05-08 11:31:42 +0000
> @@ -475,8 +475,18 @@
>        if test "$git_cv_ld_rpath" = "yes"; then
>           CC_LD_DYNPATH=-rpath
>        else
> -         CC_LD_DYNPATH=
> -         AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
> +         AC_CACHE_CHECK([if linker supports -Wl,+b,], git_cv_ld_wl_b, [
> +            SAVE_LDFLAGS="${LDFLAGS}"
> +            LDFLAGS="${SAVE_LDFLAGS} -Wl,+b,/"
> +            AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_wl_b=yes], [git_cv_ld_wl_b=no])
> +            LDFLAGS="${SAVE_LDFLAGS}"
> +         ])
> +         if test "$git_cv_ld_wl_b" = "yes"; then
> +            CC_LD_DYNPATH=-Wl,+b,
> +          else
> +             CC_LD_DYNPATH=
> +             AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
> +          fi
>        fi
>     fi
>  fi

Do we want to also have something in config.mak.uname to always do this
on HP/UX?

>  /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
> -#elif (defined(_AIX))
> +#elif (defined(_AIX) || defined(__hpux))

Seems sane, and per my googling even though HP/UX now runs on
little-endian hardware it's always big-endian. But in this manual they
advice doing it at runtime with a TEST_ENDIAN() macro in sys/portal.h:
http://h20628.www2.hp.com/km-ext/kmcsdirect/emr_na-c01921401-1.pdf

Is that something we need to worry about / support? E.g. in the
configure script?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56AB1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970734AbeCSTMK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:12:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39058 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969958AbeCSTMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:12:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id f125so9453329wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wmt+b0Z/O0kBDr3yceCLK1dWmLtTcS1cqo3YkG3XmTc=;
        b=tX78W4fBO+VRvx16aDBUs/Ns2ZOmmJWiOsXfEJAaRFaf6lUeKcyyWAvMStObw9mr3U
         d/msb3DkAOCkdt091to8Fp8y3HX41cvyq+A+/Ozgw17aj1eGlQNMcrO6aSyCLd7oimsA
         gFFx5jXIEf2oUziTcHbeYFNZD2aVvLfuVXzMD3B1ItYJFItgiD45dl4UfrfpjxRTtt98
         YXAOWCplfDJUuOi1jOEkUYm6trr8tRLMKKEoUhmMSDe34hEZNrsdvV4p1iv7bflYw3R8
         118tLpeL5H9WjvzVZ/CjyartsWsfKUQ8QoWjiboZLHh0m5LGzlVOLZ0IB1MY2jCuHOHs
         YZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wmt+b0Z/O0kBDr3yceCLK1dWmLtTcS1cqo3YkG3XmTc=;
        b=evfVuF0CDo+IFR1sfs7MgCWlmTR0z4u4xOy+JOjU+iIR67FT4ex3MXgsByXRuzIn5L
         Vkyzz7Jc6N013ho9UWBPj6zUH9C8r4TGaJJGOUsbBsMCvdgQr4GsfiVLfGyWb+PzgcNO
         s5MT3VuCdiKMAZLQ3r7ygwlrejuS1+KzJ0WnDO+QXilm4NDoSQJ9rVobFzbcnBzgeb7G
         VP8huixXXqD35BbruiEuZdnHggC1xla2SuS9B0o5OdnFiI6nbi5ZUT+LADT0Qt5c01Xr
         NBy9VWIKxAz7YnQkvsMXJkqZ9WCfUhXp1u0G0hyWHlB2lZZqHTDamc0fm8wAG64CMA+G
         D47Q==
X-Gm-Message-State: AElRT7F9X/xOqY/Y6HJQAh88BIpM3wCjX5RYABF3seZY5leHZlzsvCed
        c4l6/KedX8ZJBJBQB16egJM=
X-Google-Smtp-Source: AG47ELvWoh0k89wwAEyavsjELs9JENgVXySsUdoyt2jz0xgmO2Z5Z9qIaDt6YG1TgYViD0EhALerVg==
X-Received: by 10.28.114.6 with SMTP id n6mr9474948wmc.70.1521486724689;
        Mon, 19 Mar 2018 12:12:04 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id k1sm953042wrf.66.2018.03.19.12.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:12:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180319025046.58052-3-dnj@google.com>
Date:   Mon, 19 Mar 2018 20:12:02 +0100
Message-ID: <87zi33c22l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 19 2018, Dan Jacques jotted:

> +gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
>  mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
>  infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
> +localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
>  htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
> +perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))

I stole a small part of this for my a4d79b99a0 ("Makefile: add a
gitexecdir_relative variable", 2018-03-13) patch now sitting in next, if
you do this:

    diff --git a/Makefile b/Makefile
    index 101a98a783..033a55505e 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -501,9 +501,9 @@ lib = lib
     # DESTDIR =
     pathsep = :

    -gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
     mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
     infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
    +gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
     localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
     htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
     perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))

The merge conflict becomes a tad easier to deal with, also makes sense
to have gitexecdir after infodir since that's the order we're listing
these in just a few lines earlier, and this is otherwise (mostly)
consistent.

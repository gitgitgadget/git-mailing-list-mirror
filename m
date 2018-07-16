Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452211F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGPVOt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:14:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35076 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeGPVOt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:14:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id y22-v6so2666109wma.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GN9X9vIQP7PGQbny2hOZ31zJHzoW0aTipGQxuTVeZiY=;
        b=A9RyHkMqUu4G3rPNEcZqW7oRWVlapAHcJNlSnUQZcMRJsoxHvUUe43ihOsjjclJ6EP
         gTX+nBqdwqInmxJw4ZzCX+qGVZZ/FFkv+KsAWP7aPKV+2KCQwkOIC8BlbfWrcqPVsWY5
         T6yvYpl93e/tsBIuM9m+dyzzqjbOhrOggejfnDufVrKEqcIxzzY6gaezZZeTHKCOem8+
         zyDyenf0EIuCHC9tJF338/HIJL01GpVKQQigGJJedw2HQABAa8U9+amSDXkmBl/k6gnx
         j/sJECbxdwcn6neNXmdZ1t7sXueQPM0jiLky6wdO8aY5Fh/sZ9e5G/FSOm65WDbKtFI5
         QP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GN9X9vIQP7PGQbny2hOZ31zJHzoW0aTipGQxuTVeZiY=;
        b=aDCsksE9gQfCnYj6gLXzZX2fwkDh1kUUXyCsyRllPE3oUAVCv2KllFU3GVnuvXuq8E
         m5IV+G57d/H0RslHf6f41NCp7OxfIP6orhL3rY0XMsBM4Tbm5iJirbv/z1LBGi/Lw5Rf
         +N+0UUa6HoDQ5de6sO7W9EVSY2IS9/1g3fJPzRjfKiJhZIMiq1CxYT+8s5FrzRirrKE/
         5gE9G76Te2DQrvW8LFpCx9azsQ0lUKcKyWLCmZOEMm2VHNCz2qi1KSFahPwsVrbmp3yh
         fn4YpiRkwGbTbVswJqNvstVSBriWwmqvnDZNMrJ99t7oxsEjzBm5mHlSEcr4u5jo3HWS
         wgJQ==
X-Gm-Message-State: AOUpUlH4B3AiSBp2KbQmmx5o9si/AaK1CLaOZxkLWmLJWedKQvysjyGH
        X3dWYQWdH9lf4sUVRK3uv4M=
X-Google-Smtp-Source: AAOMgpdfV5cKhz1URS4iz9GlhrhI8FKrzvI0DH6Rb370Zm3L0cyQLKHpHdhiYkWeV1OAL5C/BNTecw==
X-Received: by 2002:a1c:b80c:: with SMTP id i12-v6mr5095813wmf.30.1531773941263;
        Mon, 16 Jul 2018 13:45:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 125-v6sm22695634wmw.9.2018.07.16.13.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:45:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/7] gpg-interface: introduce new config to select per gpg format program
References: <cover.1531470729.git.henning.schild@siemens.com>
        <cover.1531470729.git.henning.schild@siemens.com>
        <8e6f4f547475e3ce26799901e255a78ea74dac8e.1531470729.git.henning.schild@siemens.com>
Date:   Mon, 16 Jul 2018 13:45:40 -0700
In-Reply-To: <8e6f4f547475e3ce26799901e255a78ea74dac8e.1531470729.git.henning.schild@siemens.com>
        (Henning Schild's message of "Fri, 13 Jul 2018 10:41:27 +0200")
Message-ID: <xmqqva9esydn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> +gpg.<format>.program::
> +	Use this to customize the program used for the signing format you
> +	chose. (see gpg.program) gpg.openpgp.program is a synonym for the
> +	legacy gpg.program.

I _think_ you meant "see gpg.format", but I am not 100% sure.

When X is a synonym for Y, Y is also a synonym for X, so technically
speaking this does not matter, but when we talk about backward
compatibility fallback, I think we say "OLDway is retained as a
legacy synonym for NEWway", i.e. the other way around.

Also, `typeset in tt` what end-users would type literally, like
configuration variable names, i.e.

	Use this to customize the rpogram used for the signing
	format you chose (see `gpg.format`).  `gpg.program` can
	still be used as a legacy synonym for `gpg.openpgp.program`.

>  gui.commitMsgWidth::
>  	Defines how wide the commit message window is in the
>  	linkgit:git-gui[1]. "75" is the default.
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 93bd0fb32..f3c22b551 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -182,7 +182,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> -	if (!strcmp(var, "gpg.program"))
> +	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
>  		fmtname = "openpgp";
>  
>  	if (fmtname) {

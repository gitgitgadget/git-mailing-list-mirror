Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202861F576
	for <e@80x24.org>; Tue, 13 Feb 2018 07:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933579AbeBMHvr (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 02:51:47 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33763 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933463AbeBMHvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 02:51:45 -0500
Received: by mail-wm0-f68.google.com with SMTP id x4so12052909wmc.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fM8iPJRcE+y8NnkKi1MkbBBnSjbmVTNLi6vmdUHp/o0=;
        b=qVDReT6kQdmo8FCfYefsICJITWz/bhl8QKUePA+2PpI5vqnZBrhzjhpYRTCI5OJkAJ
         ucAwHnh8Q2Ql0NC1BhrfqNuuR/fb85RfZqBP2uh4XZVunT8sgMItMYFfP3vA/Q8RNV2Z
         W7nFVQhyu+Abi7ScxLHLK+QcDj4NZ5DmxwxCyR+QDvZKHnDuaACq941KOQMm028D9f4H
         3d70dBj72WvpqwPqxsbxvy2ENj2VH8kuP8YhIdYFz4414x/bexuxsDPA2D9PhILx3F9+
         bzAz/a6hBZ+/8JJrJj0y83ymPHM5q7u+1xzRnkFX48gBNTaA9yXEywPkrdgJAO/JKYA0
         y7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fM8iPJRcE+y8NnkKi1MkbBBnSjbmVTNLi6vmdUHp/o0=;
        b=KTfgzKMazYYfnVTnN5tQzRsLr8e3NlbwtUSMkTn5+D0aTHvB9PfrO3RyEIhBWx68QJ
         xWU/CJ1c+ONn9Pjuo4KWnRtagO/0jL8B6wkZIOkfJafHA/SSnw/Z2yqxoWAKDEToLXmZ
         jm/DBoy7EHsrfaGzMmEQ2c8uVZ2ljRgQ9Jll4S/SK1OMw9k/7kLN6N3KSBtGonNGRQB5
         ZOrsQBOdNSyqZWN8x/HhAOnT2i6hCyxRHMQ47RlsE6z7Wzt6Yuvr8MAorxf+ZLrP5NDQ
         nK2j+2hQ738Zg9bTlRIczW2+tGx+Sg60MZ3b4OHxmEAWDvFT5x1CG8Az+vrjeROItPY8
         SR8Q==
X-Gm-Message-State: APf1xPDoLlVxYjymLm2npi30OPyb1sx1qv3Agv6n+mO4oqGDO/joA6rz
        EAnxxsd2KnxCNcA/VI31bws=
X-Google-Smtp-Source: AH8x225Q+1+h0pze5j2w0tJHHpM4DzWzLhQSjjjPFtnswNspph9PVTTu1xIZO676DVG42jcoH080xg==
X-Received: by 10.28.192.24 with SMTP id q24mr449710wmf.149.1518508303776;
        Mon, 12 Feb 2018 23:51:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p21sm5692646wmc.28.2018.02.12.23.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 23:51:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
        <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 23:51:42 -0800
In-Reply-To: <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 13 Feb 2018 01:58:19 +0000")
Message-ID: <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> I must admit that I didn't think about the effect of the useless
> "| sort" on the exit status!  What I saw was: a process that
> received no input, sorted nothing and produced no output - pretty
> much the definition of useless! ;-)

I am not sure what you mean by "receive no input, sort nothing and
produce no output".

Ahh, OK, this is a funny one.  I think the original meant to do

	grep ... | grep -v ... | sort >actual

but it did

	grep ... | grep -v ... >actual | sort

instead by mistake.

And we have two possible "fixes" for that mistake.  Either removing
"|sort" (and replace its only effect, which is to hide brittleness
of relying on exit status of the second grep, with something else)
to declare that we do care about the order multiple warning messages
are given by the last test in the script (by the way, the script is
t5536, not t5556; the patch needs to be retitled), or keeping the "|
sort" and move the redirection into ">actual" to the correct place,
which is to follow through the intention of having that "sort" on
the pipeline in the first place.  I somewhat favor the former in
this particular case myself, but the preference is not a very strong
one.

Thanks.


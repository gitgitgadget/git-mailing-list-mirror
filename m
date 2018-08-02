Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC621F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeHBXJx (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:09:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53837 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeHBXJx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:09:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so4049462wmh.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Wzk8xTAb8lBXyR9rOyGi7DQiL++E+9GzdErM/ZflCB4=;
        b=YYCvOz+aYODNgee/2oQl2rLcVyYwmH6SbCdE7HBLncQXms91bRhR6p1pDd9T+6VE+g
         wEveCeMlMNRe1iyfBDQYruIro3CNTqnHAUHESrRm2eq0C5czVOS9RMho52gGOife0FBG
         P6L4knsKtvWPdX8jXbhZDifnqm0IrTeCz+8ujVvUxUTxT8GxkB53LdcaENXIwYpTZ9fu
         tehUz6bh0F/4Ln3eF0rTA/nRwISVX3zkVbUpQq75taJnVBA++IkFWfQON45jE5AZ0fw/
         iIPuVFPjOlqHd+HfPRjozY2gnxhUAG7TG4mX/RI7c0UILhCRQ5HwnqBbrhAcbb53r/HN
         iclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Wzk8xTAb8lBXyR9rOyGi7DQiL++E+9GzdErM/ZflCB4=;
        b=PdYbA3i01bAol3TDWDYwFC8n1OHVMNYQ0Fp/dNPi5h3hszIa1DaS2uNBa5L07UoDY3
         zefReR3KLNSmQdinMz3JHHWBet5+VzWgTtv6A2XL4zKyFeGV4vu4J49VkcCSoZKDUTpJ
         QeMLuXtaBSctd44JWZvraXLoct81z2Zzm2E0pk7N8ASK+rkkEx6kuhelh7BSTRuU5Phj
         DEecV6P8F73gGate+17Hg0dGV19t5ZpaDi+tRqAr0BR0AV5ydcC0db02/7u3HbC4+4Af
         NEhklsg5ugvTi3R6QKUJMTLghl+/IhPOr8JT/H99CCBj5fuXrID1C/t6kD0lTn8vO8AY
         S7XA==
X-Gm-Message-State: AOUpUlF97owGIuJ4WiloRPNvY8Xg+vFnBRTDb4Ls9vkHXMaEB72an2Bi
        2CyxXxT2LvY9U/tNCBDjnWk=
X-Google-Smtp-Source: AAOMgpc+TE8JwAIrPykI1YTvmtXw+khRhyq0QT7JUT6nxnsNDZBC22qUvtjvEO+RrYvtZ7zuymlc0Q==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr2981478wmf.43.1533244616364;
        Thu, 02 Aug 2018 14:16:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q188-v6sm4149648wmd.36.2018.08.02.14.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:16:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] add, update-index: fix --chmod argument help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
        <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
        <20180802165457.GC15984@sigill.intra.peff.net>
        <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
        <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
        <4a570679-3024-1541-95da-0fa8baef75ba@gmail.com>
Date:   Thu, 02 Aug 2018 14:16:55 -0700
In-Reply-To: <4a570679-3024-1541-95da-0fa8baef75ba@gmail.com> (Andrei Rybak's
        message of "Thu, 2 Aug 2018 23:04:48 +0200")
Message-ID: <xmqqin4szcxk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On 2018-08-02 21:17, René Scharfe wrote:
>> Don't translate the argument specification for --chmod; "+x" and "-x"
>> are the literal strings that the commands accept.
>> > [...]
>> 
>> -	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
>> +	{ OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",
>> +	  N_("override the executable bit of the listed files"),
>> +	  PARSE_OPT_LITERAL_ARGHELP },
>
> Would it make sense to drop the localizations in po/* as well?
> Or should such things be handled with l10n rounds?

It should happen "automatically" (eh, rather, thanks to hard work by
Jiang); for the rest of us, when the l10n coordinator updates the
master .*pot file next time.

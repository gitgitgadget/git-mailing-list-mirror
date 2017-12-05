Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A005920C11
	for <e@80x24.org>; Tue,  5 Dec 2017 10:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbdLEKWO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 05:22:14 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:43831 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdLEKWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 05:22:11 -0500
Received: by mail-wm0-f54.google.com with SMTP id n138so270823wmg.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=olahRjH8CAK/Nw0saV5Cb22b5tKLeChKR7l7fG8c4YY=;
        b=SWr0H/85jOIfNDFPl/lkIDiUWiy10VzAXA0Aqb6vkoaUDOJg9ae40qFI32cHzc1+aO
         YKeQPQIkI6HczXC4Uf8Pkc5omXh0pLXFOVf/opRgOMem1mQsikq+WtVHYPbwod0G+Ft1
         hHI/5My/gmahm2+379eTmXEdL3OykSNGPDTvTZk95D5Glk2h21bQ58J5cIWDutc9HXLm
         y57MOU5mXTNTh53LMuq37UrfGS/cqAKzpK91sKNUn0SsM3yDkKvrZYxhBToQNOQ2sBXP
         r1ZyZyuIvnyvNfFF5Uj6Fkh12uAEO6PNhdk7wNH9GiugSN7aPDjanWaJzwv+YzP/56qO
         BfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=olahRjH8CAK/Nw0saV5Cb22b5tKLeChKR7l7fG8c4YY=;
        b=uFM5kHlmh4ZwO8z1ahfelkXJ3gK1ONxoG0uCrsZadkMxIxcs72vbDAVoIJITd09A5q
         Kv4Ee8WWXoTm56ZhI57Is9NVxAFidAX/15kDEXoeMMY53XJmF9tWgkXzUnrA02nQRMY/
         EdZeQdF07bwp9Pna0ILahx24loArstJvBIIo0tjsC/8WMR3F4QwpSpYfO5fLdq23//5T
         xiafswPLtQmeymU2PYqnRuNw/valKon1KnizPywlsiEYmh6nHxWrPUeRk3L1be9wcPXU
         5DWeu/LuWMaBDuH52bpQt55kkMLBOUFcNQSSkph7TXJQGx1DVUoIzZkZ9WuERvTmWLqU
         ZsoQ==
X-Gm-Message-State: AJaThX5NDcTHr38Tl6GHeiQHa7aWkEu8HqzNDUKQfYhXIsKQYVlbMJ3Y
        PwtTZyWQ6+I0LwrT/0F0oWw=
X-Google-Smtp-Source: AGs4zMapjDTWBKdvP00ZZYpseDPxdJSrnOYOhAjJ73Dj89zp8IhJEklD6/ZrSgh60f4uX1TJPIwglw==
X-Received: by 10.80.209.193 with SMTP id i1mr34531332edg.107.1512469329916;
        Tue, 05 Dec 2017 02:22:09 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id a16sm60455edd.19.2017.12.05.02.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 02:22:09 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eMAMa-00076c-5j; Tue, 05 Dec 2017 11:22:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takashi Iwai <tiwai@suse.de>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] Makefile: use the sha1collisiondetection submodule by default
References: <20171128213214.12477-1-avarab@gmail.com> <20171128213214.12477-4-avarab@gmail.com> <20171205070249.GC4788@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171205070249.GC4788@sigill.intra.peff.net>
Date:   Tue, 05 Dec 2017 11:22:08 +0100
Message-ID: <87bmjdscdr.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Forgot to CC Stefan & Brandon who were involved in previous
discussions]

On Tue, Dec 05 2017, Jeff King jotted:

> On Tue, Nov 28, 2017 at 09:32:13PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Change the build process so that instead of needing to supply
>> DC_SHA1_SUBMODULE=YesPlease to use the sha1collisiondetection
>> submodule instead of the copy of the same code shipped in the sha1dc
>> directory, it uses the submodule by default unless
>> NO_DC_SHA1_SUBMODULE=UnfortunatelyYes is supplied.
>>
>> This reverses the logic added by me in 86cfd61e6b ("sha1dc: optionally
>> use sha1collisiondetection as a submodule", 2017-07-01). Git has now
>> shipped with the submodule in git.git for two major releases, if we're
>> ever going to migrate to fully using it instead of perpetually
>> maintaining both sha1collisiondetection and the sha1dc directory this
>> is a logical first step.
>>
>> This change removes the "auto" logic Junio added in
>> cac87dc01d ("sha1collisiondetection: automatically enable when
>> submodule is populated", 2017-07-01), I feel that automatically
>> falling back to using sha1dc would defeat the point, which is to smoke
>> out any remaining users of git.git who have issues cloning the
>> submodule for whatever reason.
>
> I'm not sure how I feel about this. I see your point that there's no
> real value in maintaining two systems indefinitely.  At the same time, I
> wonder how much value the submodule strategy is actually bringing us.
>
> IOW, are we agreed that the path forward is to get everybody using the
> submodule?
>
> It seems like it's going to cause some minor pain for CI and packaging
> systems that now need to care about submodules (so at least flipping the
> switch, but maybe also dealing with having a network dependency for the
> build that was not already there).
>
> I'll admit I'm more sensitive to this than most people, since I happen
> to maintain a fork of Git that I run through an internal CI system. And
> that CI otherwise depends only on the locally-held fork, not any
> external resources. But I'm probably in a fairly unique situation there.

In no particular order:

 * I don't feel strongly about 2-4/4 in this series. I just hacked this
   up because it occurred to me that I'd left this sha1dc stuff in some
   in-between state and we'd talked about eventually moving forward with
   this.

   We've had two releases with the submodule being purely optional, if
   we're going to keep it it seems logical to start at least using it by
   default.

   The main thing I want is for the answer to "why do we have the same
   code twice in git.git" to not be "Ævar added a submodule and never
   followed up" :)

 * The main benefit of doing 3-4/4 is to get the git project itself to
   dogfood submodules & have the entire community enjoy the resulting
   fixes that'll come out of that. Not that it's a big bother for us to
   maintain the sha1dc/ & sha1collisiondetection/ directories and we
   need to have a submodule for our own use.

 * We'll never find out whether submodules are a hassle for downstream
   git.git consumers without something like 3/4, where you'll need to at
   least supply NO_DC_SHA1_SUBMODULE=UnfortunatelyYes so we'll get
   people coming out of the woodworks complaining that we've broken
   their workflows, right now with "auto" they won't even notice.

 * The network dependency for internal builds is a bit of a pain, but
   with this 3/4 you can still just supply
   NO_DC_SHA1_SUBMODULE=UnfortunatelyYes and it'll work. With 4/4 and a
   hard dependency it won't be so easy, you'll need to clone
   sha1collisiondetection internally somewhere and use url.X.insteadOf=Y
   to rewrite the submodule URL.

 * I forgot to note: Since git-archive doesn't include submodules
   (missing that feature) 4/4 is blocking on either just hacking the
   "make dist" target in git.git to monkeypatch it into the tarball (we
   already do this for other stuff), or making git-archive support a
   --recurse-submodules option.

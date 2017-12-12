Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80121F406
	for <e@80x24.org>; Tue, 12 Dec 2017 18:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbdLLSOQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 13:14:16 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:44583 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdLLSOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 13:14:15 -0500
Received: by mail-wm0-f50.google.com with SMTP id t8so440411wmc.3
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 10:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EjJ67RQW8leVYd8DrbZ3XB5RPV97UOcC9fcO8HQP8Hk=;
        b=V5itd9RTwgef4vde/841kjcndruYrIozBVkpHVBwAEm107aGqzqaDVGovs8+W79yXa
         Pf+VzJ4vuyL3rrODx3/Su4TJBj1ltfkWLKWXvzsfkST55uE3GAEPdOhU7wgG6rq+X11b
         gaX8jyErSy5Wlpb5zP774LCWLN0oKs7+eIZe+pHY45NWjhVPqBV+ZjC0Zn6qi14lb1+5
         vBUZC9YR9D6NDFKbGhsRry6xQupfzrJ6wT5awS6GGUCEfIk+/gNQh/i6G85cCvtrYesK
         18wkDVhPptPY+cQ920RkGqypXiSOmlVkT7bkw6hSMm8KlYzKGsy/9In+UEE4RoMZCwYH
         1/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EjJ67RQW8leVYd8DrbZ3XB5RPV97UOcC9fcO8HQP8Hk=;
        b=VbmduEfGxY4IUGdmUawAywa9f8Hs9KIG4ckgK1ipaO3eYlmPGO8QKQJ9L/kMvvAcOs
         cUprg4t2RdnLAF8xmCwjqQR6Z7IEXVjTWtGfuACdIeu1iA9vq6UwdKCUS6p4gNifo9Yz
         CPSGOjx8DBCxwh0hgoM9OiQWlfI81qvOlzZ6uUceM43llzg2pWZGYXtG7wBlkTHgBdHC
         ML0zZXsghhh9VF6o8gfWqSRY8dHfj74nGBibtd2ZL0YUroKz9Xm/U7eodpzC+yAFl1NI
         PVjsjCIaZksrzWxPO21r4M2Z1+QhxF9V3cE9o2Hyj16bTpnvoz5uX0eGPKsgcCBGjUQX
         1MRw==
X-Gm-Message-State: AKGB3mIJ9VkFS7wpGKsY+Pr5S5IwiNM3MDp/mPT59jvesYoLz++LZFvi
        Flv8nw0XRxBFMC92cW8RFSfxcxp7
X-Google-Smtp-Source: ACJfBouzSFQWtV9DcS5wijWnyNZq7gdgfsG+89WQ5NteqQ9v8bi/wyn1nhoueEpiAbLlDBwLLJxWvw==
X-Received: by 10.80.221.130 with SMTP id w2mr3993835edk.226.1513102453876;
        Tue, 12 Dec 2017 10:14:13 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id x18sm78807edb.89.2017.12.12.10.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 10:14:11 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eOp4D-0003kk-Cp; Tue, 12 Dec 2017 19:14:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     Thomas Adam <thomas@xteddy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com> <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop> <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com> <87mv2p89wu.fsf@linaro.org> <20171211172615.jfsjthkvs4itjpcn@laptop> <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com> <20171212103040.jbgkyet5rapqxi44@laptop> <87indb99xy.fsf@linaro.org>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <87indb99xy.fsf@linaro.org>
Date:   Tue, 12 Dec 2017 19:14:09 +0100
Message-ID: <87fu8fddam.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 12 2017, Alex Bennée jotted:

> Thomas Adam <thomas@xteddy.org> writes:
>
>> Hi,
>>
>> On Mon, Dec 11, 2017 at 08:46:46PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>> I.e. we'd just ship a copy of Email::Valid and Mail::Address in
>>> perl/Git/FromCPAN/, use a wrapper to load them, and then we wouldn't
>>> need to if/else this at the code level, just always use the module,
>>> and it would work even on core perl.
>>
>> I disagree with the premise of this, Ævar.  As soon as you go down this route,
>> it increases maintenance to ensure we keep up to date with what's on CPAN for
>> a tiny edge-case which I don't believe exists.
>>
>> You may as well just use App::FatPacker.
>>
>> We're talking about package maintenance here -- and as I said before, there's
>> plenty of it around.  For those distributions which ship Git (and hence also
>> package git-send-email), the dependencies are already there, too.  I just
>> cannot see this being a problem in relying on non-core perl modules.  Every
>> perl program does this, and they don't go down this route of having copies of
>> various CPAN modules just in case.  So why should we?  We're not a special
>> snowflake.
>
> I less bothered my the potentially shipping a git specific copy than
> ensuring the packagers pick up the dependency when they do their builds.
> Do we already have a mechanism for testing for non-core perl modules
> during the "configure" phase of git?

Current git.git master does two things:

 * For Error.pm we test at build time. See `git grep Error --
   'perl/Make*'`. If you don't have Error.pm when you build we'll ship
   an old copy of it, and use that forever even if it's installed from
   CPAN afterwards.

 * For Mail::Address, Net::Domain etc. we don't ship the CPAN module,
   but some fallback code. We test at runtime, see `git grep
   eval.*require`. If you install the package from CPAN we'll start
   using it at your next invocation.

My "Makefile: replace perl/Makefile.PL with simple make rules" currently
cooking in pu changes that so that:

 * We always at runtime test for the system CPAN module.

 * In the case of Error.pm we happen to ship a fallback, in the case of
   Mail::Address etc. we don't and have fallback code, but we could also
   just ship a copy and remove the fallback code.

This makes more sense, we always "dynamically link" as it were, we'll
just change the target to (a presumably newer) system module in the case
of Error.pm if it's found on the system, otherwise use our fallback.

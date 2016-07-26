Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57C6203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232AbcGZULs (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:11:48 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33001 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbcGZULq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:11:46 -0400
Received: by mail-qk0-f172.google.com with SMTP id p74so16546568qka.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 13:11:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OsZh0FMPX4/E4NMXE1R3+PhnZs8J8ApRlnPwJol5eZU=;
        b=VunqxB5GLGgX2NfGSjk6PlFOdX5fuEu0HgSSUb3zHQ3R/SSe7DWX7dH/ahM0/RAZsM
         iMnjBA4Mqe8c1Gnah9PT5qaEuPozTptnRD5p20TorK7cMwHrjVqHpNvDUGk+HrT+XB7j
         AtFFJnKgGkqZxhkoHrRAbgWlwmSty2h3qjGmiZH/IM7iwp67UfyRWW6aQdoebTaxa6Dv
         SSRd2FUOYGKrMB6gXjNs6KQA30on0KpW9nnboWiGFWBr23/64PdoQ4yBefvOPo+2zgsU
         7vWGkwQZe2ddtdkVsamj7gIhpyLwrQGGHpy52L04e7v5BtA1XFFamIiIPqv26IBl64I3
         XtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OsZh0FMPX4/E4NMXE1R3+PhnZs8J8ApRlnPwJol5eZU=;
        b=L5rM0YLhNYgAcAmA34em5EZ7cjvEs5vIcq/qMG6egZ/H7IsJCREkYNj8zK3yJtIljX
         BGftL/p/NRaj9+/r/v1YwiYauQR3ku/aDDwhnXvgAx/Aq63ADIhs8DZtP7FdhOiY6r7X
         +eUwqSHNfOIdt7thWzc18w2g8HPdgA7wUROVjf1W12uCVPFLw01A85KrR+oBm+bdTnRs
         uX7R891lMKTs3LDf8I01UXpt98wwVH/8wTG5wc1kQ7IPYcU35EP8gK0WmHEAA0bAso6N
         OvoT8wDmWEk920HGJSWADcI/1gnEHZppyg2uFkOKDfvYZ8jdkjaimqPHzBbjZLdds3F+
         SIbw==
X-Gm-Message-State: AEkoousjAYgGnxSoHTE5OKaNtWD/hjOh8w7iPlS3VD83BDrqd6Y30H0K8ucBFuBIxlOtCasZdXAxo+9QUbEqAQ==
X-Received: by 10.55.163.144 with SMTP id m138mr29919328qke.21.1469563905285;
 Tue, 26 Jul 2016 13:11:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.36.77 with HTTP; Tue, 26 Jul 2016 13:11:25 -0700 (PDT)
In-Reply-To: <xmqq4m7c2ve8.fsf@gitster.mtv.corp.google.com>
References: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt>
 <1469537934-16676-1-git-send-email-vascomalmeida@sapo.pt> <xmqq4m7c2ve8.fsf@gitster.mtv.corp.google.com>
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:	Tue, 26 Jul 2016 22:11:25 +0200
Message-ID: <CACBZZX4r5jax62oVYFsWONkyREshipGC8AFu8yfr6B7y9bMQDQ@mail.gmail.com>
Subject: Re: [PATCH] t5510: skip tests under GETTEXT_POISON build
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>, Git <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 6:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [...] Back when 5e9637c6 (i18n: add infrastructure for
> translating Git with gettext, 2011-11-18) introduced the former,
> test_have_prereq did not support a negated prerequisite, so the
> commit added GETTEXT_POISON prerequisite; if we had the modern
> test_have_prereq, we would have written
>
>     test_expect_success GETTEXT_POISON '...'
>
> that appear in t0205 as
>
>     test_expect_success !C_LOCALE_OUTPUT '...'
>
> I would think.

Maybe the names of the test prerequisites should be merged. I can't
think of a rea

As for the GETTEXT_POISON facility in general, I haven't worked much
if at all on the i18n toolchain since I initially wrote the gettext
support so I think at this point it's for others to say whether stuff
like this is useful.

But for what it's worth the v1.7.4.1-65-gbb946bb commit explains
better what it's for:

    This is a debugging aid for people who are working on the i18n part of
    the system, to make sure that they are not marking plumbing messages
    that should never be translated with _().

I.e. so the person gettext-izing something can actively spot issues
with marking strings for translations right away.

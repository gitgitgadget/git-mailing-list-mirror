Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141631F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeHaUce (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:32:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44725 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaUce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:32:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so11747917wro.11
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fhM5ZrPoMHiamiKeXF90LwUmnoh84TkUPb5VbFu+UKA=;
        b=oOrp6c88+fpHCfzcPPNVEjSqrh0h9tN3gA6AH6MBNmZnJW5L+ACM9It4vSeJpdXkiD
         ndwNTmHd41kN6Ds5MQuLgoux2JW8LGbIUFwwJR9ZrRRhpH0XPX23xC3hQfUsyimHDF2u
         p8Dy3iXOkLFgn47zhFvK1uMjSuavk1kLEgHFRyVOR1yGyZ3Ag65C4XQilt+vOGkOC0C7
         aWI1/iwUBnDCXeo24/grmBfG/v+mKaVYiVD0yMjTa/ITRIfUg11HHX/TfLJkJvC2OLUY
         nesub7mOYj/pp/YxwJ+S4aWpT83K3DkzYid7pT2n+N9dfA3LAYyBOnmA2pOaqYs7IrFx
         l2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fhM5ZrPoMHiamiKeXF90LwUmnoh84TkUPb5VbFu+UKA=;
        b=b7X8TCgAZq7dOkC8S0cScOHSf9kYTrAid7VjplN1fvXg/VyJiThZiqvMZwZkEk4k0c
         /+jcY/2MUyghoVpEUHjHaIiYyC220Z9kaIXw45AUeuQZ99qDpC6g5z0buWFzCwsRBqD3
         MuingfSlHtTau6nGUiVvC/CMjQ1bKJS/UcPLEn+rZFCejbp3ByB9KU7KWsKQ2I+ISkOJ
         MWjtfsf+JWsY3uveH49ZE+WX4bB4Al7hpB0rqqzm1M+mV1eamVZmjBxNLIuufnaWBRFl
         kE63kewWb/UZ5/Ikdx5X7ytz8tDkdVjpm25GWt0CR+RzEiskBJp2XJJUXOowrFnVLGGf
         D5vw==
X-Gm-Message-State: APzg51AKk4GoGlRgZKcLtl/dxi+HdcwYfSm6wlkHXBmTde3VEpqmXpm7
        uy5mvNlQazIIYLy3oJgIrTahj+yr
X-Google-Smtp-Source: ANB0VdZN5JlXSQDQqeErgv2rRWKWrGeo3qtVQnNNIRMP97mWpgEgD2F0tu7aQOr+zN1jTH3MtOTttA==
X-Received: by 2002:adf:ac6a:: with SMTP id v97-v6mr10638417wrc.7.1535732657222;
        Fri, 31 Aug 2018 09:24:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w15-v6sm14636355wrs.8.2018.08.31.09.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 09:24:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Kristian =?utf-8?Q?H?= =?utf-8?Q?=C3=B8gsberg?= 
        <krh@redhat.com>
Subject: Re: [PATCH v4 4/6] push doc: correct lies about how push refspecs work
References: <20180813192249.27585-1-avarab@gmail.com>
        <20180830201244.25759-5-avarab@gmail.com>
        <87efefcwme.fsf@evledraar.gmail.com>
Date:   Fri, 31 Aug 2018 09:24:16 -0700
In-Reply-To: <87efefcwme.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 31 Aug 2018 00:34:01 +0200")
Message-ID: <xmqqd0ty33nz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Aug 30 2018, Ævar Arnfjörð Bjarmason wrote:
>
> [Notes to self]
> ...
>
> Later below this we say:
>
>     Pushing an empty <src> allows you to delete the <dst> ref from the
>     remote repository.
>
> Which, perhaps given the discussion of deletions as updates, should be
> mentioned earlier in some way, i.e. should we just say above all these
> rules that by "update" we mean non-deletions?

You raised good points.  The rule that applies to deletion is quite
different from the one for update, we want to make sure readers know
updates and deletions are different.  As the rule for deletion is a
lot simpler (i.e. you can always delete unless a configuration or
pre-receive says otherwise), perhaps it would be sufficient to give
the rules for deletion upfront in one section, and then start the
section(s) for update with a phrase like "rules for accepting
updates are follows" after that.

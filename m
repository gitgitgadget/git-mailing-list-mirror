Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FFE1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbeHMTzn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:55:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50251 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbeHMTzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:55:43 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so14148715ite.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEGp8NLkkYgYU7/zoE42H0uFT6PTekNfL6gZ+KVYYcs=;
        b=OXG86VnUGrlVX7ZnualaiIP6HG41DTxI81uSPk4RjxPwl7moqTMLOl/1KuNrhkT33U
         HjQ/cRZEeCWfmaUAT7Nm0UDunQmCgcxddPv47Rr7peUn8455uSyy6drJkD1CdZz2FQgs
         fCH2D0Q2UK325LGlO0RNv2HLfm/a6j55zpf7ERpDSaACjtXnME/y1c9IEvbLRhHbipsj
         WM/vTFrHgjVCbgc86jrV+kmSVQQjWdGTm47dRVmDaalzx3LgIVqng+wuc5wBL4LotYCz
         oAaakderlU8eEK8TdbxoX1NgNEdkwk3K6PLYzv6hkxbitCMePb65+HSt6zpubZItpORm
         orHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEGp8NLkkYgYU7/zoE42H0uFT6PTekNfL6gZ+KVYYcs=;
        b=m3lwZE6wYuYbJJUI2j9Dun/KkELoOS4jy2w+eYGPQG8LNzvgMinkz4d1pBmPxAufhM
         gq7/bjhUckJwHMAAirUCID0d8mCtYbWweNn9o1dbHKb528yDiyhdtqS5q8rDL++XNF0G
         TrwPrHc4cs7bn/RxoJKm9O5RlLPo/mOnoPKlJE83xZHcM6rXWScDVoAG3IY9PsDk6JPb
         DScSdSCloXUB2DjJAsoSvT9U0h/G1aW4ACjyJSqyBbOtSxCaOTmnpg6vPBtoQ/AN27TW
         pABrEOjnLXVV+GIn1H5KLx2FBVYOVPmV8Z5YetmoYftBS8GljwyaGNZfzoP1KiWjM3tz
         ykDQ==
X-Gm-Message-State: AOUpUlHV30DmdMfItQj6KpElmF2xWrzRoalAcb6WdLoP8af57NgXXI0s
        RBtMuwvQceOY9jRJoiiWZwM18YprprYNFsUKqGA=
X-Google-Smtp-Source: AA+uWPyKcV+S7nxq9TDA/0vulNIwomBPH/a1regt1o/i++2Uriv/b5wvfyf8xqlsQJRLqsySkUnvrCGian7a5Y/1rUw=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr15181358jad.94.1534180357336;
 Mon, 13 Aug 2018 10:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180807190110.16216-1-pclouds@gmail.com> <20180810153608.30051-1-pclouds@gmail.com>
 <20180810153608.30051-2-pclouds@gmail.com> <20180811100905.1511-1-szeder.dev@gmail.com>
 <CACsJy8BeRYVvWvTQU+bj+hSQ3DFw0mHtSjtOg9zVSsXznpU=Xw@mail.gmail.com> <xmqq8t5a6wbc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t5a6wbc.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 13 Aug 2018 19:12:10 +0200
Message-ID: <CACsJy8DudzY7n3XJ4tLKaLWEcA3ctwkzW8amny=KdhP4u2p_8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] clone: report duplicate entries on
 case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 6:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > I was careless and checked the wrong variable (should have checked
> > nr_duplicates not state.nr_duplicates; the second is a pointer). So we
> > always get this warning (and with no following list of files)
>
> Heh, does that bug go away if you got rid of the pointer-ness of the
> field and store the value directly in there?

You mean replacing the pointer with a real counter in struct checkout?
That would not work (it was my first option) because struct checkout
is passed around as a const struct. entry.c code is not allowed to
make any updates there. So I got rid of both "nr_duplicates" and just
count again at the bottom of check_updates(). It's not that expensive
and it simplifies the code.
-- 
Duy

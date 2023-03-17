Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B973C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCQTVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCQTVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:21:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7F25BA7
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:21:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id b8-20020a17090a488800b0023d1bf65c7eso2720938pjh.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679080860;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUGxmZc1Z5H6yJ9SlCd1NOAm1o0OVeYggwHswW2U2HM=;
        b=fnNAAEU4mJZpgZm6HAZhKAh+8o/gvfAsPaJrQZBEmyMOiil6yYYjWuJnL6TGdMOx3M
         w+Gs1wRSyq1jQXBrM5TZgvp4+B2MLWyMZmpNEe1GNbFHhJJpav/uymNJ7o0dAJj6qCpJ
         CJ+1AwYRgT+aH9ibkVDWlujc7gB+OKWxQTSwyHb6fmtJns75ocUXQOUIZX7sCZ9kQeYp
         3AJl9FCEIgm/a91sOioYQklATI37rP5/Q8oMUHQwD1q38eNl9AEDRxGTgUxEFP87gNbx
         pGsL+ClRtPlUtJ2bbl4MDBSzU8w8b3trXLY2u4dmjBQcqNNb22WvvUmY4xjDidVOqOdX
         aBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080860;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iUGxmZc1Z5H6yJ9SlCd1NOAm1o0OVeYggwHswW2U2HM=;
        b=BHA3dn8wWvKg8qbWe6jYJs6Ll2+sJ6b2RRs63vEf32D7v2+8MWbvtOj4TuGH43akUP
         cEsw04urINEeks97W4jc+gtREpO+tPciHDziGO4oMUCQxM1xKM5tPKow6xPn9CYIgVIv
         piv27AyBVg2N9ZRnCfjU6Yej5P955BIoFCgCEhKEh3rlflHdLKHWY9TSEhC/SEk2wY47
         oytcWKtiNJ8C6lJiFHUknEQFy75SNNV6qzYfWsSYKYDJoMfVAiGH+TzuEfkg+4rcVYC9
         HVJTK15rD95gA03z0SN5vgs9gAW3cZkHlxxQZxXOEptT27lFUbfgb1nmXuomajXIwjKw
         h0EQ==
X-Gm-Message-State: AO0yUKXrYZpRFm36XIjzyrM4RXaOarOyZ+vIdeS2x5bVCYv2+9ooFCXd
        aNTjh/GZF5z0pqT/VNxj8O+JvyNbTRsN7w==
X-Google-Smtp-Source: AK7set9LK8jsP/eNYvpwkjHHWrg1eL+mhrRQT0jb9ux+rHORKwsU0SqH0KhQtIWwar7zfAdei8D3tIgtZoeTmQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a65:5283:0:b0:502:f20a:6e0a with SMTP id
 y3-20020a655283000000b00502f20a6e0amr164803pgp.0.1679080859908; Fri, 17 Mar
 2023 12:20:59 -0700 (PDT)
Date:   Fri, 17 Mar 2023 12:20:52 -0700
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
Mime-Version: 1.0
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
Message-ID: <kl6la60buquj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/5] bypass config.c global state with configset
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe it still makes sense to go for this "the_reader" intermediate
> step, but I can't help but think that we could just go for it all in
> one leap, and that you've just got stuck on thinking that you needed
> to change "config_fn_t" for all its callers.
>
> As the 5/5 here shows we have various orthagonal uses of the
> "config_fn_t" in config.c, and can just implement a new callback type
> for the edge cases where we need the file & line info.
>
> This still leave the current_config_name() etc, which
> e.g. builtin/config.c still uses. In your series you've needed to add
> the new "reader" parameter for everything from do_config_from(), but
> if we're doing that can't we instead just go straight to passing a
> "struct key_value_info *" (perhaps with an added "name" field) all the
> way down, replacing "cf->linenr" etc?

In the end state, I also think we should be passing "struct
key_value_info *" around instead of "cf", so I think we are seeing
"the_reader" in the same way (as a transitional state).

I considered the "repo_config_kvi() + config_fn_kvi_t" as well, but I
rejected it (before discussion on the list, whoops) because I didn't
want to add _yet another_ set of parallel config APIs, e.g. we already
have repo_config(), git_config(), configset*(),
git_config_from_file*(). Multiplying that by 2 to add *_kvi() seems like
way too much, especially when it seems clear that our current definition
of config_fn_t has some problems.

Maybe we could deprecate the non-*_kvi(), and have both as a
transitional state? It might work, but I think biting the bullet and
changing config_fn_t would be easier actually.

I'll try applying your series on top of my 1/8 (and maybe 7/8, see next
reply) and extending it to cover "cf" (instead of just
current_config_kvi()) to see whether the *_kvi() approach saves a lot of
unnecessary plumbing. I'd still feel very strongly about getting rid of
all of the non *_kvi() versions, though, but maybe that would happen in
a cleanup topic.

> Similarly, you mention git_parse_int() wanting to report a filename
> and/or line number. I'm aware that it can do that, but it doesn't do
> so in the common case, e.g.:
>
> 	git -c format.filenameMaxLength=3Dabc log
> 	fatal: bad numeric config value 'abc' for 'format.filenamemaxlength': in=
valid unit
>
> And the same goes for writing it to e.g. ~/.gitconfig. It's only if
> you use "git config --file" or similar that we'll report a filename.

That's true, but I think that's a bug, not a feature. See 7/8 [1] where
I addressed it.

1.  https://lore.kernel.org/git/3c83d9535a037653c7de2d462a4df3a3c43a9308.16=
78925506.git.gitgitgadget@gmail.com/

> We can just make config_set_callback() and configset_iter()
> non-static, so e.g. the builtin/config.c caller that implements
> "--show-origin" can keep its config_with_options(...) call, but
> instead of "streaming" the config, it'll buffer it up into a
> configset.

Hm, so to extrapolate, we could make it so that nobody outside of
config.c uses the *config_from_file() APIs directly. Instead, all reads
get buffered up into a configset. That might not be a bad idea. It would
definitely help with some of your goals of config API surface reduction.

This would be friendlier in cases where we were already creating custom
configsets (I know we have some of those, but I don't recall where), but
in cases where we were reading the file directly (e.g.
builtin/config.c), we'd be taking a memory and runtime hit. I'm not sure
how I (or others) feel about that yet.

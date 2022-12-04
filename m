Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26991C4332F
	for <git@archiver.kernel.org>; Sun,  4 Dec 2022 00:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLDAlH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 3 Dec 2022 19:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLDAlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 19:41:05 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA5E1A229
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 16:41:01 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so11652760pjp.1
        for <git@vger.kernel.org>; Sat, 03 Dec 2022 16:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZVS/Tgm9TQyfeLrYsG1h1S653YWticw60t22lkTpI0=;
        b=g6Swny0tvV6pp+HXbkE7vo6bMENptFUjpAYTe4sJ/vdB+JnvcP6fuHbN54Jf0bl6ix
         WAJ5ZYaanjlBLjS2De9Pa81nr514yz9ZeFcsn/q0mw8VelBcd27rTvvVM9PQjB99V3qZ
         yA5WPepvwdUQE1fX+jBTxKk1D3h2wQ74fKGDjfxBkM902qC0/R3VMdemqqQjinnvPaZf
         lBAhCaKVL+Ilwc3ISbttV98V9BO8JFptlW7DJ/0IoHRU87Ux/2Slq8OiC8aC4gX4v8YX
         0Zg4UR/ov9MoUFW9bdwTvLsmzvDE4KeDB3gE0AUwbK1Go269K5ugqKM6M2tS2Nbfr5c2
         gBJQ==
X-Gm-Message-State: ANoB5plRMMlMnMvMo8pliT0r0hMYnirhh8l7VpP/ZWeBCrRmkzXh7uF+
        2phcREZ3xqY3sX5KiKhXntbVhvFHIXuVJYJJBwE=
X-Google-Smtp-Source: AA0mqf4YgHMBKTLS3/ewqmVfFHuNOxr4UKgtlwoX9R4JaBfWwtNzN3l6xKQ4FmjJ+TF+AozWGIGFcaprDtOGZbIiekI=
X-Received: by 2002:a17:902:8f96:b0:189:3803:23e6 with SMTP id
 z22-20020a1709028f9600b00189380323e6mr56522528plo.77.1670114460412; Sat, 03
 Dec 2022 16:41:00 -0800 (PST)
MIME-Version: 1.0
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <patch-v3-8.8-37c75f4a097-20221202T114733Z-avarab@gmail.com>
In-Reply-To: <patch-v3-8.8-37c75f4a097-20221202T114733Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Dec 2022 19:40:49 -0500
Message-ID: <CAPig+cTh487GoAnw9CD7i2GmKzAtoG=1hwGdxXHQYoK6Vi=Arw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] tests: don't lose mist "git" exit codes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 6:53 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> tests: don't lose mist "git" exit codes

"mist"?

> Fix a few miscellaneous cases where:
>
> - We lost the "git" exit code via "git ... | grep"
> - Likewise by having a $(git) argument to git itself
> - Used "test -z" to check that a command emitted no output, we can use
>   "test_must_be_empty" and &&-chaining instead.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

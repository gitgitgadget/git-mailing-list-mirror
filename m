Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12D81F453
	for <e@80x24.org>; Tue, 12 Feb 2019 13:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfBLNHY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 08:07:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44651 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfBLNHY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 08:07:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so2570589wrn.11
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 05:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ccX+1GRCckgiJn286ZnvKDQp/UZJtwEEedF7kPzVgb0=;
        b=ObJTUssyFt7DDHZsJi9YKS4/P6z8yYI4LWajVEKD2J2tymgq27T+FAlBMZqz4k+oM+
         Bhf4lKiRyzVp1x1wv2mKpjunu50FgW5D5ZikWS7+xpiusE4EabXxNkC13p7e65JlgqvW
         XTTWenBmNv+sWCq/0BxL5AumOkcOEzKkBbcIx3Uum4M1PAdNxHFN+kuuX+AMFvo8aUTw
         A9bIi5lAbf8OTF+7k54MmL3x3ONRrT60l6TuqO2N9YjTzpi55Zj5lpvV4l6cdgby9r0Z
         TUYHXALiOLZF5y9fHRam+TS5AKGM5GfNrYiHhBqUhKFjKWRf5i+ee3hOdWpn/7yCas3t
         j1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ccX+1GRCckgiJn286ZnvKDQp/UZJtwEEedF7kPzVgb0=;
        b=cHtLhfMvESYNyZb4zBiQiIX6TfxyLZ7YCOGyktjbRtA/iuWitplvZV7JVJD0lQLwx9
         7vJV+398DGsew5uzUIf1jEOVOcjWXAKA7v0oZv3UmJestTy18ZwLeOFuS2rUKDSVrSDg
         Br4i4xFv2m0l/IwePJmIkx6il/TqV1+NiYYfqPFsmp592X7U6MMjAcLaDKWQDGds9Ogm
         MGUarECQdlglZqaMkPnMuxPbvvi6125/M33kfcmobmjD/nAPC/ikmizbqSkjT7PjrUPT
         REcf9814zTNM+sEgl1kN4TE7cZ5Ay/NSrBGIe9DeMcBoZzNy6sGF4tokExe+KNKVLqXM
         sS8A==
X-Gm-Message-State: AHQUAuZVIn0Ob7HJrbGK9n2rwbVfcC8nPQqYNeL57bZdqda4tlAw8IKZ
        6xO2J7viYm3ZLmZosYAmjuI=
X-Google-Smtp-Source: AHgI3Iah9uRyPt8CN5vtZuEaP447bAeAXsTZcGUzILWBf8VDWMs4IdKKSHYqKnJ7DbkFMpV7PaYf9w==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr2841545wrn.13.1549976842725;
        Tue, 12 Feb 2019 05:07:22 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id h4sm7643165wre.5.2019.02.12.05.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 05:07:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com> <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124424.GF1622@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190212124424.GF1622@szeder.dev>
Date:   Tue, 12 Feb 2019 14:07:14 +0100
Message-ID: <87r2cdjgu5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Feb 12, 2019 at 01:13:35PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> As seen on https://gitlab.com/git-vcs/git-ci/branches there are
>> regressions since 2.19.0, e.g. we have hard compile errors on BSD now,
>> and maybe AIX. I haven't dug into it.
>
> Where exactly can we see those?  Could you please give us a link
> pointing directly to such a compile error?

Click on one of the branches, e.g. "master" ends up at
https://gitlab.com/git-vcs/git-ci/tree/master

Then besides the commit shown at the tip there's a yellow/red/blue
circle showing the CI status, e.g. for master currently that links to
https://gitlab.com/git-vcs/git-ci/pipelines/47139741

Those then show individual test targets
e.g. https://gitlab.com/git-vcs/git-ci/-/jobs/160004621 for the AIX
compile failure.

Some of those failures are false positives because it can't ssh to a
given test machine or whatever.

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
	by dcvr.yhbt.net (Postfix) with ESMTP id 275AE1F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 09:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAQJbx (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 04:31:53 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:51852 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfAQJbx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 04:31:53 -0500
Received: by mail-wm1-f44.google.com with SMTP id b11so287482wmj.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 01:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=o/bBM4HUwMMtKEKuSbOmxNqsxrgvnm0zCGo0TP+Sf+8=;
        b=ClqnaxJVvttHw2bCmZZ4Y/66don/7NZqFc2YORvFN0v3sR1rVSW5inVnRG14r3RP7a
         Avplnb0DzQkpMN2vVvUD5WuYsWVSzOXyeIh8kcUQ3xL7Y9Eq0kfP8yWMbMkKbbgQbjOj
         Nh33Fsi6qdv7qx2pCFzYjT7HMDu6OxURXf0leWTuehibfz6ZtGtcpI0RdhyudP+qxwBf
         EE8XXfV5YXOc5dmZgUdZvlJ+GB0/qdlP8+IgvYW94Lh78SloE+3Sy+u5IbVbeJmG2ZRR
         /WzRtYYYPlw+ro27a76bbBPlU92LNnxZ32u9OaVl+W4lBXJUOKfFsPWHAX6suHtLxOjb
         mLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=o/bBM4HUwMMtKEKuSbOmxNqsxrgvnm0zCGo0TP+Sf+8=;
        b=W1sPFAkJ+/nlAlvJGx992PunPugCOiNUJg0F7J//xg2LnEd6Qi9KUGxiwoMlvhs7L9
         F3UK4mfsDyEX7Z5tUSXkXBx630SFUWFgBO6JJGcZcxiE1FbbkN9v0a2ScGcHv1cy8q/s
         U9Zuh+hVvednzveWosMqb7OGGxqLGE/ub2fTkIuwSFkSNgIxx1pHPD4bhvyv/FT7FdlM
         U4b7Z+N5SNU33SLYoHt+vCep1sMx4qBGQkuT1IpCIrDkOJu7wpF3G/ep3MRoe3mnwQlc
         1uKOMD2e1nXeMhfKZ+fAhx2LPJY/ZAH4zkdHNHxCMRACt4NQIDBgVjXfZqkuXf+XcSb/
         ktxQ==
X-Gm-Message-State: AJcUuke+Z4eBqQjHKaUGvF4QhsTK9om0+jRSNMnDGLqH3eMJa2A8UCgB
        CntkoBSUI97v3qvQ/AgmiLs=
X-Google-Smtp-Source: ALg8bN4m0YmXFEl5igS2N0DuY3MWbSZSk4aQ2Qx3cThbMphK082UhxIyM3P3wL+bbqQcSl5Dyz07aw==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr11060065wma.109.1547717511172;
        Thu, 17 Jan 2019 01:31:51 -0800 (PST)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id o3sm65062087wrs.30.2019.01.17.01.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 01:31:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP 0/8] Trying to revive GIT_TEST_PROTOCOL_VERSION
References: <cover.1547677183.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <cover.1547677183.git.jonathantanmy@google.com>
Date:   Thu, 17 Jan 2019 10:31:49 +0100
Message-ID: <87o98f4ol6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 16 2019, Jonathan Tan wrote:

> =C3=86var, are you planning to revive GIT_TEST_PROTOCOL_VERSION? I have
> updated the patchset in light of some new branches that have appeared.
>
> This is on master merged with:
>  - jk/proto-v2-hidden-refs-fix
>  - tg/t5570-drop-racy-test
>  - js/protocol-advertise-multi
>  - jt/upload-pack-deepen-relative-proto-v2
>  - jt/fetch-pack-v2

I'm happy to have you pick that up as you've done here, especially since
you're actually working on v2 and I'm not, so you can more easily know
what it conflicts with etc. I just wanted to have it in one way or
another, i.e. be able to deploy v2 and assert that "next + custom
patches" doesn't break something for v2.

I think [CC: Junio] that we shouldn't be concerned about an addition of
GIT_TEST_PROTOCOL_VERSION patches in any form breaking the test suite
under GIT_TEST_PROTOCOL_VERSION=3D2, and just be concerned about the
default GIT_TEST_PROTOCOL_VERSION=3D case. I.e. if we have v2 patches
in-flight that break things no big deal, we can always circle back and
fix those things or annotate the tests.

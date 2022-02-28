Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8233CC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 11:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiB1LXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiB1LX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 06:23:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E13E3C480
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:22:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x5so17051972edd.11
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 03:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qdjBrc1KvbA8PU3nrI8RfHOKZLKRQUjfcy4gccWizWs=;
        b=Zzv21dbRL489fT+qtEm6Mb3eG3BSK5yWVKtXAMsJ4YyflSiMqOGi7v96i7uCSd+S+j
         5z8GY6OhCJFiI/Cd95H3y8rwS9/S4DniYJjxerMxJsb+iLbdEBJ+jt6LAFz5Ps5nMV1K
         Xr2U5DvyqAplPJ98AtZt79c4/5lIrmADrH2DLFwryMlQgy2fU9K/lGZhh6CAfe898d3F
         H2HPvd5/pu+Vk60nveReGpOtwt48l/Qmib7ES1M7xGG7gVgxqWdIbGA3pVV1MPQgGV32
         eoARYX/rU/uFl3p+FeZksaO2hlqoVdRWU74MjyP0gwOaT5p4Z4X1UEc8zgb0KZqPoANF
         /oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qdjBrc1KvbA8PU3nrI8RfHOKZLKRQUjfcy4gccWizWs=;
        b=h6h17My0kr0XF362MFzVInGvjqmRGFjQIu69ZrigxjfWs33B6rZanozKDmZG8TfvPu
         N80/758n3zbvDho2Yao0yDHqvb0Wfwn1Qw02RLie83lj0Qedr52D+pmwyWyP0kh4HqiT
         DHjBUOMowDQQnvT7rPAC6j9OcXo8HJXQ5QSjFtbJCzn29VNXw10OkV5+M7pLE8+7DCLU
         bhbViQAX39YuHxFz5J9p2iy2Pi7oRdywOuPlIZNOOnFSE5BKYXpEzAZeGGMCVNn1eh0B
         fOWViEIXztJn8UjgTJhchUWhzdkq9NkRJ7MlIS5BoT3E0VNiE4Va+v+fClksrRYI07K7
         MXZA==
X-Gm-Message-State: AOAM531m/umrOSfYYMH0gyI+29AaMn9mof2+gcjDuPnTFPQjBPH6ckoX
        4ebOHR1JNOdocrAAVSTl/SKnebNtYGSLtsSNhO6QqnI8Oi0=
X-Google-Smtp-Source: ABdhPJx+87gsSStVFbqa1lnV1HUFKtzGA5euK17U2TmmlecsrylaQeT/fsFKdsXU0ph0kJ9MHqDot5aVeDlOmQpuhKY=
X-Received: by 2002:a05:6402:1a4e:b0:413:617e:702f with SMTP id
 bf14-20020a0564021a4e00b00413617e702fmr17493752edb.235.1646047367470; Mon, 28
 Feb 2022 03:22:47 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 28 Feb 2022 12:22:32 +0100
Message-ID: <CAP8UFD0gvzWnXmZFBtdzC8Hk2Xpmx=YfOSWdL74UX4e5paQ8zg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 84
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 84th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/02/28/edition-84/

Thanks a lot to Eric Sunshine, Philip Oakley, Bruno Brito
and Josh Steadmon who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/562

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F3FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 10:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKAK2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAK1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 06:27:55 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2C186DA
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 03:27:53 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13b23e29e36so16298324fac.8
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YZb7qFIhiLqdX4xHKoiOxdSf3FOlemk12GfDDemtzo=;
        b=T0EUMuriXY2t+9P+TOw9DAOjbxXT4niCpU/OkqKkPim1qiJB+J3sB9xafXYSGKXwyo
         UcUjBstw+82vdJMEUtqxM7Un13o4kY2KFH3DDx1m6F7T9wDVQHE8WPUNVFNTz8aynjoD
         n0t0Hm8tXVeZRt0bk31fQFsbUFkut3FkmRjZ0Rx0EGgrGUjnveH5zZtBDMG5uRq0bZRb
         WUyzsjbP+6qSbk8McxfQ2WeykybWJwNfSOBNO4Fr9JfS+Y4Pi8mr2rUnWTp1rnBvzBF4
         L3V43oBjSuO42MQ+Eb92TeHBpOEWYjwmyLrKR96sakBz06PMdsEO+28FSqC4YeZsi0qp
         /OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YZb7qFIhiLqdX4xHKoiOxdSf3FOlemk12GfDDemtzo=;
        b=HuCOaIm/Xq0BC2wMusM9B2Qu47whNz/x8NzvvVknzNRH/NMNQ1cXAcyXWLLQSKu1v7
         OumkeTqpktHozAHU66EsZyXSBNcgeWXxHw9gfqzfdLugtdisR6geBRFjBPWaKMi9haV+
         HutUnRZnd2El21s/JIcJyUzIpqBXy+7zY2Wl2qlK8GVYMQpN90NpyqqN3xhADz0wGlbK
         KljBCgMErGi26uMQ3NZmlV9VZwnW8IZYoeIghYKtLwSaGXU+ZT8StQzT/XV4n7EzEK9m
         iLjV1itga0qKesz3RCUNBdTUUumi+zRZgoqzi5NXfPnd65he3DtAZ6PKGtEzcJxCDX21
         R52Q==
X-Gm-Message-State: ACrzQf1zPDINgAV9dAJfa3xgSjtD/1Yq6cQlFc8QEmsxi0bKdVGt2oJA
        esjwu3KY9AhN+n4oyu4RAM6+ciKBq/mXafu7Uf4=
X-Google-Smtp-Source: AMsMyM6DL6ckECD4a+Vc9OwIa1OUvXd9NVzB3uU17vuzbP22ki4Mns9zrFSkEbNFvueQZPJ+b8LHCybXk6oDuBlEJ1s=
X-Received: by 2002:a05:6870:8091:b0:13c:50b8:23de with SMTP id
 q17-20020a056870809100b0013c50b823demr16034465oab.183.1667298472301; Tue, 01
 Nov 2022 03:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
 <xmqqk04lmagy.fsf@gitster.g> <CAGJzqs=PovTFeVFJAT1HLcKQxHdRjozUACh3Z-x8ih6yuYSb7w@mail.gmail.com>
 <221101.86wn8f3xlp.gmgdl@evledraar.gmail.com>
In-Reply-To: <221101.86wn8f3xlp.gmgdl@evledraar.gmail.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Tue, 1 Nov 2022 10:27:15 +0000
Message-ID: <CAGJzqsm1WRQL79012rboSaPyuP_knPh5aSUiucDNntV-_x4SDQ@mail.gmail.com>
Subject: Re: [PATCH] Mention that password could be a personal access token.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 1 Nov 2022 at 08:09, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>
> what's really going on here is that providers
> have been moving to using N passwords instead of 1.

I like that way of thinking about it.

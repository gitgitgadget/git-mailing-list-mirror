Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A825C3F2D2
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF6F246B9
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 04:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI4cp+2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBErF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:47:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34380 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCBErF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 23:47:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id n1so317011qtv.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 20:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XTxAneURDoRlN+DoxzslOSvcC0+qKR2MmQGsIqnJ+qc=;
        b=HI4cp+2T4H5V0v+0h+ecTnfUjuyoYP66HSlQBnBIPhXEvvCm2Yxe0TJf4gH44tAxpD
         CEnha2DkUljBJ8Kyt5v+lwjhfSuTJKDDvWkgI56EVV1Q/2L8fLAx0TqmRP//yxzGEy0q
         J8yBmdl87OnCEfRniDKrd0Dr+63DQ7CHwQSCcwU9k8CB8W4DBXyGXEdJwqdXXMCl9ifs
         KzDcvYq/RHaKoJV1qRafL9BI935GXlwoNA1DmfsT1JHbgWss18oLZK82rAfxHJE2XEIu
         PW7sa/Xuh3TAkoe6srsCtiXytrvkRvzKjsfwLNBX46XLcbpkIis/GTHSYsPzn7KzGSau
         mlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XTxAneURDoRlN+DoxzslOSvcC0+qKR2MmQGsIqnJ+qc=;
        b=uIQQuwttFp8u59r11wKOC6mhpp6pwHDJf6BVUIg2sJ0iO24hmUKmM8XB1eOEVWsUSp
         zoM1P7Ew1KdxLjtmIiF6OuTFGwY78sGDVX3X3o9M+L7L1KTrmTXAqBA+zuH0RPLWONHK
         NCDrC9cCulX7kBBnPuWM8di9C6GPLXjRLAKc5gw2bUeN7zg1Bahz7pQkPSBk0oA0zVbV
         oBDuNaZVf5qvJY8frXUrF04vCzkF8T83mL5HPfHQOjuO260wcjb5G2tg3yghBKvjpZTJ
         ga53zw9EXoIInKPqhk0Ewp2H6g1RHqshRZiloLEk1egkx+IMOf068mzOFUISAvMJfHhS
         wCaw==
X-Gm-Message-State: APjAAAUxxNY5B/HiD+SEUtsbwnbQ7ddnZD70pYYPRpq+nx3UYSNCeyaI
        uYppbCaDg8WloarCSkgV2I4=
X-Google-Smtp-Source: APXvYqxLhOIxMQgYUCT2xF+pvD2A83phXOFrpy8JW528VKCw4Q8v8d4Qe8l6xPtM+IUy+uZ1ZVqZ8A==
X-Received: by 2002:ac8:691a:: with SMTP id e26mr14445357qtr.287.1583124424181;
        Sun, 01 Mar 2020 20:47:04 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i4sm9594602qkf.111.2020.03.01.20.47.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Mar 2020 20:47:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/4] doc: --recurse-submodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
Date:   Sun, 1 Mar 2020 23:47:03 -0500
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1ECBCF2C-256F-453B-9503-7818D82F4C61@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Damien,
> Le 28 f=C3=A9vr. 2020 =C3=A0 05:35, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> This series add some extra documentation on --recurse-submodules.
>=20
> Damien Robert (4):
>  doc: list all commands affected by recurse.submodule
>  doc: document --recurse-submodules for reset and restore
>  doc: explain how to deactivate recurse.submodule completely
>  doc: be more precise on (fetch|pull).recurseSubmodules
>=20
> Documentation/config/fetch.txt     |  6 ++++--
> Documentation/config/push.txt      |  3 +++
> Documentation/config/submodule.txt | 11 +++++++++--
> Documentation/git-reset.txt        |  6 ++++++
> Documentation/git-restore.txt      |  9 +++++++++
> 5 files changed, 31 insertions(+), 4 deletions(-)

Thanks a lot for working on that!

Cheers,
Philippe.

>=20
> --=20
> Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)
>=20


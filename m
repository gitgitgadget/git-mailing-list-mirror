Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A91DB2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdBOS3j (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:29:39 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:38710 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBOS3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:29:38 -0500
Received: by mail-it0-f42.google.com with SMTP id c7so70461480itd.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XTfWYeQRfpMZE3/3+G1T2XNc9iPg7ckMYoysuIUSql0=;
        b=VHwU7F9DBYfROfQAzAhLuKATylQyGX06U7HvIVMnV7ypQrLulINpD8niLHvMQKeIqh
         RW5eAeC32VM/+W816t8Vc4ytxv2nMq7eRidzgpKDJoaJnZGAnoO74O2dl5lbADoHTAfC
         jOXuknb30530VOpe2EvdEClHhTMsBS72DPkLnsC+/KzWnu+4L9icW7fNKaGqnBMSRs8p
         762AC4QGA+1/h++3qRbAWtfE862s0RHoa9N9lS5ZAqkKvhr7A0wFxXEBXYRUjI6jaC1W
         f7yfbloZCgLCclyu1rCjaC1j/5Ep+T7FRM7sM+MccZgBimhzA0ko/AyVHO7ctiOtHI2t
         90yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XTfWYeQRfpMZE3/3+G1T2XNc9iPg7ckMYoysuIUSql0=;
        b=P+8/5QBycFZdbcZGQjvQoU0K1I8eWdnrgJAyRj7mZkM5FIrR15zXIuqTbwdMWYb+NV
         dHNkf+7pwd2FHoT1Dy+pQOS2SXMVlU2LS0gULCrxj5IxbMlNBzKBPn1IoqIs6HLWUmSO
         bsFjqMG44IxQKhuQdA+dYW/v/qm6uCNa3oGvjjnOIYtTwf1sDW8Kq9IjOgbm2OJ60FWn
         ik4hfvzTQCiUR03T3te2lommxegBd4NdcUJQE+nSqQog5IbCPdW15SsOktAQudtBGkDu
         CcRId6ab8ts64GJ7eJs87iGcUmdPEmCrVxzXpv322WB0Z2nKO+A9/49vPXiPAhJjOs1U
         V9ZA==
X-Gm-Message-State: AMke39lLp0EpcB4ciHQgznE1mmFAppXJ8sUinWkIi4jloD6PEF8Ed+dMvAga87idsG/7tGlUpn4rH50eRy7EkQT5
X-Received: by 10.36.34.79 with SMTP id o76mr9773960ito.116.1487183377423;
 Wed, 15 Feb 2017 10:29:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 10:29:36 -0800 (PST)
In-Reply-To: <20170215113325.14393-1-larsxschneider@gmail.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com> <20170215113325.14393-1-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:29:36 -0800
Message-ID: <CAGZ79kaP5+vXYv=0fV+-dvLy_i0oH_f-5dvSzrap3zjK3kDvnQ@mail.gmail.com>
Subject: Re: [PATCH v1] t7400: cleanup "submodule add clone shallow submodule" test
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 3:33 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> @Junio: I think this patch should be applied regardless of the bug.

Sounds good; thanks!
Stefan

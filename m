Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E099E1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 11:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfIQL1i (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 07:27:38 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38028 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfIQL1h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 07:27:37 -0400
Received: by mail-lf1-f50.google.com with SMTP id u28so2575017lfc.5
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 04:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zjHGamOfXNDWbtz3bodrbBqQ6KfgTXzHDP9bTJqifg=;
        b=ZG47QdNY9nSYgX7nbX/boHWQn9TzjV4GyOMYnSvOOmxDleqtAP+9qfmsqm55BVI/3B
         jnT/0JNX7bwLgH3vz4vwwazT1DIrkZ97A996PIBo1QOxdVnpdzkmbM0nHp2ZuBrl5qdJ
         hh5lwv2sHi8zrIJiYa0jfKfJZ/NdgIZkkHCuKxYWXznBb+H3KQbvUT9SK5pZ70NqBQ1u
         8wqODjL1n1VB33Mxfn2b2QAStlSLaj88ppUgWwOrT7JFpMn2JvQL+KHleU3i47t2n3e2
         tnHkEcmNT2xh65Wll7X9pNP+ozAQNHeA0DlRa/6Ok4K1CN7mwXLDra1LeCDzcQDlcdgw
         GRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zjHGamOfXNDWbtz3bodrbBqQ6KfgTXzHDP9bTJqifg=;
        b=fbqlFe3D5FJudvQMQQG4+q/xYWdFKPAXGMMh1eVmgEvFmmAyL5OO5eKiSxnXBmrgg8
         NHIl1k1NozX30ampraNbG0Z7PkSSBPoN2c2vvgh41JSgI0WWIQN308gxzQKzOunslzJL
         qmU3oR3/BJ29Z4FE2FNZErkQRQaXDXySMCKPcSFasBw1g8bgymYOrbe3ajM1yD6deLVC
         L/T9j2zacXBQjM0N6jX88cU8dFvSe9Qv70GiEnUteESuRxDLb0l5xSLxLBv4uYDk4IKQ
         S2+s6snqQSd7GwE3XpMAN2mF9kHwbMw8lFstmL393q/wisvpyrltPnciV97DRRL8Y7Uq
         gB/A==
X-Gm-Message-State: APjAAAVAWZaQBFc8ZN+oTjkrNbZ3dvgH3AvbRBHwPn6WHJtJxPyp1SRz
        R6S3/2OHEE47kegPyI/W99XPiwm404EupGkEtixdLBfR/24=
X-Google-Smtp-Source: APXvYqwVNURExarDH4T5IzaBhxNIGBwQJNyKZEri/MgBAeaN7X/3hfQXqU5PU7jx9eKy7MEGsr4hA2VTurZ4nxbbd7k=
X-Received: by 2002:a19:711e:: with SMTP id m30mr1838916lfc.63.1568719655389;
 Tue, 17 Sep 2019 04:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+L6tff-5oSX9oAF6AnvPwv8GDxb8vfyhRBnSS+JU7AAw@mail.gmail.com>
In-Reply-To: <CAGr--=+L6tff-5oSX9oAF6AnvPwv8GDxb8vfyhRBnSS+JU7AAw@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 17 Sep 2019 13:24:53 +0200
Message-ID: <CAGr--=JMEuCRZZaiE0Djw6igSm4DgVrgxKPVEEZuiaH6yfY1wQ@mail.gmail.com>
Subject: Re: git-gui Makefile: cannot derive correct sharedir when gitexecdir
 has a space char
To:     Git List <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just saw this[0] issue discussed about GNU Make. It seems Make don't
play with path with spaces (at all). I guess my best solution is just
to make a symbolic link so there's a path without spaces.
I guess this issue can be ignored.

[0] http://savannah.gnu.org/bugs/?712

Best regards,
Birger

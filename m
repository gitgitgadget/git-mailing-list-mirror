Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75F31F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 22:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeFAWkK (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 18:40:10 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42031 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFAWkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 18:40:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id y31-v6so4022524qty.9
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=nIr6bt6pB7IqBGr+Yo+o5MCyv1buPZrfQFTLTpaz3no=;
        b=D3xu/BWyvXQWBDWP2DpDMlNB7V60tPFjyB/8maxpXaepI9h9H6OpOGmS3EDVcqKG9Z
         4iOvT1Gxva068geDeaq/P+m/OEsRoN9/PB1cJ6aEEMAmMYPCuRJ0iYqP8nCDdm0yIwaW
         yuC3abZ9reVAc8IX3BpPF5xhznFeOB6N1DUeRIY3qdlJPN59FaaT80Iuzw/iLC9MlFoX
         1VPkUfg87WwgALaYanaG1XdwM1qXVL0oWxmyPeFIHWej03Xv0wuDmkHvbQHGkyKfgnIG
         V9aBgb9X+4uQF6DsLf4nSvnbSjFUyY77aqY+ddF6QEbqo5WLeWHdI6CKKrX7C9vbY8sV
         huGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=nIr6bt6pB7IqBGr+Yo+o5MCyv1buPZrfQFTLTpaz3no=;
        b=GlaJe6j865cllT5tBZBbAqi5EFpVeB8XHyAMeZTevdd0diCrjsnIUg3VCZxl+HdaH7
         J1rAcyUPdX6fE7lVYxVeFqUhJNlmHgz/CdIwPBWubWFnNfgFS/Kvr4Ucq4IKuHdcnY7c
         +uPVUNDLRbiycYySK2766h8ny8MFfu6V+WqAL/Jj9S026S5sNzjC8Na1/GXKchsHe971
         FE+9JL3euzUxj1RN3zmuP1H7HvQqEYsIEk8TrmvVsKXK3esB6DSJkcNKX1WnDwEnE/XZ
         SgeMrH6kqvw3Ji3UXfYFzVuV9AToBUYRSK7FfxOQPa4EtlDk6BwGfi2rQ+nPtXnT7f79
         8OJA==
X-Gm-Message-State: APt69E07bc64X22rdFjNg4nKJGwhKffGSbIOHRE+8sJhD7PxuI7l4Jy4
        j0/MPxKonmSycCW5HvUStLWFPX3HCa/j5W6ntsI=
X-Google-Smtp-Source: ADUXVKKylEumkP59fXdGUDRq6/5wEztCkzWjLebHM/zE4HwV77QpxImS/e6jGMHuidFcsoRV/nge2ffnNf3Eyvzyt4k=
X-Received: by 2002:a0c:9487:: with SMTP id j7-v6mr9198757qvj.41.1527892809110;
 Fri, 01 Jun 2018 15:40:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 15:40:08 -0700 (PDT)
In-Reply-To: <20180601211015.11919-4-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com> <20180601211015.11919-1-avarab@gmail.com>
 <20180601211015.11919-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jun 2018 18:40:08 -0400
X-Google-Sender-Auth: fKSQsHhiDgcNczquuRQY-jh2Wcs
Message-ID: <CAPig+cR-4ni9nuKp8buvBOKe-43DM7g5Y_pfEcQDuM5n9xuhVg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] checkout.[ch]: introduce an *_INIT macro
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 5:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> checkout.[ch]: introduce an *_INIT macro

   checkout.c: introduce...

> Add an *_INIT macro for the tracking_name_data similar to what exists
> elsewhere in the codebase, e.g. OID_ARRAY_INIT in sha1-array.h. This
> will make it more idiomatic in later changes to add more fields to the
> struct & its initialization macro.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

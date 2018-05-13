Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCF01F406
	for <e@80x24.org>; Sun, 13 May 2018 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbeEMSUP (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 14:20:15 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:36186 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeEMSUP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 14:20:15 -0400
Received: by mail-ot0-f175.google.com with SMTP id m11-v6so11848646otf.3
        for <git@vger.kernel.org>; Sun, 13 May 2018 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VmbbhTwKcrrcrnCOm0sUAVgcb6YTDSaPFW6e9puPnP4=;
        b=Z9+cZU6RTslobW1QcFt+1taa+op6/ASDjNVoeCo8wgCE++FdnPVSQCBZ5nxdiyWhLV
         lLFMx52aSwc/yWc+xBOzo4UghkFM+v0mPaCs5rt+opF5SoTEDNuUnZGh3I0KytN7k0ea
         MJS8saePXWVANvQges8jC08t3P2JRTlnJSoa7e/J/8mbiM6/lwE/yIE5obGXkWFlGNta
         7EA60KunvQ7IyDcP6gc2TOQoY63rMDoqq8w3Y1Ps4aDIZLdTJOwAq1JN1uNj2r8PKC24
         ZaB/e1cramFEKX5ivY92VQqSSHf+sfh5FSPQlCYsr+OwnFVbx3VxUD8mxgOBHpPwAvrR
         1rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VmbbhTwKcrrcrnCOm0sUAVgcb6YTDSaPFW6e9puPnP4=;
        b=HlypbSbMBDbYCra4DnVRUzkHruKWFXVvdUaQAFfy73LX2OwTzaae0w9uIayWJiWl3y
         tjD9FNi4tdCD9v3nptBAjBLq+zmAFwEnrq+ezXSxTRAFYPGsiLFIz4xVX3dv4eiGCdG5
         /8gw4vAKJV3+pNWiaPRR6dy1WMHldpcUZ7IRwhT5YLXXJUefwi+SkdmlHMn8ckXeNUUs
         8Rkv3n932E9bY954p4hYyiNTb5+lPj8zLQi1eCGG6mmuUtkxVACghwhoxTOUwT7GZo4/
         kUByntey2IQuKn8sCHZQKcDlSH+qFo7VfbPEHkZa9kquBYjp+X7KINBjA2+FbW8uPzEF
         Jo8w==
X-Gm-Message-State: ALKqPwcuSCRlvggjOMrdyywF2tgUrRvDx/9BJinKQS84q6KaZByl05dD
        H33KCCYzXpb97mxcvTir5leVgKu4yd7+ZJgWlEE=
X-Google-Smtp-Source: AB8JxZqmSXvILHKiNPUMhHAejFYrYUmghLUB8QKYrG62Gl7Cn/3/zCUaumzWOc6DVWesOOb2lE1J6WtnyQ0uo++vWcI=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr5131004otb.152.1526235614563;
 Sun, 13 May 2018 11:20:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sun, 13 May 2018 11:19:44 -0700 (PDT)
In-Reply-To: <3f51970cbc44bfe34133c48c0844ed3723e83808.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <3f51970cbc44bfe34133c48c0844ed3723e83808.1525361419.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 13 May 2018 20:19:44 +0200
Message-ID: <CACsJy8ApDb_KTjoJgMuV_AJ+dQdGC0kgCnMcJXj5pMGdqMQCyA@mail.gmail.com>
Subject: Re: [PATCH 01/18] Add a function to solve least-cost assignment problems
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 5:30 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> +       /* reduction transfer */
> +       free_row =3D xmalloc(sizeof(int) * row_count);
> +       for (int i =3D 0; i < row_count; i++) {

travis complains about this


hungarian.c: In function =E2=80=98compute_assignment=E2=80=99:
hungarian.c:47:11: error: redeclaration of =E2=80=98i=E2=80=99 with no link=
age
  for (int i =3D 0; i < row_count; i++) {
           ^
hungarian.c:21:6: note: previous declaration of =E2=80=98i=E2=80=99 was her=
e
  int i, j, phase;
      ^
hungarian.c:47:2: error: =E2=80=98for=E2=80=99 loop initial declarations ar=
e only
allowed in C99 mode
  for (int i =3D 0; i < row_count; i++) {
  ^
hungarian.c:47:2: note: use option -std=3Dc99 or -std=3Dgnu99 to compile yo=
ur code
--=20
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7601F404
	for <e@80x24.org>; Wed, 27 Dec 2017 17:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdL0Ru7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 12:50:59 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42409 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdL0Ru6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 12:50:58 -0500
Received: by mail-qt0-f196.google.com with SMTP id g9so48666522qth.9
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IKH9YuqdYrT8nJQgTZ5pQ86kUt7SoluUqP1jwDrKM28=;
        b=fjlH54wVQfdE9B7vHc3Et/j4FSYNerdLbXnJjLBdib4Tg6bddIrvIEcyd/b47GbYae
         KajjYI+JigOSe5JnNlH/aYGrDq3UXmNEyvdK9ZCpFvsLVj+GzDOy6Fes6GfVF7pdk5e7
         kq6Lb3keLI08+zyIova85vTuFqYmElL2EdXM0pJRzyadfZ0E6LVgPf0M3mEBgyV3PxTw
         Qm30WO0ZhqL/i1pnoO2wMBk+Udwrd4ulZGaYrNQQo6wW/eid2RAkSuQTIOQE9uRUXucB
         RAVTl53ieVxQ9AdVculaDtrQog0HxAVy5vVrHjU36wlYXqpM3zmxQSUtij6Y+ufTDLRj
         3qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IKH9YuqdYrT8nJQgTZ5pQ86kUt7SoluUqP1jwDrKM28=;
        b=PL/WJUKI+As7IFfSalb3Rjfel5xDTEP1qBgK0COIapZIf//kimXaUXWFTbIpWediV2
         YIhkblETcwIW9Df8OG7m5Kw0h7eTPthfGKUDWVeUbpiZ9nMjfxiHfICU1KnYd/A1vB1n
         N6A/TNSlZD6m8a/mVVVzMzBqXL1MjvGnNklBJNc6GSDnovUUoF2o1rBrVxnlcNM9fHYw
         C131EgpfAbY/gZB1JBGgg65HS+c/PtcrcFa/tk3H9EPw/rWgRT2ejx77FbgUHicKoxVZ
         2ZI08HZmlk63/PeEeXEH5eszYt6U07GRkpngUtlWQoVVR34Nsxa8AOXjbVg+8A4kqhug
         gJTw==
X-Gm-Message-State: AKGB3mIWx4innC9SehVvd1UdjDgJzcvVkD99InxrPCBq159nBr5HPepQ
        JFqt3E60oSwP3wbcxWrxYvbmG4iguGfi/RdFUfQ=
X-Google-Smtp-Source: ACJfBosQfYQzB/mzzMCxrbJbty8thhu9LArKzO3WsXcUq6Ow/AiQM9wGvvtXJbtQRpp6ApZm7fGZxCRTr7XJJQPc0qo=
X-Received: by 10.237.37.162 with SMTP id x31mr40484349qtc.58.1514397057871;
 Wed, 27 Dec 2017 09:50:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Wed, 27 Dec 2017 09:50:57 -0800 (PST)
In-Reply-To: <20171227102551.GA26616@ash>
References: <20171222140032.21180-1-avarab@gmail.com> <CACsJy8B1FNpq-AYJdcs_gVOxdPSnh-kNaeVykLSSDL1+EW9YjA@mail.gmail.com>
 <87wp1ar6j1.fsf@evledraar.gmail.com> <CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com>
 <20171227102551.GA26616@ash>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Dec 2017 12:50:57 -0500
X-Google-Sender-Auth: f4EnRMpwhVH_V2JgOcLInKRB6VY
Message-ID: <CAPig+cSuWivA-YKnv7q6y1zFebzq72Y2F+ioPmiNEO9VQeQSNQ@mail.gmail.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache bug
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 5:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Subject: [PATCH] dir.c: fix missing dir invalidation in untracked code
> [...]
> After step 3, we mark the cache valid. Any stale subdir with incorrect
> recurse flagbecomes a real subdir next time we traverse the directory

s/flagbecomes/flag becomes/

> using dirs[] array.
> [...]
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

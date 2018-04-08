Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453781F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDHX7t (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:59:49 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35360 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeDHX7s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:59:48 -0400
Received: by mail-qk0-f179.google.com with SMTP id c188so7478636qkg.2
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tmxebXMeso0ouLgAht4qSbdB1VE5NMI24z9i5ip5dGY=;
        b=LbsvuaaHgF+KK5cDnanHAo5qNpRyA07+uKpfukpERMNMOHhPvY39nnXUXHrYrVPw+D
         FJ5PnEnAudGsEJGJiLusUZWVYQT3+mP2b9ZQDgJHueD47ZrLBfPSDVNd8bO5yyulCIdZ
         voSJVcyJHxswiNoxOfeafksay05Uhuc0ksgzcL2Jp9qIm4twR0PbOYbCwtVLXQG7aG5X
         uD7PkkmIuPTO6vQ3Mnyl9Q5VqPvdmWTIB9YYr/w7fD2EtQNgjXSKThYqmPR9uQKkJIjB
         zZjgH38JpY+/Eyh+VndOG5RE2O9tNERTAvu0zQwLQtdQjedP585dhYdUHul2lVp7vx28
         B0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tmxebXMeso0ouLgAht4qSbdB1VE5NMI24z9i5ip5dGY=;
        b=Iy/9pzVv7sQbPE3RZJyHHC97bht5BohHUltiTscUIQWoK4HvWgRKJKIUe/SNq/zvgX
         f97PK0+4pTif7WcQJnbn8/EeQCXKT0+pnx17lpeonsK6PWy2waC9lIxsJmJzVzG1HdZH
         Nrpba8XpXN6P8NuGVRsiRulFKsDrVrqRbEnTpHz4tRkZRZv1i+0jXgvVidZM0qUFe0Kw
         YAqjguIemW4Wh/gdOlEcX025wq3FPFMxGcfvMMYYt0mM3HM5rG6OQn7yy+AJVZxoA190
         A6wWhz2oJzugfhcFTg4hgBummsLQ3DS64n1Tv7VfaFJPSICjWy9EVRGrD9LYRd4P8sXX
         gHNQ==
X-Gm-Message-State: ALQs6tC3E76UwW8y6dxOruDoFQYRrDwuTPWU3R00QsRxkQf2J0tQk+XM
        HXgmRjtY+7UArqBNn/s51Ga4vnsvW6ACWs+OYIk=
X-Google-Smtp-Source: AIpwx48aEcVEJQ99v9taQ3i5sWUlNwPrwSLod8L/KGo48UqKBJQG4rYnkEqSRFV42hPxOXURVBjUiGzT9BWpfU7es+k=
X-Received: by 10.55.159.140 with SMTP id i134mr45856044qke.220.1523231987933;
 Sun, 08 Apr 2018 16:59:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 16:59:47 -0700 (PDT)
In-Reply-To: <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com> <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 19:59:47 -0400
X-Google-Sender-Auth: x--LS8D9TyPuMqCJEOgW6kvI88E
Message-ID: <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 8, 2018 at 7:55 PM, Igor Korot <ikorot01@gmail.com> wrote:
> On Sun, Apr 8, 2018, 6:23 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> And, as noted earlier, before running "make", you may need to create
>> config.mak to override some settings documented at the top of Makefile
>> (in particular, you may want to set NO_GETTEXT if you don't want to
>> install gettext and don't think you'll need it). As prerequisite,
>> you'll probably need to install OpenSSL.
>
> Is there a way to check for OpenSSL presence?

Not sure what you're asking. Are you asking how to determine if you
already have OpenSSL built on your machine?

Note that you might be able to get by without installing OpenSSL since
Git will try to use Apple's "Common Crypto" instead, so you could
define NO_OPENSSL in config.mak and see if the project builds.

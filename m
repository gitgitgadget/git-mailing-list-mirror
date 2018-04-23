Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41621F424
	for <e@80x24.org>; Mon, 23 Apr 2018 16:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeDWQxt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 12:53:49 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:45881 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbeDWQxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 12:53:48 -0400
Received: by mail-qk0-f172.google.com with SMTP id c136so16788996qkb.12
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t6vBAYmBref93EQFv5soxnXordo10oPkY/YqYXSnudo=;
        b=GAayF0qhP7mhjrW5VQAr4LLliDY1BJHM6af5KjR1cR3Xov+1YCaKaT4b5w42H9P1SF
         LgEBazi9jEwQS8YWSoXPq3QruHKsyRSVGuMHHnl7JsllTBXEpLsnHZqVzYm9nXUtNseH
         axVIOkqHauc55wxpXJeXUYPzBomcWS9dlGVG2A50/XR43oTXS8Ei/6Y6ChSrZxYq1h6X
         yRohUV0nXTIezCEYTXizphgj1S23HhkBD6Nf55kTxjs2CihBXpdv2Xp/vArjcuvkB0bK
         C0Wwo0Ob56+aAzkq8LgYxgkreiMVtvlL1De/qOk8UAaJMq8EdwwIxvVIg58zXYsx2nxW
         wgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t6vBAYmBref93EQFv5soxnXordo10oPkY/YqYXSnudo=;
        b=KyBgXyypg/xgR/q51h6FN8A3vVSqACc23C2vWcKeteWzFLaPFreuT+tLN3q785HW22
         OhZXGxXWibAxCic4KIZSUxenyugXrLNxxHxWHl1rKTRogpjVCiEnYJEZPJw5MZ8gKzqd
         atWSaa2n6jvwLmKS61VsHnUvi+kvv8PJI8SGuVbVNfSwS44cxiIhzqOwWJUkdP3IegK+
         a9+5fWcz/eRBDoLoHY/UvZWxXf8rE66f8Piq4E389KNzRsIVhmzdyszdwL3ySBba8ZK9
         j/F6MyPdOWq4/zO7FYNRalju8fqnI8qcOutWEkIoNImaC7mGs9RON79EYJ5irwnVL85I
         HXIA==
X-Gm-Message-State: ALQs6tDhCVCVZoiE2VKrqPqTKKsKxftcf3+gsr19rCuRjjg9e6z+kClh
        NNRPYyFVz//RFeZaQhMOr0Xpe3kTy09wokWC068=
X-Google-Smtp-Source: AB8JxZpfT+6aKmkcrrauASh1N3FposRfZd7xoU3555iTfNBgsi3gt+iz5vaCgJycw+Q4lUiUYXOqRyUTn+Bc5eKfi/w=
X-Received: by 10.55.190.134 with SMTP id o128mr21264021qkf.141.1524502427345;
 Mon, 23 Apr 2018 09:53:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 23 Apr 2018 09:53:46 -0700 (PDT)
In-Reply-To: <CA+FnnTxXOwORs_qYvOdSj41UX1aBfj+Hd1+kxPa8j+34xgjhgQ@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
 <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
 <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com> <CA+FnnTxXOwORs_qYvOdSj41UX1aBfj+Hd1+kxPa8j+34xgjhgQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 12:53:46 -0400
X-Google-Sender-Auth: EKXBdsRZNjN29xn2q1Ge8inxVYU
Message-ID: <CAPig+cQzX04JuoUOnxOxWtqMCpHCUi=hMOSDL+jpNuML0iE+Tw@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 12:31 PM, Igor Korot <ikorot01@gmail.com> wrote:
> 1. Is the file name "config.mak" or "config.make"?

"config.mak"

> 2. Do I have to do "make clean" or just remove the line and o "make"?

"make clean" would not hurt.

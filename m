Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73E21F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeCRJpc (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:45:32 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:37375 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeCRJpb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:45:31 -0400
Received: by mail-ot0-f178.google.com with SMTP id t2-v6so5263396otj.4
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/jvqcISLvZcL2LRqoRPeqp0lcRkJ8Uh8tZ0AOZqCGJY=;
        b=s+FF7tsow7x3uXfyjsTre/3JBCbHujPpQ2pQ0eFk/07DQCyx2j1gSqM7Jc1+WT6X9s
         JfoHMRb0duic4CHPQVvJohlBUX6QT9W+Z9HHpxGwFm+hwg423j+ghXpEVTOY45dxLRKF
         oOCUTOxzZA+aCCvljVHoh4IrM1k9ozMRSYIUtV6HF5ZjJZr4thiJtooSjPesCBE++JyH
         AVx8cEcJwfn8RbglQSIhvH1HkmOW6Ry51sPfUm9HXJjGgwIcSom/Q1eaSEodN6VQSWdR
         KkzW3lrDefhyczgDMdEeIg6K5sndIv6NPLBawSAqjGmulzyCEd9QI5KlKgYt/n/LJC1m
         k8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/jvqcISLvZcL2LRqoRPeqp0lcRkJ8Uh8tZ0AOZqCGJY=;
        b=hyRyUIDZpxFM1c34Aqd8qtpANEB3fZsYOXzl5qqI0JRDE4ZL1x2cCCOEJdVUVRXmG2
         V+6aNtAgWuh1I4o4yfaEJdytDhqF4lO9cDtcjKcyKjHNMrhGS4IFi+KlkAMRTgKkHiBz
         oS1p2ps2np85pOXn3ZKI8xXhludvGqfuxb8rQKzpu97kffpI6nj2SwrMVeGFVKUpK35b
         z3YkOud4R/7IMZAdA7qb8gSp5CEoaUh7Z+E6hPBmVg4Leuet+gAsswCfVyUgvf4LAT3Z
         gigVYkqQOWq8fJjh2wdU5oHz1GkxzjtHtcg7fcT9UKoPPIdFfsV2ylAOPIT9MZ19P58w
         gFfg==
X-Gm-Message-State: AElRT7G4nhJAInUtnPcgGSCK7a6MtkVKMuVWFLX2mp3acqVmqu3pgmq1
        qO4FaTvCUhNSJygqTwJ7S+A3KSUZtsO2raxW4jQ=
X-Google-Smtp-Source: AG47ELvL+qniYLtZiN/4RFD1WoDhUz132G7iaCYKhE6su6TWpnDXS3yMBMS+h9aRrAQbxAij5/vob3Fh4lC4LWH8mzc=
X-Received: by 2002:a9d:182a:: with SMTP id b39-v6mr5589239ote.356.1521366331352;
 Sun, 18 Mar 2018 02:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sun, 18 Mar 2018 02:45:00 -0700 (PDT)
In-Reply-To: <20180318092629.GB29208@sigill.intra.peff.net>
References: <20180317160832.GB15772@sigill.intra.peff.net> <20180318081834.16081-1-pclouds@gmail.com>
 <20180318092629.GB29208@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 10:45:00 +0100
Message-ID: <CACsJy8B-Z7iY0ZHkKtVfLE7RsOAAX4MU17NdkMxwgfO8p3Q3bw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 10:26 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 18, 2018 at 09:18:34AM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> The set of extra warnings we enable when DEVELOPER has to be
>> conservative because we can't assume any compiler version the
>> developer may use. Detect the compiler version so we know when it's
>> safe to enable -Wextra and maybe more.
>
> Hrm, I was planning to expand my patch into a series.

I started this so I think people expect me to move it forward. But
I'll gladly hand it to you. It looks like you have more compilers to
play with anyway (I'm on gentoo and installing a new compiler,
especially llvm-based, takes ages).
--=20
Duy

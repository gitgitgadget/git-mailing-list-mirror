Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0725B20248
	for <e@80x24.org>; Sun, 10 Mar 2019 11:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCJLTz (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 07:19:55 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39927 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfCJLTz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 07:19:55 -0400
Received: by mail-it1-f196.google.com with SMTP id l15so2968998iti.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nmH1VeOAwVhtWcDbpfWf7WyVVca3Rb2tTORdPUu32bc=;
        b=aIORMndYeMFAka18MNIS6UdF8QGe8s0P08CNvMjmYimatxgEfaUeFbjRe5wF7u2EcI
         s8sarJrEo1CCP0ClYtzb3wGV/c239qPtgJGScgg9Jxzk30026oJvFuR+onisdJWlq4Pc
         nu/NG24o6Td6y2nlMwSl09acKkwkg2+2KYOGn8Y2WqC0Ij61Tmm3m7zIYLLxKqwdTYMf
         1Hj6NkJwni5K6MYPHXSS/1ZnnBnjiERFlWyGS16ElUlEx99S8oT1r+IbNtL1/yjua/g3
         gakP/NCuEs3HpXLcq54rtq6p5iJk525LsLp2swZBv4FdrFqUTQEADTwvWaDRBzRr0hEh
         kppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=nmH1VeOAwVhtWcDbpfWf7WyVVca3Rb2tTORdPUu32bc=;
        b=fXQFL5H2HxCwn96eIwxVvFIkKhcPijdRCSfR2ZL7JBXTd37RMVPmO9aCKd8kjh0kYN
         GH/0tWRqtHTVqRJS0t1UkhOq5fyNs8ZDbNt7FqguPSbHb+8QXyp71xSRwk4UD/8dqoaN
         ieT2jqll3wMCUSyovTs/lyn3WQtGwbWW/+8Lx3rVRq6p7WFOtogeZ8PnzsHKVHQtRK2D
         7zqXNYNXBBwg1DUVPFbfzAtI0GN94DI7pPvIYQzt8A5JBJBF0amuQu1/HOUZUkcijFi6
         kn3Wl8RWNwk9PhIY348x1Krh/w9TxDp07GwMnfUgRIm+BrruFaEx9vyQr/vGsLmLNGIw
         9sGA==
X-Gm-Message-State: APjAAAWr8GRyXKo3UXum2Cr+Atl06XmAUiotsdlJA3JR3LJvR7Hgehxq
        d9JSUf/FjnADrS91wO03jZ6HqUP7uTZWzTLyovWEaA==
X-Google-Smtp-Source: APXvYqy/anlVtVBXxlVhCnj0nEMr9Ekhciy7RJmUhYQgjRKuE1Kqx+6EJk2Ak0TFELDmlH2girPnrqH5fsH6urvEQrc=
X-Received: by 2002:a24:7542:: with SMTP id y63mr13161430itc.70.1552216794511;
 Sun, 10 Mar 2019 04:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 10 Mar 2019 18:19:28 +0700
Message-ID: <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] And new command "restore"
To:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 5:17 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
> - --index has a different meaning in git-apply. I don't have a good
>   suggestion except "yeah we have two different worlds now, the old
>   and the new one"

I will rename --index to --staged to avoid this. It is already used as
synonym for --cached in git-diff. I will also add --staged as synonym
to "git rm" so that "git status" can consistently advise "git <verb>
--staged" where verb is either restore or rm.

Since option rename is a lot of work. If you think this is not a good
move, raise it now, even if it's just "I don't like it, no reasons".
--=20
Duy

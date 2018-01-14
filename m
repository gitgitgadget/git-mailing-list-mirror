Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388221F406
	for <e@80x24.org>; Sun, 14 Jan 2018 10:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeANKYu (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 05:24:50 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:44872 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeANKYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 05:24:49 -0500
Received: by mail-ot0-f177.google.com with SMTP id g59so8459952otg.11
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j6CU7bLlZt8bfd5q/TULygkUuI7LQWf5DML6jtFlLT0=;
        b=eHk9sNmR9+Rp+8tl3U5W/FWJYV510Ue3DCRpI49Dp1pOYGSAn8SG9OJJqA4vidCHjQ
         qikkb+lBxD23vf5aT+bNcthMDGe7HCY/89MTV95SQsSUCrQ+FrF4kHDIjFSmRRRIzWZ4
         k/ekn3JHAHxqtnUw3HRVriPSIsEKKBG9h2vXbiN68mgds72jVspQXcKrTdhamvY3CCj4
         e4KXUVXSz7ihcvqmTVfaBwXZspfOD2PWnPPLZaG24JbqXWbauvPufXGBRNPEj7BXE5TE
         ZEIDOf8vTqoPylB7ckkAKyR0/k4jRaJpJ29/TnSfOQBT5F4E7I7OnFoq0B6z/1IWFuNz
         zqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j6CU7bLlZt8bfd5q/TULygkUuI7LQWf5DML6jtFlLT0=;
        b=Cu13c8oFejl5nHzjp8j0db4pFAmmSjK1YNpxYMxLmR/t5g+1Miyargzo7i46Ngk8Vm
         3WiNgF4tKs/Uil2aT9a7cjsLC5LUu2fF7sXQYQDoQo8IpbJWlogU2tsujsh+As/kTu2p
         AvkfANTPzKimMrQu8zq5Cw4FfKB+fUF0ZMmG7sASUI+BpDnl4qbliRE89reGKAStPwRw
         l1AR/F2onDz8tS/7ondQQVlCnwrk723BRjLdr0ckVtjeB5D0c9jfviqj9tkKTJBvErsu
         GeqIAUtoGERqMeL68pSDuz2MvjjThdhv2oFsbKxW6soFmhbsxXb+FM74BGc9/IkaHsMv
         /v7w==
X-Gm-Message-State: AKwxytcvPQ21z9ANhogmzwjLyUK6LVzch2ZXgdj/fK8ZTgymfsnD5eRi
        9TDh0++Mlknp0jdf39oOgOx/gpRoIPKyVjFWZEg=
X-Google-Smtp-Source: ACJfBot0d0AsjoEuW0eb7CXRak4vqvCU9nxaVJzdwKuyz3INNDLNs9Xp7SXoXnmcf0B0aeSzJvI0aHxqtWYTjQ81asY=
X-Received: by 10.157.45.198 with SMTP id g64mr15514730otb.226.1515925488524;
 Sun, 14 Jan 2018 02:24:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Sun, 14 Jan 2018 02:24:18 -0800 (PST)
In-Reply-To: <20180114093535.GA2518@ruderich.org>
References: <20180113132211.13350-1-pclouds@gmail.com> <20180114093535.GA2518@ruderich.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 14 Jan 2018 17:24:18 +0700
Message-ID: <CACsJy8BsV9+pxTzTD4mr6ZwThyxir5w2+a4ArqrhBPgyE3q5AA@mail.gmail.com>
Subject: Re: [PATCH/RFC] diff: add --compact-summary option to complement --stat
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 14, 2018 at 4:37 PM, Simon Ruderich <simon@ruderich.org> wrote:
> On Sat, Jan 13, 2018 at 08:22:11PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>> [snip]
>>
>> For mode changes, executable bit is denoted as "(+x)" or "(-x)" when
>> it's added or removed respectively. The same for when a regular file is
>> replaced with a symlink "(+l)" or the other way "(-l)". This also
>> applies to new files. New regulare files are "A", while new executable
>> files or symlinks are "A+x" or "A+l".
>
> I like the short summary. However I find the use of parentheses
> inconsistent.

I agree. I put them in parentheses because somehow to me plain "+x"
looks weird to me.

> Why not use them either always (also for "(A+l)")
> or never? Was there a specific reason why you added them just in
> one place?

Actually shortly after I sent the mail, I realized I could do better.
Since this is a mode _modification_, we could denote it with "M" (most
files in diffstat are "M" for obvious reasons, we just don't print it
because it adds no value), so here we could print "M+x" or "M-x". This
aligns well with "A+l" or "A+x" for example and is one character
shorter than my old way.
--=20
Duy

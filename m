Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC8D202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbdKTUjS (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:39:18 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45826 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbdKTUjR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:39:17 -0500
Received: by mail-qt0-f173.google.com with SMTP id r37so8358079qtj.12
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 12:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jqqPar+FMtTAWGUarQDUOor1WY1kxk9Ne7rSb+28aTU=;
        b=oLfW7uf3kC4Ar66iKE7iEp3OXCCH6k1yhe1V7Di1DVLUJSOWiM1YqaG4K5xT/KyU98
         v/noKF07EEq3H5IuE/C1y0IiPlmjqP03fHRT7cyWKHON0BheVZ7/ZlUGQMaG/+WK+zbQ
         8slTEEPySlZ7etJZV4YpuneAbmKXrYZp7WqK3JujKga70Uq6DfF/GgJCcXuW1qpnAjh6
         nRrANsaWt3m+RI67wvuGt8IuA9a/2s44Lho+Trzl5VeaIgDDn2yshRqAtYeRFwF0aoCF
         rz/5z9yQ2i/+wLYncHz11pPE9DAcORqrIRyHzHPRrxCvPD3frR2m6z48XCUAxe9TOxTg
         mLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jqqPar+FMtTAWGUarQDUOor1WY1kxk9Ne7rSb+28aTU=;
        b=sCmDovkA8jcCbvd0eqet+QcMEuYrbGgFtLIvBxI4Ok0K1kUt0gLc3n73nIakKeN5EL
         HQ5ApMn/OJG5ugMbbky2CB0Alo8qRfQtfsw/g6eZFM3pjpRT/jFbM8mehhxEFowwR7M0
         +ol0DrQ8z1N6SnqLALKQytQhfMHygpdeJf+CpJRX2P5htVhXxl0+Z7UVmAIUvJ0lPcCE
         Xg6y3LTVNCieuQE3toWeoM6BRqhIY7JTl0/exNYVA3p9fN8o3Z2qpni5eavBmqXudPQy
         ZZEdRhA4zfm3pUmoIUYWNwM9NVgC3Q6wXAq1JW17b3Wn1fwFqeKSoQfNXsUsxoYHBLas
         mi8g==
X-Gm-Message-State: AJaThX4JNsFEpaypnwspp2ldlFPz6qrxzpp+2LLsYDOV4Zp3pF20iAMi
        vV64aoYre428gmdEqJ1L/7w+1bvqcuv6qI6n0YNXjw==
X-Google-Smtp-Source: AGs4zMbwuWQtwMrvHIRk1KtQ5xCHEV5kbJhqAPhZajnbySnfvKELaRu0dfDVbGeiHnnFDC3Kds9F5lxQyRuVP18U3UE=
X-Received: by 10.200.44.251 with SMTP id 56mr23281342qtx.87.1511210356582;
 Mon, 20 Nov 2017 12:39:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 20 Nov 2017 12:39:15 -0800 (PST)
In-Reply-To: <9c3462e3-2d1d-05bc-9f7d-4bc93d32e7ff@web.de>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de> <9c3462e3-2d1d-05bc-9f7d-4bc93d32e7ff@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Nov 2017 12:39:15 -0800
Message-ID: <CAGZ79kZxiEPE4LPEo-eb4Ta4bYXVr9xQM0dFeiJk9XXKU4AR+w@mail.gmail.com>
Subject: Re: [PATCH 6/6] grep: show non-empty lines before functions with -W
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 18, 2017 at 10:08 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Non-empty lines before a function definition are most likely comments
> for that function and thus relevant.  Include them in function context.
>
> Such a non-empty line might also belong to the preceding function if
> there is no separating blank line.  Stop extending the context upwards
> also at the next function line to make sure only one extra function body
> is shown at most.

Can we add another heuristic, that checks for common function body ends, e.=
g.
if the preceding line contains '}' but is not commented (the line doesn't
contain '*/' '//', '#'), we have a strong hint that it is a function, not a=
n
additional comment.

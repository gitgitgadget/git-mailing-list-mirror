Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96F21F406
	for <e@80x24.org>; Sun, 31 Dec 2017 12:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbdLaMX2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 07:23:28 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38680 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdLaMX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 07:23:27 -0500
Received: by mail-wm0-f47.google.com with SMTP id 64so54232354wme.3
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 04:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KjKlM2Xjc5PA4iXrFfIVZnJ4h/LS2Qwd4uZNvOIj3xE=;
        b=e18iR7AobgCVVhGh93CR+LSdP/f7SzYEXPRcD7ICNzoF5642Hc1a5KGx4HCtKqvPXw
         0xgZgAnWJR3QjYp0J6vkVifyAJlLVOU864q1U0oe6h31Q0a+SpVBCCV3yPEevrjNZjvk
         0CUrEMi6CUGqj3GtOfarQJh2q+4erWUjq2RgF1q5cMbSmtxBC1oZG8U3nZydW7j5beHn
         DnIZPofyAYWMuwYCCWziXX6NYQGAKvb9vedofQgNqQHI/QidI74QhlvBDek4HgHA3BCF
         3yOp2FrGpko0tySlpR0Im7QT7ztxcO+Gmz1UlFbUIFUs/oO+eplLMRcmz22qqyqTCGuw
         1qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KjKlM2Xjc5PA4iXrFfIVZnJ4h/LS2Qwd4uZNvOIj3xE=;
        b=Bp8wD4vXqNkB8q+WUHPhaq0pQkkTKUV55+kguMoWqwb5sJfRbykbFBSQgnJLLzySC1
         Gsaqp0bxX4LPjp2Qz8rthZOaNxDHJD8I7wRmidtUHgD52tDql6wOE1mMC9rOt6s3PLjE
         tgELUlZwELHNUjpLZ4kr6RLoYLNX5c71C3cMkZMIpAv836mCjygwNlXK+f9lVhJDKcEM
         5koNrLrt4tZmwl883ry1MWqqnZq4ol2sVAIRxVdz6Fxf6JWqX2hzaVxznIL62+Ad32DE
         DsQ+f0KL40s9vVBlEE+YZ78ULIaB/d2yTQD+9us32hMf9tx7ZMOgTR03SmdBUq5IS9zP
         lQ4A==
X-Gm-Message-State: AKGB3mL4d3stMx4yOm4jCVXNq1T2JhYG3rI4dog0Jhug4yvjVJ4Tch9z
        jwsH7zUV+JwNWpG/mqNkA68=
X-Google-Smtp-Source: ACJfBosfGTbKPUSZuQo7Xc5U8yCfvneK74jhtHJ4c8dyMjMHMi/JR0fJb/MXCCW+FKM5QGxgAjFnew==
X-Received: by 10.28.47.66 with SMTP id v63mr31059567wmv.144.1514723005851;
        Sun, 31 Dec 2017 04:23:25 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB57B0.dip0.t-ipconnect.de. [93.219.87.176])
        by smtp.gmail.com with ESMTPSA id x75sm18172516wme.44.2017.12.31.04.23.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 04:23:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/5] convert_to_git(): checksafe becomes an integer
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171231080552.22258-1-tboegi@web.de>
Date:   Sun, 31 Dec 2017 13:23:25 +0100
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com> <20171231080552.22258-1-tboegi@web.de>
To:     tboegi@web.de
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 31 Dec 2017, at 09:05, tboegi@web.de wrote:
>=20
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> When calling convert_to_git(), the checksafe parameter has been used =
to
> check if commit would give a non-roundtrip conversion of EOL.
>=20
> When checksafe was introduced, 3 values had been in use:
> SAFE_CRLF_FALSE: no warning
> SAFE_CRLF_FAIL:  reject the commit if EOL do not roundtrip
> SAFE_CRLF_WARN:  warn the user if EOL do not roundtrip

In general, I really like the direction as this simplifies
my patch later on in 5/5. However, I see a few problems:

(1) The prefix "SAFE_CRLF" confuses me because the main theme
    is EOL and CRLF just happens to be a EOL type.

    What do you think about something like this:
    CONVERT_ERROR_IGNORE     0
    CONVERT_EOL_ERROR_DIE    (1<<0)
    CONVERT_EOL_ERROR_WARN   (1<<1)
    CONVERT_EOL_TO_LF        (1<<2)
    CONVERT_EOL_KEEP_CRLF    (1<<3)
    CONVERT_ENCODE_ERROR_DIE (1<<4)

(2) We mix error reporting switches (FALSE/FAIL/WARN) with
    switches that change the content (RENORMALIZE/KEEP_CRLF).
    Plus, these the switches should be mutually exclusive
    (e.g. we don't want to enable the FAIL and WARN bit at
    the same time).

(3) We kind of replicate some flags defined in cache.h:
    #define HASH_WRITE_OBJECT 1
    #define HASH_RENORMALIZE  4


- Lars



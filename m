Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7701B1FD09
	for <e@80x24.org>; Sun, 28 May 2017 19:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdE1TI4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 15:08:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36010 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdE1TIz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 15:08:55 -0400
Received: by mail-io0-f194.google.com with SMTP id f102so5366916ioi.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xv7lt7BkSJC3TrIDB9klwby0o0AvCK0iXmn5jrmVafk=;
        b=ZoETC4TBYNRtmXRgbykeSouHGc35B6X6j6aWePlAu1Nn5C8D/KI/jBxzV3RUrjd47/
         tdyJXR6VAucNNOpSBWnGTBboacQgwU2pzs3zX8snc1AVgHGmaxW3yYdw11V3hWByLXE6
         pCsphDTMtMWhl/TCTpj13FLPwc4o327KDciUlwe6EiG9h8Q3A3pFI39/gv0T0xM1/W3s
         HOCi4gkHhlFm9/N1RRgXjsLykPJK04NBcxUzd4YNzlLEVnzZytxNc2QZcmOfMj+8H+nO
         /ZZvrbsMqzXgtutGdGMCPVK2UbxZNdqbjyi70AYSTONZ7axjt7ieu0xcUoFqd7wyqQSq
         GqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xv7lt7BkSJC3TrIDB9klwby0o0AvCK0iXmn5jrmVafk=;
        b=VdcKjYL5pZcH2FqXOlo2KBMwZwVBLF3oU93u4SDJhHaqkqVLMkbQDG1AZ2WNxV7V5T
         2LUv2EYTA9uBBVg+wl6s4QKNUZhvHrgEzwkRr7oe/SELpSlfePpSjGy3jEbwvKYGwG0+
         Szmlv3114YRtIPU5xttDVLKGCXgQjXDhOyxcRdftlhFtxxl+4QszylE5KEzoAlMOiZsh
         QpsZjkgZzOFZdU8kguhRCuQ8ZDguBcSw6mggot9pcjKhx+bwuJDSHrsO9esBYbwjtwVR
         H/pgNHwr96H5YkUOwcUgrqD92izS9v2zGWjFGYPowka8hjthOZC1J/USJi2ikILuZQcY
         ScgA==
X-Gm-Message-State: AODbwcAAgmFxsfxrjUwsWlOypCYIVdEhkth0uUphPXaEAxkAd2OOjlH3
        o4X3G5c1hrZeGeqbJgL55ZNbSReRWg==
X-Received: by 10.107.178.12 with SMTP id b12mr9891872iof.50.1495998535131;
 Sun, 28 May 2017 12:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 12:08:34 -0700 (PDT)
In-Reply-To: <20170528165642.14699-1-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 21:08:34 +0200
Message-ID: <CACBZZX5wA57+9t+wzYc-iMpvns-zm1XAdzKszUk7PF2vkoxeMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Implement git stash as a builtin command
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> I've rewritten git stash as a builtin c command. All tests pass,
> and I've added two new tests. Test coverage is around 95% with the
> only things missing coverage being error handlers.

Worth noting, with your patches the best of 3 run of all the stash tests:

$ for i in {1..3}; do (time prove -j1 t*-stash*.sh) 2>&1 | grep ^real;
done  |awk '{print $2}' | sort -n | head -n 1
0m3.293s

Without:

$ for i in {1..3}; do (time prove -j1 t*-stash*.sh) 2>&1 | grep ^real;
done  |awk '{print $2}' | sort -n | head -n 1
0m7.619s

Of course some individual invocations are much faster than that, this
includes all the shell overhead of the tests themselves.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841F520248
	for <e@80x24.org>; Fri, 15 Mar 2019 09:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfCOJJh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 05:09:37 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:35820 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfCOJJh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 05:09:37 -0400
Received: by mail-oi1-f171.google.com with SMTP id j132so3708798oib.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 02:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2Cf7F0rAVv8Yoa5Vd5lioo/o4XHofMNqEoCGffBi8bQ=;
        b=lDn3xMF8RNmRNY2UEZtRCxPJUVYnSOijyFOjYMle93V5V/hOChUpeq4+rxKKYdw6jY
         OR76jlCrxGWt1JbbX6MTYfcjR/9L2LfgmI8WiCgKLsmnBGY05Nrwyieo9veDrXKFlAhG
         0ecCvqMsCpGMgkfEFoOKsoBFoKwFC4B2UstD6vomaDywEDbxsbQAxC+D4UNrZQVUwLGn
         xPZCB6jQz4F/JmO6g0MBt65o7BCGfMKLUt/QxIn+HWwDIQgEI8pQklIaWl6sDLtuMioz
         yo9l/Zi4sA89bFfOupHMkrp9K+oe5wa+udXl+flltlnvyN9L4OkFJk/f6NNJbP3ej5XL
         kT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2Cf7F0rAVv8Yoa5Vd5lioo/o4XHofMNqEoCGffBi8bQ=;
        b=GcOCTjTV6QxBQfxb8vkywy8m8iKbot+u/sV26ZaJh6NodbpnhkaR9ehujLX6E5OrzH
         k6Ztags1Zgb2crImWQwl+dIo5T8M5TT2Rh9pByiLLWkGTJ9FOKqW+A+QQmfXWzvH8gAE
         UHPwTBnh+TuT4tMeveMGXdtjtDcTvDx+BloDStOfJ/j2IrZuZrOGC+DK+l6oEkHNg9JK
         qDvlQ5b8l7bNLWzbg/v2ckvMT50Nn5Axlj2sv3KdxpcaK+/w2SGmvDLGEGVzec6N7t1L
         LXlLf+ZU9yYPP5ecuyTv1a2Xefv7S8f4mfDpQI3W5WtBOYwWvHNnjk3TT6LeAe/e1n5x
         TPdA==
X-Gm-Message-State: APjAAAWI2N0YWYPEn8Khdmxq4qaap0M5/XVHXFmdeJDuNSd/CmRrMxpS
        y/rKGLenTOUY78695JjcPhGyG6fUKX6d5Arn4e9rEnXo
X-Google-Smtp-Source: APXvYqySC71N1vNV0poRpvswXQuTVXAyxRudW/gPQXWwdMRqagH9xaZKJrUTdTULNpGHNuO3YZPnozwmr3EuP0nQHw8=
X-Received: by 2002:aca:3081:: with SMTP id w123mr913709oiw.141.1552640976229;
 Fri, 15 Mar 2019 02:09:36 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Fri, 15 Mar 2019 14:39:25 +0530
Message-ID: <CAMknYEMgJ88zWsebxBqsLq8LUwYzg0vN3RpsWVpbqvncrd5dGQ@mail.gmail.com>
Subject: [GSoC] Microproject: Add more builtin patterns for userdiff
To:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

for the microproject: creating diff function support for different languages.
i wrote one for shell script, have tested it outside of git and it works fine.

query regarding accommodating the pattern in:
1) userdiff.c, it uses - #define PATTERNS(name, pattern, word_regex),
for defining patterns to locate functions.
what is the use of pattern and word_regex parameters ? i am guessing
that pattern parameter is the actual pattern to spot functions in a
file,
and word_regex is used to get function name. is that correct ?
please let me know.

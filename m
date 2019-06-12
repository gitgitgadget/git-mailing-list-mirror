Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B031F462
	for <e@80x24.org>; Wed, 12 Jun 2019 09:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437688AbfFLJrA (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 05:47:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41978 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437315AbfFLJq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 05:46:59 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so12389772ioc.8
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gE2DaGT6KdTRqas/YebQhpKPXD0Ua7k6ALcgfZWjrBU=;
        b=XUYbuS1Y0yHkZl1C2qPgGSF4B3jwnx13WSy2ou6wWAtyxAYOEDnJhBj90Qsk1iYR2S
         MM/p3CjBfwGb39rsVDLX5z9gv9p9WuRD9qmzJI7hArzL6rDIcJJawSbPlObftkin8gb4
         IMwOBAjqKUDtSeZbo5RG7FX9zBirq/rcl2wa5YXKYKVXk80Ie5uXS8PLWVjDf1v4BZ/u
         HblJrAENITO0LLrztw7l4yVPxN/BqFM0o9Z5w1St5tgp9QR0j/NM4IvkbKZwPsFonua3
         wLiK9CpDgEElpPT7O/ytJdXcDgaUnBdGJibfXBhgoJSDWrJz/hIBTklTktjaTTqIp4xi
         9wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gE2DaGT6KdTRqas/YebQhpKPXD0Ua7k6ALcgfZWjrBU=;
        b=PBp/nVWnuFkdtbfUEYHlpyelmqNmUIOA9oojjo00pFRsJP1A4Z2EsCUfM6T++YlEce
         /nDMTErPP9lZXsxIVAKJGjBgJW/RGY/R27tyXCLv8JmZjnKTq9e9Z4UJXS8pKK0j3E5a
         PpNyeBSKWmuyt1/F/lKkgi3xxAuW9fyFc8iXiD5V1NklTxxuCkRulVHTksCfvTXmsFwh
         SJXOH0HaBHmMjIk6uwTkrhMsbzVrOe7gGB8dG8XbpBgL6c1+ltN3F1vIolc3UyZ/poxk
         Hct4rzrbIsGC/BXjAvgPxoxbTRSkPdQSGbBqO0RTCTd0cyIJ9sMt23jqldXOBQ8HyvCO
         MPGQ==
X-Gm-Message-State: APjAAAUJiAysVEPRMtZ0+3seuXfJ9gIyn7xmMw9t5PMisceyfZBVdCXy
        RQjkHmRyfRfhLxBGlr/4sNmvIjvGc7yA9jHS8NGiSQ==
X-Google-Smtp-Source: APXvYqzx4dy2tnPzngerdRaZHeH664+xqurTzQ+k4lPyeww3ecUlRM7DrCXRD/qjjr7Lwyhim2TJNufWlYXKaLqcDFw=
X-Received: by 2002:a6b:d21a:: with SMTP id q26mr909646iob.273.1560332819168;
 Wed, 12 Jun 2019 02:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu> <87y32787k9.fsf@evledraar.gmail.com>
In-Reply-To: <87y32787k9.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Jun 2019 16:46:33 +0700
Message-ID: <CACsJy8Ce9exNKEYojo8Uu6WjyjSGN2imO-8Z4cXa-FGkXs4GJQ@mail.gmail.com>
Subject: Re: Reducing git size by building libgit.so
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 4:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I.e. we'd just have one git binary, everything else symlinking to that,
> and we'd route to the right program by inspecting argv, which we mostly
> do already.

If I remember correctly libcurl.so startup time was the reason it's
split out of "git" binary, so we can't just merge everything into one
(*). But yeah merging some back is not a bad idea.

(*) but maybe "git" binary has gotten much slower overall, or
libcurl.so much faster that it does not matter anymore. That problem
was like 10 years ago.
--=20
Duy

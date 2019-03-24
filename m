Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0330320248
	for <e@80x24.org>; Sun, 24 Mar 2019 09:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfCXJTZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 05:19:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46244 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXJTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 05:19:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so5015496edd.13
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wY0z65v8ecPrUSRbLGgk6b18eJrXUTTFQ/21M3r8G6k=;
        b=JsJJsliQ3RC2F1aPkU9E89CK+/o1G/v+3PhWiFXMpyUf0vBFOnOrwPA2rJ+vrSXc5D
         LuQTjf7vBiCqPJYQ5D7Htu2UeldIMszDWzJihtirNIA1zWnGexEcs/fdBdTo3UARlJcF
         koHqsaww5NXiCLtmSnUyw1RAkEQfZywR+O0Bb8bQ2MbrTZ9SUXdSo874G7S/yy5v/tCS
         rH9JF6WSeoPqGlh6oSAQHpKTlEPZ+Al2V56wIBHab7vNf3o6ggOVq7IicLMrSDdCoeAK
         /dRmAJxtcOsG9I21U0amG4x08QO2TkVrciF3vmIJprSuVoiKhhFa5Ehh02WnOMVxNdZS
         oPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY0z65v8ecPrUSRbLGgk6b18eJrXUTTFQ/21M3r8G6k=;
        b=iPdTAkcOG1lQC2aXK0OO+wq17Yod+Zy439UXMhMzQIWHMknqN0YB4mUrnDJLSYSFkc
         VijbmcLgatRe0HSfGz+PgzCTc0LmLCDznEo4JLRB1kF32JxdeChYkVtxsKqUI4Oe6aGS
         5rkXyKaR3+TXJeUf34oWIAc6s/pYoPqza7Izph+ZCvHJtCjlnpzbIZYJo7MIB8k5JjJk
         gircHsLPVtlCRmnjROLzi9VLnM7hdEMtyY66W8fhrWYo5A5lW+16nJlLWdXUsmm+w6Up
         4HPqK4Hx2Dk1yPbsiZF4Z5ZuccIenh2Ghp5n2iT6CW9akreZlXcAymsLNSun0A433HDq
         95Uw==
X-Gm-Message-State: APjAAAVpnCZaDMEISgcn5NJ+xIQpjJ3VIDEn5IxGNd9zMV+iWIDZp55i
        KaPsnjxNj8x2fdXcoOV8lzvr5yY2SaiV9Hy/dY8LKqd2
X-Google-Smtp-Source: APXvYqzLccsLI1zvPRPvtmiZw1Os1NKvPez8dsutrtBz1A18kmm4Bq+ZZmwLmJI6bl1bVfo2ATctuwIb/C7JCZZZixo=
X-Received: by 2002:aa7:c250:: with SMTP id y16mr8889640edo.238.1553419163732;
 Sun, 24 Mar 2019 02:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190322160615.27124-1-jkapil.cs@gmail.com> <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
 <CAMknYEMBYxp1QJ3Ds9dmuS4ccHKtExx33d_Kv63UOwaUMm5oUQ@mail.gmail.com>
In-Reply-To: <CAMknYEMBYxp1QJ3Ds9dmuS4ccHKtExx33d_Kv63UOwaUMm5oUQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 24 Mar 2019 10:19:12 +0100
Message-ID: <CAP8UFD0cWSTZPqqVwTFyYL06S+6aT_EiLPW6jUE0AH9puxevmg@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH] userdiff: added support for diffing shell scripts
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 9:04 AM Kapil Jain <jkapil.cs@gmail.com> wrote:
>
> On Sun, Mar 24, 2019 at 1:34 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > To save some work by people who could help you, it might be a good
> > idea to show the output of the failing test, for example the output of
> > `./t4034-diff-words.sh -i -v` or `./t4034-diff-words.sh -i -v -x`.
>
> Looks like i just needed to know about -i, -v and -x switches, they
> helped in debugging.
> The problem was with the expect file. It is resolved now.

Great!

> Thanks, will be resubmitting with updated expect file.

It looks like you sent "[GSoC][RFC/PATCH 2/2] userdiff: added shell
script support, clears test". I think though that it should have been
named "[GSoC][RFC/PATCH v2] userdiff: added shell script support,
clears test".

"2/2" means that it is patch number 2 in a patch series that has 2
patches (which should be marked with "1/2" and "2/2"). When
resubmitting an already submitted patch (or patch series) we ask for a
version number like "v2", "v3", so that we can know that it has
already been submitted.

`git format-patch -v 2 ...` will automatically add "v2".

> is the parser used to parse the expect file specific to git ? or is it
> some general one ?

The test_language_driver() function used to test the regexps is
defined in t4034-diff-words.sh and it calls the word_diff() function
(also defined in t4034-diff-words.sh) which is:

word_diff () {
    test_must_fail git diff --no-index "$@" pre post >output &&
    test_decode_color <output >output.decrypted &&
    test_cmp expect output.decrypted
}

So it uses test_decode_color() and test_cmp() that are defined in
t/test-lib-functions.sh. test_cmp() in turn is defined using
GIT_TEST_CMP which is usually either "diff -u" or "diff -c".

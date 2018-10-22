Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D5D1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeJWF33 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:29:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34107 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeJWF31 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:29:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so39327718eds.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7jYY6vfF4hO+GjjsFwUtDKUC8GJLQarGSvOMBhqEohY=;
        b=ks7ET7SCDLQd6jJZvyr3/G4Yfh5SmrVT6HKhF4ZOaqqTbpIrCtDU++EonOxznHJfU7
         fk/wXZ17LwA7HnoaYXiPkco/JEpL+AINxhSlgf3bWi6FcKpcGiQppOxNa7rUwHwdo0CQ
         IXl0iYT7lbU9mGwpmdLfZ7cj6ody0NOvFbEy+GMs2519OzBexjqCix2VVzkL+rzSjdWb
         PDd8H/83aRKKP8W9uZFFbsjran5+YTXxFD+Sd+sZT433xwbA1pCUUALw+ZwK7Hjoxe5H
         RLdDRdScpEhn7SMTOPTiw6BkJLYgMIVf1dC9xjErTZC3SwQ1dzpFSbKVWNpfv1SJV8qz
         VTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7jYY6vfF4hO+GjjsFwUtDKUC8GJLQarGSvOMBhqEohY=;
        b=GuQ/01awcRXtTrPJ85io76ppFH9B9FpNtf3rMxHyw4CtZOOog2rlXMfO01HGNUdI50
         XtQq4ap7uGCqZFavrg0IsI87lTVQlFalt7UNeLTlLWih4rvAftyC0QEZI/GqEnSUbNKb
         qcAjF77tzEAyvBNHMEZ6tHPWZQfLTA7c+bR5arm5AG4eO2ENUhtlCMndBb9jugZf6U5G
         Z70sjkapQXwcxPiZDqLxzwv0Mo+HsAkuivupa04nPCuMd9otxkI2C+NZxWQp+vWSinO3
         MLl0k2C4/ddxHnSG9+zVgghTb09fQBwL7deJ1+cfPjvyctnQh3cSLSVJT/3PUoHQ46un
         sbfw==
X-Gm-Message-State: ABuFfogP3XM20ShGl/xjV9HaUSH7V7JD6/zUDnogzJd6wl1zLMgpiEHi
        iXq6Z8iYfU8XQHxvxoPtvMaESa8w
X-Google-Smtp-Source: ACcGV61SJO+qcYu36ER69lFXeo+3YQ82RoVNKunwhgnc2ad+cmtbcHDOWcKUnzH9NB/KiFvJW7ufAQ==
X-Received: by 2002:a17:906:a2c4:: with SMTP id by4-v6mr36246364ejb.86.1540242555235;
        Mon, 22 Oct 2018 14:09:15 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id 94-v6sm11595538edc.59.2018.10.22.14.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:09:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181022153633.31757-1-pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 23:09:13 +0200
Message-ID: <878t2pd6yu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 22 2018, Nguyễn Thái Ngọc Duy wrote:

> The current gettext() function just replaces all strings with
> '# GETTEXT POISON #' including format strings and hides the things
> that we should be allowed to grep (like branch names, or some other
> codes) even when gettext is poisoned.
>
> This patch implements the poisoned _() with a universal and totally
> legit language called Ook [1]. We could actually grep stuff even in
> with this because format strings are preserved.
>
> Long term, we could implement an "ook translator" for test_i18ngrep
> and friends so that they translate English to Ook, allowing us to
> match full text while making sure the text in the code is still marked
> for translation.

Replying to both this patch, and SZEDER's series for brevity. Thanks
both for working on this. It's obvious that this stuff needs some
polishing, and it's great that's being done, and sorry for my part of
having left this in the current state.

a)

Both this patch and SZEDER's 7/8 are addressing the issue that the
poison mode doesn't preserve format specifiers.

I haven't tried to dig this up in the list archive, and maybe it only
exists in my mind, but I seem to remember that this was explicitly
discussed as a goal at the time.

I.e. we were expecting the lack of this to break tests, and that was
considered a feature as it would spot plumbing messages we shouldn't be
translating.

However, it's my opinion that this was just a bad idea to begin with,
I've CC'd a couple of prolific markers of i18n from my log grepping (and
feel free to add more) to see if they disagre.

I think it probably helped me a bit in the beginning when i18n was
bootstrapping and there was a *lot* to mark for translation, but we've
long since stabilized and aren't doing that anymore, so it's much easier
to just review the patches to see if they translate plumbing.

All of which is to say that I think something like your patch here is
fine to just accept, and the only improvement I'd suggest is some note
in the commit message saying that this was always intentional, but
nobody can name a case where it helped, so let's just drop it.

In SZEDER's case that we shouldn't have GIT_GETTEXT_POISON=scrambled,
let's just make it boolean and make "scrambled" (i.e. preserving format
specifiecs) the default.

b)

SZEDER's series, and your patch (although it's smaller) still preserve
the notion that there's such a thing as a GETTEXT_POISON *build* and you
actually need to compile git with that flag to make use of it.

This, as I recall, was just paranoia on my part back in 2010/2011. I
wanted to be able to present a version of this i18n stuff where people
who didn't like it could be assured that if they didn't opt-in to it
they wouldn't get any of the code (sans a few trivial and obviously
correct wrapper functions).

So I think the only reason to keep it compile-time is performance, but I
don't think that matters. It's not like we're printing gigabytes of _()
formatted output. Everything where formatting matters is plumbing which
doesn't use this API. These messages are always for human consumption.

So shouldn't we just drop this notion of GETTEXT_POISON at compile-time
entirely, and make GIT_GETTEXT_POISON=<boolean> a test flag that all
builds of git are aware of? I think so.

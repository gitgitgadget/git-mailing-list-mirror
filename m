Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B951F406
	for <e@80x24.org>; Sun, 13 May 2018 20:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeEMUST (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 16:18:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36611 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEMUSS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 16:18:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id n10-v6so11479331wmc.1
        for <git@vger.kernel.org>; Sun, 13 May 2018 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHW55LNTK83H6rEpaPAb5tbIgATxGXQcuyw5oM90z0A=;
        b=BzebxnbhIm1OhZmlTBrRglaP2oOhGSF27BkzicQ0wUnBFCTpLFdQhQ5qclMzkIY18I
         AZ5TgWcK0eCo7XClhicLK/J4wJvoNMEm5vGcewzHqHZbwMqkTLztr+iZqYO57q3r3XGK
         C7GYTeILIzpXjDeFOKvIYo4Hqgh29VT8esN0zkW4wvr3MyZJLwbSNbBviqU0cd2JItLe
         uUTGkmCaLSVkVACeDOeVw7g1RGsG9tBiywLFTdiKb7Cx5KppS8ZmfA06RYlCmHggfEUL
         ra/Ha5GgkTimpHLcoyYGz7UJLwGCwBR5z1741NbAvome/lsjf2xOCkuaTjsTk8hAIwsz
         1KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHW55LNTK83H6rEpaPAb5tbIgATxGXQcuyw5oM90z0A=;
        b=N2YkGj2s5LAj+a9MgBSkadXp+I71WBGG2XpB4av2O6sjoiU3Qm4vQXWH4fZ14mJMJD
         h2d7nftFn4AncbmspX9qD6GF+7t9J1DFFqYz5CPV504duOqJouQGI0MtCwUusdYKgl/8
         X8Gz05UTabH76J420einWqm1MOIBaxjCFlc9PLiKuWRQu/mEVNnWpm5xncz0bu5a0PFj
         4xIdss3S5Ar4XyyywtUXtWa7352W9eVqlZsJoH/iIgIzEyTcoAu5ahRj5ZRuvOrxezAB
         ZOgMI+8JVf5Mq8gTVobHfxaMGOdZ66PFSOzIXXse32Jt95m1NNXpFdgk0GqS2VOLUCfg
         VBTg==
X-Gm-Message-State: ALKqPwfDViv3L61EyKWqhXmobZi3nLD1NNCSt4eslEvOmSfwHV8zWsHv
        6NKNpPuX/XEHE1mLCKEu1+c=
X-Google-Smtp-Source: AB8JxZopPNsmyMgcApldkFpowoaGv1bKOXYl3UYpCBdoMxImQlpdsq7fdm2XkypJ2I5rRw+blmIY5Q==
X-Received: by 2002:a1c:d50a:: with SMTP id m10-v6mr3711625wmg.72.1526242697535;
        Sun, 13 May 2018 13:18:17 -0700 (PDT)
Received: from localhost.localdomain (x4db292f8.dyn.telefonica.de. [77.178.146.248])
        by smtp.gmail.com with ESMTPSA id 64-v6sm7153712wmb.2.2018.05.13.13.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 May 2018 13:18:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Dannier Castro L <danniercl@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
Date:   Sun, 13 May 2018 22:18:10 +0200
Message-Id: <20180513201810.6440-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.756.gcf614c5aff
In-Reply-To: <775fe020-be92-f65c-5a67-e83e6bf4777f@gmail.com>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com> <CACsJy8DZ1QvjO+JdbB76TOLtB2wp4Ya+CgsTyD1oz2Y+ZdKdYQ@mail.gmail.com> <775fe020-be92-f65c-5a67-e83e6bf4777f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 13/05/2018 00:03, Duy Nguyen wrote:
> 
> > On Sun, May 13, 2018 at 4:23 AM, Dannier Castro L <danniercl@gmail.com> wrote:
> >> For GIT new users, this complicated versatility of <checkout> could
> >> be very confused, also considering that actually the flag '--' is
> >> completely useless (added or not, there is not any difference for
> >> this command), when the same program messages promote the use of
> >> this flag.
> > I would like an option to revert back to current behavior. I'm not a
> > new user. I know what I'm doing. Please don't make me type more.
> >
> > And '--" is not completely useless. If you have <file> and <branch>
> > with the same name, you have to give "--" to to tell git what the
> > first argument means.
> 
> Sure Duy, you're right, probably "completely useless" is not the correct
> definition,

No, "completely useless" is just plain wrong.

> even according with the code I didn't find another useful
> case that is not file and branch with the same name.

The optional disambiguating doubledash is the standard way to erm, well,
to disambiguate whatever there is to disambiguate.  Not only refs and
filenames, but also e.g. options and filenames:

  $ git checkout --option-looking-file
  error: unknown option `option-looking-file'
  usage: git checkout [<options>] <branch>
  <...>
  $ git checkout -- --option-looking-file
  error: pathspec '--option-looking-file' did not match any file(s) known to git.

Note that this is not at all specific to Git, many other programs
support the optional disambiguating doubledash as well:

  $ touch --option-looking-file
  touch: unrecognized option '--option-looking-file'
  Try 'touch --help' for more information.
  $ touch -- --option-looking-file
  $ ls --option-looking-file
  ls: unrecognized option '--option-looking-file'
  Try 'ls --help' for more information.
  $ ls -- --option-looking-file
  --option-looking-file

Please do not make it mandatory.


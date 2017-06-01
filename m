Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF77020D12
	for <e@80x24.org>; Thu,  1 Jun 2017 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdFADaF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 23:30:05 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33205 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFADaE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 23:30:04 -0400
Received: by mail-oi0-f67.google.com with SMTP id h4so4895868oib.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RQoPod/DHL7lQsS/b13BlSuTVMJeFmJCHRH3oTDH2+8=;
        b=sBAKWZYLdK8SL3+vl3o9xF5phlWUQrsztGJTPEDo2mJB+v9sGlF9NuvkAZNxC9p+Tt
         6mUF4jSOnRyb96g/oY6xi7QJJEVx5gqazWkQhYQatQkVy1+KOT1oGzakBGUCd+fdqJYE
         l5Di10UOviXW2X/hVSHiRqOfbmF7uhuckg/xaLtrTgx36LxSBgoLs9vVEJKkug5eYA5C
         RJfGcc4f5MKehsWOugazNA/MhB7s+nRePNyeFCYta3zF40uUXu4J0riwjUbg2pezsqbW
         82q1zayFsrBpyM5lfXhDKmfRurHoGdFKzGOwgheGmlTAiYKI5L20kYYsh+hQTT+U+Ojb
         0wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RQoPod/DHL7lQsS/b13BlSuTVMJeFmJCHRH3oTDH2+8=;
        b=oeAVpgbZF9aQaVY1E0ekbeg8TZTTjGnmD+2lFf9aVPtZqByfM4+R24ps96oxo031Cn
         8TH/XSdkHt2sSTqAKshpQBqSigAghOkozvuE0nlKYsds48ZGUR4DAXwG6NDTc4vz5Aen
         6jZwVNfmblQCbgiSFlDXmyUZQui17s/XNWU3+tSlkdJjZVr7icj48DMJlaztXMG2XHlp
         xPnaYhyH/xBOU2s21v0hUmab2v+ZPpSivDyaxbnwOrwuLgX8dpuOpTSRBNHDmOaeHQtf
         jGoEDDKdb+5GA4hJCEYNrN2gAA+WcCqn3bnIAQGG1Jo+pROpVnZnGYRXIgNKpxJ0xvkU
         uKtQ==
X-Gm-Message-State: AODbwcBg7wXAypicaqu/syqWm6dwHgKYNPwpbaRVVOZHOVRN0tNekq4e
        7INlekfCjl3EPY2jNiXNaKkgtL1vFw==
X-Received: by 10.157.13.45 with SMTP id 42mr9041750oti.15.1496287804227; Wed,
 31 May 2017 20:30:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.51.169 with HTTP; Wed, 31 May 2017 20:29:43 -0700 (PDT)
In-Reply-To: <CACBZZX4VP2GZSxw5MqBY=w1EhN64=75MFnjd0CYvPTvoVdFWQw@mail.gmail.com>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-5-joel@teichroeb.net>
 <CACBZZX6uXnE+BTfsiLNF2OT3Dsr-J99uUFEwcu-qK45OrU+1hQ@mail.gmail.com>
 <20170528192149.dgzibu334n5ja57e@sigill.intra.peff.net> <CA+CzEk8NoGhDB6nX6RRL7J-KenoJBE7rVfskJfCQn_iCSnA4nA@mail.gmail.com>
 <CACBZZX4VP2GZSxw5MqBY=w1EhN64=75MFnjd0CYvPTvoVdFWQw@mail.gmail.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Wed, 31 May 2017 20:29:43 -0700
X-Google-Sender-Auth: HKKBbvTP1ZN7OdspQHIyVjwdW30
Message-ID: <CA+CzEk9uV5Oqa=NMhd1bjnXP-vjUqVUMH9KSzW6ehi67hqU2+Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm running into a lot of trouble using argv_array_clear. It seems
that some of the builtin git cmd functions move the parameters around,
and write new pointers to argv. There's three options I have now, and
I'm not sure which is the best one.

1. Fix all the builtin cmd functions that I use to not mess around with argv
2. Stop using the builtin cmd functions, and use child processes exclusively
3. Don't worry about clearing the memory used for these function calls.

It looks like the rest of the code generally does #3.

Any advice here would be appreciated.

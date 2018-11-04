Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684A31F453
	for <e@80x24.org>; Sun,  4 Nov 2018 01:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeKDKO2 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 4 Nov 2018 05:14:28 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44113 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDKO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 05:14:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so9173436qkh.11
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 18:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5Xdf7bH2K2LZsguy4aj2vfOvqN/j/l9g7XJC0AIF5A=;
        b=ezB7h2lGA7KH91I22OBurxOZqSsMgLxPc/9Eyo608p49giY2wGjMOxbIoBm/kDcEFA
         dXDkUyKpuhQjNIY3s2tdSfoVEu0Ed15fsyq7W5rBDV6Q7pb0vRgIkT+m9v+of7j3BGaC
         tWKpmwWrdIEgH1DJFin3frSsMOgNy2AT5YYKqbOEL0ZpydznAjTqxHKscls59EJeMWuL
         1V40X1xpiZ1amjUk1+2vz2h5CpO+5f/CpP3oj1eOp5v3Zn1Ih3VdRitBy1lrX2kR+JNb
         5RGl8YOyeRM+8kuulzoDqZAwkX2saR1mBjrlK4eMbvW1f5gVu0gPNsyiPL+rUebDr4Wa
         ot2A==
X-Gm-Message-State: AGRZ1gKpRk7L72oHGz4u16d0kmFb+pd/0bODYYl0PBpJ0yhxYHMO3s02
        AnrUNH7Mf9YlQnmwApcg+XPLcJvhmO4sn85f4eg=
X-Google-Smtp-Source: AJdET5d83AKGRS7JhQDy7ou9TrgrHoMW9X+e3YOkBEFEY5jr5g/Obb/k/FWFBom7xXe/XPj3lF457+LUch5H2687bJU=
X-Received: by 2002:ac8:5190:: with SMTP id c16-v6mr15889189qtn.352.1541293286447;
 Sat, 03 Nov 2018 18:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-5-avarab@gmail.com>
In-Reply-To: <20181102223743.4331-5-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Nov 2018 21:01:15 -0400
Message-ID: <CAPig+cQXmxZM6mHn9EwuPes=bB6zHN5rqAkGs5AwpLHGib4WPQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 4/5] Makefile: add NO_INSTALL_SYMLINKS_FALLBACK switch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, stanhu@gmail.com,
        richardc@unixbeard.net, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 6:38 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Add a switch for use in conjunction with the INSTALL_SYMLINKS flag
> added in ad874608d8 ("Makefile: optionally symlink libexec/git-core
> binaries to bin/git", 2018-03-13).
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> @@ -342,6 +342,10 @@ all::
> +# Define NO_INSTALL_SYMLINKS_FALLBACK if in conjunction with

s/if in/in/

> +# INSTALL_SYMLINKS if you'd prefer not to have the install procedure
> +# fallack on hardlinking or copying if "ln -s" fails.
> +#

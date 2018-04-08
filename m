Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EB01F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeDHXXW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:23:22 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43894 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeDHXXW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:23:22 -0400
Received: by mail-qt0-f178.google.com with SMTP id s48so7284157qtb.10
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tPQXDIf5SqCnT1jORzmWayasH17Hu/uMG+A8z1ZPURM=;
        b=ukw1R41oNPHEwblMSe80ydizRPpVMH/lvpAKVnv/ekesgfkRikeJWPHLiI1Cua9/XX
         McsYoYyIH/E8LoOLqzR/cpu1bpwbauZsA9cGNnLMcINZwcvj0/ZPsrwF/Cs1hjUeJVVE
         urN5pPD+yAJlsrKrXS4XVMSxLAZjiHkn2eiRtZudAa7uFp9amWCogyNJ99w0SBcP53BG
         kUjwmBBF4PmAwUxniKcZ7/5sahxddNLd6Tgq44zGBYbPF13MlXjQRfve2uMymJ4vBOwj
         imN1eZz8+DWuPSg3I9hQjFRFF4YkpHMe3f0K41TCsBkHqj3twu6XcByaYTObw03cSiDB
         5Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tPQXDIf5SqCnT1jORzmWayasH17Hu/uMG+A8z1ZPURM=;
        b=P86WnVlvwFnf/oCAKbOwIHCQyAnm3D7yOavPriPj42jEW8m6LvKfdLaiGAJh2VwPN3
         T4I6R/vdeGuqFnynhqZFjaTcEmDKTUoX3m8a4RTx0+7Q/eJBb9iBfrSYLw3FEHAjE9iu
         mo58QPSGkwyYE1Z/J7MYrXeNxhUz33vtGDun5RWPBdpzdvBHd0rnm0c5E61HxLftYud/
         jP0/O7laXSYTA1KX+TCAFVL0+g9j/XAgSOpsBsZNeX9FLivHsgd+J8HGf774Gy/UjAl4
         hEPICyqA6CkyrqYefn1E6kWpjqnpOKK3uKRe3sQWtGdcC55aOCpvdzdzNVuZAa1wx4ny
         ubLQ==
X-Gm-Message-State: ALQs6tBf+uyPOgSX2AKkfVd8IzDNIeOZTasJ8UMcqIumrvjsOFhX3JZa
        winaBZL0WnqHcEqrUkdmqNslAtnzy9yDkVhYC20=
X-Google-Smtp-Source: AIpwx4/DMmW7Awvhtl6ltCW5auxQQoDMAnT+ojO+iUqRD3T36+7I13MNByIcXUmdQnZHzPtPd4LZ7CzNsS33oWwiEWM=
X-Received: by 10.200.50.174 with SMTP id z43mr47645664qta.250.1523229801358;
 Sun, 08 Apr 2018 16:23:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 16:23:20 -0700 (PDT)
In-Reply-To: <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com> <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 19:23:20 -0400
X-Google-Sender-Auth: 2SUk1f1ZneDAcfexJhqQprKmiK4
Message-ID: <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Igor Korot <ikorot01@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 8, 2018 at 6:37 PM, Igor Korot <ikorot01@gmail.com> wrote:
> MyMac:git-2.17.0 igorkorot$ make configure
> GIT_VERSION = 2.17.0
>     GEN configure
> /bin/sh: autoconf: command not found
> make: *** [configure] Error 127
>
> Does this mean that something is a miss?

That means that you don't have the Autoconf tools installed, but don't
worry about it since use of the 'configure' script it very optional in
this project. Git tends to build just fine on most platforms without
running 'configure'. You should be able to get by just by typing
"make" in the git directory after downloading the source.

And, as noted earlier, before running "make", you may need to create
config.mak to override some settings documented at the top of Makefile
(in particular, you may want to set NO_GETTEXT if you don't want to
install gettext and don't think you'll need it). As prerequisite,
you'll probably need to install OpenSSL.

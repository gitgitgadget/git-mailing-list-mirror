Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CE320248
	for <e@80x24.org>; Wed, 20 Mar 2019 23:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCTXAZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 19:00:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45386 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTXAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 19:00:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id m16so3419739edd.12
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LnC9IgBpVdZnM2MbGhuPaDSxUYtze0C4J7iDlANrzC0=;
        b=drxVcPPhzOStDlKmMR5qLdRzjZ9p1XV7PfrIGC2QcUqjBqjE/k5BF+OzoePCXkboNA
         cGjAbXvkqINtvcxB7dlSPi0fo7ysBIzPq5wMwNt5fCs1yImbaa2CMsbwh4IzrIfx2kwN
         d0UFNfndSudQjozMwetCw9XxnJ93wsJNV5Nq/VW3uB+JLByftO+HoEiWa+Fac2E5Nk7U
         fIUYiO0X3V76xk6/Jxgs8ZnRKQUuRlhWQyLI4C/EgQO2jsnDuXCU9CqMXi2kUzL8Oh2v
         K5BOw+AbgAEwYrwh7P+WLtjCNk1cWJUzpGNPKZCtV9wtMCTpd+O7J6j/5xCEb45WckjJ
         HWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LnC9IgBpVdZnM2MbGhuPaDSxUYtze0C4J7iDlANrzC0=;
        b=uI4D63yE+aKhxuLsgqiSMNzx/HQfMSTlXwNb2Jmn7qR287XEiTB9DASzFj0MUw9tSE
         MMzmEr2GZguM8au7oyo7gt4SPiEbeeKtGgzogABNx0hKhvWGhr05XQ30r4QAJwKUv+kL
         0QSQQAFJWK5XO3g/+rcGl8EjnCKZKNRdVDL+psN+eMJwuLHnTfnVMFDLRnNbBcbdFzt3
         eYHTAEd+wV9XrTTg+ig6abmoaEXfhKib61vfg2e5rTTW6PPp4lAQ8/6U96i+yId2AlhD
         AZ0gxXar+VxKR24msm7y5vbYYklnWSuBGXYqQ9wBr3JIE3Ryvsp/QsTt7DCzv8kBJoJK
         7IRw==
X-Gm-Message-State: APjAAAXUWcaWhWnr3hWuPfLJ4okhL3IvPk+J6FswfLulKVJ2TluMMhBS
        Eb+cah/vhmF9dZ1/WIvIcNVZ+Exj
X-Google-Smtp-Source: APXvYqzjDdjRymwz9gZBSuBDnpzChyTM8CBtX5BlT1tNHcDPc+agIJgCFdKZIYJzeJytBclYR031fQ==
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr370468ejb.222.1553122822713;
        Wed, 20 Mar 2019 16:00:22 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id i1sm1045382edi.15.2019.03.20.16.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 16:00:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 10/20] diff-parseopt: convert --[no-]abbrev
References: <20190320114703.18659-1-pclouds@gmail.com> <20190320114703.18659-11-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190320114703.18659-11-pclouds@gmail.com>
Date:   Thu, 21 Mar 2019 00:00:21 +0100
Message-ID: <87zhppcfsq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 20 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> [...]And the '40' change is self explanatory.

Let me make an attempt at being dense anyway...

> -		else if (v > 40)
> -			v =3D 40;
> +		else if (v > the_hash_algo->hexsz)
> +			v =3D the_hash_algo->hexsz;
>  	}

This is obviously not a regression, it's a hardcoded 40 *now*. So we
should take this patch.

But in general, I wonder how this is going to work once we get a few
steps further into the SHA-256 migration. I.e. here we're still parsing
the command-line, and the_hash_algo might be initialized early to SHA-1.

So if I set --abbrev=3D45 it'll be trimmed to --abbrev=3D40 by this code.

But then shortly afterwards we pass my SHA-256 object down to some
machinery, and will then want to abbreviate it.

Isn't that part of the code something we're going to want to support
looking up objects in either hash, even if we initially started out with
SHA-1 in the_hash_algo? So we'll be over-abbreviating a SHA-256 object.

Leaving aside the sillyness of wanting to abbreviate *anything* to 45
characters, I wonder how those sorts of chicken & egg hash scenarios
will go involving the_hash_algo.

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
	by dcvr.yhbt.net (Postfix) with ESMTP id B4DF21F462
	for <e@80x24.org>; Mon, 29 Jul 2019 11:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbfG2Ld6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 07:33:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42999 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387483AbfG2Ld6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 07:33:58 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so88739741iob.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VUDWWJfU2fg403dYIOBC4QRWqDt6Sj6IO3L5V3AqtZs=;
        b=gclI3yC1IyqYfeiwAOS8wnM4R25HREAx/PsCjwEE7KKHhztakV0Vbtyiu+6E1BZFvL
         ET5qrsh76rp3hXq9vKZ1Knd2b2KOcYJ6pjlZRHs1Vjr/OC1wVTgTJNaT5lcOm7mWCHf1
         MFR9flm1gTogE0lzfGzK7MUPTlcjnHSkj+UDnXVuWa/KnDQWmCBZPyqkRMYEY7euGYZX
         LE/ylVBOb1iAQu+K1xnab9gTU35i1RS+lHahzVc2lHd9nkKwxdRbobFQ7ocp0zXODbdh
         oU+gpz6lSPThqNKus+LmdkWAYezGYkJOeTkoHT7hVHGZyytyGQIgQjqG2M2wwgMgBeYr
         32bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VUDWWJfU2fg403dYIOBC4QRWqDt6Sj6IO3L5V3AqtZs=;
        b=XfXfE+kjAgm2Qad7mWGehGYtdMnQKt9obNg6pauSX6cUV3AOopsxyF+87BDn+dxd2o
         CAOnWYhn5yZasr2/D4MJbu9Eft7LYLcrpBvnu8aTkkDqu9Pc6CNcYaRHKNgLwfCMGzCO
         XhVYvxVBkfLTpD48n34yCYMWbQ12Depnc8yNHyXfq6ufQn6vRFT3iFfZ2NBz23fKv93+
         yWjKlqXWCT+GkZMpIbPgaOBRia0iJG/j+cRIq1hQkd98qlkmM/By19v2UrzXqdiQFzY1
         oULWClh/GNH6aRh2OV5TboXWniBG2pgvv9mjbi0W8sLnP8sGGLcXByjYzTW6rXmhLzn/
         dQ5A==
X-Gm-Message-State: APjAAAVqGhVMWif/kXjnOHt7vvf2yf/yPOI3KolSCjkkbFchYo/fBHUm
        MYapf6ftcMCNYcMjnd+/pJvn2x+ds9A20qVkUWEh/em0dmE=
X-Google-Smtp-Source: APXvYqxWRswpp3YaLDsKAt9AHd/32zNLe0j/4ye1di1aXuwAwkusFoslEZF3WOle7iWL9VFwR+Gmn5a40w3b2LkjFdU=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr56060455ioa.161.1564400037264;
 Mon, 29 Jul 2019 04:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235427.41425-1-carenas@gmail.com> <20190729105955.44390-1-carenas@gmail.com>
In-Reply-To: <20190729105955.44390-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 29 Jul 2019 04:33:45 -0700
Message-ID: <CAPUEspi7jvGEx_3CMPpYp7_gip0Mv=+MZdfWYoj+NJmomXJTHw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sandals@crustytoothpaste.net, gitster@pobox.com,
        dev+git@drbeat.li, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Known Issues:
* PCRE1 is broken, but fixing it would make more sense on top of the
topic[1] (not in pu)
* it depends on the current ab/pcre-jit-fixes that is missing 1
critical commit in pu
* no tests yet; would need to extend it on top of the debug from Beat
and test-tool changes from =C3=86var, neither of which are final
* need to build on top of pu and will need further changes to be ready
for next/master/maint

The code has been tested in OpenBSD with PCRE2 (latest from svn, but
any version should work if they are JIT enabled), it is
expected to also work in NetBSD (even with PAX enabled kernels) and
macOS 10.13.6 but haven't yet tested them.  HardenedBSD
will likely segfault unless pcre.jit=3D0 as described in the original repor=
t[2]

Testing with SElinux and PAX enabled for Linux encouraged

Carlo

[1] https://public-inbox.org/git/20190726202642.7986-1-carenas@gmail.com/
[2] https://public-inbox.org/git/20181209230024.43444-1-carenas@gmail.com/

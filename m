Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20251F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeA3VVj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:21:39 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55388 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeA3VVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:21:38 -0500
Received: by mail-wm0-f47.google.com with SMTP id 143so3979004wma.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xMlh+7452YJvbf2Q3D8pIoRnvYsh3tCMIqz7mzvL28=;
        b=Igu5RjPzrR/n3jK4/KJ78LGryVZ4J1EtbQAexLeec7idqQfmpSfbKdIGtPSobUX5u7
         8ZzxufygOtmoeXjMTbfdfvOtaRcb7TGr0HRFNM5Lh9sxcmvyLbyOe3LkFJVJ512ZEQAo
         nT2O4+nQlFBQCK7SWz+CKePKwMlqFmssgknkxY91YU3d4OILQRnPxMl93jzUVmolmhUz
         aDFMBVY11i7/Dy/AMPX8h7+ODzzuu5QFmF8ppQRKBEWlVJoLzOyNfLirPb2l5w1crYzr
         ryNwfsriwSJGHiFqvyQ6cRJnN3nhRjEnceyN1CVCb09nRFUOhpnRLTRwE2Vsmqsma4pf
         q8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xMlh+7452YJvbf2Q3D8pIoRnvYsh3tCMIqz7mzvL28=;
        b=pE+5GTpTF8mKEaJDVupsUcsF69lVb7im0r8hiYqTS6kAp4Q8BO+Zwf7lEjXGuIo7YB
         CokgjgyEbAEdMK49tr0a/Itj/XaPUmxD+13tg/CCLLQivF162bMNXaIjr91uDXQmqf/0
         AnvPHpl5nweQ+G1ksJzI0NwvY32rH3aCcCz9Y5x4W/7ALtN1ZsE50HomO/IlvOtDWqnv
         itVU7ERZUTC9Jibf0r/tmVXKtmOSG3f3H9IkmwSUx0SpXm26ToHMwsQR0+VmUBuDnqn5
         o09wGDLGgqf9dI+VdgXo7sCNsUre9Rxtkwx5y2qvFJuMu6GpY+vwH1jlFi0wN0w2CREK
         K4zQ==
X-Gm-Message-State: AKwxytfSrZ33hbO0IvEfE6mPyYsaKmv7rskAv+X4WU+kuUOhT+/KlDho
        JLI3HNaAdPrdOhGluFlC1qOICJym
X-Google-Smtp-Source: AH8x2247hB3E2+r0AcElt6o31Jjv5bdkHeY8BDHo8UDyI2Mp4dJknKodbvYAvXE0HhGFfFZBg+TNDg==
X-Received: by 10.80.181.93 with SMTP id z29mr38862091edd.223.1517347296799;
        Tue, 30 Jan 2018 13:21:36 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:21:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Kyle J . McKay" <mackyle@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/10] increase wildmatch test coverage
Date:   Tue, 30 Jan 2018 21:21:14 +0000
Message-Id: <20180130212124.2099-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180104192657.28019-1-avarab@gmail.com>
References: <20180104192657.28019-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 has been a long time coming (20 days since I said I'd re-roll
this), but hopefully this is a version that works well for everyone,
including Windows users. Changes:

Ævar Arnfjörð Bjarmason (10):
  wildmatch test: indent with tabs, not spaces
  wildmatch test: use more standard shell style
  wildmatch test: don't try to vertically align our output
  wildmatch test: use a paranoia pattern from nul_match()
  wildmatch test: remove dead fnmatch() test code

No changes.

  wildmatch test: use test_must_fail, not ! for test-wildmatch

NEW: Fix a tiny nit I spotted while re-rolling.

  wildmatch test: perform all tests under all wildmatch() modes

The testing of various wildmatch modes got factored into a
function. It makes no difference to this patch, but makes a huge
difference in readability to the follow-up patch.

Also I stopped renaming "match" to "wildtest", I can't remeber why I
did that in the first place, but no point in doing that, and this
makes things easier to review...

  wildmatch test: create & test files on disk in addition to in-memory

Almost entirely based on feedback from Johannes:

a) This is now much more friendly under -x, as little test code as
possible outside actual tests.

b) Factored out into functions

c) Gave variables better names

d) Hopefully runs under Windows now without errors, due to a blacklist
of filenames that aren't allowed on Windows. Commit message now
mentions this.

e) This should be a lot faster than before, since I factored out the
setup work being done for every test so it's only done

f) At this point I can't remember who/where this was pointed out, but
it was observed that I was using a very dangerous looking `rm -rf --
*` pattern in the old test, turns out this could be replaced with a
less scary `git clean -df`.

  test-lib: add an EXPENSIVE_ON_WINDOWS prerequisite
  wildmatch test: mark test as EXPENSIVE_ON_WINDOWS

Follow-up my 87mv1raz9p.fsf@evledraar.gmail.com from the v4 thread,
and create an EXPENSIVE_ON_WINDOWS prerequisite, which is then used
for the file tests so they're skipped on Windows by default.

Even though 8/10 should be faster now, and hopefully passes on
Windows, I still expect it to be quite slow on Windows, so let's not
run it there by default unless under GIT_TEST_LONG=1.

 t/helper/test-wildmatch.c |   2 +
 t/t3070-wildmatch.sh      | 655 +++++++++++++++++++++++++++++-----------------
 t/test-lib.sh             |   4 +
 3 files changed, 416 insertions(+), 245 deletions(-)

-- 
2.15.1.424.g9478a66081


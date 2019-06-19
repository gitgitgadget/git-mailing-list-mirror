Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9D61F462
	for <e@80x24.org>; Wed, 19 Jun 2019 23:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfFSXbF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 19:31:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33749 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfFSXbD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 19:31:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so1044584wru.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 16:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9nThxCo3McNUGv5wCiOL0FXmnYg5Zi4/7K4VsJ4UGw=;
        b=rj0zoQYMqCGHkPU6/MCQpE3olwP5Kr+fMUnqGX6SK8dsp6RFL6rd2k1A00k7GkK2PY
         u07f4zVyq5TY50AT2R9okza27V0ExRqPLBLusy04rfG7z/DaoRWztC46/MXeNa0x5bs/
         K21BJowbMNjF1EAuBjKk2yOMiIe7pMGqFJNTQ84t0bdDvO+2PYBZ17aYCRWta2HIY1AN
         kQhDojWlX2/Hgk1QF7hOCnw2qGeEM+5CG/D6w0jcHyMKO4ZNPtNxJdn+NyJo+BwPV2ZC
         1wYiybUe14UNzDpW4bAEoI6i+ZNfuViKdL6a3YR/XpanC9EcjBtG50M7jp/ftrzEa9Zi
         0ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9nThxCo3McNUGv5wCiOL0FXmnYg5Zi4/7K4VsJ4UGw=;
        b=uF07KCsAfL/S4eS5YZAwhQX64NCeEsRSuC2b+TsP4xTs7YR3hRCah33ls8DhqOFh7O
         /v5uuhYeyWse9WphVysrHskCs/3Scl+lCWeKgiEluQtSzC13AeFp5IZGI0H3d2ZwdvIW
         lPuP+cv8Pnw7tquRLKPoXvZgiFNbxufgRj/IIc6HSSIcYAOcwonUgpzqGZtC3Acv7ndh
         C9QFgMZIevUBIAv0TQrVh4RDUjol+10oSwxgB6HOlHGYdG61vmLgLvwnRT/BDkjdSUgo
         YfrfZ6hz+1tF1F9wWlt6JModT3wAisBTnkOZTlitaQw2TBYuhIb+e9hwuHjOdnH60/ic
         BJBg==
X-Gm-Message-State: APjAAAWK3qEr15RrObKk/6/xAud0a/Z6LIIMvyhgQwrS3bFjyN9x5Ox0
        nuRTHiiVBHBKK7z3C0WuE1cUjxjwBUI=
X-Google-Smtp-Source: APXvYqxqKmzyUZjum/h188AanxRZwwxKgcYVqURc/9yUOZCDemVRozgtCVhwSuZyXfiV2czxu59Ukw==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr36526000wre.248.1560987060779;
        Wed, 19 Jun 2019 16:31:00 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6sm17964958wrx.85.2019.06.19.16.30.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 16:30:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] tests README: re-flow a previously changed paragraph
Date:   Thu, 20 Jun 2019 01:30:44 +0200
Message-Id: <20190619233046.27503-5-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244
In-Reply-To: <87imt18a2r.fsf@evledraar.gmail.com>
References: <87imt18a2r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous change to the "GIT_TEST_GETTEXT_POISON" variable left this
paragraph needing to be re-flowed. Let's do that in this separate
change to make it easy to see that there's no change here when viewed
with "--word-diff".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 9a131f472e..072c9854d1 100644
--- a/t/README
+++ b/t/README
@@ -344,10 +344,10 @@ refactor to deal with it. The "SYMLINKS" prerequisite is currently
 excluded as so much relies on it, but this might change in the future.
 
 GIT_TEST_GETTEXT_POISON=<boolean> turns all strings marked for
-translation into gibberish if true. Used for
-spotting those tests that need to be marked with a C_LOCALE_OUTPUT
-prerequisite when adding more strings for translation. See "Testing
-marked strings" in po/README for details.
+translation into gibberish if true. Used for spotting those tests that
+need to be marked with a C_LOCALE_OUTPUT prerequisite when adding more
+strings for translation. See "Testing marked strings" in po/README for
+details.
 
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
-- 
2.22.0.rc1.257.g3120a18244


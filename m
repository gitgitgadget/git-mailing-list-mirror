Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788C21F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeAVNcr (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:32:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45893 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeAVNco (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:32:44 -0500
Received: by mail-wr0-f196.google.com with SMTP id 16so8664524wry.12
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0qwkUrfFGDE4WG3xBjcmLpDrr79P3AyPe4VM3r3ads=;
        b=LPpTNx1uEzE6zt3+Z0PMtSpZKsh9ITAQV5J9Bpk6hj4p+yDZU0Y7IhNKYjUoziQUUb
         Ipkw0/oPZEbiTDxQkfvxkbjzakvHtOfmHbbRx5+2enlsWQiaWLCs3+vAqdayHQeyK8J7
         ds63FPc6sNjMnuhp/VpmtgdSjXz6bdqTM5IKLFPPoPlk5cvQafECfxmO6toCXOxpqIwM
         fDiCoMZSFizmPZTjGxLonxs9Tmr+AKaPBTdNDbHFQkj0+Xh/i6xkiircdqSEJFwwe5Fq
         /gc00jUOCSogYbhCZ1/+zx5Zsdc3eGUK2linA45cRDJJ7Pa3V8+W6WoB0rZ88aIZ9NkB
         vtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0qwkUrfFGDE4WG3xBjcmLpDrr79P3AyPe4VM3r3ads=;
        b=Y6nHp6WC0NENp+2ED04X63OmEejTYREF1MfaGorC9TwT5/6+XiiM9Cw9N2DLItjKI0
         WKZo2UlHyXypQzPWxdX65noJRVChH2LloXC0B5pH6DjzWQ6ZyMCvwux48of2miqcUV5V
         bgg8fyuA4fBzIVWKgGt9Oj9CS+XaDb5NWRfUGxnxpf286gVYaYjvd1Oq+4H85et+ipV4
         4Rr2ilukWnQcE/gdsOH1lpijbGrasiJhvXlQllnaU3CVfGMw2UJHE0t997hFkOb6ChLn
         t3qNh2Xt4eqy62ku5psvcPo+K73BCIvXFhI0fwVLX8Mlx9iP+iIOWo60giU5jnnmxDWQ
         oFlQ==
X-Gm-Message-State: AKwxytfB7UpwNKNTVKKG0A8WBHaHh8Ve79sxvH17HFMOd6n9B65V7uyi
        exvncaIxxVvhBfYA49Kl40o=
X-Google-Smtp-Source: AH8x227ZTmcZ6pRHMq66TMcYLOwLq5wXz63x0lI6LAl2zIQJV+digcIbspwq4YY/eOZHuOyoEzdYAg==
X-Received: by 10.223.139.156 with SMTP id o28mr6977795wra.165.1516627963198;
        Mon, 22 Jan 2018 05:32:43 -0800 (PST)
Received: from localhost.localdomain (x590e64ec.dyn.telefonica.de. [89.14.100.236])
        by smtp.gmail.com with ESMTPSA id c54sm24284520wrg.68.2018.01.22.05.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 05:32:42 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] travis-ci: use 'set -e' in the 32 bit Linux build job
Date:   Mon, 22 Jan 2018 14:32:17 +0100
Message-Id: <20180122133220.18587-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.80.gc0eec9753d
In-Reply-To: <20180122133220.18587-1-szeder.dev@gmail.com>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All 'ci/*' scripts use 'set -e' to break the build job if a command
fails, except 'ci/run-linux32-build.sh' which relies on the && chain
to do the same.  This inconsistency among the 'ci/*' scripts is asking
for trouble: I forgot about the && chain more than once while working
on this patch series.

Enable 'set -e' for the whole script and for the commands executed
under 'su' as well.

While touching every line in the 'su' command block anyway, change
their indentation to use a tab instead of spaces.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 5a36a8d7c0..248183982b 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -6,29 +6,29 @@
 #   run-linux32-build.sh [host-user-id]
 #
 
-set -x
+set -ex
 
 # Update packages to the latest available versions
 linux32 --32bit i386 sh -c '
     apt update >/dev/null &&
     apt install -y build-essential libcurl4-openssl-dev libssl-dev \
 	libexpat-dev gettext python >/dev/null
-' &&
+'
 
 # If this script runs inside a docker container, then all commands are
 # usually executed as root. Consequently, the host user might not be
 # able to access the test output files.
 # If a host user id is given, then create a user "ci" with the host user
 # id to make everything accessible to the host user.
-HOST_UID=$1 &&
-CI_USER=$USER &&
-test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
+HOST_UID=$1
+CI_USER=$USER
+test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
 
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
-    set -x &&
-    cd /usr/src/git &&
-    ln -s /tmp/travis-cache/.prove t/.prove &&
-    make --jobs=2 &&
-    make --quiet test
+	set -ex
+	cd /usr/src/git
+	ln -s /tmp/travis-cache/.prove t/.prove
+	make --jobs=2
+	make --quiet test
 '
-- 
2.16.1.80.gc0eec9753d


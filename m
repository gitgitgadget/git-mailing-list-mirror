Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081C71F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbeAUADr (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35014 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756790AbeAUADm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so10209817wme.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v8tZwqfLDBJaHFe9UQiLA0uAJdZ851RNG+2Elct2GBc=;
        b=FDMxRVDASw2tW4FcrIPGCjX18n6mzgAfJu1jcCkl5DN+L/mTwlBQHgJMO0DkSTupD0
         /rVpn76p87xejzgk4dfP/BbdSOtGhOt1aLsDXZ2lDL4abtH0JrrHDYsz7qIfK5TAJ1L1
         1w8QNpYCHaM8WKuuov0fPL/jll1uWakRjMFTCLfBD5qSjlfhNPzlY1LaNQb4xOhQUMCt
         4/fgb/vnpK+YHVWLLLDLcQUO7Jr26VYBvOijFeC2PS+w1McQEXR1oUyrcgYCgNQDU8rE
         te132nInK5yhRUMvyIc2jQgP45VU3hz6CY+3D8tvdnpFUjhDL3KloMgjjEPzxAzUEmhH
         dOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v8tZwqfLDBJaHFe9UQiLA0uAJdZ851RNG+2Elct2GBc=;
        b=t5SCMV7BgoSN+4pF0Qn7mvHn9XFrmDt8fhJZB6BVlFT8TjuUKOW4I5bsvOxP3Z2OI6
         BQY8a4BgpXqneL7PZSIbO8yEQGI4aWaQjs8S07sZhYGVgd3I5UmrGTCQt4/dAbBEpulJ
         9uZHzokhRRvqDgFgO3K3iUb+R2DUcYlZ1eFlvr2NcLJUc0Fle/8bj1hdr+OeaBWVOQKn
         +XFC0Ohr6dOeqE3Je98VaOWXdCbrbt+iME8b0t/tYxvIGXXgD1tO+PbPM8u9IviLEp0L
         LEVNtcRV0rdOFYmthaJPOUem2tr8e/CWG2EfTGsIhEpuPHVZoNH4ELsTDnqoOwOUlKXB
         s17Q==
X-Gm-Message-State: AKwxytc/0o6av2fawTKOckt5XV587l6SdYyEK0loWcF7rc9m5jh632/s
        qokop393GkNuwdopKPiCasjdmeiy
X-Google-Smtp-Source: AH8x227vMARbSPgbyGvmiV8tdBdxaItuU8F1qBMIGnpbj0rCDEEKAGNWi37g3lGjoQciz02Vq4gsiQ==
X-Received: by 10.28.55.81 with SMTP id e78mr2031995wma.50.1516493020474;
        Sat, 20 Jan 2018 16:03:40 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/12] git remote doc: correct dangerous lies about what prune does
Date:   Sun, 21 Jan 2018 00:02:59 +0000
Message-Id: <20180121000304.32323-8-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git remote prune <name>" command uses the same machinery as "git
fetch <name> --prune", and shares all the same caveats, but its
documentation has suggested that it'll just "delete stale
remote-tracking branches under <name>".

This isn't true, and hasn't been true since at least v1.8.5.6 (the
oldest version I could be bothered to test).

E.g. if "+refs/tags/*:refs/tags/*" is explicitly set in the refspec of
the remote it'll delete all local tags <name> doesn't know about.

Instead, briefly give the reader just enough of a hint that this
option might constitute a shotgun aimed at their foot, and point them
to the new PRUNING section in the git-fetch documentation which
explains all the nuances of what this facility does.

See "[BUG] git remote prune removes local tags, depending on fetch
config" (CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com)
by Michael Giuffrida for the initial report.

Reported-by: Michael Giuffrida <michaelpg@chromium.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-remote.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 577b969c1b..7183a72a23 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -172,10 +172,14 @@ With `-n` option, the remote heads are not queried first with
 
 'prune'::
 
-Deletes all stale remote-tracking branches under <name>.
-These stale branches have already been removed from the remote repository
-referenced by <name>, but are still locally available in
-"remotes/<name>".
+Deletes stale references associated with <name>. By default stale
+remote-tracking branches under <name>, but depending on global
+configuration and the configuration of the remote we might even prune
+local tags. Equivalent to `git fetch <name> --prune`, except that no
+new references will be fetched.
++
+See the PRUNING section of linkgit:git-fetch[1] for what it'll prune
+depending on various configuration.
 +
 With `--dry-run` option, report what branches will be pruned, but do not
 actually prune them.
@@ -189,7 +193,7 @@ remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true will
 be updated.  (See linkgit:git-config[1]).
 +
-With `--prune` option, prune all the remotes that are updated.
+With `--prune` option, run pruning against all the remotes that are updated.
 
 
 DISCUSSION
-- 
2.15.1.424.g9478a66081


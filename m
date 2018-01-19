Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1551FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeASABP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43769 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932784AbeASABF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so226934wmg.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v8tZwqfLDBJaHFe9UQiLA0uAJdZ851RNG+2Elct2GBc=;
        b=f4BhvUdBzmqB06Uwz3UGSSLGeepSeQQiVKl565U3znZpPOBNB00u6lkiMNsg6GB7qw
         1ufOyRTlQu1DSIcv+26mx1qGU1ga2dX70yoL1QbidBCVB6jx/pgnt8qC9O5b79fQw7Bd
         TL/kkd9pPym5xd4M5/+2+gfmh1amO22CE7/QFw6Qcyg9JOnX9MIlQgfmauf9sT7+qnEf
         Qr8/s+8065mY5BapmtH1gGl38WlK/z9UI09ZqVwE1pmy3yND9zGeJYUo5t1T+U9aJCWQ
         pmiOLXYIMNIk94kmkm7y92GyQqFigT/a2J+nvUqZ1ORnE6ARg2pgZ6TrnNWV+Wkv5O3C
         RZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v8tZwqfLDBJaHFe9UQiLA0uAJdZ851RNG+2Elct2GBc=;
        b=YzsiRbNi79jEE05ihY8QSvUxrGnHPBgIz5fZLswWc5KMCUNURY/GBm1cTPB2DU4LNr
         gLty/ObvY6BZg0tp/XWub1xebydFC3oJuorzWEeYQILtoKH/wkQctQIgcCX5YNzvy/fb
         JmMOh/zgw/jY/NO8Eetkcjq+EcLJwhvzx9C1jj8PfkJQb/LEPK4eYhSFFTqiBGsvN6Fh
         +Hdp+8hIiE1Y/BmD1ewbwEk5P6eaEPDO1VIu4s/rGQ+TCepe8bOmbKtX/ZKRLH7ws1sT
         hwylYDp9nl4PPcL+bkM69qqAIrXzkRHb2KzDZ+yUzupPad4LdAKQhtIOttMHoIGTaxh7
         e3GQ==
X-Gm-Message-State: AKwxytfBx9eZLzFjpZpgG+01vSsoUpmLs7xK1yc4AEUpCr3Bn0RKMLoh
        y+LsLG0K2PsxswlqahNOuMLtsqyj
X-Google-Smtp-Source: AH8x2246llK52Fnxe8O3Rzha2rpQ79jvpCKQ52fVv+XbcI7z7ttb808p6VbInNjqGW4Rb24rWz4Qzg==
X-Received: by 10.28.52.134 with SMTP id b128mr98184wma.66.1516320063398;
        Thu, 18 Jan 2018 16:01:03 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:01:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/11] git remote doc: correct dangerous lies about what prune does
Date:   Fri, 19 Jan 2018 00:00:23 +0000
Message-Id: <20180119000027.28898-8-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
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


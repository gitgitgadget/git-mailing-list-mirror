Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD6F1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBHQUb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33864 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbeBHQUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id j21so126296wmh.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UXrWZrP4BK4Rwc0MQ+8Q0ay2veiuAoKWzdFOErde31k=;
        b=ukmbixaAXNb6Wqm/mRpYrXLOn0WfDP8g5P84UluRgvNhf5DPdqv+03t9fAiV0/gPW8
         pJtHcuBry7SRiioBgcq4cyX0OZweWIU5ih4JLGgUSbjA0d+1dljq0L1bWU1KLlCot9KP
         fqNDwtZpg0BlO1X5HYnLSMAKLmjOAMSXaGZxghrdgNKS3aHw74/x1wI/q7UhWI+11edv
         86KbAynEkyE+LR+26mjGmH/Bb+E4SPea77Lx+jVDBuSdq1bk7zYrtjT6KUgfUAQ1gZ/M
         9WI4ULN8DuP679njyI+OhmiZPbPE9Z1mCbyqv1jT2ErAqcB7llUp897pHWnBh3CT9dDN
         bZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UXrWZrP4BK4Rwc0MQ+8Q0ay2veiuAoKWzdFOErde31k=;
        b=IVLXGqH23qlljNxcaa4xmkKfmJ5/uE4ftkvIjLt2ElR/x2zlNzvq55LSa3EUZKGJvr
         fd/33n7NV74mO2VPCHyAazbTZqKKPvtqGKb5bK1BUxwHq0Vgj73N1FYLANqK3Gm0gMkO
         a8STSCArWrI18nUJTDwyVS3FVLmNo8+2PSvRTzPYfI7xXeNfDpHWF80lf2NDAnZW9oCm
         2YqvruIVwlHdBNpdUhY3+ZayTdgzzHtlZrTfswqLNE7/9nXsy1jFmsYe1hz6OnCeig8w
         lNnwmKnGMM8A6vq3gS0QptMyf66QeKpRlY37U4/QSGDJyMO6Mq89ZHPdTjjjChvM1/+t
         kasA==
X-Gm-Message-State: APf1xPCnPY9TIhg+VqQfwOSkgnubqhiuJQUJGRsZjuzcCeuDTpQGg4ed
        cnX2IIjXvmOOMfB756AIrFL8M/uf
X-Google-Smtp-Source: AH8x2265Zm4ebj84KlTiEkaF8AkxOEqwRNmupqZQwr3Uq7m8ujTnpRbxw+Pgxm8kdFc9rGpHgDyY0A==
X-Received: by 10.28.208.76 with SMTP id h73mr1575273wmg.35.1518106823898;
        Thu, 08 Feb 2018 08:20:23 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/17] git remote doc: correct dangerous lies about what prune does
Date:   Thu,  8 Feb 2018 16:19:32 +0000
Message-Id: <20180208161936.8196-14-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
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

E.g. if "refs/tags/*:refs/tags/*" is explicitly set in the refspec of
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
index 577b969c1b..04e2410aec 100644
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
+local tags that haven't been pushed there. Equivalent to `git fetch
+--prune <name>`, except that no new references will be fetched.
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


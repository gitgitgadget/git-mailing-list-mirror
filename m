Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63561F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeAWWOQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:16 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44425 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeAWWOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:14:03 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so4775367wme.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=chO490/Q4yBgb1HtYDuyjP/qm2xzvCq0K1JUHlZamRs=;
        b=vN9uBgSs36MLix0jC1Q8R8BtnOmU/FOkvKf6slJhJKk3FT8H4QVj1JQowCgxUDULkb
         gzl5wV/kMvfX+nCnPOLNBFBv5FlKsi+M7guV8QyGB20apHlGmwgj2IG2S2ApWri3skQH
         3/DT4+cQ5tb0UlyYwe1K3oTGTII9nKXZY5+uUHfCzSpHWZxcrEe8qZUcPiGyGdet1tft
         ygpmMpqLA7LjTxyDqqbT76u9DMpv345UFdZqz7UmP+bNpD1lGeP3MnNfqWnMSBgacoY/
         oB4VHpeh/2f9Xng2FqNOALVhJwFmgAsqEPuMadWAHb63JJxgh4XA8v7YgFOQVVdVDJGU
         UQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=chO490/Q4yBgb1HtYDuyjP/qm2xzvCq0K1JUHlZamRs=;
        b=eypnU1I+/NE37ruyLerjzGAArDRz8k4Q8hHEl3zvxcrLz86xvalRbur/h2g9Wseu7c
         RCzO6ZKMmZqstDat1IKgnH2ZnTtXjCvc58ZibGzAKlw6crTYl6aptoByFk02DjdoktkJ
         dja4siJga8sUr1Oc+0UA5q+1awfuyzINVCXUqjQ7PN+b4RMVE62lSFZSRZ0/9DBWrIL0
         18bTyQIFxCM+YxrcBkmnuLLzhq4TICVOQgkhYgYx0WPQYttgq905kUXe9r7Q4IskWd44
         yiUv+m8ILRXRtDnBWvTBOJeLWL+XI+pLe1nbT6kNxDkY79JSTit5I6mAcJf/oqGe1Bb4
         KQeg==
X-Gm-Message-State: AKwxytepBlzx0JpQ2xBhbDrq6D19yMhLNsZIsEY12YLW43y7oCWdLdAb
        fK+tSXsPEXqgCO3kWOTwB31ELjGd
X-Google-Smtp-Source: AH8x224/zsxkUBWEOFcO6pEaJLB2uMScynEZlGATWNUC7G8U0ejzymSJgCOJ2PFtNlc/pOFptmGNJg==
X-Received: by 10.80.219.75 with SMTP id b11mr22169462edl.220.1516745641341;
        Tue, 23 Jan 2018 14:14:01 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:14:00 -0800 (PST)
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
Subject: [PATCH v3 08/11] git remote doc: correct dangerous lies about what prune does
Date:   Tue, 23 Jan 2018 22:13:23 +0000
Message-Id: <20180123221326.28495-9-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
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


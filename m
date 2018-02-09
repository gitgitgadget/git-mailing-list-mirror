Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE69D1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbeBIUdC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:33:02 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35696 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeBIUdA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:33:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so18538642wme.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jMHBJVOiSIYX/w5UN/RHAWfLS2tivMrZDP69dXyCvio=;
        b=nw+3aB9OAFI0LqFFJqkYhoowGEUzibEpQVPx/rQRPxw0rmX/xS6Bbghdv4wUsNYpPa
         f7Qylg1Ud80ZeOdeDorJROLHlvq1fNy5qgsIYPB9LZ3OjpMUS+pS0Zown/X49wM2b2ta
         JrH1PdcvoNP+Inq9lnNWAPfBvesxpIeZ4zU/vy0nfXdCOe4Zu0+fr/3Y7qHfnjq3dBk3
         ISYUFgcBCavP+VyVUeugLTm7MNwdYNBiTWn9je0hh4pG6A3DzR7GUKcc9ghebjUhp1KF
         82Wzrp4opF1zNGyQqvW+d6x1qEOIyppwHNfBBpbuGPjf6w3LUIpPKldvUca0PhIsy7Mb
         eTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jMHBJVOiSIYX/w5UN/RHAWfLS2tivMrZDP69dXyCvio=;
        b=LWaY09mgaiDWwIRrbNuQyAXStmQx+m3HrBVT76ulaHVVcClyKpMsGdGwAPLkvFSe91
         xruMpN6V0XBKw8Wl2gYoo20kz73u3gS0tNFBG//6LEEiAjEnxYm1/uyCYfR9z2IMWdjw
         VaGyYpt8jhsTCxozXix9JXaXmXWFXM+4TQHsL0fAmcORTObqhjjWf+rutJ5lCvDRRTbR
         jyFBf6vIbjsTPp+mqDAhbC7fMSzL4QnsESYeWmkFQwneVBMrNbW3ZCKPlmx+V0A73cBN
         cmSmHAvpWM2HS5/FUS9N7Vof5v/Q62lXwj1RveJj1y/VipYEiFNTq75Y3pUzCDxQYFJ8
         xudw==
X-Gm-Message-State: APf1xPDxntBJgBO3+6OV3wlUJ/5+nZaTc04I0mqbZ1ll/Vu/Vc543cO0
        xFK0NAMyEDZdB0TdcqYxmo2dszbM
X-Google-Smtp-Source: AH8x224fh6skL/ZrfsXhBXrGA5IL3DrHyQMcWzaifNBbxjqEDfjgp7ebEn3/9i7z8xoHyf5aEWpYbw==
X-Received: by 10.28.145.21 with SMTP id t21mr3491483wmd.136.1518208378540;
        Fri, 09 Feb 2018 12:32:58 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:57 -0800 (PST)
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
Subject: [PATCH v5 13/17] git remote doc: correct dangerous lies about what prune does
Date:   Fri,  9 Feb 2018 20:32:12 +0000
Message-Id: <20180209203216.11560-14-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
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

E.g. if "refs/tags/*:refs/tags/*" is explicitly set in the refspec of
the remote, it'll delete all local tags <name> doesn't know about.

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
index 577b969c1b..4feddc0293 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -172,10 +172,14 @@ With `-n` option, the remote heads are not queried first with
 
 'prune'::
 
-Deletes all stale remote-tracking branches under <name>.
-These stale branches have already been removed from the remote repository
-referenced by <name>, but are still locally available in
-"remotes/<name>".
+Deletes stale references associated with <name>. By default, stale
+remote-tracking branches under <name> are deleted, but depending on
+global configuration and the configuration of the remote we might even
+prune local tags that haven't been pushed there. Equivalent to `git
+fetch --prune <name>`, except that no new references will be fetched.
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


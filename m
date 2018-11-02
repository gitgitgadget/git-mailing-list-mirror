Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14B91F453
	for <e@80x24.org>; Fri,  2 Nov 2018 22:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKCHq7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 03:46:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45567 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeKCHq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 03:46:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so469621wre.12
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7ImqB4p4fpZ4QP/K9tBOzZnMKkxYzIoBIlJ7Qr34dk=;
        b=oSiYc9QUtzdEKw9NrF7bRuTscyukxQlPNqRB2iSjv/5rvJne5l3n9F0OlpOeQ3XhB9
         Iazr3vHtqNU1gLVHSHjSeLxuskPQqvvabMfIs5ZOMJj9GenTK12tM4H5baq4l+KzY5LV
         GpeWILEs8mshiNFL9/bf7IwqI+SoHN/sZ3IYKSF6jZ4nyOFFxIYvZNurPri85bZi6if8
         UhtxB3N8muj7uWrfJrA9XOEAdQ/M9VgxlGKF5aYhdoqdGKa//pDQBJ4D/vmGMfDpH5b0
         z5bQyfxL5jCZNkP/BgpxqpQa9flVYHJUt33Dz0MjqiddQd+chmrabKhsS7lqLtVurXOF
         RaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7ImqB4p4fpZ4QP/K9tBOzZnMKkxYzIoBIlJ7Qr34dk=;
        b=aRhXECTbg41jGtkouTBLoVLInQgXUzsdfHztL69tp3P4mI/Wa9vQLdGcWcTolQzH2K
         xF97OgFBa1xCUs8+zEpvU7lPIMpRWfja//1u0TzXT/VMxRbbpwEHD8StF9sYQgYp332b
         KcIf36K+ClBmREHcGGogqPnsXXPPuypVYQqWBrqAgcFsrAYCszwCTj3NBZnrqpu/JG4E
         WFfqywKHQXlHuGAei/QrbBjldwfcEeb/4SULsakuoRePgdCyUpGaCuxUhzeZMwIMPp99
         q0Kth24gLjq6uAUmzaMWIsN1nvW71cYzXIZ4gm0qZBjdCiGIpJkweldXVBgWpNhkfhJG
         SeJw==
X-Gm-Message-State: AGRZ1gIliG9M3vm2eTpkSiDfonxING2KXGksLNvLX1gF0J/tF+d7g9dK
        tGkFZSrGtmyqZlllYqsl223ad52O
X-Google-Smtp-Source: AJdET5dp6N5wUBIZ+xB9B78QACYoRzpEBNyt133MvqxYFazo2ZiddiDAaqE7bu/DFyrvJadKfxVTlw==
X-Received: by 2002:adf:fbc6:: with SMTP id d6-v6mr7367832wrs.241.1541198278076;
        Fri, 02 Nov 2018 15:37:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a12-v6sm21461469wrr.71.2018.11.02.15.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:37:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 3/5] Makefile: stop hiding failures during "install"
Date:   Fri,  2 Nov 2018 22:37:41 +0000
Message-Id: <20181102223743.4331-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <87efkkdwcv.fsf@evledraar.gmail.com>
References: <87efkkdwcv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the fallback mechanism where we try to create hardlinks and
ultimately fall back on a plain copy to emit the errors it encounters
instead of hiding them away and silently falling back to copying.

Hiding these errors dates back to 3e073dc561 ("Makefile: always
provide a fallback when hardlinks fail", 2008-08-25) when the existing
"hardlink or copy" logic was amended to hide the errors.

At that time "make install" hadn't yet been taught any of the
NO_*_HARDLINK options, that happened later in 3426e34fed ("Add
NO_CROSS_DIRECTORY_HARDLINKS support to the Makefile", 2009-05-11) and
was finally finished to roughly the current form in
70de5e65e8 ("Makefile: NO_INSTALL_HARDLINKS", 2012-05-02).

If someone is building a git in an environment where hard linking
fails, they can now specify some combination of
NO_INSTALL_HARDLINKS=YesPlease and NO_INSTALL_HARDLINKS=YesPlease, it
doesn't make sense anymore to not only implicitly fall back to
copying, but to do so silently.

This change leaves no way to not get errors spewed if we're trying and
failing to e.g. make symlinks and having to fall back on "cp". I think
that's OK.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 install_programs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/install_programs b/install_programs
index d3333cd25f..367e9a6cdf 100755
--- a/install_programs
+++ b/install_programs
@@ -58,7 +58,7 @@ then
 		test -n "$INSTALL_SYMLINKS" &&
 		ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
 		{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
-		  ln "$bindir/$p" "$execdir/$p" 2>/dev/null ||
+		  ln "$bindir/$p" "$execdir/$p" ||
 		  cp "$bindir/$p" "$execdir/$p" || exit; }
 	done
 fi &&
@@ -69,8 +69,8 @@ do
 	test -n "$INSTALL_SYMLINKS" &&
 	ln -s "git$X" "$bindir/$p" ||
 	{ test -z "$NO_INSTALL_HARDLINKS" &&
-	  ln "$bindir/git$X" "$bindir/$p" 2>/dev/null ||
-	  ln -s "git$X" "$bindir/$p" 2>/dev/null ||
+	  ln "$bindir/git$X" "$bindir/$p" ||
+	  ln -s "git$X" "$bindir/$p" ||
 	  cp "$bindir/git$X" "$bindir/$p" || exit; }
 done &&
 
@@ -79,8 +79,8 @@ for p in $list_execdir_git_dashed; do
 	test -n "$INSTALL_SYMLINKS" &&
 	ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
 	{ test -z "$NO_INSTALL_HARDLINKS" &&
-	  ln "$execdir/git$X" "$execdir/$p" 2>/dev/null ||
-	  ln -s "git$X" "$execdir/$p" 2>/dev/null ||
+	  ln "$execdir/git$X" "$execdir/$p" ||
+	  ln -s "git$X" "$execdir/$p" ||
 	  cp "$execdir/git$X" "$execdir/$p" || exit; }
 done &&
 
@@ -89,7 +89,7 @@ for p in $list_execdir_curl_aliases; do
 	test -n "$INSTALL_SYMLINKS" &&
 	ln -s "git-remote-http$X" "$execdir/$p" ||
 	{ test -z "$NO_INSTALL_HARDLINKS" &&
-	  ln "$execdir/git-remote-http$X" "$execdir/$p" 2>/dev/null ||
-	  ln -s "git-remote-http$X" "$execdir/$p" 2>/dev/null ||
+	  ln "$execdir/git-remote-http$X" "$execdir/$p" ||
+	  ln -s "git-remote-http$X" "$execdir/$p" ||
 	  cp "$execdir/git-remote-http$X" "$execdir/$p" || exit; }
 done
-- 
2.19.1.930.g4563a0d9d0


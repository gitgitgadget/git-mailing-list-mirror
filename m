Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646331F405
	for <e@80x24.org>; Sun, 16 Dec 2018 14:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbeLPO3c (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 09:29:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42468 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPO3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 09:29:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so7555423lfh.9
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXABqcjWT+ewhtaZYYeXwDDPimGmYxsXNXKaRicM2Fw=;
        b=d8+NrXlxziDqYvA431fdd7/WOUNLYFtT5r/TTgOjZxfOSlUgAgPurZDkk+mAeUWQiq
         m03lvKWKE6uowzwAIQIw1qfMh3d3PHyJe1xW/1F2Jor9O1a+fWHbH2UqBEHHQ597qJ0k
         PwF4mOFWexFk+dNn8P2XQuekQet28SrUOehzwlZqSIXezsSfIVjmgxf782AsunR7iDCW
         l8iEACEXTzVncpq0OvCfhDlvdesvNQDxRcpElgOPLOW4nT8g5mWwvexNBRRhmu/P1ZV1
         shR4LufUim73g5aaVwDGVZxPjjn8BI3vJUgmc4N6b5StKEuhIAas4OOBONqEUz2HpNI1
         fHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXABqcjWT+ewhtaZYYeXwDDPimGmYxsXNXKaRicM2Fw=;
        b=pMjHX9h9VGiAtgvaQuPelJ5bIng/mdaxEvG0oDA2NVNUr3UKjQdh5K1aBPb+OQvykx
         OcexxkaGayLau0JBkGk7SThPExDCUYAuaycm2n4nhwwocwCMwJaNOiHRnHW2hdo1zqzf
         xLLVd0nb2Sl/pecrVhqa95sm80rAgm6kHsD6Psc2gQngVjnurGoI7h5JU6HTgh8ZA5OQ
         Y2iV9iTmpQs1ZBW/3D4oeYxFWRUb8ZmyX7t4NNyATYmGSnfqHLO5aMtLtw3ZAsZGak8t
         yp8qgISQHpoL/o8Sbp1DtAT2qHc2R21uGWq956DVt3MnaeDnpoMsBSo2YmlRcql3S1yh
         VFkw==
X-Gm-Message-State: AA+aEWYIjyeCUvOa8afP/YPvGKBKwVxlBTD+5SfEwIq5+7+mhxZttCIR
        CkfDTtwyztPqD/cZUq5suHAWawwR
X-Google-Smtp-Source: AFSGD/Uen1+p6XCIdK4OmIc/EstGmrMXGE5h0F04L25vJvdAwiYX1tasjJf2ZCPyFVDhlfDKZ4PTCg==
X-Received: by 2002:a19:4cc3:: with SMTP id z186mr5245052lfa.37.1544970568481;
        Sun, 16 Dec 2018 06:29:28 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k63sm2083296lfe.13.2018.12.16.06.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 06:29:27 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] git-status.txt: render tables correctly under Asciidoctor
Date:   Sun, 16 Dec 2018 15:28:59 +0100
Message-Id: <2cca954957c5b9c750e6d2211b673997effe7d60.1544969984.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1544969984.git.martin.agren@gmail.com>
References: <20181216105944.GG13704@sigill.intra.peff.net> <cover.1544969984.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor removes the indentation of each line in these tables, so the
last lines of each table have a completely broken alignment.

Similar to 379805051d ("Documentation: render revisions correctly under
Asciidoctor", 2018-05-06), use an explicit literal block to indicate
that we want to keep the leading whitespace in the tables.

Because this gives us some extra indentation, we can remove the one that
we have been carrying explicitly. That is, drop the first four spaces of
indentation on each line. With Asciidoc (8.6.10), this results in
identical rendering before and after this commit, both for git-status.1
and git-status.html.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-status.txt | 162 ++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 77 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d9f422d560..861d821d7f 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -197,31 +197,33 @@ codes can be interpreted as follows:
 Ignored files are not listed, unless `--ignored` option is in effect,
 in which case `XY` are `!!`.
 
-    X          Y     Meaning
-    -------------------------------------------------
-	     [AMD]   not updated
-    M        [ MD]   updated in index
-    A        [ MD]   added to index
-    D                deleted from index
-    R        [ MD]   renamed in index
-    C        [ MD]   copied in index
-    [MARC]           index and work tree matches
-    [ MARC]     M    work tree changed since index
-    [ MARC]     D    deleted in work tree
-    [ D]        R    renamed in work tree
-    [ D]        C    copied in work tree
-    -------------------------------------------------
-    D           D    unmerged, both deleted
-    A           U    unmerged, added by us
-    U           D    unmerged, deleted by them
-    U           A    unmerged, added by them
-    D           U    unmerged, deleted by us
-    A           A    unmerged, both added
-    U           U    unmerged, both modified
-    -------------------------------------------------
-    ?           ?    untracked
-    !           !    ignored
-    -------------------------------------------------
+....
+X          Y     Meaning
+-------------------------------------------------
+	 [AMD]   not updated
+M        [ MD]   updated in index
+A        [ MD]   added to index
+D                deleted from index
+R        [ MD]   renamed in index
+C        [ MD]   copied in index
+[MARC]           index and work tree matches
+[ MARC]     M    work tree changed since index
+[ MARC]     D    deleted in work tree
+[ D]        R    renamed in work tree
+[ D]        C    copied in work tree
+-------------------------------------------------
+D           D    unmerged, both deleted
+A           U    unmerged, added by us
+U           D    unmerged, deleted by them
+U           A    unmerged, added by them
+D           U    unmerged, deleted by us
+A           A    unmerged, both added
+U           U    unmerged, both modified
+-------------------------------------------------
+?           ?    untracked
+!           !    ignored
+-------------------------------------------------
+....
 
 Submodules have more state and instead report
 		M    the submodule has a different HEAD than
@@ -281,14 +283,16 @@ don't recognize.
 If `--branch` is given, a series of header lines are printed with
 information about the current branch.
 
-    Line                                     Notes
-    ------------------------------------------------------------
-    # branch.oid <commit> | (initial)        Current commit.
-    # branch.head <branch> | (detached)      Current branch.
-    # branch.upstream <upstream_branch>      If upstream is set.
-    # branch.ab +<ahead> -<behind>           If upstream is set and
-					     the commit is present.
-    ------------------------------------------------------------
+....
+Line                                     Notes
+------------------------------------------------------------
+# branch.oid <commit> | (initial)        Current commit.
+# branch.head <branch> | (detached)      Current branch.
+# branch.upstream <upstream_branch>      If upstream is set.
+# branch.ab +<ahead> -<behind>           If upstream is set and
+					 the commit is present.
+------------------------------------------------------------
+....
 
 ### Changed Tracked Entries
 
@@ -306,56 +310,60 @@ Renamed or copied entries have the following format:
 
     2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><score> <path><sep><origPath>
 
-    Field       Meaning
-    --------------------------------------------------------
-    <XY>        A 2 character field containing the staged and
-		unstaged XY values described in the short format,
-		with unchanged indicated by a "." rather than
-		a space.
-    <sub>       A 4 character field describing the submodule state.
-		"N..." when the entry is not a submodule.
-		"S<c><m><u>" when the entry is a submodule.
-		<c> is "C" if the commit changed; otherwise ".".
-		<m> is "M" if it has tracked changes; otherwise ".".
-		<u> is "U" if there are untracked changes; otherwise ".".
-    <mH>        The octal file mode in HEAD.
-    <mI>        The octal file mode in the index.
-    <mW>        The octal file mode in the worktree.
-    <hH>        The object name in HEAD.
-    <hI>        The object name in the index.
-    <X><score>  The rename or copy score (denoting the percentage
-		of similarity between the source and target of the
-		move or copy). For example "R100" or "C75".
-    <path>      The pathname.  In a renamed/copied entry, this
-		is the target path.
-    <sep>       When the `-z` option is used, the 2 pathnames are separated
-		with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
-		byte separates them.
-    <origPath>  The pathname in the commit at HEAD or in the index.
-		This is only present in a renamed/copied entry, and
-		tells where the renamed/copied contents came from.
-    --------------------------------------------------------
+....
+Field       Meaning
+--------------------------------------------------------
+<XY>        A 2 character field containing the staged and
+	    unstaged XY values described in the short format,
+	    with unchanged indicated by a "." rather than
+	    a space.
+<sub>       A 4 character field describing the submodule state.
+	    "N..." when the entry is not a submodule.
+	    "S<c><m><u>" when the entry is a submodule.
+	    <c> is "C" if the commit changed; otherwise ".".
+	    <m> is "M" if it has tracked changes; otherwise ".".
+	    <u> is "U" if there are untracked changes; otherwise ".".
+<mH>        The octal file mode in HEAD.
+<mI>        The octal file mode in the index.
+<mW>        The octal file mode in the worktree.
+<hH>        The object name in HEAD.
+<hI>        The object name in the index.
+<X><score>  The rename or copy score (denoting the percentage
+	    of similarity between the source and target of the
+	    move or copy). For example "R100" or "C75".
+<path>      The pathname.  In a renamed/copied entry, this
+	    is the target path.
+<sep>       When the `-z` option is used, the 2 pathnames are separated
+	    with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
+	    byte separates them.
+<origPath>  The pathname in the commit at HEAD or in the index.
+	    This is only present in a renamed/copied entry, and
+	    tells where the renamed/copied contents came from.
+--------------------------------------------------------
+....
 
 Unmerged entries have the following format; the first character is
 a "u" to distinguish from ordinary changed entries.
 
     u <xy> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
 
-    Field       Meaning
-    --------------------------------------------------------
-    <XY>        A 2 character field describing the conflict type
-		as described in the short format.
-    <sub>       A 4 character field describing the submodule state
-		as described above.
-    <m1>        The octal file mode in stage 1.
-    <m2>        The octal file mode in stage 2.
-    <m3>        The octal file mode in stage 3.
-    <mW>        The octal file mode in the worktree.
-    <h1>        The object name in stage 1.
-    <h2>        The object name in stage 2.
-    <h3>        The object name in stage 3.
-    <path>      The pathname.
-    --------------------------------------------------------
+....
+Field       Meaning
+--------------------------------------------------------
+<XY>        A 2 character field describing the conflict type
+	    as described in the short format.
+<sub>       A 4 character field describing the submodule state
+	    as described above.
+<m1>        The octal file mode in stage 1.
+<m2>        The octal file mode in stage 2.
+<m3>        The octal file mode in stage 3.
+<mW>        The octal file mode in the worktree.
+<h1>        The object name in stage 1.
+<h2>        The object name in stage 2.
+<h3>        The object name in stage 3.
+<path>      The pathname.
+--------------------------------------------------------
+....
 
 ### Other Items
 
-- 
2.20.1


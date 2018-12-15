Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE7E211B3
	for <e@80x24.org>; Sat, 15 Dec 2018 11:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeLOL2L (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 06:28:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33637 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOL2K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 06:28:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so6185647lfc.0
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 03:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9BbX8e8GvoJsOoQqL7OyRUc9pMFW3aQMvAUT4kwbUsI=;
        b=aib2sEJE2bElwamVytYafGsrFyAUrTG9LG0imVoz1nxjFM3tc5nEdIhLTtUUdgStDn
         fm8zYtnZyk3TYiRRShWrGjmOqqxcOOgRhWWtZA7Ca9hDK1Yhoj3uWlbnMoF3uC7UoJDZ
         FbUkM4nslgFyIFgTw2832jj8EvfaiJTjEpX4GNYyddf1wrNuFwBK/rZXpbdd/dDrUymi
         FxLFhbeoRprsFRxilPGY89PIFzbiOHFLpG6MlZpvdkBAZzVu/uJNjmDetYatQqbM1mLz
         utLL6tnPlrDdCFp09TyTaqf1jgvKzXEL71bbn7kEA3xib/A+VFAR/mU8gd+13KxS//tv
         6F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BbX8e8GvoJsOoQqL7OyRUc9pMFW3aQMvAUT4kwbUsI=;
        b=qbyNOQsM6fuoDTx6Y9WW6tdU7H4fR1rHKNBXs/QRT7gt7QNygET7DEDNiJKeYPUTsL
         8MUJpvrVEE1O5nGLwdCCXTF83awFZDdz3h+CjViODqRpBBSy7nuQNJ0mq7G2+SVdlveZ
         Gj/hqcuhg7zG/OIwjFIO5RZrHQYG3e4miqiBWfOVU03iRn5oSpWw6pz5jFfNhRkZ2fju
         /3YNzDh3DxpEMGbuOXSf8CadSHefNjksTkiRdW0deVRSUMdV3i0OydA5JNcbg6Djom2/
         jel5B4PeJeeYJt9Q7zN0x2dTKTiAqZ+G6DWVXHCsj/dHvVtmRPjfMs5ZQgJCieVxJtIS
         Fuug==
X-Gm-Message-State: AA+aEWZ2eu7u0rPe72Q/ITJIsuR5cqAw1TGaii+3LHGQRpiEEoQPxJJb
        VZccfoRr2pDQD7KhrnYLiUWrUV7z
X-Google-Smtp-Source: AFSGD/W0EgSxLPRAo3NSfuUENhXzawwyo84LzJcEZSlLAaXl+mex6opSNFpLFPkgf/xOQBOrV5EcIQ==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr3973772lfa.32.1544873285897;
        Sat, 15 Dec 2018 03:28:05 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id t18sm1439174lft.93.2018.12.15.03.28.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 03:28:05 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] git-status.txt: render tables correctly under Asciidoctor
Date:   Sat, 15 Dec 2018 12:27:42 +0100
Message-Id: <20181215112742.1475882-5-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181215112742.1475882-1-martin.agren@gmail.com>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
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
 See https://git-scm.com/docs/git-status#_short_format ,
 https://git-scm.com/docs/git-status#_branch_headers and
 https://git-scm.com/docs/git-status#_changed_tracked_entries .

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


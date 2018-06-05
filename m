Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21211F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeFEUsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36554 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeFEUsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:48:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so3856492wrm.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mj2evgPeY1ZnqAdko1EVQNIwaOwSSUkCGcwyqOb236A=;
        b=l4kG554afXMzcHD6D6BNDfu0NDtiETAkcPJL9YKlzUm8W3zEmROoxbT6/hoMUHjpHf
         kF6KW6A0WYShwK1yJd4DwGD4GVlahxLbdf6fbjKry+QPfSdZEUzRTcVetAu0wZnS/e4E
         LFyRrYdJI3tbhZoZG4QrpX7tBD5Lb2g9gXmt+FBzk1N1rPJRLQpxV2UScbftMyvfbfXP
         YZuZKr8zMBRMFVlHDFX0BMPP2z4oGOj5mxcmUvMkMKTglMmGgYbrW46fwSDlqGJXqKEw
         GC0QlN11SKPvcbrD5XF5CNAd2TeJ18Q16g+B0z8ofDM07XiExLzzF6cIXX7we3jwM1iQ
         AmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mj2evgPeY1ZnqAdko1EVQNIwaOwSSUkCGcwyqOb236A=;
        b=ldTUhWiDSAPO9thS3t2MNrAmXFbGLw3KZewVRrEsnSKChxR2c2j72NGucpvJx/dIk5
         xBv2YHAYyaYGhgWR2dRadrMKlbs5E2dEUWydNkI37lzQ8rk+eWXj8KxAIeWAtbKyWvkl
         9sTe7ocC1GswaiENGUlJshQdHZ2J4sKjrPaNdkhDDEPL4Iic9EX7zj5BJ2aMJEG4OVk8
         YbVwvCNFj3Z+MIOm7Mjp8YqIeoP6+FRZ8jDPsjCJjF1FmshZicUlReuh4AIeKgWpUIP9
         otEsbcvnqjMvQkfc8WarYMB+2uaND9Jhv5+WAAZEzv/PgZEL3XffecMS/drfD3H09fN3
         bf1A==
X-Gm-Message-State: APt69E1ZQr3YJc/cbjKUMRK0caKO+NhSh77+Z+KgKV6bGprqkGlZy+ps
        +yZ1fzaiuZq1MQxOVhcw/c+V1QlJ
X-Google-Smtp-Source: ADUXVKI9NT6E+I3Qj20cKJ0yUmDgpsZoCQ6jtlDFEMdv65Vqh3LoSSNHxe9gpodt83f3C24rBJdfDg==
X-Received: by 2002:adf:88b2:: with SMTP id f47-v6mr109584wrf.55.1528231683128;
        Tue, 05 Jun 2018 13:48:03 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d3-v6sm31841327wri.24.2018.06.05.13.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:48:02 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 05/10] rerere: add some documentation
Date:   Tue,  5 Jun 2018 22:52:14 +0100
Message-Id: <20180605215219.28783-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add some documentation for the logic behind the conflict normalization
in rerere.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/technical/rerere.txt | 142 +++++++++++++++++++++++++++++
 rerere.c                           |   4 -
 2 files changed, 142 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/technical/rerere.txt

diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
new file mode 100644
index 0000000000..2c517fe0fc
--- /dev/null
+++ b/Documentation/technical/rerere.txt
@@ -0,0 +1,142 @@
+Rerere
+======
+
+This document describes the rerere logic.
+
+Conflict normalization
+----------------------
+
+To ensure recorded conflict resolutions can be looked up in the rerere
+database, even when branches are merged in a different order,
+different branches are merged that result in the same conflict, or
+when different conflict style settings are used, rerere normalizes the
+conflicts before writing them to the rerere database.
+
+Differnt conflict styles and branch names are dealt with by stripping
+that information from the conflict markers, and removing extraneous
+information from the `diff3` conflict style.
+
+Branches being merged in different order are dealt with by sorting the
+conflict hunks.  More on each of those parts in the following
+sections.
+
+Once these two normalization operations are applied, a conflict ID is
+created based on the normalized conflict, which is later used by
+rerere to look up the conflict in the rerere database.
+
+Stripping extraneous information
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Say we have three branches AB, AC and AC2.  The common ancestor of
+these branches has a file with with a line with the string "A" (for
+brevity this line is called "line A" for brevity in the following) in
+it.  In branch AB this line is changed to "B", in AC, this line is
+changed to C, and branch AC2 is forked off of AC, after the line was
+changed to C.
+
+Now forking a branch ABAC off of branch AB and then merging AC into it,
+we'd get a conflict like the following:
+
+    <<<<<<< HEAD
+    B
+    =======
+    C
+    >>>>>>> AC
+
+Now doing the analogous with AC2 (forking a branch ABAC2 off of branch
+AB and then merging branch AC2 into it), maybe using the diff3
+conflict style, we'd get a conflict like the following:
+
+    <<<<<<< HEAD
+    B
+    ||||||| merged common ancestors
+    A
+    =======
+    C
+    >>>>>>> AC2
+
+By resolving this conflict, to leave line D, the user declares:
+
+    After examining what branches AB and AC did, I believe that making
+    line A into line D is the best thing to do that is compatible with
+    what AB and AC wanted to do.
+
+As branch AC2 refers to the same commit as AC, the above implies that
+this is also compatible what AB and AC2 wanted to do.
+
+By extension, this means that rerere should recognize that the above
+conflicts are the same.  To do this, the labels on the conflict
+markers are stripped, and the diff3 output is removed.  The above
+examples would both result in the following normalized conflict:
+
+    <<<<<<<
+    B
+    =======
+    C
+    >>>>>>>
+
+Sorting hunks
+~~~~~~~~~~~~~
+
+As before, lets imagine that a common ancestor had a file with line A
+its early part, and line X in its late part.  And then four branches
+are forked that do these things:
+
+    - AB: changes A to B
+    - AC: changes A to C
+    - XY: changes X to Y
+    - XZ: changes X to Z
+
+Now, forking a branch ABAC off of branch AB and then merging AC into
+it, and forking a branch ACAB off of branch AC and then merging AB
+into it, would yield the conflict in a different order.  The former
+would say "A became B or C, what now?" while the latter would say "A
+became C or B, what now?"
+
+As a reminder, the act of merging AC into ABAC and resolving the
+conflict to leave line D means that the user declares:
+
+    After examining what branches AB and AC did, I believe that
+    making line A into line D is the best thing to do that is
+    compatible with what AB and AC wanted to do.
+
+So the conflict we would see when merging AB into ACAB should be
+resolved the same way---it is the resolution that is in line with that
+declaration.
+
+Imagine that similarly previously a branch XYXZ was forked from XY,
+and XZ was merged into it, and resolved "X became Y or Z" into "X
+became W".
+
+Now, if a branch ABXY was forked from AB and then merged XY, then ABXY
+would have line B in its early part and line Y in its later part.
+Such a merge would be quite clean.  We can construct 4 combinations
+using these four branches ((AB, AC) x (XY, XZ)).
+
+Merging ABXY and ACXZ would make "an early A became B or C, a late X
+became Y or Z" conflict, while merging ACXY and ABXZ would make "an
+early A became C or B, a late X became Y or Z".  We can see there are
+4 combinations of ("B or C", "C or B") x ("X or Y", "Y or X").
+
+By sorting, the conflict is given its canonical name, namely, "an
+early part became B or C, a late part becames X or Y", and whenever
+any of these four patterns appear, and we can get to the same conflict
+and resolution that we saw earlier.
+
+Without the sorting, we'd have to somehow find a previous resolution
+from combinatorial explosion.
+
+Conflict ID calculation
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Once the conflict normalization is done, the conflict ID is calculated
+as the sha1 hash of the conflict hunks appended to each other,
+separated by <NUL> characters.  The conflict markers are stripped out
+before the sha1 is calculated.  So in the example above, where we
+merge branch AC which changes line A to line C, into branch AB, which
+changes line A to line C, the conflict ID would be
+SHA1('B<NUL>C<NUL>').
+
+If there are multiple conflicts in one file, the sha1 is calculated
+the same way with all hunks appended to each other, in the order in
+which they appear in the file, separated by a <NUL> character.
diff --git a/rerere.c b/rerere.c
index 74ce422634..ef23abe4dd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -394,10 +394,6 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
  * and NUL concatenated together.
  *
  * Return the number of conflict hunks found.
- *
- * NEEDSWORK: the logic and theory of operation behind this conflict
- * normalization may deserve to be documented somewhere, perhaps in
- * Documentation/technical/rerere.txt.
  */
 static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
-- 
2.17.0.410.g65aef3a6c4


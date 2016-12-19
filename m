Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96FE11FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbcLSQqV (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:21 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53426 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933445AbcLSQpe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:34 -0500
X-AuditID: 1207440c-e3bff700000009a1-0e-58580ead4760
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 61.17.02465.DAE08585; Mon, 19 Dec 2016 11:45:33 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKR4011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:33 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/13] gitk: introduce a constant otherrefbgcolor
Date:   Mon, 19 Dec 2016 17:45:10 +0100
Message-Id: <b1587aa5b9b7b3ab4197309706035a8837340778.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsUixO6iqLuWLyLCYO1rI4uuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugStj14kLLAUH+CsaV2xma2Dc
        zNPFyMkhIWAicX3OdkYQW0jgMqPE9LOaXYxcQPYpJokN09azgSTYBHQlFvU0M3UxcnCICKhK
        rL8gBBJmFnCQ2Py5EaxXWMBRYsbCZlYQmwWo5NfPNcwgNq9AlMTC45/YIHbJSVza9gUszilg
        IXFz/hV2iL3mEhue/WaZwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrp
        JkZIQPDsYPy2TuYQowAHoxIPr+TbsAgh1sSy4srcQ4ySHExKorz7eSIihPiS8lMqMxKLM+KL
        SnNSiw8xSnAwK4nw7uUFyvGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiU
        JHjDQRoFi1LTUyvSMnNKENJMHJwgw3mAhqeDDS8uSMwtzkyHyJ9i1OVYcGPdUyYhlrz8vFQp
        cV5HkCIBkKKM0jy4ObBIfsUoDvSWMO8ZkCoeYBKAm/QKaAkT0JKF3eEgS0oSEVJSDYxB1WUn
        p2ttrNKVT9cWuMC0ie/ZY80oScefP8ynT7t7MTq55pTsGva4dzL+bPkdUpuuHilm+fLRXPhe
        Uer9HVseVWceNdn57X8L55PCwoMce9y+1LzaG6RwbMdCfr6D1acT8+eUPrnCqFy00uiqcQzr
        vK3fOKxSriqvallm/dDjw97Wyuf/604psRRnJBpqMRcVJwIAu5xSar8CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the value used for references other than tags, heads, and
remote-tracking references (e.g., `refs/stash`).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 44f4d70..0bd4aa5 100755
--- a/gitk
+++ b/gitk
@@ -6573,7 +6573,8 @@ proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
     global canv rowtextx curview fgcolor bgcolor ctxbut
-    global headbgcolor headfgcolor headoutlinecolor remotebgcolor
+    global headbgcolor headfgcolor headoutlinecolor
+    global remotebgcolor otherrefbgcolor
     global tagbgcolor tagfgcolor tagoutlinecolor
     global reflinecolor
 
@@ -6671,7 +6672,7 @@ proc drawtags {id x xt y1} {
 	    } elseif {$type eq "head" || $type eq "remote"} {
 		set col $headbgcolor
 	    } else {
-		set col "#ddddff"
+		set col $otherrefbgcolor
 	    }
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
@@ -12361,6 +12362,7 @@ set headbgcolor "#00ff00"
 set headfgcolor black
 set headoutlinecolor black
 set remotebgcolor #ffddaa
+set otherrefbgcolor #ddddff
 set tagbgcolor yellow
 set tagfgcolor black
 set tagoutlinecolor black
@@ -12418,7 +12420,8 @@ set config_variables {
     bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
     markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
     extdifftool perfile_attrs headbgcolor headfgcolor headoutlinecolor
-    remotebgcolor tagbgcolor tagfgcolor tagoutlinecolor reflinecolor
+    remotebgcolor otherrefbgcolor
+    tagbgcolor tagfgcolor tagoutlinecolor reflinecolor
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
-- 
2.9.3


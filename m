Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287CD20248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfCQShG (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:37:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36328 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQShG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:37:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so10146419lfn.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7c5YDSgyoawrfmqf/oFmLzUxQUdk/OeK/sp494Ht4c=;
        b=nm50bhIb5PMMJz/PWjSiwkSXp9iNVlO6I8TKZDWyoaR9FGosg2b7oWbweaO2RDbwT8
         Q0LgnZ1RoLyXIOIDjM4O88vQCvIHW36742Kl5T8x2jkKcxtfpE3GlFrabAeoqz/Ud2q7
         J3p5124whc30Ro8oiCUjXbHauOAupwxcyZgrmJiCCjtlS84h2LcQmhVnNkzpTtMHA8lJ
         k9LBqbZwCcjYOQu+wzyn8Xv72LpBow25Qx+eEkX5aberZa1UrhpMb6ObHLi76DXl24La
         0XSi8Sosl3XgJHMviLfFiwOOyHRJ96Jv2Y1F8s7uUtbwTATVGfzwHtZ7ZVi7WQrxKHl5
         p1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7c5YDSgyoawrfmqf/oFmLzUxQUdk/OeK/sp494Ht4c=;
        b=D5kMFQR/s/Q904O0qnsxIKFbzF3CxRls5a6SyI1fX7u+08R6+w6LaGuAO2jG7CG/qp
         zYnLtOsxUr4Xsq6onU/Heu8hHtVVapM8tD4oGaisk3YOBW6fq6lXsUS0iI5E4/5oM8lA
         Hvzgp3AvaM8cTd7+N6s2IQEQWr2zWIj9sPHBt2hC0KEmCA1miqf9bm1p1GEPTlljyUrr
         /KxPLE/cYnH4DMEr70DHa4GgBIKrEYFmUGTwEBfUTQnyW9SRO3kEsY7SoxPCQL4rKs+7
         mNcXME92N32/TUrB8XaTuBEKxrZ4o/XKdaiRwWh4816ymTKpWoRh2JygckME2mRP3Lxw
         on7w==
X-Gm-Message-State: APjAAAWQIyVNM/fOIzZbjitqQ5gnSKivdOf103eijQMmGYDkpKwtrr4l
        Fd0qjys4N+VrSLrzFznGfje0BCPP
X-Google-Smtp-Source: APXvYqzOrGONPm1VHbU3Qqd/lvh7AxCu8a2DgG8Tz47uSgaBTmtglUiFppDngb35CbzjhEqT8U4G6w==
X-Received: by 2002:ac2:5921:: with SMTP id v1mr7824933lfi.135.1552847824025;
        Sun, 17 Mar 2019 11:37:04 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id e2sm1589484lfc.75.2019.03.17.11.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:37:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 4/4] doc-diff: add `--cut-header-footer`
Date:   Sun, 17 Mar 2019 19:36:03 +0100
Message-Id: <7ce7aa6f2f1ea40442c17c15fe8d7744b29d8650.1552838239.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552838239.git.martin.agren@gmail.com>
References: <cover.1552838239.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AsciiDoc and Asciidoctor do not agree on what to write in the header and
footer of each man-page, i.e., the very first and the very last line of
*.[157]. Those differences can certainly be interesting in their own
right, but they clutter the output of `./doc-diff --from-asciidoc
--to-asciidoctor HEAD HEAD` quite a bit since the diff contains some
10-15 lines of noise per file diffed.

Teach doc-diff to cut away the first two and last two lines, i.e., the
header/footer and the empty line immediately following/preceding it.
Because Asciidoctor uses an extra empty line compared to AsciiDoc,
remove one more line at each end of the file, but only if it's empty.

An alternative approach might be to pass down `--no-header-footer`,
which both AsciiDoc and Asciidoctor understand, but it has some
drawbacks. First of all, the result doesn't build -- `xmlto` stumbles on
the resulting xml since it has multiple root elements. Second, it cuts
too much -- dropping the header loses the synopsis, which would be
interesting to diff.

Like in the previous commit, encode this option into the directory name
of the "installed" and "rendered" files. Otherwise, we wouldn't be able
to trust that what we use out of that cache actually corresponds to the
options given for this run. (We could optimize this caching a little
since this flag doesn't affect the contents of "installed" at all, but
let's punt on that.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/doc-diff | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 36fc2307a7..3355be4798 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -21,6 +21,7 @@ asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
 asciidoctor		use asciidoctor with both commits
+cut-header-footer	cut away header and footer
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -30,6 +31,7 @@ force=
 clean=
 from_program=
 to_program=
+cut_header_footer=
 while test $# -gt 0
 do
 	case "$1" in
@@ -53,6 +55,8 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
+	--cut-header-footer)
+		cut_header_footer=-cut-header-footer ;;
 	--)
 		shift; break ;;
 	*)
@@ -114,8 +118,8 @@ construct_makemanflags () {
 from_makemanflags=$(construct_makemanflags "$from_program") &&
 to_makemanflags=$(construct_makemanflags "$to_program") &&
 
-from_dir=$from_oid$from_program &&
-to_dir=$to_oid$to_program &&
+from_dir=$from_oid$from_program$cut_header_footer &&
+to_dir=$to_oid$to_program$cut_header_footer &&
 
 # generate_render_makefile <srcdir> <dstdir>
 generate_render_makefile () {
@@ -164,6 +168,17 @@ render_tree () {
 			"$tmp/rendered/$dname+" |
 		make -j$parallel -f - &&
 		mv "$tmp/rendered/$dname+" "$tmp/rendered/$dname"
+
+		if test "$cut_header_footer" = "-cut-header-footer"
+		then
+			for f in $(find "$tmp/rendered/$dname" -type f)
+			do
+				tail -n +3 "$f" | head -n -2 |
+				sed -e '1{/^$/d}' -e '${/^$/d}' >"$f+" &&
+				mv "$f+" "$f" ||
+				return 1
+			done
+		fi
 	fi
 }
 
-- 
2.21.0


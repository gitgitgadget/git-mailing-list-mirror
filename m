Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7ACC1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbdKMWij (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:38:39 -0500
Received: from mout.gmx.net ([212.227.17.22]:61471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdKMWii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:38:38 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Ln8gj-1erFxS1Wbl-00hPak; Mon, 13 Nov 2017 23:37:59 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v2 1/6] config: introduce core.printsha1ellipsis
Date:   Mon, 13 Nov 2017 23:36:49 +0100
Message-Id: <20171113223654.27732-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <EA775C6AB4684B7A86A88C733C132827@PhilipOakley>
X-Provags-ID: V03:K0:3yqKHVvUKJCEs4ZetsdYgTPCPA9RUVGFOcY/skUBODmRx3wDxgq
 JHWstlJgfXcDg2YtBqVf3CocoHgHD64hUQq8nkQoFf7753DBFptj+me2dfEfwtqh9FjfmI2
 wCXevUBr6ZbcR7JBdR1ppRmTkpBRKs/rJ0+Aq0EtqlELo95olV+3OkRvFe2lyvqVb5hJK6b
 X8ycJFHLrKCZiMPJD1fMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0dXvQcAn27U=:7P3t8/P+evAjxjMkGJG2wg
 Mei/xDrHiFTwW1FDJVmk2JrkL6cjfGizpq5aIrpQv2pmEj07YK5CFSqv5CGMAMpsSTSNoNhU0
 9/qTmt0/rzB7GjYl4KxQNce3115E/OV8o3j/In/h4Fq7N6qC3e5H8xdNg/26VK0NxT+GCU+wm
 hGfdwSzqH3+iT0ekgMMjvMAgA7AyLjHw3S65YSIvnSpPSxF2BsNpMC3WlCwm0BuhqA80FW2WL
 Lz+mZglnVsKIIw3Btc1DvumJ+qYR7rTYL9cjL1uuqxJpommYI/W6l/jvtZ0Yls6i8rMWHXMCG
 uXc+vB6IU9R5/LRnURohJz2bT4CoRTKwv7kUxdLSfIlojA2ggv1KmKV1f1zf5mODjliRQba3h
 CPbImk9NX3nmkDjta61gOpN4VkUOqUhZzAn30oQWlQDsfltOKQ0DspuuDwc2zz9vpreYp6pRk
 llOSRfZpxZ4WK3b+0FstEvlFbsv06JF0AgGoA+CeHiFViEPzOglIVoV6sNTWZYUWjgjRZyifL
 annZ3fVwT11Ov4YcZJS2uIcAf49QyeFZTNZaIE1LqT3imBAWJgsbBbkBGxwIxsacGiTxDESb7
 gCuRdw5ruI0pJ45IduE1CrIzjld/QF1U+cgy03UCMWfz4A0F/fQxaGGZ0Ad5YII5NlzWj14ZS
 fBG206XxZaxRE0H9OtLrdkTKkME5VFI4BDBdTk9BeYECvtDY0bLqqOGy+E8cS7355uaPoNXRO
 CyglAfgSUAyOioQ1JorNIdbC3zsVsaj5uJQcPPLz3u0Jyuu0W1m88QQLxYqWvQIO+G7TCJDoJ
 WhmmmEGDfjm2TSylzVvBNZ29Oov2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use it to ascertain whether or not the user wants an ellipsis
printed after an abbreviated SHA-1 value.

By de-asserting it in the default, we encourage not printing the
ellipsis in such circumstances.

Not adding a corresponding cli option is intentional; and we would like
to remove the config option *and* the ellipses after abbreviated SHA-1
values after a respectable period.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
 Documentation/config.txt | 10 ++++++++++
 cache.h                  |  1 +
 config.c                 |  9 +++++++++
 environment.c            |  1 +
 4 files changed, 21 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 671fcbaa0fd1..93887820ff89 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -898,6 +898,16 @@ core.abbrev::
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
 
+core.printsha1ellipsis (deprecated)::
+	A Boolean controlling whether an ellipsis should be
+	printed following an (abbreviated) SHA-1 value.  This
+	affects indications of detached HEADs or the raw diff
+	output.  Printing an ellipsis in the cases mentioned is no
+	longer considered adequate and support for it will be
+	removed in the foreseeable future (along with the
+	option).
+	Therefore, the default is false.
+
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/cache.h b/cache.h
index cb7fb7c004be..5cbc50a0c1ab 100644
--- a/cache.h
+++ b/cache.h
@@ -753,6 +753,7 @@ extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
+extern int print_sha1_ellipsis;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
diff --git a/config.c b/config.c
index 903abf9533b1..f560aea5e98b 100644
--- a/config.c
+++ b/config.c
@@ -1073,6 +1073,15 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	/* Printing an ellipsis after an abbreviated SHA-1 value
+	 * is no longer desired but must be selectable for some
+	 * time to come.
+	 */
+	if (!strcmp(var, "core.printsha1ellipsis")) {
+		print_sha1_ellipsis = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.disambiguate"))
 		return set_disambiguate_hint_config(var, value);
 
diff --git a/environment.c b/environment.c
index 8289c25b44d7..5ceb92f921c6 100644
--- a/environment.c
+++ b/environment.c
@@ -19,6 +19,7 @@ int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
+int print_sha1_ellipsis = 0; /* Only if the user requests it. */
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
-- 
2.13.6


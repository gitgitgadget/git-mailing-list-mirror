Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E1E1FAE7
	for <e@80x24.org>; Thu, 29 Mar 2018 15:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeC2PTU (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:19:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:42571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeC2PTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:19:19 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7UUd-1eey8u26aN-00xM0m; Thu, 29
 Mar 2018 17:19:11 +0200
Date:   Thu, 29 Mar 2018 17:19:09 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 9/9] git_config_set: reuse empty sections
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <29868fec2606f5f6aa1c5de2928580f2ca24e6e2.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GrmA+oSZkI3vN4oLvkTOLhRSgOrbGxLdom1e08H9Q1di8k3iDlc
 8VEcPxFrQbqDn8BDyazkt3gjCvtu5/bKnjtNMaPCUcey6ZI6mxUJ1UcTJKKsKVIwkrDnbsd
 EhMg/8OxS6hzacItuWzH9QdFQe07giN1PXXtS0IBHemNkjs3PeCkigTRZwKXUStte/E4k+g
 BSPNU+so4JkBGsyMnNvZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uXx1ssMIPOY=:4MaopYisSgy6yJRXa7wCz2
 4xS93Rt32VyAPuRtqjU6gNSCR6V3dDMRyMs1ju187B/QzPUt4ALxM4EcmTQvYc/LUFd5LGY8p
 XgIr09/XmUypQP0rcNaFScBcHg1C4R8G1JNNVlZsEFb7U5L9zO8McBE5OcJj1qd/drqW3Ih3L
 8dYxGwQsgDOhAD+89bxTa/FmsTpUMq9K2/wqHMokQkk1E4cJJf9adxoUVqG3vq8aAKvgSoOGN
 m+QyVOoBqI/T3R9ggnB8UW51mXlfoEGN1lc9TunvxJ4+IXYHE21s3gIIn4+D4HheAzdJxxd2k
 tSMtNUVtIPGIiQ7lZEz0QFzacAnOpUYJbmGi4f0maIGPgyOwQMI4FKTPCxsoyZV0y2iFPdLSF
 GdAxZ7aBj3amqFmY6S04QSzJkHky4phP7KBeu8lCF1JOVN7hTKb+KbF9Glu74i4lNq3STrJwP
 QPxhjQzhJ0L/4Co4bXswrBHNXsTIJKKFD8RJ1g6pQ5K5OOTBfpVejt87f7fGrs4XZ7A+c4jN5
 3eShJYtluH6rBwxpG2p3dsP+GyutIU/umUhqQ5C7it0tREfBpQya2d9dxm0kvdbG6jBftebU9
 Gl9A4g1cDlYifERfKqXA/GEmh1t8W6+zUkWCLtxFvhLUBPp8hj7F4j0skAl2lt8A8WtKDTnEy
 wC6IzH5ua/xnE2CyN8AV0G9sm/wxOsgB1aGC3vCGhLr6jEVn9zH/xRCq8VBHM0nSLHVmh9N7E
 u8Z8F/NxJu8ki82pKOIXEBv1QmXGkgGO0mGeOipohy72f5mXSHJP7wVSZjQqfpXcyY6hEcydX
 LIUUxy8IdmiePJVtBuQlaaBBBXef2JUqp1sU/PSnEFpeKyYUhNMbGsG0eUmfzMnuttznDov
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can happen quite easily that the last setting in a config section is
removed, and to avoid confusion when there are comments in the config
about that section, we keep a lone section header, i.e. an empty
section.

The code to add new entries in the config tries to be cute by reusing
the parsing code that is used to retrieve config settings, but that
poses the problem that the latter use case does *not* care about empty
sections, therefore even the former user case won't see them.

Fix this by introducing a mode where the parser reports also empty
sections (with a trailing '.' as tell-tale), and then using that when
adding new config entries.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c          | 32 +++++++++++++++++++++++---------
 t/t1300-config.sh |  2 +-
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index eb1e0d335fc..b04c40f76bc 100644
--- a/config.c
+++ b/config.c
@@ -653,13 +653,15 @@ static int get_base_var(struct strbuf *name)
 	}
 }
 
-static int git_parse_source(config_fn_t fn, void *data)
+static int git_parse_source(config_fn_t fn, void *data,
+			    int include_section_headers)
 {
 	int comment = 0;
 	int baselen = 0;
 	struct strbuf *var = &cf->var;
 	int error_return = 0;
 	char *error_msg = NULL;
+	int saw_section_header = 0;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -685,6 +687,16 @@ static int git_parse_source(config_fn_t fn, void *data)
 			if (cf->eof)
 				return 0;
 			comment = 0;
+			if (saw_section_header) {
+				if (include_section_headers) {
+					cf->linenr--;
+					error_return = fn(var->buf, NULL, data);
+					if (error_return < 0)
+						break;
+					cf->linenr++;
+				}
+				saw_section_header = 0;
+			}
 			continue;
 		}
 		if (comment || isspace(c))
@@ -700,6 +712,7 @@ static int git_parse_source(config_fn_t fn, void *data)
 				break;
 			strbuf_addch(var, '.');
 			baselen = var->len;
+			saw_section_header = 1;
 			continue;
 		}
 		if (!isalpha(c))
@@ -1398,7 +1411,8 @@ int git_default_config(const char *var, const char *value, void *dummy)
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
+static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
+			  int include_section_headers)
 {
 	int ret;
 
@@ -1410,7 +1424,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 	strbuf_init(&top->var, 1024);
 	cf = top;
 
-	ret = git_parse_source(fn, data);
+	ret = git_parse_source(fn, data, include_section_headers);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -1423,7 +1437,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 static int do_config_from_file(config_fn_t fn,
 		const enum config_origin_type origin_type,
 		const char *name, const char *path, FILE *f,
-		void *data)
+		void *data, int include_section_headers)
 {
 	struct config_source top;
 
@@ -1436,12 +1450,12 @@ static int do_config_from_file(config_fn_t fn,
 	top.do_ungetc = config_file_ungetc;
 	top.do_ftell = config_file_ftell;
 
-	return do_config_from(&top, fn, data);
+	return do_config_from(&top, fn, data, include_section_headers);
 }
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data);
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data, 0);
 }
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -1452,7 +1466,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		flockfile(f);
-		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
+		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data, 0);
 		funlockfile(f);
 		fclose(f);
 	}
@@ -1475,7 +1489,7 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&top, fn, data);
+	return do_config_from(&top, fn, data, 0);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -2743,7 +2757,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		f = fopen_or_warn(config_filename, "r");
 		if (!f || do_config_from_file(store_aux, CONFIG_ORIGIN_FILE,
 					      config_filename, config_filename,
-					      f, NULL)) {
+					      f, NULL, 1)) {
 			error("invalid config file %s", config_filename);
 			if (store.value_regex != NULL &&
 			    store.value_regex != CONFIG_REGEX_NONE) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index ecbcc9cf3d0..867397ae930 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1463,7 +1463,7 @@ test_expect_success '--unset-all removes section if empty & uncommented' '
 	test_line_count = 0 .git/config
 '
 
-test_expect_failure 'adding a key into an empty section reuses header' '
+test_expect_success 'adding a key into an empty section reuses header' '
 	cat >.git/config <<-\EOF &&
 	[section]
 	EOF
-- 
2.16.2.windows.1.26.g2cc3565eb4b

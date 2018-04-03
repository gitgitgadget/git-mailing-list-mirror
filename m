Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9734C1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeDCQ3P (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:29:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:47169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeDCQ3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:29:14 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MPV69-1f7XX61xXl-004i38; Tue, 03 Apr 2018 18:29:05 +0200
Date:   Tue, 3 Apr 2018 18:29:04 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 14/15] git_config_set: reuse empty sections
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <000be096b9a3ece6374ca5d0bf5eb3c2a872bf2f.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JvtVtDA60PpprPSqnJiIi3Lmoyn2yzNFW9zUq+nh5WCzCblyI7e
 FmDWgN23qRZNd+V8eBRpP2Ifx7WnNNc9uReSUfxekd8vCBSuBvm6Gwr1j+VEfblKgTqaO/O
 2uSH5TLbRL9BiR05oTnvJOJHcOUbKrSGF8eyEWvbNePAxgnC/1f01h76HUiCT/WeBRXHZUw
 BX2z6ETV83+ZuTJ/m/5pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:00i1nk/Emm0=:uK37rCfdZJ4wE4UAqyhJYH
 00qcpfrgdvkIbZMabxTwJKHwGdZwrPpPuPXC6xYcK0mtuQkn1ExmKsxazUi8nm425FEy6CQVf
 +Ofy+WIJ2S1aDVkQL9rQjQrSOUNC1nNuNDLFEy1cBmGwTCABTGRCxH/UBpBNCVHhqqMXnRi2z
 b/oZeSdBNJ57RPw1PPgq96UYzXXRuG1Xg1zsW5YwU0m8W5068jUO8gq8IPAt3FiUJLsBThZT5
 qGLUZhLoj7G6vSKcRvKWPTwtTVFhtt3C5L8JOYV2OC30av76XT1Nd/Pe5M3UbB98KKYXAOjzj
 ATxKaawz3UZU+Ywn5JkLfgr7iIwr75DBp8r3bkMPh6JithoU8QL1SQEel2Zu+Iw9PwrZpzm3u
 LF1gfjFOsQPFe0ZXlqlHfCPuMDe5LT7eI8NdxQLoisl/yOELtAmX5aTuNT8zPwJAwkvV5klAi
 jdw+m2IYb+fGupF+8MApInZ7k8Vlwa1CroSYM5WiHaIGvzEaNELVWvtQJOlRXSWM1L1FB9rXx
 0QmpS/xjNizk66641vNrmL9/DyR1nbFFrhNXerAId5wHZtnTK6BHrlJ/hEUW5Ed20dtVtJHn0
 tKoQewpQmMPgJDiePtL04XIqDC9VwjRZHNyuacHjXgb2YhhuAwTwAlcLi/gfagZQrZGmhdjfN
 x1YMHzOWKzvJMRDUuuWDxzRlGQoadY7mZGLtFjASiZTR4QWDkGe/+mJkRb6D/L0i44wEdDHTf
 ksVIs+FmHuD/TbiDH1NwkRehOWnhnSaGRcxHzjLH8sCn0wXWlqhMEwoSQaNZmtb1G+yN030pc
 /SjUQsjfLQfWcCdvTiOE5eRAIhPuf/Y8D8tPofF86+0BPsVPvoGiHWW+1q7UOdzYRcU6Ls0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can happen quite easily that the last setting in a config section is
removed, and to avoid confusion when there are comments in the config
about that section, we keep a lone section header, i.e. an empty
section.

Now that we use the `event_fn` callback, it is easy to add support for
re-using empty sections, so let's do that.

Note: t5512-ls-remote requires that this change is applied *after* the
patch "git config --unset: remove empty sections (in the common case)":
without that patch, there would be empty `transfer` and `uploadpack`
sections ready for reuse, but in the *wrong* order (and sconsequently,
t5512's "overrides work between mixed transfer/upload-pack hideRefs"
would fail).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c          | 14 +++++++++++++-
 t/t1300-config.sh |  2 +-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 271e9605ec1..ee7ea24123d 100644
--- a/config.c
+++ b/config.c
@@ -2345,6 +2345,12 @@ static int store_aux_event(enum config_event_t type,
 			store->parsed[store->parsed_nr].is_keys_section =
 			cf->var.len - 1 == store->baselen &&
 			!strncasecmp(cf->var.buf, store->key, store->baselen);
+		if (store->is_keys_section) {
+			store->section_seen = 1;
+			ALLOC_GROW(store->seen, store->seen_nr + 1,
+				   store->seen_alloc);
+			store->seen[store->seen_nr] = store->parsed_nr;
+		}
 	}
 
 	store->parsed_nr++;
@@ -2779,7 +2785,13 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 			new_line = 0;
 			if (!store.key_seen) {
-				replace_end = copy_end = store.parsed[j].end;
+				copy_end = store.parsed[j].end;
+				/* include '\n' when copying section header */
+				if (copy_end > 0 && copy_end < contents_sz &&
+				    contents[copy_end - 1] != '\n' &&
+				    contents[copy_end] == '\n')
+					copy_end++;
+				replace_end = copy_end;
 			} else {
 				replace_end = store.parsed[j].end;
 				copy_end = store.parsed[j].begin;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 6d34513eedd..6d0e13020d1 100755
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

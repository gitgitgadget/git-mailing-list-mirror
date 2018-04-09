Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E3A1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeDIIci (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:46603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeDIIch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:37 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le5bY-1eiTsO1JEK-00pppo; Mon, 09
 Apr 2018 10:32:28 +0200
Date:   Mon, 9 Apr 2018 10:32:29 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 15/15] git_config_set: reuse empty sections
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <f0d3f88b7c1bf34cd880650efb11bc2a34509ab4.1523262450.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zkGHQ5TpsdzTZa4vtbW/1I2zhGjJD4mziwHh1eggvB5Tk3JdpDu
 M+8/Taenb8QGZ4+2TZVOcg82JR4n+mEwg5DtuXwpqNrCyCPjzhUUwisAu4tJJExKy6hy6oz
 VoeRzdWx34qjmS2+FWdT+g/pXBzNHZfPI3DjKv1RtUMMhDGfGWArakXBqu4AvLHKDrHaay1
 xFU+V9CutF4cZ5w3cFTPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nSikA/Ud3zU=:EcUINb75MIubU+gB/O1r7e
 avBO8goWUMyYn+6MZquczr8GOrwNhKBF7Rovs7sC8XSfciHaODNdHcf+4k18PDS4kqJWe4mPP
 AKKK7It1tv1EK8gAISJsy74kbL+Bai4NtyaSMFWvAK7wQ6j2GtxLcoT+GamQIXiS1yZf4b3H/
 oN8i0biQinIjEbum5e52zjwA1h/lgfSwk2QwzlFDW+Qi6wSiIJmSqxiXyVuUw5JJ2LTTKK0N4
 OJYx1YWu8E8sp6fhtb/UrGYQIdVDRXKUIeYLRl+f/O6jmDq/YS5e9EbdOQ3MjdlSoigq/TtbL
 hJHWu9b1wq+zJ9BaEtN3TUDFWKt+rAKmX0NiBtTeaOEZmJSFkilYVYAtLKl86W/zeUJadxQN+
 hzOJy4LT3Gq45h1sfIe8B0hRUNFh0aDGiXYnaD6bPZfQLRPu0QeKVaV+QdAlEGWN1qc640tF+
 7ZvI1/PiTMmMSJiQAnNdbHtxnbzHbDs/0PCYYKY2YTxU2wCWcY53quXL0jLxkFf+a6rcmawxu
 ZecO1RWkhJyg2PSbZOONGRuaXvudMWFGE/Qwfm76srUwD6vmUX6+VwdOV7KWjjo3GgsVKrFHj
 IrJ+DJMr+W+kZpc9gLVigaidqcobLoRXRsc0GT96HUgrL5eFf6dm0jvh2ilcJFYQI/SsFRCOy
 OWEs/mEKh4kBprP/p1Ajrfazio0Hw/JeufL9Z7tf/Uy94fOjMB7TbBYgbkuVLvXoY47frLDtg
 9ZBHVrSv3Z63TTKMA0HkCK+w/C3QWc5pyS+JImTWfyFWYSNH15hNaTysIgJIbdd/VWW+rrh9C
 4bti33p/BPzU07MWYhB1sU7aNY4kmxBDPw4cG884YLzNaCUo0Y=
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
index 2c7a10acdaa..6155d0651bd 100644
--- a/config.c
+++ b/config.c
@@ -2344,6 +2344,12 @@ static int store_aux_event(enum config_event_t type,
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
@@ -2778,7 +2784,13 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
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
index d973fd53398..eef0bbe4f9f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1506,7 +1506,7 @@ test_expect_success '--unset-all removes section if empty & uncommented' '
 	test_line_count = 0 .git/config
 '
 
-test_expect_failure 'adding a key into an empty section reuses header' '
+test_expect_success 'adding a key into an empty section reuses header' '
 	cat >.git/config <<-\EOF &&
 	[section]
 	EOF
-- 
2.17.0.windows.1.4.g7e4058d72e3

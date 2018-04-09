Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285BD1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDIIcg (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:32:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:58495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751630AbeDIIcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:32:35 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSeH-1eh6pq2rCD-00p10I; Mon, 09
 Apr 2018 10:32:23 +0200
Date:   Mon, 9 Apr 2018 10:32:24 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 14/15] git config --unset: remove empty sections (in the
 common case)
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <7f3d1b7520622801ccdf1bc9898eb7e9b4e78c8e.1523262450.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NejvNgI/SChD/CwPdeYDRz/w+DxS94muXzPLYrxZIA0wAh5o28U
 kiKaXzXbBYtLaN49hJPSFUI6OFYLvVslOEeXUZ+zUXY91iSzYhqzAzPsN+W0zembPx67tEX
 KNaeksniHLc/eF12kZu7nu0l1Dt5KTn9xELT9VcIQMwUVbHPF0glNErMO33gQZLoSMnCqeO
 ITrbV6+FFVlIulJcfJhFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FGRHTdsp8ho=:ubIqg6y8eQtlhVa/ZJ3R1r
 mBLy19LhKKe918Znft3IJz3y4aN6s28SxrqbdsdKiiAVNVhM0yBqbWLzJXFqkG3dnca5/dTGh
 3wccahGz1brYOpnoqLdgbz1cyVFesZIZo/3Gzt2SZ81Anld1wXwnnSDPdC5N+Xf3zFYyO+ZFf
 3xQ0LqnPtbxoE8f2X/U+mr46pya38dnge6cfxKJ+W/IeHXLFa1rm28zHEIWxHErWRaeARs1wp
 x3qfvK9ynLyCDaMR2IWNOk5emG4Jwe5SoKt+i4824ovHmra0Olkg9OGkZ9Mmb7kK0d2n/9b2a
 FvV3kaMsb5HPX04j6g1AmX70uoeRUWaPcHMAZAUy7vGQUrdArBJNjt3Q8A2Ckz5cUEdTWFFLJ
 3MsHxV0rgsNa/TPdaO/BMHz8rmujakSOEMN6UzEPTuoAf2N0DOPZkqChCteBN7uMggNHzbbuo
 ScKRlnu018Z8GW83+Rb2FMyGOhoT5AIVTXoHiEpscH6t0QDO1zXCmYTh3DptoJM8UPGvtn3GT
 c8SqHk7l9iGCiNiaZN7/zJhhu4qbaw7Airxet0SYMZdk0e1OB08z3PpBM4vui9nGiP00WY7XP
 kSZYAXBcYif2RnCDBBfPAcmXqxiP7WW+ofoa8eSr28hsqHQ1twaV3mCCjUmmYl+mqSEpV7fK5
 6S+uv1m2eSAe3OXbQGauf/vWzdA3kc+CZ3V0BgFPKyjgZiDyFat6gL8mh2Bg0+DD9A6TZqVkb
 0gjEfTTtt9NRxeqjYA6TUdkkIFUMtAAnxTS5uO72vzaX4kQWNwbiVBlpg1wTsKzXffVa4d8r4
 Dq4c2XzIqH9VxVAtCL1beNHZ5RruhhVnHpZ+oETEW/p1YRCIVE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original reasoning for not removing section headers upon removal of
the last entry went like this: the user could have added comments about
the section, or about the entries therein, and if there were other
comments there, we would not know whether we should remove them.

In particular, a concocted example was presented that looked like this
(and was added to t1300):

	# some generic comment on the configuration file itself
	# a comment specific to this "section" section.
	[section]
	# some intervening lines
	# that should also be dropped

	key = value
	# please be careful when you update the above variable

The ideal thing for `git config --unset section.key` in this case would
be to leave only the first line behind, because all the other comments
are now obsolete.

However, this is unfeasible, short of adding a complete Natural Language
Processing module to Git, which seems not only a lot of work, but a
totally unreasonable feature (for little benefit to most users).

Now, the real kicker about this problem is: most users do not edit their
config files at all! In their use case, the config looks like this
instead:

	[section]
		key = value

... and it is totally obvious what should happen if the entry is
removed: the entire section should vanish.

Let's generalize this observation to this conservative strategy: if we
are removing the last entry from a section, and there are no comments
inside that section nor surrounding it, then remove the entire section.
Otherwise behave as before: leave the now-empty section (including those
comments, even ones about the now-deleted entry).

We have to be extra careful to handle the case where more than one entry
is removed: any subset of them might be the last entries of their
respective sections (and if there are no comments in or around that
section, the section should be removed, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c          | 93 ++++++++++++++++++++++++++++++++++++++++++++++-
 t/t1300-config.sh |  4 +-
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 72d71fc9a4e..2c7a10acdaa 100644
--- a/config.c
+++ b/config.c
@@ -2305,6 +2305,7 @@ struct config_store_data {
 	struct {
 		size_t begin, end;
 		enum config_event_t type;
+		int is_keys_section;
 	} *parsed;
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
@@ -2333,17 +2334,20 @@ static int store_aux_event(enum config_event_t type,
 	store->parsed[store->parsed_nr].begin = begin;
 	store->parsed[store->parsed_nr].end = end;
 	store->parsed[store->parsed_nr].type = type;
-	store->parsed_nr++;
 
 	if (type == CONFIG_EVENT_SECTION) {
 		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
 			BUG("Invalid section name '%s'", cf->var.buf);
 
 		/* Is this the section we were looking for? */
-		store->is_keys_section = cf->var.len - 1 == store->baselen &&
+		store->is_keys_section =
+			store->parsed[store->parsed_nr].is_keys_section =
+			cf->var.len - 1 == store->baselen &&
 			!strncasecmp(cf->var.buf, store->key, store->baselen);
 	}
 
+	store->parsed_nr++;
+
 	return 0;
 }
 
@@ -2475,6 +2479,87 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 	return ret;
 }
 
+/*
+ * If we are about to unset the last key(s) in a section, and if there are
+ * no comments surrounding (or included in) the section, we will want to
+ * extend begin/end to remove the entire section.
+ *
+ * Note: the parameter `seen_ptr` points to the index into the store.seen
+ * array.  * This index may be incremented if a section has more than one
+ * entry (which all are to be removed).
+ */
+static void maybe_remove_section(struct config_store_data *store,
+				 const char *contents,
+				 size_t *begin_offset, size_t *end_offset,
+				 int *seen_ptr)
+{
+	size_t begin;
+	int i, seen, section_seen = 0;
+
+	/*
+	 * First, ensure that this is the first key, and that there are no
+	 * comments before the entry nor before the section header.
+	 */
+	seen = *seen_ptr;
+	for (i = store->seen[seen]; i > 0; i--) {
+		enum config_event_t type = store->parsed[i - 1].type;
+
+		if (type == CONFIG_EVENT_COMMENT)
+			/* There is a comment before this entry or section */
+			return;
+		if (type == CONFIG_EVENT_ENTRY) {
+			if (!section_seen)
+				/* This is not the section's first entry. */
+				return;
+			/* We encountered no comment before the section. */
+			break;
+		}
+		if (type == CONFIG_EVENT_SECTION) {
+			if (!store->parsed[i - 1].is_keys_section)
+				break;
+			section_seen = 1;
+		}
+	}
+	begin = store->parsed[i].begin;
+
+	/*
+	 * Next, make sure that we are removing he last key(s) in the section,
+	 * and that there are no comments that are possibly about the current
+	 * section.
+	 */
+	for (i = store->seen[seen] + 1; i < store->parsed_nr; i++) {
+		enum config_event_t type = store->parsed[i].type;
+
+		if (type == CONFIG_EVENT_COMMENT)
+			return;
+		if (type == CONFIG_EVENT_SECTION) {
+			if (store->parsed[i].is_keys_section)
+				continue;
+			break;
+		}
+		if (type == CONFIG_EVENT_ENTRY) {
+			if (++seen < store->seen_nr &&
+			    i == store->seen[seen])
+				/* We want to remove this entry, too */
+				continue;
+			/* There is another entry in this section. */
+			return;
+		}
+	}
+
+	/*
+	 * We are really removing the last entry/entries from this section, and
+	 * there are no enclosed or surrounding comments. Remove the entire,
+	 * now-empty section.
+	 */
+	*seen_ptr = seen;
+	*begin_offset = begin;
+	if (i < store->parsed_nr)
+		*end_offset = store->parsed[i].begin;
+	else
+		*end_offset = store->parsed[store->parsed_nr - 1].end;
+}
+
 int git_config_set_in_file_gently(const char *config_filename,
 				  const char *key, const char *value)
 {
@@ -2697,6 +2782,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			} else {
 				replace_end = store.parsed[j].end;
 				copy_end = store.parsed[j].begin;
+				if (!value)
+					maybe_remove_section(&store, contents,
+							     &copy_end,
+							     &replace_end, &i);
 				/*
 				 * Swallow preceding white-space on the same
 				 * line.
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9d23a8ca972..d973fd53398 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1413,7 +1413,7 @@ test_expect_success 'urlmatch with wildcard' '
 '
 
 # good section hygiene
-test_expect_failure '--unset last key removes section (except if commented)' '
+test_expect_success '--unset last key removes section (except if commented)' '
 	cat >.git/config <<-\EOF &&
 	# some generic comment on the configuration file itself
 	# a comment specific to this "section" section.
@@ -1495,7 +1495,7 @@ test_expect_failure '--unset last key removes section (except if commented)' '
 	test_line_count = 3 .git/config
 '
 
-test_expect_failure '--unset-all removes section if empty & uncommented' '
+test_expect_success '--unset-all removes section if empty & uncommented' '
 	cat >.git/config <<-\EOF &&
 	[section]
 	key = value1
-- 
2.17.0.windows.1.4.g7e4058d72e3



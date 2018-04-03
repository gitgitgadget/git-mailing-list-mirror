Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B9D1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDCQ3B (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:29:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:41307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeDCQ3A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:29:00 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M0y8F-1eF04j3FNP-00v5HC; Tue, 03 Apr 2018 18:28:50 +0200
Date:   Tue, 3 Apr 2018 18:28:50 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 13/15] git config --unset: remove empty sections (in the
 common case)
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <8046fb9c3d0af0f442ff65ce703f0898a95d8976.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OIhLo4DnpG6L7XDRHqYvGRrxZuAaPPVc8NOInH6jjmiSJN1k97x
 7PbnlzUCK32XyNhQMjr4eEEgxqoziQ99P3Ahe39atDcKwhDywhKIj9mJzOY0xRN4BjCjxbm
 fZaoq2mkHxSyI8d+g55Kz2BhURFwckcurB5fBeDV3tE19R9jL95keeAGahAQgj19nWAKfNp
 g66Xx+RCBPvyhCSW0qV1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IniVRCEQV14=:aDdsLu0WC/g+vXcWB4qnJ5
 tlgTDGIb+2+h37kbwfhmWtZ6w6bClSaZWuYhgOsomAYTX3OZL6OKMvUL3jS2HjV3yI6iM+Tej
 k6p2fMhBaGj0CTPF7zYe29aZJz+LrCqLbX8A+T362O0KQFfMPV5pS2FNqshHQJUpouILXpv+o
 fTHQp0aQQK3dnUdrnnizRLj1dsAeUsftJSO8vbF5czjaFkh9TrazCnPja9CvWyrtU/J1Yp98X
 42WYOuZpnOJJWHiPeIBElvAM8/SbdlpUQW/B2sZvPev7NVXpRpLXbndOCA7zhOETeR513MlC9
 7O3cjePDy35NtTGDLTgfn/893RDMUyrKJKp90q85sFH2ZhLJODTWdAAI4Yut/nMZ6vZtq4Hwb
 g0XNE7WjF/sL6GLGnuxwKg7snAqA7Ga3c8d+NE0WY5jjzVfPzuZHtGOcyhkV1BgeSCICsvK0W
 bW/y5a9sdzYkUgauH6KNjnNYscMM8Bv8cDfTMo9THPIchetOhoSFL0VznjbIuZ4EcAs0vpkTs
 +LP45Idyp1yJPzWBF6ir50hOMbiVTKLZOpZCW304FFHUMfzHcYAl2c9EXceYk4l0NpCFPtqxb
 xZp1B3oxWZw9n2sD4ey0/+4IntRwFkV24h2f9YThIAwAtxq69sfRYa4137KQ21SToeLUaAmDQ
 ENvpCukKhocg6sHi3ydeK4zHq91Eq1IqHYwcL0bFuHw1oBMqSmHgBtwAAsiyHytw5zbIE56S5
 C8K02MoHFLHDwzPlzuubgg+jQIhD8qowIdyuONhCTNQ54QnnKfrdovbFxdpnTesvhzaCrTgpx
 JPBuY2vOR8CGtqLm05PotugL16x3Ziw1raxwsuoLmHt4aSl8jDoi7J5XQlgBhPmNL1Gr/Fw
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
 config.c          | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 t/t1300-config.sh |  4 +--
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 345b1d2f140..271e9605ec1 100644
--- a/config.c
+++ b/config.c
@@ -2306,6 +2306,7 @@ struct config_set_store {
 	struct {
 		size_t begin, end;
 		enum config_event_t type;
+		int is_keys_section;
 	} *parsed;
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
@@ -2334,17 +2335,20 @@ static int store_aux_event(enum config_event_t type,
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
 
@@ -2476,6 +2480,87 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
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
+static void maybe_remove_section(struct config_set_store *store,
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
@@ -2698,6 +2783,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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
index 10b9bf4b088..6d34513eedd 100755
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
@@ -1452,7 +1452,7 @@ test_expect_failure '--unset last key removes section (except if commented)' '
 	test_cmp expect .git/config
 '
 
-test_expect_failure '--unset-all removes section if empty & uncommented' '
+test_expect_success '--unset-all removes section if empty & uncommented' '
 	cat >.git/config <<-\EOF &&
 	[section]
 	key = value1
-- 
2.16.2.windows.1.26.g2cc3565eb4b



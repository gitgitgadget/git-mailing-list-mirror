Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B22B1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeC2PTL (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:19:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:54719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeC2PTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:19:10 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lq9se-1eO7qX2Ubo-00dmeW; Thu, 29
 Mar 2018 17:19:01 +0200
Date:   Thu, 29 Mar 2018 17:19:00 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 7/9] git config --unset: remove empty sections (in normal
 situations)
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <c246c8bc2fb1cd6fe6307463d299cf56fbe4dc5b.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kSh6EjZ0wuyXuzGyvN11RZH037WpRTmczz45du0pioZayOvJKdL
 3LEbn6nXZs3zJXtd1U/0hLr/B4MNqWPslEHkA4hBsRCpTwPiZ7yQX+HBNf0jasjNMkeR3aN
 7eX8Kofbb2kmMttQ8/sgQ6g0qupFTO7dh3U8693MZecW/Actu09IQX7MjuGPW+lPXtbL/t1
 lAdQlit1hNvWzaJTkphMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lUohubDyqag=:ITjUZ30dy4yhf7cYD2dwK7
 22UbDIbJmDK4MuCKD6q+E/xodHbkK0e6A5DFCOyf96P3s5FOEqsb2lk/9k07BMC3Qkcc9cpbI
 i8x+NMawytRajER53v2zsWqX8syEituMWzN6S5O4cRwS8Nvxz5bItzzjBWNzlojqpagxdnMb8
 o+OKO1aQneWOHh8DmKSXZM7yE2BNsg7ThajeVjw49Xpem9IK9tYU4O37DkeGCKfWGES33AaY1
 ZlaxlJRCBZPvDkR5MAWnFWj9jz7fKoiZMgrjh43VEdbi9ZTKXf8lHfo6GxTmh6U+761uIxIbq
 A2DBP/4Ykyq8Lmtla+bQh2zloE1KY+v+DSh0QPWqRMJA57SlD6KM9zESekzpdJJvdklSYn/Qq
 FIKKWA8+PyyFE23F0yCuLd6vKvLj0gaMwrRcxFCDdZuHr5NX8dGqsR49PokkkJ34qxooamGPu
 OglzPyvvDSxB0H1VSdyElbhFjmi7HgBGfKqEdbUTOnDkkIKV+o7prSm0sNY1Xmt0w1t8AGI/a
 oy9HP7OjS0I9L3Nmh4zNTQhfglEJkyMVassMjuJY4Wq3rqJpsfCAgr53vUaCerdGqQaMGU2hZ
 rTyFNDwu5xE98w6WrjovgT51NnPnKTxSIDcGU+LKnZEVRtRcAioe2oDT6V3QO8NqzK9pCkNWJ
 dy8flCfUsnaaSxHfx/wN/KUA88HsCkrQAPTLJG4yTu0JEhUXBu4G2QIYf62GOaSxlrJbWBKw9
 bfOddFjUt3VosL3jzyPG8mhkxNNxK/Y0mU9GDTg98tiSc4gEvn7qJQqPIQ1zVGiigjuBsH2Gg
 4sT5R7uHrL/D3TsQt/pvjLnuSsWD17t7hTMBNFvz5YYOWNYFqfOh9ECYV+6KgUy3nKy16bc
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
removed.

Let's generalize this observation to this conservative strategy: if we
are removing the last entry from a section, and there are no comments
inside that section nor surrounding it, then remove the entire section.
Otherwise behave as before: leave the now-empty section (including those
comments, even the one about the now-deleted entry).

We have to be careful, though, to handle also the case where there are
*multiple* entries that are removed: any subset of them might be the last
entries of their respective sections.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c          | 181 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t1300-config.sh |   4 +-
 2 files changed, 182 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index d35dffa50de..503aef4b318 100644
--- a/config.c
+++ b/config.c
@@ -2429,6 +2429,177 @@ static ssize_t find_beginning_of_line(const char *contents, size_t size,
 	return offset;
 }
 
+/*
+ * This function determines whether the offset is in a line that starts with a
+ * comment character.
+ *
+ * Note: it does *not* report when a regular line (section header, config
+ * setting) *ends* in a comment.
+ */
+static int is_in_comment_line(const char *contents, size_t offset)
+{
+	int comment = 0;
+
+	while (offset > 0)
+		switch (contents[--offset]) {
+		case ';':
+		case '#':
+			comment = 1;
+			break;
+		case '\n':
+			break;
+		case ' ':
+		case '\t':
+			continue;
+		default:
+			comment = 0;
+		}
+
+	return comment;
+}
+
+/*
+ * If we are about to unset the last key(s) in a section, and if there are
+ * no comments surrounding (or included in) the section, we will want to
+ * extend begin/end to remove the entire section.
+ *
+ * Note: the parameter `i_ptr` points to the index into the store.offset
+ * array, reflecting the end offset of the respective entry to be deleted.
+ * This index may be incremented if a section has more than one entry (which
+ * all are to be removed).
+ */
+static void maybe_remove_section(const char *contents, size_t size,
+				 const char *section_name,
+				 size_t section_name_len,
+				 size_t *begin, int *i_ptr, int *new_line)
+{
+	size_t begin2, end2;
+	int seen_section = 0, dummy, i = *i_ptr;
+
+	/*
+	 * First, make sure that this is the last key in the section, and that
+	 * there are no comments that are possibly about the current section.
+	 */
+next_entry:
+	for (end2 = store.offset[i]; end2 < size; end2++) {
+		switch (contents[end2]) {
+		case ' ':
+		case '\t':
+		case '\n':
+			continue;
+		case '\r':
+			if (++end2 < size && contents[end2] == '\n')
+				continue;
+			break;
+		case '[':
+			/* If the section name is repeated, continue */
+			if (end2 + 1 + section_name_len < size &&
+			    contents[end2 + section_name_len] == ']' &&
+			    !memcmp(contents + end2 + 1, section_name,
+				    section_name_len)) {
+				end2 += section_name_len;
+				continue;
+			}
+			goto look_before;
+		case ';':
+		case '#':
+			/* There is a comment, cannot remove this section */
+			return;
+		default:
+			/* There are other keys in that section */
+			break;
+		}
+
+		/*
+		 * Uh oh... we found something else in this section. But do
+		 * we want to remove this, too?
+		 */
+		if (++i >= store.seen)
+			return;
+
+		begin2 = find_beginning_of_line(contents, size, store.offset[i],
+						&dummy);
+		if (begin2 > end2)
+			return;
+
+		/* Looks like we want to remove the next one, too... */
+		goto next_entry;
+	}
+
+look_before:
+	/*
+	 * Now, ensure that this is the first key, and that there are no
+	 * comments before the entry nor before the section header.
+	 */
+	for (begin2 = *begin; begin2 > 0; )
+		switch (contents[begin2 - 1]) {
+		case ' ':
+		case '\t':
+			begin2--;
+			continue;
+		case '\n':
+			if (--begin2 > 0 && contents[begin2 - 1] == '\r')
+				begin2--;
+			continue;
+		case ']':
+			if (begin2 > section_name_len + 1 &&
+			    contents[begin2 - section_name_len - 2] == '[' &&
+			    !memcmp(contents + begin2 - section_name_len - 1,
+				    section_name, section_name_len)) {
+				begin2 -= section_name_len + 2;
+				seen_section = 1;
+				continue;
+			}
+
+			/*
+			 * It looks like a section header, but it could be a
+			 * comment instead...
+			 */
+			if (is_in_comment_line(contents, begin2))
+				return;
+
+			/*
+			 * We encountered the previous section header: This
+			 * really was the only entry, so remove the entire
+			 * section.
+			 */
+			if (contents[begin2] != '\n') {
+				begin2--;
+				*new_line = 1;
+			}
+
+			store.offset[i] = end2;
+			*begin = begin2;
+			*i_ptr = i;
+			return;
+		default:
+			/*
+			 * Any other character means it is either a comment or
+			 * a config setting; if it is a comment, we do not want
+			 * to remove this section. If it is a config setting,
+			 * we only want to remove this section if this is
+			 * already the next section.
+			 */
+			if (seen_section &&
+			    !is_in_comment_line(contents, begin2)) {
+				if (contents[begin2] != '\n') {
+					begin2--;
+					*new_line = 1;
+				}
+
+				store.offset[i] = end2;
+				*begin = begin2;
+				*i_ptr = i;
+			}
+			return;
+		}
+
+	/* This section extends to the beginning of the file. */
+	store.offset[i] = end2;
+	*begin = begin2;
+	*i_ptr = i;
+}
+
 int git_config_set_in_file_gently(const char *config_filename,
 				  const char *key, const char *value)
 {
@@ -2626,10 +2797,18 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				store.offset[i] = copy_end = contents_sz;
 			} else if (store.state != KEY_SEEN) {
 				copy_end = store.offset[i];
-			} else
+			} else {
 				copy_end = find_beginning_of_line(
 					contents, contents_sz,
 					store.offset[i], &new_line);
+				if (!value)
+					maybe_remove_section(contents,
+							     contents_sz,
+							     section_name,
+							     store.baselen,
+							     &copy_end, &i,
+							     &new_line);
+			}
 
 			if (copy_end > 0 && contents[copy_end-1] != '\n')
 				new_line = 1;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index ff79a213567..ecbcc9cf3d0 100755
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



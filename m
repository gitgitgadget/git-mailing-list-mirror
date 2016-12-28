Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB37F20441
	for <e@80x24.org>; Wed, 28 Dec 2016 18:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbcL1SCL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 13:02:11 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36589 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbcL1SCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 13:02:10 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so157833204pgc.3
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 10:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D2la/aw9JUx33q8JB3CGlYv56x28WLm/9y8dxU8Z5fg=;
        b=iiOvYKKWY3Ev91b4dLuIS4fA4PyR/xiBbQdZO6wOHzkDc5X2V3UQysnf0g93jPMTui
         NLae0Lzq7RBAQF+YNFknmZ+E0j3MnQv0NqHxxdFPjk8tbVH+78TDJZQOy/MaK5ET/E8g
         SibnzXQtTZd4mSBKRC8sPFBZ/GFa4kzbkFZbpj8KmRYoQaFb+icDkletilYut28ZKYbg
         FdhJN2mapTzZ/kKyRSphCo32jRUywK/r6XUj2AVy6P2AYUYRKX+3zQhqIMJWTX9qEegj
         bU+cgW67TNKX3tVxrTkqPEnnxQdxhXQ1gzPlPU18HYx7WhSIV3zowdz3qg+B1H24yG9n
         0daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D2la/aw9JUx33q8JB3CGlYv56x28WLm/9y8dxU8Z5fg=;
        b=qjypxTSna2r8xMUBDLN7YxrJIgWJrVaxLaTRs0cxjjtL1t2TrSXICLquZFRRIiNMM8
         CEtJG8jvwVCMO+/4PH+SP5TxiVbcU8fIixICZotjZIhnyX0XaSV9ibRjo0MKQ5U1kvVf
         1ux5Oy5OdrG6ivdiyuFGfHdHrs2I0CdoT/6uFS3FB6ZyWhtRgOx+l3gNQnTXk8XpjqP7
         sTojAWcmmFhbbKXSaT6sWUX8ZnSUgyqdCXI/6Xfzooji9RXSXsU/sXqShvqsAeO2WPJm
         dKzFmXzCm4Oh84posjqcggiZz7FAam99fogcxLTwA248f5RVajH87FXjoPzXnC6U5AfT
         +Rqw==
X-Gm-Message-State: AIkVDXL0N6UcAUmyVleJSdgc9yoeFgm3DEKAB4Pb8PkDZXltjWjtvRGB7USQ31Oy/X3G4hwW
X-Received: by 10.84.232.141 with SMTP id i13mr37122427plk.73.1482948129367;
        Wed, 28 Dec 2016 10:02:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:d4d5:954a:76bf:2d18])
        by smtp.gmail.com with ESMTPSA id r8sm57776583pfa.44.2016.12.28.10.02.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Dec 2016 10:02:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] contrib: remove git-convert-objects
Date:   Wed, 28 Dec 2016 10:02:05 -0800
Message-Id: <20161228180205.29213-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.ga95e92af08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-convert-objects, originally named git-convert-cache was used in
early 2005 to convert to a new repository format, e.g. adding an author
date.

By now the need for conversion of the very early repositories is less
relevant, we no longer need to keep it in contrib; remove it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/convert-objects/convert-objects.c       | 329 ------------------------
 contrib/convert-objects/git-convert-objects.txt |  29 ---
 2 files changed, 358 deletions(-)
 delete mode 100644 contrib/convert-objects/convert-objects.c
 delete mode 100644 contrib/convert-objects/git-convert-objects.txt

diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
deleted file mode 100644
index f3b57bf1d2..0000000000
--- a/contrib/convert-objects/convert-objects.c
+++ /dev/null
@@ -1,329 +0,0 @@
-#include "cache.h"
-#include "blob.h"
-#include "commit.h"
-#include "tree.h"
-
-struct entry {
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
-	int converted;
-};
-
-#define MAXOBJECTS (1000000)
-
-static struct entry *convert[MAXOBJECTS];
-static int nr_convert;
-
-static struct entry * convert_entry(unsigned char *sha1);
-
-static struct entry *insert_new(unsigned char *sha1, int pos)
-{
-	struct entry *new = xcalloc(1, sizeof(struct entry));
-	hashcpy(new->old_sha1, sha1);
-	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
-	convert[pos] = new;
-	nr_convert++;
-	if (nr_convert == MAXOBJECTS)
-		die("you're kidding me - hit maximum object limit");
-	return new;
-}
-
-static struct entry *lookup_entry(unsigned char *sha1)
-{
-	int low = 0, high = nr_convert;
-
-	while (low < high) {
-		int next = (low + high) / 2;
-		struct entry *n = convert[next];
-		int cmp = hashcmp(sha1, n->old_sha1);
-		if (!cmp)
-			return n;
-		if (cmp < 0) {
-			high = next;
-			continue;
-		}
-		low = next+1;
-	}
-	return insert_new(sha1, low);
-}
-
-static void convert_binary_sha1(void *buffer)
-{
-	struct entry *entry = convert_entry(buffer);
-	hashcpy(buffer, entry->new_sha1);
-}
-
-static void convert_ascii_sha1(void *buffer)
-{
-	unsigned char sha1[20];
-	struct entry *entry;
-
-	if (get_sha1_hex(buffer, sha1))
-		die("expected sha1, got '%s'", (char *) buffer);
-	entry = convert_entry(sha1);
-	memcpy(buffer, sha1_to_hex(entry->new_sha1), 40);
-}
-
-static unsigned int convert_mode(unsigned int mode)
-{
-	unsigned int newmode;
-
-	newmode = mode & S_IFMT;
-	if (S_ISREG(mode))
-		newmode |= (mode & 0100) ? 0755 : 0644;
-	return newmode;
-}
-
-static int write_subdirectory(void *buffer, unsigned long size, const char *base, int baselen, unsigned char *result_sha1)
-{
-	char *new = xmalloc(size);
-	unsigned long newlen = 0;
-	unsigned long used;
-
-	used = 0;
-	while (size) {
-		int len = 21 + strlen(buffer);
-		char *path = strchr(buffer, ' ');
-		unsigned char *sha1;
-		unsigned int mode;
-		char *slash, *origpath;
-
-		if (!path || strtoul_ui(buffer, 8, &mode))
-			die("bad tree conversion");
-		mode = convert_mode(mode);
-		path++;
-		if (memcmp(path, base, baselen))
-			break;
-		origpath = path;
-		path += baselen;
-		slash = strchr(path, '/');
-		if (!slash) {
-			newlen += sprintf(new + newlen, "%o %s", mode, path);
-			new[newlen++] = '\0';
-			hashcpy((unsigned char *)new + newlen, (unsigned char *) buffer + len - 20);
-			newlen += 20;
-
-			used += len;
-			size -= len;
-			buffer = (char *) buffer + len;
-			continue;
-		}
-
-		newlen += sprintf(new + newlen, "%o %.*s", S_IFDIR, (int)(slash - path), path);
-		new[newlen++] = 0;
-		sha1 = (unsigned char *)(new + newlen);
-		newlen += 20;
-
-		len = write_subdirectory(buffer, size, origpath, slash-origpath+1, sha1);
-
-		used += len;
-		size -= len;
-		buffer = (char *) buffer + len;
-	}
-
-	write_sha1_file(new, newlen, tree_type, result_sha1);
-	free(new);
-	return used;
-}
-
-static void convert_tree(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	void *orig_buffer = buffer;
-	unsigned long orig_size = size;
-
-	while (size) {
-		size_t len = 1+strlen(buffer);
-
-		convert_binary_sha1((char *) buffer + len);
-
-		len += 20;
-		if (len > size)
-			die("corrupt tree object");
-		size -= len;
-		buffer = (char *) buffer + len;
-	}
-
-	write_subdirectory(orig_buffer, orig_size, "", 0, result_sha1);
-}
-
-static unsigned long parse_oldstyle_date(const char *buf)
-{
-	char c, *p;
-	char buffer[100];
-	struct tm tm;
-	const char *formats[] = {
-		"%c",
-		"%a %b %d %T",
-		"%Z",
-		"%Y",
-		" %Y",
-		NULL
-	};
-	/* We only ever did two timezones in the bad old format .. */
-	const char *timezones[] = {
-		"PDT", "PST", "CEST", NULL
-	};
-	const char **fmt = formats;
-
-	p = buffer;
-	while (isspace(c = *buf))
-		buf++;
-	while ((c = *buf++) != '\n')
-		*p++ = c;
-	*p++ = 0;
-	buf = buffer;
-	memset(&tm, 0, sizeof(tm));
-	do {
-		const char *next = strptime(buf, *fmt, &tm);
-		if (next) {
-			if (!*next)
-				return mktime(&tm);
-			buf = next;
-		} else {
-			const char **p = timezones;
-			while (isspace(*buf))
-				buf++;
-			while (*p) {
-				if (!memcmp(buf, *p, strlen(*p))) {
-					buf += strlen(*p);
-					break;
-				}
-				p++;
-			}
-		}
-		fmt++;
-	} while (*buf && *fmt);
-	printf("left: %s\n", buf);
-	return mktime(&tm);
-}
-
-static int convert_date_line(char *dst, void **buf, unsigned long *sp)
-{
-	unsigned long size = *sp;
-	char *line = *buf;
-	char *next = strchr(line, '\n');
-	char *date = strchr(line, '>');
-	int len;
-
-	if (!next || !date)
-		die("missing or bad author/committer line %s", line);
-	next++; date += 2;
-
-	*buf = next;
-	*sp = size - (next - line);
-
-	len = date - line;
-	memcpy(dst, line, len);
-	dst += len;
-
-	/* Is it already in new format? */
-	if (isdigit(*date)) {
-		int datelen = next - date;
-		memcpy(dst, date, datelen);
-		return len + datelen;
-	}
-
-	/*
-	 * Hacky hacky: one of the sparse old-style commits does not have
-	 * any date at all, but we can fake it by using the committer date.
-	 */
-	if (*date == '\n' && strchr(next, '>'))
-		date = strchr(next, '>')+2;
-
-	return len + sprintf(dst, "%lu -0700\n", parse_oldstyle_date(date));
-}
-
-static void convert_date(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	char *new = xmalloc(size + 100);
-	unsigned long newlen = 0;
-
-	/* "tree <sha1>\n" */
-	memcpy(new + newlen, buffer, 46);
-	newlen += 46;
-	buffer = (char *) buffer + 46;
-	size -= 46;
-
-	/* "parent <sha1>\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
-		memcpy(new + newlen, buffer, 48);
-		newlen += 48;
-		buffer = (char *) buffer + 48;
-		size -= 48;
-	}
-
-	/* "author xyz <xyz> date" */
-	newlen += convert_date_line(new + newlen, &buffer, &size);
-	/* "committer xyz <xyz> date" */
-	newlen += convert_date_line(new + newlen, &buffer, &size);
-
-	/* Rest */
-	memcpy(new + newlen, buffer, size);
-	newlen += size;
-
-	write_sha1_file(new, newlen, commit_type, result_sha1);
-	free(new);
-}
-
-static void convert_commit(void *buffer, unsigned long size, unsigned char *result_sha1)
-{
-	void *orig_buffer = buffer;
-	unsigned long orig_size = size;
-
-	if (memcmp(buffer, "tree ", 5))
-		die("Bad commit '%s'", (char *) buffer);
-	convert_ascii_sha1((char *) buffer + 5);
-	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
-	while (!memcmp(buffer, "parent ", 7)) {
-		convert_ascii_sha1((char *) buffer + 7);
-		buffer = (char *) buffer + 48;
-	}
-	convert_date(orig_buffer, orig_size, result_sha1);
-}
-
-static struct entry * convert_entry(unsigned char *sha1)
-{
-	struct entry *entry = lookup_entry(sha1);
-	enum object_type type;
-	void *buffer, *data;
-	unsigned long size;
-
-	if (entry->converted)
-		return entry;
-	data = read_sha1_file(sha1, &type, &size);
-	if (!data)
-		die("unable to read object %s", sha1_to_hex(sha1));
-
-	buffer = xmalloc(size);
-	memcpy(buffer, data, size);
-
-	if (type == OBJ_BLOB) {
-		write_sha1_file(buffer, size, blob_type, entry->new_sha1);
-	} else if (type == OBJ_TREE)
-		convert_tree(buffer, size, entry->new_sha1);
-	else if (type == OBJ_COMMIT)
-		convert_commit(buffer, size, entry->new_sha1);
-	else
-		die("unknown object type %d in %s", type, sha1_to_hex(sha1));
-	entry->converted = 1;
-	free(buffer);
-	free(data);
-	return entry;
-}
-
-int main(int argc, char **argv)
-{
-	unsigned char sha1[20];
-	struct entry *entry;
-
-	setup_git_directory();
-
-	if (argc != 2)
-		usage("git-convert-objects <sha1>");
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	entry = convert_entry(sha1);
-	printf("new sha1: %s\n", sha1_to_hex(entry->new_sha1));
-	return 0;
-}
diff --git a/contrib/convert-objects/git-convert-objects.txt b/contrib/convert-objects/git-convert-objects.txt
deleted file mode 100644
index f871880cfb..0000000000
--- a/contrib/convert-objects/git-convert-objects.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-git-convert-objects(1)
-======================
-
-NAME
-----
-git-convert-objects - Converts old-style git repository
-
-
-SYNOPSIS
---------
-[verse]
-'git-convert-objects'
-
-DESCRIPTION
------------
-Converts old-style git repository to the latest format
-
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the linkgit:git[7] suite
-- 
2.11.0.259.ga95e92af08


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29E72047F
	for <e@80x24.org>; Tue, 26 Sep 2017 11:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030384AbdIZLWk (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 07:22:40 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:45933 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968100AbdIZLWi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 07:22:38 -0400
Received: by mail-wr0-f181.google.com with SMTP id m18so12841247wrm.2
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYuVZ+oH3iL4xoGSyVVHLgszfrYuxlW+UanPcJaKWR4=;
        b=OWxTyEteqNM2BnILpwhbMyWh6H/ge4ofSYefrmng1ntIgd75+UGeYWlYwANc5wFor4
         NrX+/T04jbAK2cpWXJ8cliPO8kXQq7CRkpvE9mzy/7w1LpZ/492DO4SPOur2Fhq1ekey
         RTrbV/mIQLtOQGtuWm4jV0XdVmu6WX9PeavKcnTD4cYxge8GX7B9mdLmmmvNCeM4yBpE
         Vryc2L2hDFHftJ2l5+BDcg/BiSGUL7tIcM9bCrBxqp7Q7gzPPanJaVbVqConlmiuD/gE
         fOSFWUEmJ6KUEMEjOJHCQRMgCraPFo3U6JZzDDtPurPPGpxC2aayZxvs1/CX6REWhSUR
         Vw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYuVZ+oH3iL4xoGSyVVHLgszfrYuxlW+UanPcJaKWR4=;
        b=XyqtOPV/a+iBDrU3kcrlafC3kLi/cJxI4VdyKRsQtCRY1M+ymxwUcfsaF2EY8O98KU
         AncB9uZyyiIZ4JEF+p2X9DNgLYYY8jKDXVwRTW3aRxuiNahKoqtiCRuEnJj3+jbVDG9u
         T2sQu9/3Le5ZfQ+3UL2wQHk0WqCoF6ZIrswVy0sLVDVenlZz01x0/sKlGnQoj3VlGpBz
         PiVdkqAjhlVvfaREEHxaG7hJPrtC3NpWTM/6juGGj0Is+HZDN5MfVRLQfS8c53iRy/2o
         OwVJHSZwlS2OtNLp6EbQkQtzhQwo5PkYdecfLqwSH27c8aYqccXyXX2T3ZEH5JIloMov
         6nJQ==
X-Gm-Message-State: AHPjjUhOQoQFViIMWkpyTU7KABzfuZ+AdLT59OxcwJWDyiz/J9h/8wTC
        KJBo8NBepxEmKhurrP6YU/d+A9H/SnU=
X-Google-Smtp-Source: AOwi7QAGnQSGpBBed0YlxNgUgwC7FVNqvVjIo/6lSRTvCEPdbnK+ZlTEJJGm4lbY/887t0OQssSv5w==
X-Received: by 10.223.134.93 with SMTP id 29mr9931665wrw.60.1506424955865;
        Tue, 26 Sep 2017 04:22:35 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id f19sm15854873wrf.85.2017.09.26.04.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 04:22:34 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 3/3] string-list.h: move documentation from Documentation/api/ into header
Date:   Tue, 26 Sep 2017 13:21:50 +0200
Message-Id: <20170926112150.21850-4-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170926112150.21850-1-hanwen@google.com>
References: <20170926112150.21850-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This mirrors commit 'bdfdaa497 ("strbuf.h: integrate api-strbuf.txt
documentation, 2015-01-16") which did the same for strbuf.h:

* API documentation uses /** */ to set it apart from other comments.

* Function names were stripped from the comments.

* Ordering of the header was adjusted to follow the one from the text
  file.

* Edited some existing comments from string-list.h for consistency.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/api-string-list.txt | 209 ----------------------------
 string-list.h                               | 192 +++++++++++++++++++++----
 2 files changed, 162 insertions(+), 239 deletions(-)
 delete mode 100644 Documentation/technical/api-string-list.txt

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
deleted file mode 100644
index c08402b12..000000000
--- a/Documentation/technical/api-string-list.txt
+++ /dev/null
@@ -1,209 +0,0 @@
-string-list API
-===============
-
-The string_list API offers a data structure and functions to handle
-sorted and unsorted string lists.  A "sorted" list is one whose
-entries are sorted by string value in `strcmp()` order.
-
-The 'string_list' struct used to be called 'path_list', but was renamed
-because it is not specific to paths.
-
-The caller:
-
-. Allocates and clears a `struct string_list` variable.
-
-. Initializes the members. You might want to set the flag `strdup_strings`
-  if the strings should be strdup()ed. For example, this is necessary
-  when you add something like git_path("..."), since that function returns
-  a static buffer that will change with the next call to git_path().
-+
-If you need something advanced, you can manually malloc() the `items`
-member (you need this if you add things later) and you should set the
-`nr` and `alloc` members in that case, too.
-
-. Adds new items to the list, using `string_list_append`,
-  `string_list_append_nodup`, `string_list_insert`,
-  `string_list_split`, and/or `string_list_split_in_place`.
-
-. Can check if a string is in the list using `string_list_has_string` or
-  `unsorted_string_list_has_string` and get it from the list using
-  `string_list_lookup` for sorted lists.
-
-. Can sort an unsorted list using `string_list_sort`.
-
-. Can remove duplicate items from a sorted list using
-  `string_list_remove_duplicates`.
-
-. Can remove individual items of an unsorted list using
-  `unsorted_string_list_delete_item`.
-
-. Can remove items not matching a criterion from a sorted or unsorted
-  list using `filter_string_list`, or remove empty strings using
-  `string_list_remove_empty_items`.
-
-. Finally it should free the list using `string_list_clear`.
-
-Example:
-
-----
-struct string_list list = STRING_LIST_INIT_NODUP;
-int i;
-
-string_list_append(&list, "foo");
-string_list_append(&list, "bar");
-for (i = 0; i < list.nr; i++)
-	printf("%s\n", list.items[i].string)
-----
-
-NOTE: It is more efficient to build an unsorted list and sort it
-afterwards, instead of building a sorted list (`O(n log n)` instead of
-`O(n^2)`).
-+
-However, if you use the list to check if a certain string was added
-already, you should not do that (using unsorted_string_list_has_string()),
-because the complexity would be quadratic again (but with a worse factor).
-
-Functions
----------
-
-* General ones (works with sorted and unsorted lists as well)
-
-`string_list_init`::
-
-	Initialize the members of the string_list, set `strdup_strings`
-	member according to the value of the second parameter.
-
-`filter_string_list`::
-
-	Apply a function to each item in a list, retaining only the
-	items for which the function returns true.  If free_util is
-	true, call free() on the util members of any items that have
-	to be deleted.  Preserve the order of the items that are
-	retained.
-
-`string_list_remove_empty_items`::
-
-	Remove any empty strings from the list.  If free_util is true,
-	call free() on the util members of any items that have to be
-	deleted.  Preserve the order of the items that are retained.
-
-`print_string_list`::
-
-	Dump a string_list to stdout, useful mainly for debugging purposes. It
-	can take an optional header argument and it writes out the
-	string-pointer pairs of the string_list, each one in its own line.
-
-`string_list_clear`::
-
-	Free a string_list. The `string` pointer of the items will be freed in
-	case the `strdup_strings` member of the string_list is set. The second
-	parameter controls if the `util` pointer of the items should be freed
-	or not.
-
-* Functions for sorted lists only
-
-`string_list_has_string`::
-
-	Determine if the string_list has a given string or not.
-
-`string_list_insert`::
-
-	Insert a new element to the string_list. The returned pointer can be
-	handy if you want to write something to the `util` pointer of the
-	string_list_item containing the just added string. If the given
-	string already exists the insertion will be skipped and the
-	pointer to the existing item returned.
-+
-Since this function uses xrealloc() (which die()s if it fails) if the
-list needs to grow, it is safe not to check the pointer. I.e. you may
-write `string_list_insert(...)->util = ...;`.
-
-`string_list_lookup`::
-
-	Look up a given string in the string_list, returning the containing
-	string_list_item. If the string is not found, NULL is returned.
-
-`string_list_remove_duplicates`::
-
-	Remove all but the first of consecutive entries that have the
-	same string value.  If free_util is true, call free() on the
-	util members of any items that have to be deleted.
-
-* Functions for unsorted lists only
-
-`string_list_append`::
-
-	Append a new string to the end of the string_list.  If
-	`strdup_string` is set, then the string argument is copied;
-	otherwise the new `string_list_entry` refers to the input
-	string.
-
-`string_list_append_nodup`::
-
-	Append a new string to the end of the string_list.  The new
-	`string_list_entry` always refers to the input string, even if
-	`strdup_string` is set.  This function can be used to hand
-	ownership of a malloc()ed string to a `string_list` that has
-	`strdup_string` set.
-
-`string_list_sort`::
-
-	Sort the list's entries by string value in `strcmp()` order.
-
-`unsorted_string_list_has_string`::
-
-	It's like `string_list_has_string()` but for unsorted lists.
-
-`unsorted_string_list_lookup`::
-
-	It's like `string_list_lookup()` but for unsorted lists.
-+
-The above two functions need to look through all items, as opposed to their
-counterpart for sorted lists, which performs a binary search.
-
-`unsorted_string_list_delete_item`::
-
-	Remove an item from a string_list. The `string` pointer of the items
-	will be freed in case the `strdup_strings` member of the string_list
-	is set. The third parameter controls if the `util` pointer of the
-	items should be freed or not.
-
-`string_list_split`::
-`string_list_split_in_place`::
-
-	Split a string into substrings on a delimiter character and
-	append the substrings to a `string_list`.  If `maxsplit` is
-	non-negative, then split at most `maxsplit` times.  Return the
-	number of substrings appended to the list.
-+
-`string_list_split` requires a `string_list` that has `strdup_strings`
-set to true; it leaves the input string untouched and makes copies of
-the substrings in newly-allocated memory.
-`string_list_split_in_place` requires a `string_list` that has
-`strdup_strings` set to false; it splits the input string in place,
-overwriting the delimiter characters with NULs and creating new
-string_list_items that point into the original string (the original
-string must therefore not be modified or freed while the `string_list`
-is in use).
-
-
-Data structures
----------------
-
-* `struct string_list_item`
-
-Represents an item of the list. The `string` member is a pointer to the
-string, and you may use the `util` member for any purpose, if you want.
-
-* `struct string_list`
-
-Represents the list itself.
-
-. The array of items are available via the `items` member.
-. The `nr` member contains the number of items stored in the list.
-. The `alloc` member is used to avoid reallocating at every insertion.
-  You should not tamper with it.
-. Setting the `strdup_strings` member to 1 will strdup() the strings
-  before adding them, see above.
-. The `compare_strings_fn` member is used to specify a custom compare
-  function, otherwise `strcmp()` is used as the default function.
diff --git a/string-list.h b/string-list.h
index 79ae567cb..ff8f6094a 100644
--- a/string-list.h
+++ b/string-list.h
@@ -1,6 +1,69 @@
 #ifndef STRING_LIST_H
 #define STRING_LIST_H
 
+/**
+ * The string_list API offers a data structure and functions to handle
+ * sorted and unsorted arrays of strings.  A "sorted" list is one whose
+ * entries are sorted by string value in `strcmp()` order.
+ *
+ * The caller:
+ *
+ * . Allocates and clears a `struct string_list` variable.
+ *
+ * . Initializes the members. You might want to set the flag `strdup_strings`
+ *   if the strings should be strdup()ed. For example, this is necessary
+ *   when you add something like git_path("..."), since that function returns
+ *   a static buffer that will change with the next call to git_path().
+ *
+ * If you need something advanced, you can manually malloc() the `items`
+ * member (you need this if you add things later) and you should set the
+ * `nr` and `alloc` members in that case, too.
+ *
+ * . Adds new items to the list, using `string_list_append`,
+ *   `string_list_append_nodup`, `string_list_insert`,
+ *   `string_list_split`, and/or `string_list_split_in_place`.
+ *
+ * . Can check if a string is in the list using `string_list_has_string` or
+ *   `unsorted_string_list_has_string` and get it from the list using
+ *   `string_list_lookup` for sorted lists.
+ *
+ * . Can sort an unsorted list using `string_list_sort`.
+ *
+ * . Can remove duplicate items from a sorted list using
+ *   `string_list_remove_duplicates`.
+ *
+ * . Can remove individual items of an unsorted list using
+ *   `unsorted_string_list_delete_item`.
+ *
+ * . Can remove items not matching a criterion from a sorted or unsorted
+ *   list using `filter_string_list`, or remove empty strings using
+ *   `string_list_remove_empty_items`.
+ *
+ * . Finally it should free the list using `string_list_clear`.
+ *
+ * Example:
+ *
+ *     struct string_list list = STRING_LIST_INIT_NODUP;
+ *     int i;
+ *
+ *     string_list_append(&list, "foo");
+ *     string_list_append(&list, "bar");
+ *     for (i = 0; i < list.nr; i++)
+ *             printf("%s\n", list.items[i].string)
+ *
+ * NOTE: It is more efficient to build an unsorted list and sort it
+ * afterwards, instead of building a sorted list (`O(n log n)` instead of
+ * `O(n^2)`).
+ *
+ * However, if you use the list to check if a certain string was added
+ * already, you should not do that (using unsorted_string_list_has_string()),
+ * because the complexity would be quadratic again (but with a worse factor).
+ */
+
+/**
+ * Represents an item of the list. The `string` member is a pointer to the
+ * string, and you may use the `util` member for any purpose, if you want.
+ */
 struct string_list_item {
 	char *string;
 	void *util;
@@ -8,6 +71,18 @@ struct string_list_item {
 
 typedef int (*compare_strings_fn)(const char *, const char *);
 
+/**
+ * Represents the list itself.
+ *
+ * . The array of items are available via the `items` member.
+ * . The `nr` member contains the number of items stored in the list.
+ * . The `alloc` member is used to avoid reallocating at every insertion.
+ *   You should not tamper with it.
+ * . Setting the `strdup_strings` member to 1 will strdup() the strings
+ *   before adding them, see above.
+ * . The `compare_strings_fn` member is used to specify a custom compare
+ *   function, otherwise `strcmp()` is used as the default function.
+ */
 struct string_list {
 	struct string_list_item *items;
 	unsigned int nr, alloc;
@@ -18,35 +93,65 @@ struct string_list {
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
 #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
 
+/* General functions which work with both sorted and unsorted lists. */
+
+/**
+ * Initialize the members of the string_list, set `strdup_strings`
+ * member according to the value of the second parameter.
+ */
 void string_list_init(struct string_list *list, int strdup_strings);
 
+/** Callback function type for for_each_string_list */
+typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
+
+/**
+ * Apply `want` to each item in `list`, retaining only the ones for which
+ * the function returns true.  If `free_util` is true, call free() on
+ * the util members of any items that have to be deleted.  Preserve
+ * the order of the items that are retained.
+ */
+void filter_string_list(struct string_list *list, int free_util,
+			string_list_each_func_t want, void *cb_data);
+
+/**
+ * Dump a string_list to stdout, useful mainly for debugging
+ * purposes. It can take an optional header argument and it writes out
+ * the string-pointer pairs of the string_list, each one in its own
+ * line.
+ */
 void print_string_list(const struct string_list *p, const char *text);
+
+/**
+ * Free a string_list. The `string` pointer of the items will be freed
+ * in case the `strdup_strings` member of the string_list is set. The
+ * second parameter controls if the `util` pointer of the items should
+ * be freed or not.
+ */
 void string_list_clear(struct string_list *list, int free_util);
 
-/* Use this function to call a custom clear function on each util pointer */
-/* The string associated with the util pointer is passed as the second argument */
+/**
+ * Callback type for `string_list_clear_func`.  The string associated
+ * with the util pointer is passed as the second argument
+ */
 typedef void (*string_list_clear_func_t)(void *p, const char *str);
+
+/** Call a custom clear function on each util pointer */
 void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
 
-/* Use this function or the macro below to iterate over each item */
-typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
+/**
+ * Apply `func` to each item. If `func` returns nonzero, the
+ * iteration aborts and the return value is propagated.
+ */
 int for_each_string_list(struct string_list *list,
-			 string_list_each_func_t, void *cb_data);
+			 string_list_each_func_t func, void *cb_data);
+
+/** Iterate over each item, as a macro. */
 #define for_each_string_list_item(item,list)            \
 	for (item = (list)->items;                      \
 	     item && item < (list)->items + (list)->nr; \
 	     ++item)
 
-/*
- * Apply want to each item in list, retaining only the ones for which
- * the function returns true.  If free_util is true, call free() on
- * the util members of any items that have to be deleted.  Preserve
- * the order of the items that are retained.
- */
-void filter_string_list(struct string_list *list, int free_util,
-			string_list_each_func_t want, void *cb_data);
-
-/*
+/**
  * Remove any empty strings from the list.  If free_util is true, call
  * free() on the util members of any items that have to be deleted.
  * Preserve the order of the items that are retained.
@@ -54,25 +159,34 @@ void filter_string_list(struct string_list *list, int free_util,
 void string_list_remove_empty_items(struct string_list *list, int free_util);
 
 /* Use these functions only on sorted lists: */
+
+/** Determine if the string_list has a given string or not. */
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
 				  int negative_existing_index);
-/*
- * Inserts the given string into the sorted list.
- * If the string already exists, the list is not altered.
- * Returns the string_list_item, the string is part of.
+
+/**
+ * Insert a new element to the string_list. The returned pointer can
+ * be handy if you want to write something to the `util` pointer of
+ * the string_list_item containing the just added string. If the given
+ * string already exists the insertion will be skipped and the pointer
+ * to the existing item returned.
+ *
+ * Since this function uses xrealloc() (which die()s if it fails) if the
+ * list needs to grow, it is safe not to check the pointer. I.e. you may
+ * write `string_list_insert(...)->util = ...;`.
  */
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
 
-/*
- * Removes the given string from the sorted list.
- * If the string doesn't exist, the list is not altered.
+/**
+ * Remove the given string from the sorted list.  If the string
+ * doesn't exist, the list is not altered.
  */
 extern void string_list_remove(struct string_list *list, const char *string,
 			       int free_util);
 
-/*
- * Checks if the given string is part of a sorted list. If it is part of the list,
+/**
+ * Check if the given string is part of a sorted list. If it is part of the list,
  * return the coresponding string_list_item, NULL otherwise.
  */
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
@@ -87,14 +201,14 @@ void string_list_remove_duplicates(struct string_list *sorted_list, int free_uti
 
 /* Use these functions only on unsorted lists: */
 
-/*
+/**
  * Add string to the end of list.  If list->strdup_string is set, then
  * string is copied; otherwise the new string_list_entry refers to the
  * input string.
  */
 struct string_list_item *string_list_append(struct string_list *list, const char *string);
 
-/*
+/**
  * Like string_list_append(), except string is never copied.  When
  * list->strdup_strings is set, this function can be used to hand
  * ownership of a malloc()ed string to list without making an extra
@@ -102,16 +216,34 @@ struct string_list_item *string_list_append(struct string_list *list, const char
  */
 struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
 
+/**
+ * Sort the list's entries by string value in `strcmp()` order.
+ */
 void string_list_sort(struct string_list *list);
+
+/**
+ * Like `string_list_has_string()` but for unsorted lists. Linear in
+ * size of the list.
+ */
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
+
+/**
+ * Like `string_list_lookup()` but for unsorted lists. Linear in size
+ * of the list.
+ */
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
-
+/**
+ * Remove an item from a string_list. The `string` pointer of the
+ * items will be freed in case the `strdup_strings` member of the
+ * string_list is set. The third parameter controls if the `util`
+ * pointer of the items should be freed or not.
+ */
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 
-/*
- * Split string into substrings on character delim and append the
- * substrings to list.  The input string is not modified.
+/**
+ * Split string into substrings on character `delim` and append the
+ * substrings to `list`.  The input string is not modified.
  * list->strdup_strings must be set, as new memory needs to be
  * allocated to hold the substrings.  If maxsplit is non-negative,
  * then split at most maxsplit times.  Return the number of substrings
-- 
2.14.1.821.g8fa685d3b7-goog


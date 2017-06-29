Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A366E202AB
	for <e@80x24.org>; Thu, 29 Jun 2017 23:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdF2Xxs (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 19:53:48 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36842 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdF2Xxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 19:53:45 -0400
Received: by mail-pf0-f180.google.com with SMTP id q86so57875264pfl.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 16:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgHSRT1+AOMpkA52HwgehnXHy1rIk/LVXC1eTExRUIQ=;
        b=e+fZawkLufDwI6vYQhBJD/e7AeRWfaAcNmZt9AFh5CtPw2NyAH51e8fG9K223+JY45
         X1ZQN9Aza1qvs20gi+si3WZDVAKcEe4IagVKTzV09PPhnB1IzG1+F35xG9vxjBp+zCMe
         PXtxdIx8ysaJ2TMiL+jmlMkz4emTgWtR0ICkvHY/v29Y7126AfY36jAZmQ21x6N79zwZ
         rI2qcr3VlU+PejrEK5K+swO6xGQJhkwxJd1Qpc+0QFPw3KVB1r29DFMrhgZ+Q47q+/jM
         PyJaCI8LBD2oFhkZmteYaQQQ2dkvBrDIVycRzkBGtjVTbqOYVM22zGqKXR7aW0TnGeMN
         ZQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lgHSRT1+AOMpkA52HwgehnXHy1rIk/LVXC1eTExRUIQ=;
        b=PtNx7tlW3snKkBzdkI7nGOH4oKsWBGDqbRp66OQLHgikkFg5eWsUOIT1hHH6Ybbb1j
         ajCkk2Fh5B0hEG8ph5fqCBeYlupZNl2f4F5RruEHNbWX2tWvnhyyTqcf+ZqBusqJMlVy
         Ocm4pKJN+tR6TwGYNdBeN3HjIOFpIrpiWcCbEa+059X7rt+gwYxdDrS9lFFbTrbLZVxR
         ucH37ob4Xj6UmPvcVD+CAjdwgIzFBtngihUo2AAKS1kf/Y8SQN0w6SC7ukNOv/xy1IfD
         jiHbbHOxJFHw0wEDqkQ6QIQfYd+ekDdHTKo9K1jSSDWXUoBNcT1ptcNA2GXn4iSH2GJP
         cWwQ==
X-Gm-Message-State: AKS2vOxyL7j2OP7eTVeNUKxBDAtBDUqFezqIf73rdkaqTUkoiOm1OWQo
        kQzTCK4ThQGveEQI
X-Received: by 10.98.129.196 with SMTP id t187mr19444090pfd.0.1498780424029;
        Thu, 29 Jun 2017 16:53:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id d185sm10510384pgc.39.2017.06.29.16.53.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 16:53:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCHv2 2/2] hashmap: migrate documentation from Documentation/technical into header
Date:   Thu, 29 Jun 2017 16:53:36 -0700
Message-Id: <20170629235336.28460-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170629235336.28460-1-sbeller@google.com>
References: <20170629011334.11173-1-sbeller@google.com>
 <20170629235336.28460-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it, clarify the use of `key`, `keydata`, `entry_or_key` as well
as documenting the new data pointer for the compare function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-hashmap.txt | 309 ----------------------------
 hashmap.h                               | 351 +++++++++++++++++++++++++++++---
 2 files changed, 318 insertions(+), 342 deletions(-)
 delete mode 100644 Documentation/technical/api-hashmap.txt

diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
deleted file mode 100644
index ccc634bbd7..0000000000
--- a/Documentation/technical/api-hashmap.txt
+++ /dev/null
@@ -1,309 +0,0 @@
-hashmap API
-===========
-
-The hashmap API is a generic implementation of hash-based key-value mappings.
-
-Data Structures
----------------
-
-`struct hashmap`::
-
-	The hash table structure. Members can be used as follows, but should
-	not be modified directly:
-+
-The `size` member keeps track of the total number of entries (0 means the
-hashmap is empty).
-+
-`tablesize` is the allocated size of the hash table. A non-0 value indicates
-that the hashmap is initialized. It may also be useful for statistical purposes
-(i.e. `size / tablesize` is the current load factor).
-+
-`cmpfn` stores the comparison function specified in `hashmap_init()`. In
-advanced scenarios, it may be useful to change this, e.g. to switch between
-case-sensitive and case-insensitive lookup.
-+
-When `disallow_rehash` is set, automatic rehashes are prevented during inserts
-and deletes.
-
-`struct hashmap_entry`::
-
-	An opaque structure representing an entry in the hash table, which must
-	be used as first member of user data structures. Ideally it should be
-	followed by an int-sized member to prevent unused memory on 64-bit
-	systems due to alignment.
-+
-The `hash` member is the entry's hash code and the `next` member points to the
-next entry in case of collisions (i.e. if multiple entries map to the same
-bucket).
-
-`struct hashmap_iter`::
-
-	An iterator structure, to be used with hashmap_iter_* functions.
-
-Types
------
-
-`int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key, const void *keydata)`::
-
-	User-supplied function to test two hashmap entries for equality. Shall
-	return 0 if the entries are equal.
-+
-This function is always called with non-NULL `entry` / `entry_or_key`
-parameters that have the same hash code. When looking up an entry, the `key`
-and `keydata` parameters to hashmap_get and hashmap_remove are always passed
-as second and third argument, respectively. Otherwise, `keydata` is NULL.
-
-Functions
----------
-
-`unsigned int strhash(const char *buf)`::
-`unsigned int strihash(const char *buf)`::
-`unsigned int memhash(const void *buf, size_t len)`::
-`unsigned int memihash(const void *buf, size_t len)`::
-`unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len)`::
-
-	Ready-to-use hash functions for strings, using the FNV-1 algorithm (see
-	http://www.isthe.com/chongo/tech/comp/fnv).
-+
-`strhash` and `strihash` take 0-terminated strings, while `memhash` and
-`memihash` operate on arbitrary-length memory.
-+
-`strihash` and `memihash` are case insensitive versions.
-+
-`memihash_cont` is a variant of `memihash` that allows a computation to be
-continued with another chunk of data.
-
-`unsigned int sha1hash(const unsigned char *sha1)`::
-
-	Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
-	for use in hash tables. Cryptographic hashes are supposed to have
-	uniform distribution, so in contrast to `memhash()`, this just copies
-	the first `sizeof(int)` bytes without shuffling any bits. Note that
-	the results will be different on big-endian and little-endian
-	platforms, so they should not be stored or transferred over the net.
-
-`void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function, size_t initial_size)`::
-
-	Initializes a hashmap structure.
-+
-`map` is the hashmap to initialize.
-+
-The `equals_function` can be specified to compare two entries for equality.
-If NULL, entries are considered equal if their hash codes are equal.
-+
-If the total number of entries is known in advance, the `initial_size`
-parameter may be used to preallocate a sufficiently large table and thus
-prevent expensive resizing. If 0, the table is dynamically resized.
-
-`void hashmap_free(struct hashmap *map, int free_entries)`::
-
-	Frees a hashmap structure and allocated memory.
-+
-`map` is the hashmap to free.
-+
-If `free_entries` is true, each hashmap_entry in the map is freed as well
-(using stdlib's free()).
-
-`void hashmap_entry_init(void *entry, unsigned int hash)`::
-
-	Initializes a hashmap_entry structure.
-+
-`entry` points to the entry to initialize.
-+
-`hash` is the hash code of the entry.
-+
-The hashmap_entry structure does not hold references to external resources,
-and it is safe to just discard it once you are done with it (i.e. if
-your structure was allocated with xmalloc(), you can just free(3) it,
-and if it is on stack, you can just let it go out of scope).
-
-`void *hashmap_get(const struct hashmap *map, const void *key, const void *keydata)`::
-
-	Returns the hashmap entry for the specified key, or NULL if not found.
-+
-`map` is the hashmap structure.
-+
-`key` is a hashmap_entry structure (or user data structure that starts with
-hashmap_entry) that has at least been initialized with the proper hash code
-(via `hashmap_entry_init`).
-+
-If an entry with matching hash code is found, `key` and `keydata` are passed
-to `hashmap_cmp_fn` to decide whether the entry matches the key.
-
-`void *hashmap_get_from_hash(const struct hashmap *map, unsigned int hash, const void *keydata)`::
-
-	Returns the hashmap entry for the specified hash code and key data,
-	or NULL if not found.
-+
-`map` is the hashmap structure.
-+
-`hash` is the hash code of the entry to look up.
-+
-If an entry with matching hash code is found, `keydata` is passed to
-`hashmap_cmp_fn` to decide whether the entry matches the key. The
-`entry_or_key` parameter points to a bogus hashmap_entry structure that
-should not be used in the comparison.
-
-`void *hashmap_get_next(const struct hashmap *map, const void *entry)`::
-
-	Returns the next equal hashmap entry, or NULL if not found. This can be
-	used to iterate over duplicate entries (see `hashmap_add`).
-+
-`map` is the hashmap structure.
-+
-`entry` is the hashmap_entry to start the search from, obtained via a previous
-call to `hashmap_get` or `hashmap_get_next`.
-
-`void hashmap_add(struct hashmap *map, void *entry)`::
-
-	Adds a hashmap entry. This allows to add duplicate entries (i.e.
-	separate values with the same key according to hashmap_cmp_fn).
-+
-`map` is the hashmap structure.
-+
-`entry` is the entry to add.
-
-`void *hashmap_put(struct hashmap *map, void *entry)`::
-
-	Adds or replaces a hashmap entry. If the hashmap contains duplicate
-	entries equal to the specified entry, only one of them will be replaced.
-+
-`map` is the hashmap structure.
-+
-`entry` is the entry to add or replace.
-+
-Returns the replaced entry, or NULL if not found (i.e. the entry was added).
-
-`void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)`::
-
-	Removes a hashmap entry matching the specified key. If the hashmap
-	contains duplicate entries equal to the specified key, only one of
-	them will be removed.
-+
-`map` is the hashmap structure.
-+
-`key` is a hashmap_entry structure (or user data structure that starts with
-hashmap_entry) that has at least been initialized with the proper hash code
-(via `hashmap_entry_init`).
-+
-If an entry with matching hash code is found, `key` and `keydata` are
-passed to `hashmap_cmp_fn` to decide whether the entry matches the key.
-+
-Returns the removed entry, or NULL if not found.
-
-`void hashmap_disallow_rehash(struct hashmap *map, unsigned value)`::
-
-	Disallow/allow automatic rehashing of the hashmap during inserts
-	and deletes.
-+
-This is useful if the caller knows that the hashmap will be accessed
-by multiple threads.
-+
-The caller is still responsible for any necessary locking; this simply
-prevents unexpected rehashing.  The caller is also responsible for properly
-sizing the initial hashmap to ensure good performance.
-+
-A call to allow rehashing does not force a rehash; that might happen
-with the next insert or delete.
-
-`void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter)`::
-`void *hashmap_iter_next(struct hashmap_iter *iter)`::
-`void *hashmap_iter_first(struct hashmap *map, struct hashmap_iter *iter)`::
-
-	Used to iterate over all entries of a hashmap. Note that it is
-	not safe to add or remove entries to the hashmap while
-	iterating.
-+
-`hashmap_iter_init` initializes a `hashmap_iter` structure.
-+
-`hashmap_iter_next` returns the next hashmap_entry, or NULL if there are no
-more entries.
-+
-`hashmap_iter_first` is a combination of both (i.e. initializes the iterator
-and returns the first entry, if any).
-
-`const char *strintern(const char *string)`::
-`const void *memintern(const void *data, size_t len)`::
-
-	Returns the unique, interned version of the specified string or data,
-	similar to the `String.intern` API in Java and .NET, respectively.
-	Interned strings remain valid for the entire lifetime of the process.
-+
-Can be used as `[x]strdup()` or `xmemdupz` replacement, except that interned
-strings / data must not be modified or freed.
-+
-Interned strings are best used for short strings with high probability of
-duplicates.
-+
-Uses a hashmap to store the pool of interned strings.
-
-Usage example
--------------
-
-Here's a simple usage example that maps long keys to double values.
-------------
-struct hashmap map;
-
-struct long2double {
-	struct hashmap_entry ent; /* must be the first member! */
-	long key;
-	double value;
-};
-
-static int long2double_cmp(const struct long2double *e1, const struct long2double *e2, const void *unused)
-{
-	return !(e1->key == e2->key);
-}
-
-void long2double_init(void)
-{
-	hashmap_init(&map, (hashmap_cmp_fn) long2double_cmp, 0);
-}
-
-void long2double_free(void)
-{
-	hashmap_free(&map, 1);
-}
-
-static struct long2double *find_entry(long key)
-{
-	struct long2double k;
-	hashmap_entry_init(&k, memhash(&key, sizeof(long)));
-	k.key = key;
-	return hashmap_get(&map, &k, NULL);
-}
-
-double get_value(long key)
-{
-	struct long2double *e = find_entry(key);
-	return e ? e->value : 0;
-}
-
-void set_value(long key, double value)
-{
-	struct long2double *e = find_entry(key);
-	if (!e) {
-		e = malloc(sizeof(struct long2double));
-		hashmap_entry_init(e, memhash(&key, sizeof(long)));
-		e->key = key;
-		hashmap_add(&map, e);
-	}
-	e->value = value;
-}
-------------
-
-Using variable-sized keys
--------------------------
-
-The `hashmap_entry_get` and `hashmap_entry_remove` functions expect an ordinary
-`hashmap_entry` structure as key to find the correct entry. If the key data is
-variable-sized (e.g. a FLEX_ARRAY string) or quite large, it is undesirable
-to create a full-fledged entry structure on the heap and copy all the key data
-into the structure.
-
-In this case, the `keydata` parameter can be used to pass
-variable-sized key data directly to the comparison function, and the `key`
-parameter can be a stripped-down, fixed size entry structure allocated on the
-stack.
-
-See test-hashmap.c for an example using arbitrary-length strings as keys.
diff --git a/hashmap.h b/hashmap.h
index 1c26bbad5b..2e0adbe5df 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -3,17 +3,123 @@
 
 /*
  * Generic implementation of hash-based key-value mappings.
- * See Documentation/technical/api-hashmap.txt.
+ *
+ * An example that maps long to a string:
+ * For the sake of the example this allows to lookup exact values, too
+ * (i.e. it is operated as a set, the value is part of the key)
+ * -------------------------------------
+ *
+ * struct hashmap map;
+ * struct long2string {
+ *     struct hashmap_entry ent; // must be the first member!
+ *     long key;
+ *     char value[FLEX_ARRAY];   // be careful with allocating on stack!
+ * };
+ *
+ * #define COMPARE_VALUE 1
+ *
+ * static int long2string_cmp(const struct long2string *e1,
+ *                            const struct long2string *e2,
+ *                            const void *keydata, const void *userdata)
+ * {
+ *     char *string = keydata;
+ *     unsigned *flags = (unsigned*)userdata;
+ *
+ *     if (flags & COMPARE_VALUE)
+ *         return !(e1->key == e2->key) || (keydata ?
+ *                  strcmp(e1->value, keydata) : strcmp(e1->value, e2->value));
+ *     else
+ *         return !(e1->key == e2->key);
+ * }
+ *
+ * int main(int argc, char **argv)
+ * {
+ *     long key;
+ *     char *value, *action;
+ *
+ *     unsigned flags = ALLOW_DUPLICATE_KEYS;
+ *
+ *     hashmap_init(&map, (hashmap_cmp_fn) long2string_cmp, &flags, 0);
+ *
+ *     while (scanf("%s %l %s", action, key, value)) {
+ *
+ *         if (!strcmp("add", action)) {
+ *             struct long2string *e;
+ *             e = malloc(sizeof(struct long2string) + strlen(value));
+ *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
+ *             e->key = key;
+ *             memcpy(e->value, value, strlen(value));
+ *             hashmap_add(&map, e);
+ *         }
+ *
+ *         if (!strcmp("print_all_by_key", action)) {
+ *             flags &= ~COMPARE_VALUE;
+ *
+ *             struct long2string k;
+ *             hashmap_entry_init(&k, memhash(&key, sizeof(long)));
+ *             k.key = key;
+ *
+ *             struct long2string *e = hashmap_get(&map, &k, NULL);
+ *             if (e) {
+ *                 printf("first: %l %s\n", e->key, e->value);
+ *                 while (e = hashmap_get_next(&map, e))
+ *                     printf("found more: %l %s\n", e->key, e->value);
+ *             }
+ *         }
+ *
+ *         if (!strcmp("has_exact_match", action)) {
+ *             flags |= COMPARE_VALUE;
+ *
+ *             struct long2string *e;
+ *             e = malloc(sizeof(struct long2string) + strlen(value));
+ *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
+ *             e->key = key;
+ *             memcpy(e->value, value, strlen(value));
+ *
+ *             printf("%s found\n", hashmap_get(&map, e, NULL) ? "" : "not");
+ *         }
+ *
+ *         if (!strcmp("has_exact_match_no_heap_alloc", action)) {
+ *             flags |= COMPARE_VALUE;
+ *
+ *             struct long2string e;
+ *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
+ *             e.key = key;
+ *
+ *             printf("%s found\n", hashmap_get(&map, e, value) ? "" : "not");
+ *         }
+ *
+ *         if (!strcmp("end", action)) {
+ *             hashmap_free(&map, 1);
+ *             break;
+ *         }
+ *     }
+ * }
  */
 
-/* FNV-1 functions */
-
+/*
+ * Ready-to-use hash functions for strings, using the FNV-1 algorithm (see
+ * http://www.isthe.com/chongo/tech/comp/fnv).
+ * `strhash` and `strihash` take 0-terminated strings, while `memhash` and
+ * `memihash` operate on arbitrary-length memory.
+ * `strihash` and `memihash` are case insensitive versions.
+ * `memihash_cont` is a variant of `memihash` that allows a computation to be
+ * continued with another chunk of data.
+ */
 extern unsigned int strhash(const char *buf);
 extern unsigned int strihash(const char *buf);
 extern unsigned int memhash(const void *buf, size_t len);
 extern unsigned int memihash(const void *buf, size_t len);
 extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
 
+/*
+ * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
+ * for use in hash tables. Cryptographic hashes are supposed to have
+ * uniform distribution, so in contrast to `memhash()`, this just copies
+ * the first `sizeof(int)` bytes without shuffling any bits. Note that
+ * the results will be different on big-endian and little-endian
+ * platforms, so they should not be stored or transferred over the net.
+ */
 static inline unsigned int sha1hash(const unsigned char *sha1)
 {
 	/*
@@ -25,89 +131,255 @@ static inline unsigned int sha1hash(const unsigned char *sha1)
 	return hash;
 }
 
-/* data structures */
-
+/*
+ * struct hashmap_entry is an opaque structure representing an entry in the
+ * hash table, which must be used as first member of user data structures.
+ * Ideally it should be followed by an int-sized member to prevent unused
+ * memory on 64-bit systems due to alignment.
+ */
 struct hashmap_entry {
+	/*
+	 * next points to the next entry in case of collisions (i.e. if
+	 * multiple entries map to the same bucket)
+	 */
 	struct hashmap_entry *next;
+
+	/* entry's hash code */
 	unsigned int hash;
 };
 
+/*
+ * User-supplied function to test two hashmap entries for equality. Shall
+ * return 0 if the entries are equal.
+ *
+ * This function is always called with non-NULL `entry` and `entry_or_key`
+ * parameters that have the same hash code.
+ *
+ * When looking up an entry, the `key` and `keydata` parameters to hashmap_get
+ * and hashmap_remove are always passed as second `entry_or_key` and third
+ * argument `keydata`, respectively. Otherwise, `keydata` is NULL.
+ *
+ * When it is too expensive to allocate a user entry (either because it is
+ * large or varialbe sized, such that it is not on the stack), then the
+ * relevant data to check for equality should be passed via `keydata`.
+ * In this case `key` can be a stripped down version of the user key data
+ * or even just a hashmap_entry having the correct hash.
+ *
+ * The `data` entry is the pointer given in the init function and is always
+ * given.
+ */
 typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
-		const void *keydata, const void *cbdata);
+		const void *keydata, const void *data);
 
+/*
+ * struct hashmap is the hash table structure. Members can be used as follows,
+ * but should not be modified directly.
+ */
 struct hashmap {
 	struct hashmap_entry **table;
+
+	/* Stores the comparison function specified in `hashmap_init()`. */
 	hashmap_cmp_fn cmpfn;
 	const void *data;
-	unsigned int size, tablesize, grow_at, shrink_at;
-	unsigned disallow_rehash : 1;
-};
 
-struct hashmap_iter {
-	struct hashmap *map;
-	struct hashmap_entry *next;
-	unsigned int tablepos;
+	/* total number of entries (0 means the hashmap is empty) */
+	unsigned int size;
+
+	/*
+	 * tablesize is the allocated size of the hash table. A non-0 value
+	 * indicates that the hashmap is initialized. It may also be useful
+	 * for statistical purposes (i.e. `size / tablesize` is the current
+	 * load factor).
+	 */
+	unsigned int tablesize;
+
+	unsigned int grow_at;
+	unsigned int shrink_at;
+
+	/* See `hashmap_disallow_rehash`. */
+	unsigned disallow_rehash : 1;
 };
 
 /* hashmap functions */
 
+/*
+ * Initializes a hashmap structure.
+ *
+ * `map` is the hashmap to initialize.
+ *
+ * The `equals_function` can be specified to compare two entries for equality.
+ * If NULL, entries are considered equal if their hash codes are equal.
+ *
+ * The `data` parameter can be used to provide additional data (a callback
+ * cookie) that will be passed to `equals_function` each time it is called.
+ * This allows a single `equals_function` to implement multiple comparison
+ * functions.
+ *
+ * If the total number of entries is known in advance, the `initial_size`
+ * parameter may be used to preallocate a sufficiently large table and thus
+ * prevent expensive resizing. If 0, the table is dynamically resized.
+ */
 extern void hashmap_init(struct hashmap *map,
 			 hashmap_cmp_fn equals_function,
 			 const void *data,
 			 size_t initial_size);
+
+/*
+ * Frees a hashmap structure and allocated memory.
+ *
+ * If `free_entries` is true, each hashmap_entry in the map is freed as well
+ * using stdlibs free().
+ */
 extern void hashmap_free(struct hashmap *map, int free_entries);
 
 /* hashmap_entry functions */
 
+/*
+ * Initializes a hashmap_entry structure.
+ *
+ * `entry` points to the entry to initialize.
+ * `hash` is the hash code of the entry.
+ *
+ * The hashmap_entry structure does not hold references to external resources,
+ * and it is safe to just discard it once you are done with it (i.e. if
+ * your structure was allocated with xmalloc(), you can just free(3) it,
+ * and if it is on stack, you can just let it go out of scope).
+ */
 static inline void hashmap_entry_init(void *entry, unsigned int hash)
 {
 	struct hashmap_entry *e = entry;
 	e->hash = hash;
 	e->next = NULL;
 }
+
+/*
+ * Returns the hashmap entry for the specified key, or NULL if not found.
+ *
+ * `map` is the hashmap structure.
+ *
+ * `key` is a user data structure that starts with hashmap_entry that has at
+ * least been initialized with the proper hash code (via `hashmap_entry_init`).
+ *
+ * `keydata` is a data structure that holds just enough information to check
+ * for equality to a given entry.
+ *
+ * If the key data is variable-sized (e.g. a FLEX_ARRAY string) or quite large,
+ * it is undesirable to create a full-fledged entry structure on the heap and
+ * copy all the key data into the structure.
+ *
+ * In this case, the `keydata` parameter can be used to pass
+ * variable-sized key data directly to the comparison function, and the `key`
+ * parameter can be a stripped-down, fixed size entry structure allocated on the
+ * stack.
+ *
+ * If an entry with matching hash code is found, `key` and `keydata` are passed
+ * to `hashmap_cmp_fn` to decide whether the entry matches the key.
+ */
 extern void *hashmap_get(const struct hashmap *map, const void *key,
-		const void *keydata);
-extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
-extern void hashmap_add(struct hashmap *map, void *entry);
-extern void *hashmap_put(struct hashmap *map, void *entry);
-extern void *hashmap_remove(struct hashmap *map, const void *key,
-		const void *keydata);
+			 const void *keydata);
 
+/*
+ * Returns the hashmap entry for the specified hash code and key data,
+ * or NULL if not found.
+ *
+ * `map` is the hashmap structure.
+ * `hash` is the hash code of the entry to look up.
+ *
+ * If an entry with matching hash code is found, `keydata` is passed to
+ * `hashmap_cmp_fn` to decide whether the entry matches the key. The
+ * `entry_or_key` parameter of `hashmap_cmp_fn` points to a hashmap_entry
+ * structure that should not be used in the comparison.
+ */
 static inline void *hashmap_get_from_hash(const struct hashmap *map,
-		unsigned int hash, const void *keydata)
+					  unsigned int hash,
+					  const void *keydata)
 {
 	struct hashmap_entry key;
 	hashmap_entry_init(&key, hash);
 	return hashmap_get(map, &key, keydata);
 }
 
+/*
+ * Returns the next equal hashmap entry, or NULL if not found. This can be
+ * used to iterate over duplicate entries (see `hashmap_add`).
+ *
+ * `map` is the hashmap structure.
+ * `entry` is the hashmap_entry to start the search from, obtained via a previous
+ * call to `hashmap_get` or `hashmap_get_next`.
+ */
+extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
+
+/*
+ * Adds a hashmap entry. This allows to add duplicate entries (i.e.
+ * separate values with the same key according to hashmap_cmp_fn).
+ *
+ * `map` is the hashmap structure.
+ * `entry` is the entry to add.
+ */
+extern void hashmap_add(struct hashmap *map, void *entry);
+
+/*
+ * Adds or replaces a hashmap entry. If the hashmap contains duplicate
+ * entries equal to the specified entry, only one of them will be replaced.
+ *
+ * `map` is the hashmap structure.
+ * `entry` is the entry to add or replace.
+ * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
+ */
+extern void *hashmap_put(struct hashmap *map, void *entry);
+
+/*
+ * Removes a hashmap entry matching the specified key. If the hashmap contains
+ * duplicate entries equal to the specified key, only one of them will be
+ * removed. Returns the removed entry, or NULL if not found.
+ *
+ * Argument explanation is the same as in `hashmap_get`.
+ */
+extern void *hashmap_remove(struct hashmap *map, const void *key,
+		const void *keydata);
+
+/*
+ * Returns the `bucket` an entry is stored in.
+ * Useful for multithreaded read access.
+ */
 int hashmap_bucket(const struct hashmap *map, unsigned int hash);
 
 /*
  * Disallow/allow rehashing of the hashmap.
- * This is useful if the caller knows that the hashmap
- * needs multi-threaded access.  The caller is still
- * required to guard/lock searches and inserts in a
- * manner appropriate to their usage.  This simply
- * prevents the table from being unexpectedly re-mapped.
+ * This is useful if the caller knows that the hashmap needs multi-threaded
+ * access.  The caller is still required to guard/lock searches and inserts
+ * in a manner appropriate to their usage.  This simply prevents the table
+ * from being unexpectedly re-mapped.
  *
- * If is up to the caller to ensure that the hashmap is
- * initialized to a reasonable size to prevent poor
- * performance.
+ * It is up to the caller to ensure that the hashmap is initialized to a
+ * reasonable size to prevent poor performance.
  *
- * When value=1, prevent future rehashes on adds and deleted.
- * When value=0, allow future rehahses.  This DOES NOT force
- * a rehash now.
+ * A call to allow rehashing does not force a rehash; that might happen
+ * with the next insert or delete.
  */
 static inline void hashmap_disallow_rehash(struct hashmap *map, unsigned value)
 {
 	map->disallow_rehash = value;
 }
 
-/* hashmap_iter functions */
+/*
+ * Used to iterate over all entries of a hashmap. Note that it is
+ * not safe to add or remove entries to the hashmap while
+ * iterating.
+ */
+struct hashmap_iter {
+	struct hashmap *map;
+	struct hashmap_entry *next;
+	unsigned int tablepos;
+};
 
+/* Initializes a `hashmap_iter` structure. */
 extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
+
+/* Returns the next hashmap_entry, or NULL if there are no more entries. */
 extern void *hashmap_iter_next(struct hashmap_iter *iter);
+
+/* Initializes the iterator and returns the first entry, if any. */
 static inline void *hashmap_iter_first(struct hashmap *map,
 		struct hashmap_iter *iter)
 {
@@ -115,8 +387,21 @@ static inline void *hashmap_iter_first(struct hashmap *map,
 	return hashmap_iter_next(iter);
 }
 
-/* string interning */
+/* String interning */
 
+/*
+ * Returns the unique, interned version of the specified string or data,
+ * similar to the `String.intern` API in Java and .NET, respectively.
+ * Interned strings remain valid for the entire lifetime of the process.
+ *
+ * Can be used as `[x]strdup()` or `xmemdupz` replacement, except that interned
+ * strings / data must not be modified or freed.
+ *
+ * Interned strings are best used for short strings with high probability of
+ * duplicates.
+ *
+ * Uses a hashmap to store the pool of interned strings.
+ */
 extern const void *memintern(const void *data, size_t len);
 static inline const char *strintern(const char *string)
 {
-- 
2.13.0.31.g9b732c453e


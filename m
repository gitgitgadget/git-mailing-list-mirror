Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43342ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiIIOdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiIIOdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA5F10D8
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bq9so3087017wrb.4
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=XHxgGRQJzAUl3pVjpDj316DM9RlQdujLRhYoXnqT/nA=;
        b=AVyBs3SB3jy5xqATW08iPMMuGRfoA7ne1WJdaibIgkPODZXvLome6JlUROyPTCymjS
         hOnQqV+RhF2hZ0Fcbf1ZqmPwNll7hwGqv9+7Z/JUg0IdtfnVwb88iiF0p9UJFATp0QkY
         sp9d1bbdX1GGONNw0rEeThy1YKz1jP8FYJbFrxo+SgBDtOUc0hUGVq1ivy3tgHNqdVMI
         cEsXeO4uxobuGaOum9gHPkh0VD3XaNVvx/VXWdUdffp1GejBWdQdLNedl3u2N3r5WR8d
         XK484UQ8YJejr02i9HaovhiRFebhPgVTR6RxFRfiINS5o0KX1TcChfiT8Np2vCrd4AiY
         pPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XHxgGRQJzAUl3pVjpDj316DM9RlQdujLRhYoXnqT/nA=;
        b=Su9m63xvh/IqsTpo0FPBKsrS5jYyIMPvJYmgHOacsA9KdqPWAgX3ohxvlzQ05L6Vg0
         7oG5H2QNMpejfh3EiDpBaa7T5W43Xooyi+TxrJvFvQOYn1/OJMufzZtgJvUkrGLL4fxa
         tdWIhP/VfFak9szUYcXMxi3xjqWL6Mj7W3rmLZbB7Nq2rW9x+HzHEc56k5LxWKW6LqrB
         81pYul+zJfD6tPvEY78iVOim02lX6TD9lOlst0ndf/dC6oaHc3qUQymdqKTkiUGo6jgV
         QupzOuVjgoPONG5VlQjwPbVcC6Pr3ZCqbhkFBePHK2guHODTvNlo1CqpgUoYWrvsgFO2
         kMgQ==
X-Gm-Message-State: ACgBeo2bc+am8Sk5kdZBf3ZqqK7t1Q/rfEq2vhxYLJ2mf5QyuCgasV/Y
        vOxiQkVWf/hpHQos/WIXDFmIAcPBz6k=
X-Google-Smtp-Source: AA6agR6eHpRlzSAq445JLmAeN2E1mHiBF9qdFhi+LBWbVAXw78ykNa/ePG6geaq7nsKdhx3EnQcm7g==
X-Received: by 2002:a5d:5d89:0:b0:226:e5ca:4bc2 with SMTP id ci9-20020a5d5d89000000b00226e5ca4bc2mr8283541wrb.310.1662734017977;
        Fri, 09 Sep 2022 07:33:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4104000000b0022584c82c80sm701548wrp.19.2022.09.09.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:37 -0700 (PDT)
Message-Id: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:26 +0000
Subject: [PATCH v2 0/9] Bundle URIs III: Parse and download from bundle lists
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third series building the bundle URI feature. It is built on top
of ds/bundle-uri-clone, which introduced 'git clone --bundle-uri=' where is
a URI to a bundle file. This series adds the capability of downloading and
parsing a bundle list and then downloading the URIs in that list.

The core functionality of bundle lists is implemented by creating data
structures from a list of key-value pairs. These pairs can come from a
plain-text file in Git config format, but in the future, we will support the
list being supplied by packet lines over Git's protocol v2 in the
'bundle-uri' command (reserved for the next series).

The patches are organized in this way:

 1. Patches 1-2 are cleanups from the previous part. The first was
    recommended by Teng Long and the second allows us to simplify our bundle
    list data structure slightly.

 2. Patches 3-4 create the bundle list data structures and the logic for
    populating the list from key-value pairs.

 3. Patches 5-6 teach Git to parse "key=value" lines to construct a bundle
    list. Add unit tests that ensure this logic constructs lists correctly.
    These patches are adapted from Ævar's RFC [1] and were previously seen
    in my combined RFC [2].

 4. Patch 7 teaches Git to parse Git config files into bundle lists.

 5. Patches 8-9 implement the ability to download a bundle list and
    recursively download the contained bundles (and possibly the bundle
    lists within). This is limited by a constant depth to avoid issues with
    cycles or otherwise incorrectly configured bundle lists.

[1]
https://lore.kernel.org/git/RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com/

[2]
https://lore.kernel.org/git/pull.1234.git.1653072042.gitgitgadget@gmail.com/

At the end of this series, users can bootstrap clones using 'git clone
--bundle-uri= ' where points to a bundle list instead of a single bundle
file.

As outlined in the design document [1], the next steps after this are:

 1. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option). [2]
 2. Implement the 'creationToken' heuristic, allowing incremental 'git
    fetch' commands to download a bundle list from a configured URI, and
    only download bundles that are new based on the creation token values.
    [3]

I have prepared some of this work as pull requests on my personal fork so
curious readers can look ahead to where we are going:

[3]
https://lore.kernel.org/git/pull.1248.v3.git.1658757188.gitgitgadget@gmail.com

[4] https://github.com/derrickstolee/git/pull/21

[5] https://github.com/derrickstolee/git/pull/22


Updates in v2
=============

Thank you to all of the voices who chimed in on the previous version. I'm
sorry it took so long for me to get a new version.

 * I've done a rather thorough overhaul to minimize how often later patches
   rewrite portions of earlier patches.

 * We no longer use a strbuf in struct remote_bundle_info. Instead, use a
   'char *' and only in the patch where it is first used.

 * The config documentation is more clearly indicating that the bundle.*
   section has no effect in the repository config (at the moment, which will
   change in the next series).

 * The bundle.version value is now parsed using git_parse_int().

 * The config key is now parsed using parse_config_key().

 * Commit messages clarify more about the context of the change in the
   bigger picture of the bundle URI effort.

 * Some printf()s are correctly changed to fprintf()s.

 * The test helper CLI is unified across the two modes. They both take a
   filename now.

 * The count of downloaded bundles is now only updated after a successful
   download, allowing the "any" mode to keep trying after a failure.

Thanks,

 * Stolee

Derrick Stolee (7):
  bundle-uri: short-circuit capability parsing
  bundle-uri: use plain string in find_temp_filename()
  bundle-uri: create bundle_list struct and helpers
  bundle-uri: create base key-value pair parsing
  bundle-uri: parse bundle list in config format
  bundle-uri: limit recursion depth for bundle lists
  bundle-uri: fetch a list of bundles

Ævar Arnfjörð Bjarmason (2):
  bundle-uri: create "key=value" line parsing
  bundle-uri: unit test "key=value" parsing

 Documentation/config.txt        |   2 +
 Documentation/config/bundle.txt |  24 ++
 Makefile                        |   1 +
 bundle-uri.c                    | 466 ++++++++++++++++++++++++++++++--
 bundle-uri.h                    |  93 +++++++
 config.c                        |   2 +-
 config.h                        |   1 +
 t/helper/test-bundle-uri.c      |  95 +++++++
 t/helper/test-tool.c            |   1 +
 t/helper/test-tool.h            |   1 +
 t/t5558-clone-bundle-uri.sh     |  93 +++++++
 t/t5750-bundle-uri-parse.sh     | 171 ++++++++++++
 t/test-lib-functions.sh         |  11 +
 13 files changed, 942 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/config/bundle.txt
 create mode 100644 t/helper/test-bundle-uri.c
 create mode 100755 t/t5750-bundle-uri-parse.sh


base-commit: e21e663cd1942df29979d3e01f7eacb532727bb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1333%2Fderrickstolee%2Fbundle-redo%2Flist-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1333/derrickstolee/bundle-redo/list-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1333

Range-diff vs v1:

  -:  ----------- >  1:  2ca431e6c37 bundle-uri: short-circuit capability parsing
  -:  ----------- >  2:  ee6c4b824c2 bundle-uri: use plain string in find_temp_filename()
  1:  c3943888658 !  3:  d9812440594 bundle-uri: create bundle_list struct and helpers
     @@ bundle-uri.c
      +static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
      +				    void *data)
      +{
     -+	free(bundle->id);
     -+	free(bundle->uri);
     -+	strbuf_release(&bundle->file);
     ++	FREE_AND_NULL(bundle->id);
     ++	FREE_AND_NULL(bundle->uri);
      +	return 0;
      +}
      +
     @@ bundle-uri.c
      +	return 0;
      +}
       
     - static int find_temp_filename(struct strbuf *name)
     + static char *find_temp_filename(void)
       {
      
       ## bundle-uri.h ##
     @@ bundle-uri.h
      +	 * if there was no table of contents.
      +	 */
      +	char *uri;
     -+
     -+	/**
     -+	 * If the bundle has been downloaded, then 'file' is a
     -+	 * filename storing its contents. Otherwise, 'file' is
     -+	 * an empty string.
     -+	 */
     -+	struct strbuf file;
      +};
      +
     -+#define REMOTE_BUNDLE_INFO_INIT { \
     -+	.file = STRBUF_INIT, \
     -+}
     ++#define REMOTE_BUNDLE_INFO_INIT { 0 }
      +
      +enum bundle_list_mode {
      +	BUNDLE_MODE_NONE = 0,
  2:  7e4e4656e53 !  4:  70daef66833 bundle-uri: create base key-value pair parsing
     @@ Commit message
            currently is expected to be an absolute URI, but will be relaxed to be
            a relative URI in the future.
      
     +    While parsing, return an error if a URI key is repeated, since we can
     +    make that restriction with bundle lists.
     +
     +    Make the git_parse_int() method global so we can parse the integer
     +    version value carefully.
     +
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/config.txt ##
     @@ Documentation/config.txt: include::config/branch.txt[]
       ## Documentation/config/bundle.txt (new) ##
      @@
      +bundle.*::
     -+	The `bundle.*` keys are used when communicating a list of bundle URIs
     -+	See link:technical/bundle-uri.html[the bundle URI design document] for
     -+	more details.
     ++	The `bundle.*` keys may appear in a bundle list file found via the
     ++	`git clone --bundle-uri` option. These keys currently have no effect
     ++	if placed in a repository config file, though this will change in the
     ++	future. See link:technical/bundle-uri.html[the bundle URI design
     ++	document] for more details.
      +
      +bundle.version::
      +	This integer value advertises the version of the bundle list format
     @@ Documentation/config/bundle.txt (new)
      +	of this `<id>`. This URI may be a bundle file or another bundle list.
      
       ## bundle-uri.c ##
     +@@
     + #include "run-command.h"
     + #include "hashmap.h"
     + #include "pkt-line.h"
     ++#include "config.h"
     + 
     + static int compare_bundles(const void *hashmap_cmp_fn_data,
     + 			   const struct hashmap_entry *he1,
      @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
       	return 0;
       }
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
      +static int bundle_list_update(const char *key, const char *value,
      +			      struct bundle_list *list)
      +{
     -+	const char *pkey, *dot;
      +	struct strbuf id = STRBUF_INIT;
      +	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
      +	struct remote_bundle_info *bundle;
     ++	const char *subsection, *subkey;
     ++	size_t subsection_len;
      +
     -+	if (!skip_prefix(key, "bundle.", &pkey))
     -+		return 1;
     ++	if (parse_config_key(key, "bundle", &subsection, &subsection_len, &subkey))
     ++		return -1;
      +
     -+	dot = strchr(pkey, '.');
     -+	if (!dot) {
     -+		if (!strcmp(pkey, "version")) {
     -+			int version = atoi(value);
     ++	if (!subsection_len) {
     ++		if (!strcmp(subkey, "version")) {
     ++			int version;
     ++			if (!git_parse_int(value, &version))
     ++				return -1;
      +			if (version != 1)
     -+				return 1;
     ++				return -1;
      +
      +			list->version = version;
      +			return 0;
      +		}
      +
     -+		if (!strcmp(pkey, "mode")) {
     ++		if (!strcmp(subkey, "mode")) {
      +			if (!strcmp(value, "all"))
      +				list->mode = BUNDLE_MODE_ALL;
      +			else if (!strcmp(value, "any"))
      +				list->mode = BUNDLE_MODE_ANY;
      +			else
     -+				return 1;
     ++				return -1;
      +			return 0;
      +		}
      +
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
      +		return 0;
      +	}
      +
     -+	strbuf_add(&id, pkey, dot - pkey);
     -+	dot++;
     ++	strbuf_add(&id, subsection, subsection_len);
      +
      +	/*
      +	 * Check for an existing bundle with this <id>, or create one
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
      +	if (!(bundle = hashmap_get_entry(&list->bundles, &lookup, ent, NULL))) {
      +		CALLOC_ARRAY(bundle, 1);
      +		bundle->id = strbuf_detach(&id, NULL);
     -+		strbuf_init(&bundle->file, 0);
      +		hashmap_entry_init(&bundle->ent, strhash(bundle->id));
      +		hashmap_add(&list->bundles, &bundle->ent);
      +	}
      +	strbuf_release(&id);
      +
     -+	if (!strcmp(dot, "uri")) {
     -+		free(bundle->uri);
     ++	if (!strcmp(subkey, "uri")) {
     ++		if (bundle->uri)
     ++			return -1;
      +		bundle->uri = xstrdup(value);
      +		return 0;
      +	}
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
      +	return 0;
      +}
      +
     - static int find_temp_filename(struct strbuf *name)
     + static char *find_temp_filename(void)
       {
       	int fd;
     +
     + ## config.c ##
     +@@ config.c: static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
     + 	return 0;
     + }
     + 
     +-static int git_parse_int(const char *value, int *ret)
     ++int git_parse_int(const char *value, int *ret)
     + {
     + 	intmax_t tmp;
     + 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
     +
     + ## config.h ##
     +@@ config.h: int config_with_options(config_fn_t fn, void *,
     + 
     + int git_parse_ssize_t(const char *, ssize_t *);
     + int git_parse_ulong(const char *, unsigned long *);
     ++int git_parse_int(const char *value, int *ret);
     + 
     + /**
     +  * Same as `git_config_bool`, except that it returns -1 on error rather
  3:  49c4f88b6fd !  5:  4df3f834029 bundle-uri: create "key=value" line parsing
     @@ Commit message
          bundle list. Connect the API necessary for Git's transport to the
          key-value pair parsing created in the previous change.
      
     +    We are not currently implementing this protocol v2 functionality, but
     +    instead preparing to expose this parsing to be unit-testable.
     +
          Co-authored-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
       			      struct bundle_list *list)
       {
      @@ bundle-uri.c: cleanup:
     - 	strbuf_release(&filename);
     + 	free(filename);
       	return result;
       }
      +
     @@ bundle-uri.h: int for_all_bundles_in_list(struct bundle_list *list,
        */
       int fetch_bundle_uri(struct repository *r, const char *uri);
       
     --#endif
      +/**
      + * General API for {transport,connect}.c etc.
      + */
     @@ bundle-uri.h: int for_all_bundles_in_list(struct bundle_list *list,
      +int bundle_uri_parse_line(struct bundle_list *list,
      +			  const char *line);
      +
     -+#endif /* BUNDLE_URI_H */
     + #endif
  4:  7580e1f09af !  6:  91c5b58f011 bundle-uri: unit test "key=value" parsing
     @@ Commit message
          in testing logic deep in the bundle URI feature.
      
          This change introduces the 'parse-key-values' subcommand, which parses
     -    stdin as a list of lines. These are fed into bundle_uri_parse_line() to
     -    test how we construct a 'struct bundle_list' from that data. The list is
     -    then output to stdout as if the key-value pairs were a Git config file.
     +    an input file as a list of lines. These are fed into
     +    bundle_uri_parse_line() to test how we construct a 'struct bundle_list'
     +    from that data. The list is then output to stdout as if the key-value
     +    pairs were a Git config file.
     +
     +    We use an input file instead of stdin because of a future change to
     +    parse in config-file format that works better as an input file.
      
          Co-authored-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     @@ bundle-uri.c: int for_all_bundles_in_list(struct bundle_list *list,
      +		mode = "<unknown>";
      +	}
      +
     -+	printf("[bundle]\n");
     -+	printf("\tversion = %d\n", list->version);
     -+	printf("\tmode = %s\n", mode);
     ++	fprintf(fp, "[bundle]\n");
     ++	fprintf(fp, "\tversion = %d\n", list->version);
     ++	fprintf(fp, "\tmode = %s\n", mode);
      +
      +	for_all_bundles_in_list(list, summarize_bundle, fp);
      +}
     @@ t/helper/test-bundle-uri.c (new)
      +#include "strbuf.h"
      +#include "string-list.h"
      +
     -+static int cmd__bundle_uri_parse_key_values(int argc, const char **argv)
     ++static int cmd__bundle_uri_parse(int argc, const char **argv)
      +{
     -+	const char *usage[] = {
     -+		"test-tool bundle-uri parse-key-values <in",
     ++	const char *key_value_usage[] = {
     ++		"test-tool bundle-uri parse-key-values <input>",
      +		NULL
      +	};
     ++	const char **usage = key_value_usage;
      +	struct option options[] = {
      +		OPT_END(),
      +	};
      +	struct strbuf sb = STRBUF_INIT;
      +	struct bundle_list list;
      +	int err = 0;
     ++	FILE *fp;
      +
      +	argc = parse_options(argc, argv, NULL, options, usage, 0);
     -+	if (argc)
     ++	if (argc != 1)
      +		goto usage;
      +
      +	init_bundle_list(&list);
     -+	while (strbuf_getline(&sb, stdin) != EOF) {
     -+		if (bundle_uri_parse_line(&list, sb.buf) < 0)
     ++	fp = fopen(argv[0], "r");
     ++	if (!fp)
     ++		die("failed to open '%s'", argv[0]);
     ++
     ++	while (strbuf_getline(&sb, fp) != EOF) {
     ++		if (bundle_uri_parse_line(&list, sb.buf))
      +			err = error("bad line: '%s'", sb.buf);
      +	}
      +	strbuf_release(&sb);
     ++	fclose(fp);
      +
      +	print_bundle_list(stdout, &list);
      +
     @@ t/helper/test-bundle-uri.c (new)
      +		goto usage;
      +
      +	if (!strcmp(argv[1], "parse-key-values"))
     -+		return cmd__bundle_uri_parse_key_values(argc - 1, argv + 1);
     ++		return cmd__bundle_uri_parse(argc - 1, argv + 1);
      +	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
      +
      +usage:
     @@ t/t5750-bundle-uri-parse.sh (new)
      +		uri = file:///usr/share/git/bundle.bdl
      +	EOF
      +
     -+	test-tool bundle-uri parse-key-values <in >actual 2>err &&
     ++	test-tool bundle-uri parse-key-values in >actual 2>err &&
      +	test_must_be_empty err &&
      +	test_cmp_config_output expect actual
      +'
     @@ t/t5750-bundle-uri-parse.sh (new)
      +		mode = all
      +	EOF
      +
     -+	test_must_fail test-tool bundle-uri parse-key-values <in >actual 2>err &&
     ++	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
      +	test_cmp err.expect err &&
      +	test_cmp_config_output expect actual
      +'
     @@ t/t5750-bundle-uri-parse.sh (new)
      +		uri = file:///usr/share/git/bundle.bdl
      +	EOF
      +
     -+	test_must_fail test-tool bundle-uri parse-key-values <in >actual 2>err &&
     ++	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
     ++	test_cmp err.expect err &&
     ++	test_cmp_config_output expect actual
     ++'
     ++
     ++test_expect_success 'bundle_uri_parse_line() parsing edge cases: duplicate lines' '
     ++	cat >in <<-\EOF &&
     ++	bundle.one.uri=http://example.com/bundle.bdl
     ++	bundle.two.uri=https://example.com/bundle.bdl
     ++	bundle.one.uri=https://example.com/bundle-2.bdl
     ++	bundle.three.uri=file:///usr/share/git/bundle.bdl
     ++	EOF
     ++
     ++	cat >err.expect <<-\EOF &&
     ++	error: bad line: '\''bundle.one.uri=https://example.com/bundle-2.bdl'\''
     ++	EOF
     ++
     ++	# We fail, but try to continue parsing regardless
     ++	cat >expect <<-\EOF &&
     ++	[bundle]
     ++		version = 1
     ++		mode = all
     ++	[bundle "one"]
     ++		uri = http://example.com/bundle.bdl
     ++	[bundle "two"]
     ++		uri = https://example.com/bundle.bdl
     ++	[bundle "three"]
     ++		uri = file:///usr/share/git/bundle.bdl
     ++	EOF
     ++
     ++	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
      +	test_cmp err.expect err &&
      +	test_cmp_config_output expect actual
      +'
  5:  1d1bd9c7103 !  7:  1492b8f5ef0 bundle-uri: parse bundle list in config format
     @@ Commit message
          our expected "key=value" pairs and instead format them using Git config
          format.
      
     -    Create parse_bundle_list_in_config_format() to parse a file in config
     -    format and convert that into a 'struct bundle_list' filled with its
     +    Create bundle_uri_parse_config_format() to parse a file in config format
     +    and convert that into a 'struct bundle_list' filled with its
          understanding of the contents.
      
     -    Be careful to call git_config_from_file_with_options() because the
     -    default action for git_config_from_file() is to die() on a parsing
     -    error. The current warning isn't particularly helpful if it arises to a
     -    user, but it will be made more verbose at a higher layer later.
     +    Be careful to use error_action CONFIG_ERROR_ERROR when calling
     +    git_config_from_file_with_options() because the default action for
     +    git_config_from_file() is to die() on a parsing error.  The current
     +    warning isn't particularly helpful if it arises to a user, but it will
     +    be made more verbose at a higher layer later.
      
          Update 'test-tool bundle-uri' to take this config file format as input.
          It uses a filename instead of stdin because there is no existing way to
          parse a FILE pointer in the config machinery. Using
          git_config_from_mem() is overly complicated and more likely to introduce
     -    bugs than this simpler version. I would rather have a slightly confusing
     -    test helper than complicated product code.
     +    bugs than this simpler version.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## bundle-uri.c ##
     -@@
     - #include "run-command.h"
     - #include "hashmap.h"
     - #include "pkt-line.h"
     -+#include "config.h"
     - 
     - static int compare_bundles(const void *hashmap_cmp_fn_data,
     - 			   const struct hashmap_entry *he1,
      @@ bundle-uri.c: static int bundle_list_update(const char *key, const char *value,
       	return 0;
       }
     @@ bundle-uri.c: static int bundle_list_update(const char *key, const char *value,
      +	return bundle_list_update(key, value, list);
      +}
      +
     -+int parse_bundle_list_in_config_format(const char *uri,
     -+				       const char *filename,
     -+				       struct bundle_list *list)
     ++int bundle_uri_parse_config_format(const char *uri,
     ++				   const char *filename,
     ++				   struct bundle_list *list)
      +{
      +	int result;
      +	struct config_options opts = {
      +		.error_action = CONFIG_ERROR_ERROR,
      +	};
      +
     -+	list->mode = BUNDLE_MODE_NONE;
      +	result = git_config_from_file_with_options(config_to_bundle_list,
      +						   filename, list,
      +						   &opts);
     @@ bundle-uri.c: static int bundle_list_update(const char *key, const char *value,
      +	return result;
      +}
      +
     - static int find_temp_filename(struct strbuf *name)
     + static char *find_temp_filename(void)
       {
       	int fd;
      
     @@ bundle-uri.h: int for_all_bundles_in_list(struct bundle_list *list,
      + * pairs are provided in config file format. This method is
      + * exposed publicly for testing purposes.
      + */
     -+
     -+int parse_bundle_list_in_config_format(const char *uri,
     -+				       const char *filename,
     -+				       struct bundle_list *list);
     ++int bundle_uri_parse_config_format(const char *uri,
     ++				   const char *filename,
     ++				   struct bundle_list *list);
      +
       /**
        * Fetch data from the given 'uri' and unbundle the bundle data found
     @@ t/helper/test-bundle-uri.c
       #include "strbuf.h"
       #include "string-list.h"
       
     --static int cmd__bundle_uri_parse_key_values(int argc, const char **argv)
     +-static int cmd__bundle_uri_parse(int argc, const char **argv)
      +enum input_mode {
      +	KEY_VALUE_PAIRS,
      +	CONFIG_FILE,
     @@ t/helper/test-bundle-uri.c
      +
      +static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mode)
       {
     --	const char *usage[] = {
     -+	const char *key_value_usage[] = {
     - 		"test-tool bundle-uri parse-key-values <in",
     + 	const char *key_value_usage[] = {
     + 		"test-tool bundle-uri parse-key-values <input>",
       		NULL
       	};
      +	const char *config_usage[] = {
      +		"test-tool bundle-uri parse-config <input>",
      +		NULL
      +	};
     + 	const char **usage = key_value_usage;
       	struct option options[] = {
       		OPT_END(),
     - 	};
     -+	const char **usage = key_value_usage;
     - 	struct strbuf sb = STRBUF_INIT;
     - 	struct bundle_list list;
     +@@ t/helper/test-bundle-uri.c: static int cmd__bundle_uri_parse(int argc, const char **argv)
       	int err = 0;
     + 	FILE *fp;
       
      -	argc = parse_options(argc, argv, NULL, options, usage, 0);
     --	if (argc)
     +-	if (argc != 1)
      -		goto usage;
      +	if (mode == CONFIG_FILE)
      +		usage = config_usage;
     @@ t/helper/test-bundle-uri.c
      +			     PARSE_OPT_STOP_AT_NON_OPTION);
       
       	init_bundle_list(&list);
     --	while (strbuf_getline(&sb, stdin) != EOF) {
     --		if (bundle_uri_parse_line(&list, sb.buf) < 0)
     +-	fp = fopen(argv[0], "r");
     +-	if (!fp)
     +-		die("failed to open '%s'", argv[0]);
     + 
     +-	while (strbuf_getline(&sb, fp) != EOF) {
     +-		if (bundle_uri_parse_line(&list, sb.buf))
      -			err = error("bad line: '%s'", sb.buf);
     -+
      +	switch (mode) {
      +	case KEY_VALUE_PAIRS:
     -+		if (argc)
     ++		if (argc != 1)
      +			goto usage;
     -+		while (strbuf_getline(&sb, stdin) != EOF) {
     -+			if (bundle_uri_parse_line(&list, sb.buf) < 0)
     ++		fp = fopen(argv[0], "r");
     ++		if (!fp)
     ++			die("failed to open '%s'", argv[0]);
     ++		while (strbuf_getline(&sb, fp) != EOF) {
     ++			if (bundle_uri_parse_line(&list, sb.buf))
      +				err = error("bad line: '%s'", sb.buf);
      +		}
     ++		fclose(fp);
      +		break;
      +
      +	case CONFIG_FILE:
      +		if (argc != 1)
      +			goto usage;
     -+		err = parse_bundle_list_in_config_format("<uri>", argv[0], &list);
     ++		err = bundle_uri_parse_config_format("<uri>", argv[0], &list);
      +		break;
       	}
       	strbuf_release(&sb);
     +-	fclose(fp);
     + 
     + 	print_bundle_list(stdout, &list);
       
      @@ t/helper/test-bundle-uri.c: int cmd__bundle_uri(int argc, const char **argv)
       		goto usage;
       
       	if (!strcmp(argv[1], "parse-key-values"))
     --		return cmd__bundle_uri_parse_key_values(argc - 1, argv + 1);
     +-		return cmd__bundle_uri_parse(argc - 1, argv + 1);
      +		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
      +	if (!strcmp(argv[1], "parse-config"))
      +		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
     @@ t/helper/test-bundle-uri.c: int cmd__bundle_uri(int argc, const char **argv)
       usage:
      
       ## t/t5750-bundle-uri-parse.sh ##
     -@@ t/t5750-bundle-uri-parse.sh: test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty lines' '
     +@@ t/t5750-bundle-uri-parse.sh: test_expect_success 'bundle_uri_parse_line() parsing edge cases: duplicate lines
       	test_cmp_config_output expect actual
       '
       
     @@ t/t5750-bundle-uri-parse.sh: test_expect_success 'bundle_uri_parse_line() parsin
      +	cat >expect <<-\EOF &&
      +	[bundle]
      +		version = 1
     -+		mode = <unknown>
     ++		mode = all
      +	EOF
      +
      +	test_must_fail test-tool bundle-uri parse-config in1 >actual 2>err &&
     @@ t/t5750-bundle-uri-parse.sh: test_expect_success 'bundle_uri_parse_line() parsin
      +	EOF
      +
      +	cat >err2 <<-EOF &&
     -+	warning: bundle list at '\''<uri>'\'' has no mode
     ++	error: bad config line 1 in file in2
      +	EOF
      +
      +	test_must_fail test-tool bundle-uri parse-config in2 >actual 2>err &&
  6:  039e172849c !  8:  b5d570082fa bundle-uri: limit recursion depth for bundle lists
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +				     int depth)
       {
       	int result = 0;
     - 	struct strbuf filename = STRBUF_INIT;
     + 	char *filename;
       
      +	if (depth >= max_bundle_uri_depth) {
      +		warning(_("exceeded bundle URI recursion limit (%d)"),
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +		return -1;
      +	}
      +
     - 	if ((result = find_temp_filename(&filename)))
     + 	if (!(filename = find_temp_filename())) {
     + 		result = -1;
       		goto cleanup;
     - 
      @@ bundle-uri.c: cleanup:
       	return result;
       }
  7:  7b45c06cc9e !  9:  a6ab8f7c699 bundle-uri: fetch a list of bundles
     @@ Commit message
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## bundle-uri.c ##
     -@@ bundle-uri.c: void init_bundle_list(struct bundle_list *list)
     - static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
     - 				    void *data)
     +@@ bundle-uri.c: static int clear_remote_bundle_info(struct remote_bundle_info *bundle,
       {
     --	free(bundle->id);
     --	free(bundle->uri);
     -+	FREE_AND_NULL(bundle->id);
     -+	FREE_AND_NULL(bundle->uri);
     - 	strbuf_release(&bundle->file);
     + 	FREE_AND_NULL(bundle->id);
     + 	FREE_AND_NULL(bundle->uri);
     ++	FREE_AND_NULL(bundle->file);
      +	bundle->unbundled = 0;
       	return 0;
       }
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +
      +static int download_bundle_to_file(struct remote_bundle_info *bundle, void *data)
      +{
     ++	int res;
      +	struct bundle_list_context *ctx = data;
      +
      +	if (ctx->mode == BUNDLE_MODE_ANY && ctx->count)
      +		return 0;
      +
     -+	ctx->count++;
     -+	return fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
     ++	res = fetch_bundle_uri_internal(ctx->r, bundle, ctx->depth + 1, ctx->list);
     ++
     ++	/*
     ++	 * Only increment count if the download succeeded. If our mode is
     ++	 * BUNDLE_MODE_ANY, then we will want to try other URIs in the
     ++	 * list in case they work instead.
     ++	 */
     ++	if (!res)
     ++		ctx->count++;
     ++	return res;
      +}
      +
      +static int download_bundle_list(struct repository *r,
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +
      +	init_bundle_list(&list_from_bundle);
      +
     -+	if ((result = parse_bundle_list_in_config_format(bundle->uri,
     -+							 bundle->file.buf,
     -+							 &list_from_bundle)))
     ++	if ((result = bundle_uri_parse_config_format(bundle->uri,
     ++						     bundle->file,
     ++						     &list_from_bundle)))
      +		goto cleanup;
      +
      +	if (list_from_bundle.mode == BUNDLE_MODE_NONE) {
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
      +				     struct bundle_list *list)
       {
       	int result = 0;
     --	struct strbuf filename = STRBUF_INIT;
     +-	char *filename;
      +	struct remote_bundle_info *bcopy;
       
       	if (depth >= max_bundle_uri_depth) {
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
       		return -1;
       	}
       
     --	if ((result = find_temp_filename(&filename)))
     -+	if (!bundle->file.len &&
     -+	    (result = find_temp_filename(&bundle->file)))
     +-	if (!(filename = find_temp_filename())) {
     ++	if (!bundle->file &&
     ++	    !(bundle->file = find_temp_filename())) {
     + 		result = -1;
       		goto cleanup;
     + 	}
       
     --	if ((result = copy_uri_to_file(filename.buf, uri))) {
     +-	if ((result = copy_uri_to_file(filename, uri))) {
      -		warning(_("failed to download bundle from URI '%s'"), uri);
     -+	if ((result = copy_uri_to_file(bundle->file.buf, bundle->uri))) {
     ++	if ((result = copy_uri_to_file(bundle->file, bundle->uri))) {
      +		warning(_("failed to download bundle from URI '%s'"), bundle->uri);
       		goto cleanup;
       	}
       
     --	if ((result = !is_bundle(filename.buf, 0))) {
     +-	if ((result = !is_bundle(filename, 0))) {
      -		warning(_("file at URI '%s' is not a bundle"), uri);
     -+	if ((result = !is_bundle(bundle->file.buf, 1))) {
     ++	if ((result = !is_bundle(bundle->file, 1))) {
      +		result = fetch_bundle_list_in_config_format(
      +				r, list, bundle, depth);
      +		if (result)
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
       		goto cleanup;
       	}
       
     --	if ((result = unbundle_from_file(r, filename.buf))) {
     +-	if ((result = unbundle_from_file(r, filename))) {
      -		warning(_("failed to unbundle bundle from URI '%s'"), uri);
      -		goto cleanup;
      -	}
      +	/* Copy the bundle and insert it into the global list. */
      +	CALLOC_ARRAY(bcopy, 1);
      +	bcopy->id = xstrdup(bundle->id);
     -+	strbuf_init(&bcopy->file, 0);
     -+	strbuf_add(&bcopy->file, bundle->file.buf, bundle->file.len);
     ++	bcopy->file = xstrdup(bundle->file);
      +	hashmap_entry_init(&bcopy->ent, strhash(bcopy->id));
      +	hashmap_add(&list->bundles, &bcopy->ent);
       
       cleanup:
     --	unlink(filename.buf);
     --	strbuf_release(&filename);
     -+	if (result)
     -+		unlink(bundle->file.buf);
     +-	if (filename)
     +-		unlink(filename);
     +-	free(filename);
     ++	if (result && bundle->file)
     ++		unlink(bundle->file);
       	return result;
       }
       
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
      +{
      +	struct attempt_unbundle_context *ctx = data;
      +
     -+	if (info->unbundled || !unbundle_from_file(ctx->r, info->file.buf)) {
     ++	if (info->unbundled || !unbundle_from_file(ctx->r, info->file)) {
      +		ctx->success_count++;
      +		info->unbundled = 1;
      +	} else {
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
      +
      +static int unlink_bundle(struct remote_bundle_info *info, void *data)
      +{
     -+	if (info->file.buf)
     -+		unlink_or_warn(info->file.buf);
     ++	if (info->file)
     ++		unlink_or_warn(info->file);
      +	return 0;
      +}
      +
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
      +	struct bundle_list list;
      +	struct remote_bundle_info bundle = {
      +		.uri = xstrdup(uri),
     -+		.id = xstrdup("<root>"),
     -+		.file = STRBUF_INIT,
     ++		.id = xstrdup(""),
      +	};
      +
      +	init_bundle_list(&list);
     @@ bundle-uri.c: static int fetch_bundle_uri_internal(struct repository *r,
      
       ## bundle-uri.h ##
      @@ bundle-uri.h: struct remote_bundle_info {
     - 	 * an empty string.
     + 	 * if there was no table of contents.
       	 */
     - 	struct strbuf file;
     + 	char *uri;
     ++
     ++	/**
     ++	 * If the bundle has been downloaded, then 'file' is a
     ++	 * filename storing its contents. Otherwise, 'file' is
     ++	 * NULL.
     ++	 */
     ++	char *file;
      +
      +	/**
      +	 * If the bundle has been unbundled successfully, then
     @@ bundle-uri.h: struct remote_bundle_info {
      +	unsigned unbundled:1;
       };
       
     - #define REMOTE_BUNDLE_INFO_INIT { \
     + #define REMOTE_BUNDLE_INFO_INIT { 0 }
      
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with file:// bundle' '

-- 
gitgitgadget

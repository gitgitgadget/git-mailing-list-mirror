Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FC51F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeDIIbi (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:31:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:49205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeDIIbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:31:36 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WuC-1eIBT20ZDg-00ydad; Mon, 09
 Apr 2018 10:31:20 +0200
Date:   Mon, 9 Apr 2018 10:31:19 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 00/15] Assorted fixes for `git config` (including the
 "empty sections" bug)
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5FimO7MSsjjfyRuK8OlRRSs4qss/c832hpxXTTc/ucwYx8o+3Uu
 0pN35pWdmEQs0pKfFsrqFt23rLAbaxI7C5h4o94aBLCLNkuwQ5tzc9tMhTzGsTWEKe3gWd6
 87f1sEzco6tDqTceZVEWocC5xvioyOI2+9r+TTw0cDYeFiu6c3F3nTTVWY1YzpI1NUjZBrw
 mufqF5ojN1J+XU0/9uD+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xtD4r62Y5Po=:0fXoxq5BjuBuAV75FUyNcE
 KGztCaKeB4cSIze38k79PFhbLSiPjZOBYajeHZRpRz+Mog0mc0vPeVlMLB9s9eVIUQxwxK34c
 I4olFtE0VXUyZ2+s5ltMpw7BYuYBkXDfIGUVXZjD6+flZ7y1uv1agYJEjMbg92IyoLlMalaFe
 BK8NQMO0RjWRudXoYzvbMb2G1YlWCXrdOBTVETh0mJbI08Y0SEEdOubM97KOwbkQs/yS48Fsx
 /bSHBOn+Iwf1f/43ZkCO0fpi3wMZbDzUp4sWNbRAJTD/2sSztJVLN1xQSlRrEw1fN1p4hmubJ
 QgaRS6kXSrPodf6CGH+ZzKOXrju6aYlwbR7BON17maXcUTBbyz2CxwcgVbWyzIC2PNbXcywXg
 lkOpn18asvbvtXb8pVBkJKNpEHU5gnE+efZPyHpVgIGqhwr2vX23wVfEUiWlemIYaOaRH2Axb
 iqHPxQyG2qHMdaLspxYZ0WpsTJ3CUXLJwwYXMunDyx+lgrNe28IFSwxqvlj0dKAJm56XJN8m2
 2qkRDKx0Or5wG3L/QK0LJYF2u2T5hExqmSEEbnpantjQPc+hRDiDh+uIaa9313YjQLab5j94C
 moPESAnmnNEzr/HAAcDa2Uk071I/0yQAl0Q2czHhaj8avgvAe2AOSh72TOWu5eJwyOJ3aawma
 tPhfx2Iu94QsHW6YRpke4b0cisfMX6sQtN9eMRXoE4UAwKGABGORidbDEwkZrzY6kwhBd5BNm
 tu9qEga0yaFkug73rsVbToKzwX3FuwGrq3xcZG14P1jXdeg7cB9A8qQsp0Wmp+xeIHUqBIsIl
 0r7jsmiPEZc+CS/k7DJc5VPmCnsfFmOzdCJgtZM1Xh/dAo+Q+U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series originally only tried to help fixing that annoying bug that
has been reported several times over the years, where `git config --unset`
would leave empty sections behind, and `git config --add` would not reuse them.

The first patch is somewhat of a "while at it" bug fix that I first thought
would be a lot more critical than it actually is: It really only affects config
files that start with a section followed immediately (i.e. without a newline)
by a one-letter boolean setting (i.e. without a `= <value>` part). So while it
is a real bug fix, I doubt anybody ever got bitten by it.

The next swath of patches add and fix some tests, while also fixing the bug
where --replace-all would sometimes insert extra line breaks.

Then, I introduce a couple of building blocks: a "config parser event stream",
i.e. an optional callback that can be used to report events such as "comment",
"white-space", etc together with the corresponding extents in the config file.

Finally, the interesting part, where I do two things, essentially (with
preparatory steps for each thing):

1. I add the ability for `git config --unset/--unset-all` to detect that it
   can remove a section that has just become empty (see below for some more
   discussion of what I consider "become empty"), and

2. I add the ability for `git config [--add] key value` to re-use empty
   sections.

To reiterate why does this patch series not conflict with my very early
statements that we cannot simply remove empty sections because we may end up
with stale comments?

Well, the patch in question takes pains to determine *iff* there are any
comments surrounding, or included in, the section. If any are found: previous
behavior. Under the assumption that the user edited the file, we keep it as
intact as possible (see below for some argument against this). If no comments
are found, and let's face it, this is probably *the* common case, as few people
edit their config files by hand these days (neither should they because it is
too easy to end up with an unparseable one), the now-empty section *is*
removed.

So what is the argument against this extra care to detect comments? Well, if
you have something like this:

	[section]
		; Here we comment about the variable called snarf
		snarf = froop

and we run `git config --unset section.snarf`, we end up with this config:

	[section]
		; Here we comment about the variable called snarf

which obviously does not make sense. However, that is already established
behavior for quite a few years, and I do not even try to think of a way how
this could be solved.

Changes since v2:

- removed the `inline` attribute from the `do_event()` function.

- renamed `struct config_set_store` to `struct config_store_data`, to make its
  roled more obvious.

- a whole slew of concocted test cases were added to the test to verify that
  a section that becomes empty is removed, based on Peff's analysis at
  https://public-inbox.org/git/20180329213229.GG2939@sigill.intra.peff.net/


Johannes Schindelin (15):
  git_config_set: fix off-by-two
  t1300: rename it to reflect that `repo-config` was deprecated
  t1300: demonstrate that --replace-all can "invent" newlines
  config --replace-all: avoid extra line breaks
  t1300: avoid relying on a bug
  t1300: remove unreasonable expectation from TODO
  t1300: add a few more hairy examples of sections becoming empty
  t1300: `--unset-all` can leave an empty section behind (bug)
  config: introduce an optional event stream while parsing
  config: avoid using the global variable `store`
  config_set_store: rename some fields for consistency
  git_config_set: do not use a state machine
  git_config_set: make use of the config parser's event stream
  git config --unset: remove empty sections (in the common case)
  git_config_set: reuse empty sections

 config.c                                    | 448 ++++++++++++++------
 config.h                                    |  25 ++
 t/{t1300-repo-config.sh => t1300-config.sh} | 102 ++++-
 3 files changed, 439 insertions(+), 136 deletions(-)
 rename t/{t1300-repo-config.sh => t1300-config.sh} (95%)


base-commit: 468165c1d8a442994a825f3684528361727cd8c0
Published-As: https://github.com/dscho/git/releases/tag/empty-config-section-v3
Fetch-It-Via: git fetch https://github.com/dscho/git empty-config-section-v3

Interdiff vs v2:
 diff --git a/config.c b/config.c
 index ee7ea24123d..6155d0651bd 100644
 --- a/config.c
 +++ b/config.c
 @@ -659,8 +659,7 @@ struct parse_event_data {
  	const struct config_options *opts;
  };
  
 -static inline int do_event(enum config_event_t type,
 -			   struct parse_event_data *data)
 +static int do_event(enum config_event_t type, struct parse_event_data *data)
  {
  	size_t offset;
  
 @@ -2297,7 +2296,7 @@ void git_die_config(const char *key, const char *err, ...)
   * Find all the stuff for git_config_set() below.
   */
  
 -struct config_set_store {
 +struct config_store_data {
  	int baselen;
  	char *key;
  	int do_not_match;
 @@ -2313,7 +2312,7 @@ struct config_set_store {
  };
  
  static int matches(const char *key, const char *value,
 -		   const struct config_set_store *store)
 +		   const struct config_store_data *store)
  {
  	if (strcmp(key, store->key))
  		return 0; /* not ours */
 @@ -2329,7 +2328,7 @@ static int matches(const char *key, const char *value,
  static int store_aux_event(enum config_event_t type,
  			   size_t begin, size_t end, void *data)
  {
 -	struct config_set_store *store = data;
 +	struct config_store_data *store = data;
  
  	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
  	store->parsed[store->parsed_nr].begin = begin;
 @@ -2360,7 +2359,7 @@ static int store_aux_event(enum config_event_t type,
  
  static int store_aux(const char *key, const char *value, void *cb)
  {
 -	struct config_set_store *store = cb;
 +	struct config_store_data *store = cb;
  
  	if (store->key_seen) {
  		if (matches(key, value, store)) {
 @@ -2401,7 +2400,7 @@ static int write_error(const char *filename)
  }
  
  static struct strbuf store_create_section(const char *key,
 -					  const struct config_set_store *store)
 +					  const struct config_store_data *store)
  {
  	const char *dot;
  	int i;
 @@ -2424,7 +2423,7 @@ static struct strbuf store_create_section(const char *key,
  }
  
  static ssize_t write_section(int fd, const char *key,
 -			     const struct config_set_store *store)
 +			     const struct config_store_data *store)
  {
  	struct strbuf sb = store_create_section(key, store);
  	ssize_t ret;
 @@ -2436,7 +2435,7 @@ static ssize_t write_section(int fd, const char *key,
  }
  
  static ssize_t write_pair(int fd, const char *key, const char *value,
 -			  const struct config_set_store *store)
 +			  const struct config_store_data *store)
  {
  	int i;
  	ssize_t ret;
 @@ -2495,7 +2494,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
   * array.  * This index may be incremented if a section has more than one
   * entry (which all are to be removed).
   */
 -static void maybe_remove_section(struct config_set_store *store,
 +static void maybe_remove_section(struct config_store_data *store,
  				 const char *contents,
  				 size_t *begin_offset, size_t *end_offset,
  				 int *seen_ptr)
 @@ -2625,7 +2624,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  	char *filename_buf = NULL;
  	char *contents = NULL;
  	size_t contents_sz;
 -	struct config_set_store store;
 +	struct config_store_data store;
  
  	memset(&store, 0, sizeof(store));
  
 @@ -2969,7 +2968,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
  	FILE *config_file = NULL;
  	struct stat st;
  	struct strbuf copystr = STRBUF_INIT;
 -	struct config_set_store store;
 +	struct config_store_data store;
  
  	memset(&store, 0, sizeof(store));
  
 diff --git a/t/t1300-config.sh b/t/t1300-config.sh
 index 6d0e13020d1..eef0bbe4f9f 100755
 --- a/t/t1300-config.sh
 +++ b/t/t1300-config.sh
 @@ -1449,7 +1449,50 @@ test_expect_success '--unset last key removes section (except if commented)' '
  	EOF
  
  	git config --unset section.key &&
 -	test_cmp expect .git/config
 +	test_cmp expect .git/config &&
 +
 +	q_to_tab >.git/config <<-\EOF &&
 +	[one]
 +	Qkey = "multiline \
 +	QQ# with comment"
 +	[two]
 +	key = true
 +	EOF
 +	git config --unset two.key &&
 +	! grep two .git/config &&
 +
 +	q_to_tab >.git/config <<-\EOF &&
 +	[one]
 +	Qkey = "multiline \
 +	QQ# with comment"
 +	[one]
 +	key = true
 +	EOF
 +	git config --unset-all one.key &&
 +	test_line_count = 0 .git/config &&
 +
 +	q_to_tab >.git/config <<-\EOF &&
 +	[one]
 +	Qkey = true
 +	Q# a comment not at the start
 +	[two]
 +	Qkey = true
 +	EOF
 +	git config --unset two.key &&
 +	grep two .git/config &&
 +
 +	q_to_tab >.git/config <<-\EOF &&
 +	[one]
 +	Qkey = not [two "subsection"]
 +	[two "subsection"]
 +	[two "subsection"]
 +	Qkey = true
 +	[TWO "subsection"]
 +	[one]
 +	EOF
 +	git config --unset two.subsection.key &&
 +	test "not [two subsection]" = "$(git config one.key)" &&
 +	test_line_count = 3 .git/config
  '
  
  test_expect_success '--unset-all removes section if empty & uncommented' '
-- 
2.17.0.windows.1.4.g7e4058d72e3


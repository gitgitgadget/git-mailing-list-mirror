Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB4C1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKMMlM (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:41:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34567 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKMMlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so2218732wrw.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 04:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FOTGT5ongTnAPweYOeLf4ZUvSbt0QqNep/oE5OaDVZM=;
        b=ag57wgQEDxfB5mR81ThYrnNH/RyCIYzR70U8effubQMAI0lZmqRFhVq4cutkriRyt2
         64jWup84uj9WkfpgCJM30R9fshN8H9mWyYvXiGIE2hB1GDbRoRzizvWCdMqvbE0LNqHd
         KTJW+8flLifWq9vz5ZnylMcZ8Bvc7uabhPYY/cxfB16EG+lmdmsLa1aP0YOlQUsTuf32
         93T3agNsG/VIioYREyUiOYnDNGIzHxaGR/GAMLUHKDp+X1qcuZ49Riqzs0cskPLFddJz
         Q1o96KsplbI6sR1Z/TuhzklVvHCrLdiEDsVIigOq23JBZujn5/VRCfN5LTOB+/g/mMhN
         R+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FOTGT5ongTnAPweYOeLf4ZUvSbt0QqNep/oE5OaDVZM=;
        b=fSBfm6ScgjFzktz8nC1sdK61amvt67ZmMGuBzXwt+ePd/2HPhcT17zGJHgIF2NtltH
         pNwqjvolI6u397K/ddYrFMLCvlkgskuw5Mwck9xEU6HFojhDXEnUd6LnK+bL8+9hsMPz
         bU+W3dU6zZG0sjknipk+vj00fiiUTQjqKPAOTJeczA5Y2SYkw4N5aZi3UzJBdTrHJOag
         e7ii5FsI7gksPbtef4T2pANxdYxkI1XXLdZhGJSsz9ML3dR2aq6qm45bbfrAckhifh4/
         +UnpC9lfCxoU3h35pD4iEISo0tp6gre78sVol8uqSkLPZII3xWmCBU3L1om5ogaXHfEf
         OBAg==
X-Gm-Message-State: APjAAAVIdioImaQ9KaSVms08vbpDdAyoltI8z/SZacGwKCxavkTnk+4a
        YRW466WDtGNveD9aBFFjHDx/IvaS
X-Google-Smtp-Source: APXvYqxtnZ1ciQ3OINTnP6EF362Tmsg6DEmSP48m7Am+WartFd7CLU4FWE+mjVo8MQA0ajCEajcf/g==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr2817411wru.146.1573648867861;
        Wed, 13 Nov 2019 04:41:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm3040399wre.59.2019.11.13.04.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 04:41:07 -0800 (PST)
Message-Id: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 12:40:56 +0000
Subject: [PATCH v6 0/9] git add -i: add a rudimentary version in C (supporting only status and help 
 so far)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first leg on the long journey to a fully built-in git add -i 
(next up: parts 2 [https://github.com/gitgitgadget/git/pull/171], 3
[https://github.com/gitgitgadget/git/pull/172], 4
[https://github.com/gitgitgadget/git/pull/173], 5
[https://github.com/gitgitgadget/git/pull/174], and 6
[https://github.com/gitgitgadget/git/pull/175]). Note: the latter PRs are
not necessarily up to date, and will be re-targeted to the appropriate
branches in https://github.com/gitster/git as soon as Junio picks them up.

This here patch series reflects the part that was submitted a couple of
times (see https://github.com/gitgitgadget/git/pull/103) during the
Outreachy project by Slavica Ðukic that continued the journey based on an
initial patch series by Daniel Ferreira.

It only implements the status and the help part, in the interest of making
the review remotely more reviewable.

As I am a heavy user of git add -p myself and use a patched version for
several months already (it is so nice to not suffer over one second startup
until the MSYS2 Perl finally shows me anything, instead it feels
instantaneous), I integrated these patch series into Git for Windows
already, as an opt-in feature guarded by the config variable 
add.interactive.useBuiltin (and Git for Windows' installer knows to detect
this version and offer the option in the graphical user interface).

Changes since v4:

 * Rebased onto current master to make use of Thomas Gummerer's 
   repo_refresh_and_write_index() as well as to avoid merge conflicts with
   Eric Wong's work on struct hashmap.
 * Instead of rolling a dedicated data struct to simulate a Trie, we now use 
   string-list extensively (an unsorted copy and a sorted one, the latter to
   determine unique prefixes). This had massive ramifications on the rest of
   the patches... For example, the struct command_item structure no longer
   contains the name field, but is intended to be a util in a string_list.
 * Changed the commit messages and author lines to reflect Slavica's name
   correctly.
 * Touched up a couple commit messages.

Changes since v3:

 * Rebased to v2.23.0 to reduce friction.
 * free_diffstat_info() is now made public as well, and used, to avoid a
   memory leak.
 * Prepared the patches for ew/hashmap (which is strict about the hashmap
   entries' type in hashmap_entry_init() and friends).
 * The private data types have been moved from prefix-map.h to prefix-map.c.
 * A lot of int types were converted to more appropriate size_t in 
   prefix-map.c.
 * A misleading parameter name list was renamed to the correct array.
 * The code comment above find_unique_prefixes() was (hopefully) improved.
 * The run_help() function's signature now reflects that most of the
   parameters are actually unused.

Changes since v2:

 * Rebased to master to avoid merge conflicts.
 * Renumbered the prefix-map test to avoid conflicts with two patch series
   that are currently in-flight in pu.

Changes since v1:

 * The config machinery was reworked completely, to not use a callback to 
   git_config(), but instead to query the config via the repo_config_get_*() 
   functions. This also prevents a future "Huh???" moment: the internal add
   --interactive API accepts a parameter of type struct repository *r, but
   the previous configuration did not use that to query the config (and
   could in the future be a repository other than the_repository).
   
   
 * As a consequence, the color sequences are no longer stored in file-local
   variables, but passed around via a struct.
   
   
 * Instead of using the magical constant -2 to quit the main loop, it is now
   defined as LIST_AND_CHOOSE_QUIT (and likewise, LIST_AND_CHOOSE_ERROR is
   defined as -1 and used where appropriate).
   
   
 * Improved the add_prefix_item() function by avoiding buffer overruns, not
   reusing the struct that is used for lookup also for adding the new item,
   and by strengthening the bug check.

Daniel Ferreira (2):
  diff: export diffstat interface
  built-in add -i: implement the `status` command

Johannes Schindelin (4):
  Start to implement a built-in version of `git add --interactive`
  built-in add -i: implement the main loop
  built-in add -i: show unique prefixes of the commands
  built-in add -i: support `?` (prompt help)

Slavica Đukić (3):
  built-in add -i: color the header in the `status` command
  built-in add -i: use color in the main loop
  built-in add -i: implement the `help` command

 Documentation/config/add.txt |   5 +
 Makefile                     |   1 +
 add-interactive.c            | 651 +++++++++++++++++++++++++++++++++++
 add-interactive.h            |   8 +
 builtin/add.c                |  12 +
 diff.c                       |  39 +--
 diff.h                       |  20 ++
 t/README                     |   4 +
 t/t3701-add-interactive.sh   |  25 ++
 9 files changed, 742 insertions(+), 23 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2Fdscho%2Fadd-i-in-c-status-and-help-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho/add-i-in-c-status-and-help-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/170

Range-diff vs v5:

  1:  ff59d2d0b3 !  1:  5d9962d434 Start to implement a built-in version of `git add --interactive`
     @@ -2,31 +2,31 @@
      
          Start to implement a built-in version of `git add --interactive`
      
     -    This is hardly the first conversion of a Git command that is implemented
     -    as a script to a built-in. So far, the most successful strategy for such
     -    conversions has been to add a built-in helper and call that for more and
     -    more functionality from the script, as more and more parts are
     -    converted.
     +    Unlike previous conversions to C, where we started with a built-in
     +    helper, we start this conversion by adding an interception in the
     +    `run_add_interactive()` function when the new opt-in
     +    `add.interactive.useBuiltin` config knob is turned on (or the
     +    corresponding environment variable `GIT_TEST_ADD_I_USE_BUILTIN`), and
     +    calling the new internal API function `run_add_i()` that is implemented
     +    directly in libgit.a.
      
     -    With the interactive add, we choose a different strategy. The sole
     -    reason for this is that on Windows (where such a conversion has the most
     -    benefits in terms of speed and robustness) we face the very specific
     -    problem that a `system()` call in Perl seems to close `stdin` in the
     -    parent process when the spawned process consumes even one character from
     -    `stdin`. And that just does not work for us here, as it would stop the
     -    main loop as soon as any interactive command was performed by the
     -    helper. Which is almost all of the commands in `git add -i`.
     -
     -    It is almost as if Perl told us once again that it does not want us to
     -    use it on Windows.
     +    At this point, the built-in version of `git add -i` only states that it
     +    cannot do anything yet. In subsequent patches/patch series, the
     +    `run_add_i()` function will gain more and more functionality, until it
     +    is feature complete. The whole arc of the conversion can be found in the
     +    PRs #170-175 at https://github.com/gitgitgadget/git.
      
     -    Instead, we follow the opposite route where we start with a bare-bones
     -    version of the built-in interactive add, guarded by the new
     -    `add.interactive.useBuiltin` config variable, and then add more and more
     -    functionality to it, until it is feature complete.
     +    The "--helper approach" can unfortunately not be used here: on Windows
     +    we face the very specific problem that a `system()` call in
     +    Perl seems to close `stdin` in the parent process when the spawned
     +    process consumes even one character from `stdin`. Which prevents us from
     +    implementing the main loop in C and still trying to hand off to the Perl
     +    script.
      
     -    At this point, the built-in version of `git add -i` only states that it
     -    cannot do anything yet ;-)
     +    The very real downside of the approach we have to take here is that the
     +    test suite won't pass with `GIT_TEST_ADD_I_USE_BUILTIN=true` until the
     +    conversion is complete (the `--helper` approach would have let it pass,
     +    even at each of the incremental conversion steps).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -99,12 +99,14 @@
       	struct argv_array argv = ARGV_ARRAY_INIT;
      +	int use_builtin_add_i =
      +		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
     -+	if (use_builtin_add_i < 0)
     -+		git_config_get_bool("add.interactive.usebuiltin",
     -+				    &use_builtin_add_i);
      +
     -+	if (use_builtin_add_i == 1 && !patch_mode)
     -+		return !!run_add_i(the_repository, pathspec);
     ++	if (!patch_mode) {
     ++		if (use_builtin_add_i < 0)
     ++			git_config_get_bool("add.interactive.usebuiltin",
     ++					    &use_builtin_add_i);
     ++		if (use_builtin_add_i == 1)
     ++			return !!run_add_i(the_repository, pathspec);
     ++	}
       
       	argv_array_push(&argv, "add--interactive");
       	if (patch_mode)
  2:  2fc8cc3546 =  2:  f42d7b1310 diff: export diffstat interface
  3:  6aaa0de4f4 =  3:  4836191271 built-in add -i: implement the `status` command
  4:  e405f07110 =  4:  d61cf9daeb built-in add -i: color the header in the `status` command
  5:  25590fbbbe !  5:  b0c04e6ec6 built-in add -i: implement the main loop
     @@ -7,33 +7,34 @@
          function that we conveniently introduced for use by the `status`
          command.
      
     -    Apart from the "and choose" part, there are more differences between the
     -    way the `status` command calls the `list_and_choose()` function in the
     -    Perl version of `git add -i` compared to the other callers of said
     -    function. The most important ones:
     +    In contrast to the Perl version, in the built-in interactive `add`, we
     +    will keep the `list()` function (which only displays items) and the
     +    `list_and_choose()` function (which uses `list()` to display the items,
     +    and only takes care of the "and choose" part) separate.
      
     -    - The list is not only shown, but the user is also asked to make a
     -      choice, possibly selecting multiple entries.
     +    The `list_and_choose()` function, as implemented in
     +    `git-add--interactive.perl` knows a few more tricks than the function we
     +    introduce in this patch:
      
     -    - The list of items is prefixed with a marker indicating what items have
     -      been selected, if multi-selection is allowed.
     +    - There is a flag to let the user select multiple items.
      
     -    - Initially, for each item a unique prefix (if there exists any within
     -      the given parameters) is determined, and shown in the list, and
     +    - In multi-select mode, the list of items is prefixed with a marker
     +      indicating what items have been selected.
     +
     +    - Initially, for each item a unique prefix is determined (if there
     +      exists any within the given parameters), and shown in the list, and
            accepted as a shortcut for the selection.
      
     -    These features will be implemented later, except the part where the user
     -    can choose a command. At this stage, though, the built-in `git add -i`
     -    still only supports the `status` command, with the remaining commands to
     -    follow over the course of the next commits.
     +    These features will be implemented in the C version later.
      
     -    In addition, we also modify `list()` to support displaying the commands
     -    in columns, even if there is currently only one.
     +    This patch does not add any new main loop command, of course, the
     +    built-in `git add -i` still only supports the `status` command. The
     +    remaining commands to follow over the course of the next commits.
      
     -    The Perl script `git-add--interactive.perl` mixed the purposes of the
     -    "list" and the "and choose" part into the same function. In the C
     -    version, we will keep them separate instead, calling the `list()`
     -    function from the `list_and_choose()` function.
     +    To accommodate for listing the commands in columns, preparing for the
     +    commands that will be implemented over the course of the next
     +    patches/patch series, we teach the `list()` function to do precisely
     +    that.
      
          Note that we only have a prompt ending in a single ">" at this stage;
          later commits will add commands that display a double ">>" to indicate
     @@ -101,7 +102,7 @@
      +	ssize_t res = LIST_AND_CHOOSE_ERROR;
      +
      +	for (;;) {
     -+		char *p, *endp;
     ++		char *p;
      +
      +		strbuf_reset(&input);
      +
     @@ -133,6 +134,7 @@
      +			}
      +
      +			if (isdigit(*p)) {
     ++				char *endp;
      +				index = strtoul(p, &endp, 10) - 1;
      +				if (endp != p + sep)
      +					index = -1;
  6:  57fdc01463 !  6:  b6459be5eb built-in add -i: show unique prefixes of the commands
     @@ -177,7 +177,7 @@
      +	find_unique_prefixes(items);
      +
       	for (;;) {
     - 		char *p, *endp;
     + 		char *p;
       
       		strbuf_reset(&input);
       
  7:  77ad5f333a =  7:  bdf9058d9e built-in add -i: support `?` (prompt help)
  8:  3d0b172a7f =  8:  eafeedc49b built-in add -i: use color in the main loop
  9:  85e508ef11 =  9:  7fda76255a built-in add -i: implement the `help` command

-- 
gitgitgadget

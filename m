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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2811F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKOLL2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38498 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKOLL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so10529836wro.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=G9b0hWNVsHpTPqAdMOWScPPzCwgVQ1mxo291ZZWEZEA=;
        b=YcStVRah0RoHMOBKIP+f2REa+CGn21U9NgBrIgm9iQlD7RxUk9I1aRPJ3iKhDyDo5n
         BjDnGy7V81AM2K9Y20roFlaB7biLqbTzbBJvxKdr/fzYW1TOXwfWDGfMk9wRb0tXMTuh
         az0s0bcLvB8OJwhd5+8A1/fl4l74ex7YuF4Slq/N0LbMozUrr0aIKxIRZznnkO75HyB6
         xgOVL31ngq4HP4U0Kra6VfTkzGtx/+E/XbLNyQgwaL7825nhfjJGjxnbAHxLIcSTnJk5
         73WKjmuKvBVFa1McRI51CCDxOFCIVrbP3FyRYEmWHrFXrA+Eswkob6JGosGoOx6ryZyy
         KUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=G9b0hWNVsHpTPqAdMOWScPPzCwgVQ1mxo291ZZWEZEA=;
        b=g1VGI0N/iu/z/Xax3i1K8wiiFS4ffX/Ra23cmuUyPq45lrz3aJPuAdKASv+RBHGXPA
         8S7FItNoHZvMk1A9J69yrnTE+h6cVeFmWS8BkwjpoG4PiccrtKpbWF0A26FWi7T2nq8l
         8e9sYCmwWnsNG0Dk1IsVTpmHTaVBWXJDtGVSrNZx4ziqjnGYOpeGQQiHkHGgxmBIwh22
         Zfuob93OeldpiM6uUsq61dVMLLqoBoUo46NFENLzpGRZLCQyqdVVZlqG71//mVbv9xqW
         N3V/U7Ey+vjaFLn+GhDJjCR7ya67sk+RZJf4YEmHvJ6EzYFxHISazJpXp50dPkLmLZBQ
         CUgQ==
X-Gm-Message-State: APjAAAUOb7kaobu7morBKZKUI/51JWsrdBeysTX7BC30WyR7L0hn9x9K
        rY8dZsNtEDPAK3c+NCkHuB3oSEqN
X-Google-Smtp-Source: APXvYqz0KQN76z0SAcTp/JI+lWujowuCd45XYkum1tRJfcxP+muwuR9gYjsggXXD6NFF7j+es8JDEA==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr14164329wrm.156.1573816282187;
        Fri, 15 Nov 2019 03:11:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm10657286wru.32.2019.11.15.03.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:21 -0800 (PST)
Message-Id: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:11 +0000
Subject: [PATCH v7 0/9] git add -i: add a rudimentary version in C (supporting only status and help 
 so far)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
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

Changes since v6:

 * Fixed a potential buffer overrun when parsing numbers/number ranges.

Changes since v5:

 * Reworded two commit messages.
 * Clarified code that does not affect patch_mode.
 * Restricted scope of the very local variable endp.

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
 add-interactive.c            | 652 +++++++++++++++++++++++++++++++++++
 add-interactive.h            |   8 +
 builtin/add.c                |  12 +
 diff.c                       |  39 +--
 diff.h                       |  20 ++
 t/README                     |   4 +
 t/t3701-add-interactive.sh   |  25 ++
 9 files changed, 743 insertions(+), 23 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2Fdscho%2Fadd-i-in-c-status-and-help-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho/add-i-in-c-status-and-help-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/170

Range-diff vs v6:

  1:  5d9962d434 =  1:  5d9962d434 Start to implement a built-in version of `git add --interactive`
  2:  f42d7b1310 =  2:  f42d7b1310 diff: export diffstat interface
  3:  4836191271 =  3:  4836191271 built-in add -i: implement the `status` command
  4:  d61cf9daeb =  4:  d61cf9daeb built-in add -i: color the header in the `status` command
  5:  b0c04e6ec6 !  5:  601c371089 built-in add -i: implement the main loop
     @@ -140,7 +140,8 @@
      +					index = -1;
      +			}
      +
     -+			p[sep] = '\0';
     ++			if (p[sep])
     ++				p[sep++] = '\0';
      +			if (index < 0 || index >= items->nr)
      +				printf(_("Huh (%s)?\n"), p);
      +			else {
     @@ -148,7 +149,7 @@
      +				break;
      +			}
      +
     -+			p += sep + 1;
     ++			p += sep;
      +		}
      +
      +		if (res != LIST_AND_CHOOSE_ERROR)
  6:  b6459be5eb !  6:  978bb25b81 built-in add -i: show unique prefixes of the commands
     @@ -187,9 +187,9 @@
       		printf("%s%s", opts->prompt, "> ");
       		fflush(stdout);
      @@
     - 			}
       
     - 			p[sep] = '\0';
     + 			if (p[sep])
     + 				p[sep++] = '\0';
      -			if (index < 0 || index >= items->nr)
      +			if (index < 0)
      +				index = find_unique(p, items);
  7:  bdf9058d9e =  7:  d7d447026c built-in add -i: support `?` (prompt help)
  8:  eafeedc49b =  8:  bcf4aa7c5e built-in add -i: use color in the main loop
  9:  7fda76255a =  9:  ccc6fb4558 built-in add -i: implement the `help` command

-- 
gitgitgadget

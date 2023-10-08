Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D148E95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbjJHGpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbjJHGpf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C39D
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so33079655e9.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747531; x=1697352331; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Dm62WBiQ3oQ4xI7oI7Rq1hAfzchVPmMI4GEUHti1lY=;
        b=HBW9IcorPN1tpxjEDjwR8K+fYppPvs+zeYS8Z+OGW4JAp0iHXCr8Msd+INp3saOjP6
         WE7r9FegB92QvRowwxPxI4Dy1opQisn2ROE9oP7aK6dcMxm8PwLaZFiFsOFK3rdoKLnN
         tWsJ7NSePbJUGWodmD3aHzd7WJPVH38967CXN1VccCYADRNpyvmJkYeOYncYMXBoLlkL
         uDxlpRRvS4jq8USRmizTrE+avBIic4lL4/BzPkEJTRBYv7RvCyctcD7AoKlKMKLE7Z4i
         xDBdPNLTeoZ6LcNYoQcseeAsSL5QUoE4U6N585rakW9WMeBYLb06hl/eKxZ7nALMVFLx
         gh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747531; x=1697352331;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Dm62WBiQ3oQ4xI7oI7Rq1hAfzchVPmMI4GEUHti1lY=;
        b=EFu4AKfUf+FUPgCHgwht4XUKBBCFp988VLyScL4ZLIlUdyA0qhImyvbNbIy82fGGPv
         QLgwkyjSSBXYJ+anFF9yTwfUnuFPa6XWpdXIQB0AY4koTkEHS/0DBsI6IwvRjfhssneN
         ldPfuxH5pMyAYK1WnK26EJdjiw2SBffi8f1eS9af0q/gAvONuYqanRtS3azk6tkoymmu
         F3otk2Hpo4JvXjh2qHRDQwqaM3k7G8Q4pFUn4xNAGUg85XqDi3HJ9oZDjn1//S0SQzuT
         wlqok8urhulujhTLTWPDK/h2ONbtP0y0QJdDbUQp85WWkdlRew4YHBSG7HftZuX69dIw
         kb5Q==
X-Gm-Message-State: AOJu0YxxVJQPddzQYoNoj4WvjilbDPvpc3gQS5iun+QDQrn227GTLkqP
        aeVa47sccigV0gLLGFMFUB3iabao4UM=
X-Google-Smtp-Source: AGHT+IGcil0XRWLlRdmBZF3bLX8X47ERNxzrge0c126FBONZ9j+rmVrCSp4Nn4M5fFN75G18I5SuHA==
X-Received: by 2002:a1c:7711:0:b0:405:959e:dc7c with SMTP id t17-20020a1c7711000000b00405959edc7cmr11229691wmi.30.1696747530993;
        Sat, 07 Oct 2023 23:45:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b004063cd8105csm9984740wmr.22.2023.10.07.23.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:30 -0700 (PDT)
Message-ID: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:02 +0000
Subject: [PATCH 00/25] Documentation fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that AI is pretty good at making small fixes to documentation;
certainly not perfect, but it provides quite good signal. Unfortunately,
there is a lot to sift through. Some points about my strategy:

 * I ignored a few categories of things like British vs. American spellings
   (though being consistent on that might be a nice change)

 * I dropped many changes where I thought there wasn't an issue being
   corrected but just a switch of style being suggested (though I accepted a
   number of these types of changes before later deciding to drop them).

 * I also started discarding lower priority changes like comma placement. I
   accepted a number of these that I thought made the documentation clearer,
   but I eventually just started dropping them as I had spent far more hours
   than I expected on this series.

 * A few of the changes AI suggested were bad (it really shouldn't mess with
   protocol and RFC-like text). Definitely was useful to review.

 * Occasionally I noticed an even better improvement and tweaked the text
   accordingly.

I did review every single change here, multiple times, and I have tried to
split up this series in a way to make it easier to review. In particular I:

 * dropped any changes that conflicted with anything in next or seen. I may
   resubmit some of those later.

 * split it into a bunch of patches based on various grammatical rules being
   corrected

 * sometimes when a single line had multiple types of changes, I split the
   fixes across multiple patches in order to group types of changes

 * sometimes splitting the single-line changes seemed like too much, and I
   just combined the multiple changes to a single line with the first patch
   in the series, "wording improvements".

Let me know if there are other changes that would make this easier to
review. In a sense, though, it's already had multiple eyes looking at this,
it's just that one pair of those eyes were artificial. :-)

(Note: every patch in this series, except for the whitespace fixes patch,
are best viewed with --color-words.)

Elijah Newren (25):
  documentation: wording improvements
  documentation: fix small error
  documentation: fix typos
  documentation: fix apostrophe usage
  documentation: add missing words
  documentation: remove extraneous words
  documentation: fix subject/verb agreement
  documentation: employ consistent verb tense for a list
  documentation: fix verb tense
  documentation: fix adjective vs. noun
  documentation: fix verb vs. noun
  documentation: fix singular vs. plural
  documentation: whitespace is already generally plural
  documentation: fix choice of article
  documentation: add missing article
  documentation: remove unnecessary hyphens
  documentation: add missing hyphens
  documentation: use clearer prepositions
  documentation: fix punctuation
  documentation: fix capitalization
  documentation: fix whitespace issues
  documentation: add some commas where they are helpful
  documentation: add missing fullstops
  documentation: add missing quotes
  documentation: add missing parenthesis

 Documentation/CodingGuidelines                |  6 ++---
 Documentation/ReviewingGuidelines.txt         |  4 +--
 Documentation/SubmittingPatches               |  2 +-
 Documentation/ToolsForGit.txt                 |  4 +--
 Documentation/config.txt                      |  6 ++---
 Documentation/config/advice.txt               |  8 +++---
 Documentation/config/alias.txt                |  2 +-
 Documentation/config/apply.txt                |  4 +--
 Documentation/config/branch.txt               |  6 ++---
 Documentation/config/checkout.txt             |  4 +--
 Documentation/config/clean.txt                |  2 +-
 Documentation/config/clone.txt                |  4 +--
 Documentation/config/color.txt                |  2 +-
 Documentation/config/column.txt               |  4 +--
 Documentation/config/commit.txt               |  4 +--
 Documentation/config/credential.txt           |  4 +--
 Documentation/config/diff.txt                 |  2 +-
 Documentation/config/fastimport.txt           |  4 +--
 Documentation/config/fetch.txt                |  4 +--
 Documentation/config/format.txt               |  2 +-
 Documentation/config/fsck.txt                 | 22 ++++++++--------
 Documentation/config/fsmonitor--daemon.txt    |  2 +-
 Documentation/config/gc.txt                   |  4 +--
 Documentation/config/gpg.txt                  |  6 ++---
 Documentation/config/gui.txt                  |  2 +-
 Documentation/config/http.txt                 |  4 +--
 Documentation/config/i18n.txt                 |  2 +-
 Documentation/config/imap.txt                 |  4 +--
 Documentation/config/index.txt                |  2 +-
 Documentation/config/log.txt                  |  2 +-
 Documentation/config/mailinfo.txt             |  2 +-
 Documentation/config/maintenance.txt          |  2 +-
 Documentation/config/man.txt                  |  2 +-
 Documentation/config/merge.txt                |  2 +-
 Documentation/config/mergetool.txt            | 12 ++++-----
 Documentation/config/notes.txt                |  2 +-
 Documentation/config/pack.txt                 | 10 +++----
 Documentation/config/push.txt                 |  4 +--
 Documentation/config/receive.txt              |  4 +--
 Documentation/config/rerere.txt               |  2 +-
 Documentation/config/safe.txt                 |  4 +--
 Documentation/config/sendemail.txt            |  4 +--
 Documentation/config/sequencer.txt            |  2 +-
 Documentation/config/splitindex.txt           |  6 ++---
 Documentation/config/stash.txt                |  8 +++---
 Documentation/config/status.txt               |  4 +--
 Documentation/config/submodule.txt            |  4 +--
 Documentation/config/trace2.txt               |  2 +-
 Documentation/config/transfer.txt             |  4 +--
 Documentation/config/user.txt                 | 10 +++----
 Documentation/config/versionsort.txt          |  6 ++---
 Documentation/diff-generate-patch.txt         | 26 +++++++++----------
 Documentation/diff-options.txt                |  2 +-
 Documentation/fetch-options.txt               |  4 +--
 Documentation/fsck-msgids.txt                 |  4 +--
 Documentation/git-am.txt                      | 12 ++++-----
 Documentation/git-apply.txt                   | 14 +++++-----
 Documentation/git-archive.txt                 | 16 ++++++------
 Documentation/git-blame.txt                   |  8 +++---
 Documentation/git-bugreport.txt               |  9 ++++---
 Documentation/git-check-attr.txt              |  6 ++---
 Documentation/git-check-ignore.txt            |  2 +-
 Documentation/git-check-ref-format.txt        |  4 +--
 Documentation/git-checkout-index.txt          | 10 +++----
 Documentation/git-checkout.txt                |  2 +-
 Documentation/git-clean.txt                   |  2 +-
 Documentation/git-count-objects.txt           |  6 ++---
 Documentation/git-credential-cache.txt        |  2 +-
 Documentation/git-credential-store.txt        |  2 +-
 Documentation/git-credential.txt              |  2 +-
 Documentation/git-daemon.txt                  |  2 +-
 Documentation/git-diff-files.txt              |  6 ++---
 Documentation/git-diff-index.txt              |  4 +--
 Documentation/git-diff-tree.txt               | 12 ++++-----
 Documentation/git-difftool.txt                |  4 +--
 Documentation/git-fast-import.txt             |  4 +--
 Documentation/git-fetch-pack.txt              |  2 +-
 Documentation/git-format-patch.txt            |  2 +-
 Documentation/git-fsck.txt                    |  6 ++---
 Documentation/git-fsmonitor--daemon.txt       | 10 +++----
 Documentation/git-get-tar-commit-id.txt       |  2 +-
 Documentation/git-grep.txt                    |  2 +-
 Documentation/git-hash-object.txt             |  8 +++---
 Documentation/git-help.txt                    | 18 ++++++-------
 Documentation/git-hook.txt                    |  4 +--
 Documentation/git-http-backend.txt            | 10 +++----
 Documentation/git-http-fetch.txt              |  2 +-
 Documentation/git-http-push.txt               | 10 +++----
 Documentation/git-index-pack.txt              | 10 +++----
 Documentation/git-init.txt                    | 10 +++----
 Documentation/git-ls-files.txt                | 10 +++----
 Documentation/git-mailsplit.txt               |  2 +-
 Documentation/git-maintenance.txt             |  6 ++---
 Documentation/git-merge-base.txt              | 12 ++++-----
 Documentation/git-merge-tree.txt              |  8 +++---
 Documentation/git-merge.txt                   |  2 +-
 Documentation/git-mergetool--lib.txt          | 10 +++----
 Documentation/git-mergetool.txt               |  8 +++---
 Documentation/git-mktag.txt                   |  6 ++---
 Documentation/git-mktree.txt                  |  4 +--
 Documentation/git-mv.txt                      |  2 +-
 Documentation/git-name-rev.txt                |  2 +-
 Documentation/git-prune-packed.txt            |  2 +-
 Documentation/git-prune.txt                   |  2 +-
 Documentation/git-push.txt                    |  2 +-
 Documentation/git-quiltimport.txt             |  4 +--
 Documentation/git-range-diff.txt              |  2 +-
 Documentation/git-read-tree.txt               |  6 ++---
 Documentation/git-receive-pack.txt            |  4 +--
 Documentation/git-remote-ext.txt              | 10 +++----
 Documentation/git-remote-fd.txt               | 10 +++----
 Documentation/git-repack.txt                  |  4 +--
 Documentation/git-replace.txt                 |  4 +--
 Documentation/git-request-pull.txt            |  4 +--
 Documentation/git-restore.txt                 |  4 +--
 Documentation/git-rev-list.txt                |  4 +--
 Documentation/git-rev-parse.txt               |  8 +++---
 Documentation/git-rm.txt                      |  2 +-
 Documentation/git-send-email.txt              |  4 +--
 Documentation/git-send-pack.txt               | 16 ++++++------
 Documentation/git-sh-setup.txt                |  2 +-
 Documentation/git-show-branch.txt             | 12 ++++-----
 Documentation/git-show-ref.txt                |  2 +-
 Documentation/git-show.txt                    |  2 +-
 Documentation/git-status.txt                  |  2 +-
 Documentation/git-stripspace.txt              |  6 ++---
 Documentation/git-symbolic-ref.txt            |  2 +-
 Documentation/git-update-index.txt            | 18 ++++++-------
 Documentation/git-update-ref.txt              |  2 +-
 Documentation/git-update-server-info.txt      |  4 +--
 Documentation/git-upload-pack.txt             |  2 +-
 Documentation/git-var.txt                     |  2 +-
 Documentation/git-verify-pack.txt             |  6 ++---
 Documentation/git-whatchanged.txt             |  8 +++---
 Documentation/gitcli.txt                      |  8 +++---
 Documentation/gitdiffcore.txt                 | 14 +++++-----
 Documentation/giteveryday.txt                 |  2 +-
 Documentation/gitformat-bundle.txt            |  8 +++---
 Documentation/gitformat-chunk.txt             |  4 +--
 Documentation/gitformat-pack.txt              | 18 ++++++-------
 Documentation/githooks.txt                    | 10 +++----
 Documentation/gitprotocol-capabilities.txt    | 20 +++++++-------
 Documentation/gitprotocol-common.txt          |  2 +-
 Documentation/gitprotocol-http.txt            |  6 ++---
 Documentation/gitprotocol-pack.txt            |  6 ++---
 Documentation/gitprotocol-v2.txt              |  2 +-
 Documentation/gitsubmodules.txt               |  6 ++---
 Documentation/gitweb.conf.txt                 |  2 +-
 Documentation/gitweb.txt                      | 16 ++++++------
 Documentation/glossary-content.txt            |  2 +-
 .../howto/coordinate-embargoed-releases.txt   |  2 +-
 Documentation/howto/maintain-git.txt          |  6 ++---
 Documentation/howto/use-git-daemon.txt        |  2 +-
 Documentation/howto/using-merge-subtree.txt   |  2 +-
 Documentation/i18n.txt                        |  4 +--
 Documentation/mergetools/vimdiff.txt          |  6 ++---
 Documentation/pretty-options.txt              |  4 +--
 Documentation/pull-fetch-param.txt            |  6 ++---
 Documentation/rev-list-options.txt            |  4 +--
 Documentation/technical/api-index-skel.txt    |  2 +-
 Documentation/technical/api-simple-ipc.txt    | 10 +++----
 Documentation/technical/bitmap-format.txt     |  6 ++---
 Documentation/technical/commit-graph.txt      |  2 +-
 Documentation/technical/parallel-checkout.txt | 10 +++----
 Documentation/technical/partial-clone.txt     |  8 +++---
 Documentation/technical/racy-git.txt          | 10 +++----
 Documentation/technical/reftable.txt          | 10 +++----
 .../technical/repository-version.txt          |  2 +-
 Documentation/technical/rerere.txt            |  6 ++---
 Documentation/urls-remotes.txt                |  4 +--
 Documentation/urls.txt                        |  4 +--
 171 files changed, 478 insertions(+), 477 deletions(-)


base-commit: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1595%2Fnewren%2Fdoc-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1595/newren/doc-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1595
-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E791F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 06:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfJ3Gsq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 02:48:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55759 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfJ3Gsq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 02:48:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id g24so808781wmh.5
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 23:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XVvgfjDcn54fUYSjzGNVMxitzMAouzE7hQLU+DQulnw=;
        b=sM9MNRZY5THj9+8DEfM1wXeSspgr2rDLeeukO8ZdEbZMu88PqEeXrEsdBru2FlWHkw
         L59vj7IaNPAZ+DhcZB3/wOcHcogBN4nryDfGrNWw/DB0NliWmRAkr/DFGzB6B5gUlUih
         4qAFZ/hNlxqlW2BYBL+thdvn1eMxyNwJ82chfK6TiNXIBRYCjEiQkGuvazbnJvCkh6QE
         LeyDdtv6QIQ8Gq9ZhXPrvtUTMCpnBXGhKAfAglVNII5yQ2OTLBtUW0knJo6TKESJjgBL
         aGocKDKtUhLNtE+cHG4YEwq11eKhMHHNqb+clqj6Zypw+Z9Hlg5MZVfuAgAO1sWLlUY9
         vkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XVvgfjDcn54fUYSjzGNVMxitzMAouzE7hQLU+DQulnw=;
        b=O+eMzXZB79Hh4AfDtmSuT8xvcJOMNmeIB0yGJffvtZcEcLV4zfR+i853K6Sa3x7PCX
         OXa0baBGmryQTUik5NXS3NIW9WNYEJy+52kKqg+IENJJlvrLscYMRFNop2LrMePlBG68
         C+njnDXzdiRNBjlRuagl9XhN/+YU5rvHC+fvFhKUZD/W1diCzSSNwvOekNi809vRVRfe
         FEl/iG1G/k2yMZ/mmpcrOlNmZ5LnriIWk2907KV5G4+u608PwBle7Qk6kxxHqFXunsYr
         6kemc/fgAPeI1cnZBQQWfJdmX6xHDkYWVJ3gV5BKggJDenV87FvI/He+0VgfT4lLq1Ak
         vkFw==
X-Gm-Message-State: APjAAAVk5INYomquHAKzBM5MfoIkv/nI0Ub7mEjUKkKNZXQLGjmL3EQq
        GsxtixEhjOQjsSdzBazSx3em3jmp
X-Google-Smtp-Source: APXvYqwXjseEtfiZ7FT4GcvE458gwVRqrnWRgZhWWe24fBIr7fsxsd2KQUXKg8Ykw6qvkARpwTyFyg==
X-Received: by 2002:a1c:3843:: with SMTP id f64mr7129815wma.129.1572418124822;
        Tue, 29 Oct 2019 23:48:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 62sm1491579wre.38.2019.10.29.23.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 23:48:44 -0700 (PDT)
Message-Id: <pull.436.git.1572418123.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 06:48:41 +0000
Subject: [PATCH 0/2] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My development environment sometimes makes automatic changes that I don't
want to keep. In some cases, this involves new files being added that I
don't want to commit or keep (but I also don't want to outright .gitignore 
forever). I have typically had to explicitly delete those files externally
to Git Gui, which is a context switch to a manual operation, and I want to
be able to just select those newly-created untracked files in the UI and
"revert" them into oblivion.

This change updates the revert_helper proc to check for untracked files as
well as changes, and then changes to be reverted and untracked files are
handled by independent blocks of code. The user is prompted independently
for untracked files, since the underlying action is fundamentally different
(rm -f). If after deleting untracked files, the directory containing them
becomes empty, then the directory is removed as well. A new proc 
delete_files takes care of actually deleting the files, using the Tcler's
Wiki recommended approach for keeping the UI responsive.

This is the second revision of this change, which differs from the first
version in the following ways:

 * The change is now based on git-gui/master.
 * With one exception, all lines are at most 80 characters long. The
   exception has a string literal in it that pushes it to 82 characters. I
   think it would be messy to try to split it, and I got advice on 
   #git-devel to just let it go to 82 characters.
 * camelCase is eliminated. I eliminated it from existing code in a separate
   commit.
 * try is no longer used anywhere. The code that cares about the result (had
   code in a catch after a try) uses [catch].
 * Deletion of files and removal of empty directories is now handled by
   separate procs.
 * The deletion of a large number of files does not block the UI during its
   execution any more.
 * The revert_helper code no longer uses an epilogue of generic statements
   to be evaluated on exit.
 * When deleting files, the UI is notified about the deletion directly
   instead of doing a full rescan.

Jonathan Gilbert (2):
  git-gui: consolidate naming conventions
  git-gui: revert untracked files by deleting them

 lib/index.tcl | 343 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 266 insertions(+), 77 deletions(-)


base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/436
-- 
gitgitgadget

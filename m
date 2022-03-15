Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB72C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 22:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiCOWPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 18:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiCOWPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 18:15:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776B931DC5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 15:14:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x15so443094wru.13
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9rrOv0Tlxyp3G53/2aWGkhbAEcdv5+ptacsj0rPmbXM=;
        b=kxJBIiBfSwZ78A/DBoe2nVWDlpwjneDon/NyMqDq8ot70Sv3nsHgitrRxK4e5dHHfX
         kfJY+/Eny2BPV++w1W55X7XtDZ3K0iNHk1lU9QAX7JA94ZMyUhf1xZh8q2Qw3Y4YOsv9
         +563iPn83EHuXZUb3jbrhiF5i2wEcfa63H6z1XRH9m8SqKmwpAGz6J4NV6gHqEDn4Np+
         smquKEq7OPfWd5+4ZLKnV8sf41/RsPln2c20cvRyrNYnOWyr+C4vJjQ8DWRGE0MryZuX
         A9AxVAIB1qtn1hwn+JlfMeKpoqt5WCvoeNmeeDQ9Qm29JoFU0FKiUeOFzJfNTVTSgLTK
         c7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9rrOv0Tlxyp3G53/2aWGkhbAEcdv5+ptacsj0rPmbXM=;
        b=00RXyK/+MKT4/lI1wNDOhxm/z7o1PMgoAkpFhmmDGlza8yEz/Edf51CgNK6BKCNA1z
         Fh7NYtnDJSPEp1qICKoUw4hKYr+eIMhu+EWneAKrK5B+u4caM4pgequPUZzg74en9Iij
         9ppUOMNvAJ3JpvG/b+c0sy5cUOewABWfoRyqofSPeYmV2S0BGG4u7Ck7Wph7wjNT7Ylj
         fyzV5Gqu9n/t5rEzXqPGQ4tmEZUGbzoGcDPyhbqK/d9eXgOgK8czP6p98IPg7P2wVgt8
         2BnY9QmtjJiOcn+4Aa6tcmdOFYIVw0zRVBksHxhG48H4UK2b5JElZQIxi1A+mIs1SxhQ
         F+bQ==
X-Gm-Message-State: AOAM53194RQ2F/5VB4yvQJdpgDwN0eGdFjB1J/27w0cxu63eXQPw8gq1
        A9UNV0xp6wAyENYlS6f1fkJYc1Rzrpw=
X-Google-Smtp-Source: ABdhPJyh2CqBX/AZTaIz2E7TUkWiVqtqpzi9Ot61Os4Pbqh7x51gIxc25niiXHMP4buDtV2F+cQyIQ==
X-Received: by 2002:a5d:64a3:0:b0:203:d7e5:67ff with SMTP id m3-20020a5d64a3000000b00203d7e567ffmr3317739wrp.617.1647382438888;
        Tue, 15 Mar 2022 15:13:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4f07000000b00203db8f13c6sm145790wru.75.2022.03.15.15.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:13:58 -0700 (PDT)
Message-Id: <pull.1227.v3.git.git.1647382437475.gitgitgadget@gmail.com>
In-Reply-To: <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
References: <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
From:   "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 22:13:57 +0000
Subject: [PATCH v3] tab completion of filenames for 'git restore'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Cantrell <david@cantrell.org.uk>,
        David Cantrell <david@cantrell.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Cantrell <david@cantrell.org.uk>

If no --args are present after 'git restore' it assumes that you want
to tab-complete one of the files with unstaged uncommitted changes.

If a file has been staged we don't want to list it, as restoring those
requires a slightly more complex `git restore --staged`, so we only list
those files that are --modified. While --committable also looks like
a good candidate, that includes changes that have been staged.

Signed-off-by: David Cantrell <david@cantrell.org.uk>
---
    Improved bash tab completion for 'git restore' - adds support for
    auto-completing filenames
    
    This adds tab-completion of filenames to the bash completions for git
    restore.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1227%2FDrHyde%2Ffilename-completion-for-git-restore-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1227/DrHyde/filename-completion-for-git-restore-v3
Pull-Request: https://github.com/git/git/pull/1227

Range-diff vs v2:

 1:  2bb8f1cb1c4 ! 1:  779744b9fc5 tab completion of filenames for 'git restore'
     @@ Commit message
          tab completion of filenames for 'git restore'
      
          If no --args are present after 'git restore' it assumes that you want
     -    to tab-complete one of the files with uncommitted changes
     +    to tab-complete one of the files with unstaged uncommitted changes.
     +
     +    If a file has been staged we don't want to list it, as restoring those
     +    requires a slightly more complex `git restore --staged`, so we only list
     +    those files that are --modified. While --committable also looks like
     +    a good candidate, that includes changes that have been staged.
      
          Signed-off-by: David Cantrell <david@cantrell.org.uk>
      
       ## contrib/completion/git-completion.bash ##
      @@ contrib/completion/git-completion.bash: _git_restore ()
     - 	case "$cur" in
     - 	--conflict=*)
     - 		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
     -+		return
     - 		;;
     - 	--source=*)
     - 		__git_complete_refs --cur="${cur##--source=}"
     -+		return
     - 		;;
       	--*)
       		__gitcomp_builtin restore
     -+		return
       		;;
     ++	*)
     ++		if __git rev-parse --verify --quiet HEAD >/dev/null; then
     ++			__git_complete_index_file "--modified"
     ++		fi
       	esac
     -+
     -+	if __git rev-parse --verify --quiet HEAD >/dev/null; then
     -+		__git_complete_index_file "--committable"
     -+	fi
       }
       
     - __git_revert_inprogress_options=$__git_sequencer_inprogress_options
 2:  16aa4d0b2e4 < -:  ----------- if a file has been staged we don't want to list it


 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 49a328aa8a4..ba5c395d2d8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2890,6 +2890,10 @@ _git_restore ()
 	--*)
 		__gitcomp_builtin restore
 		;;
+	*)
+		if __git rev-parse --verify --quiet HEAD >/dev/null; then
+			__git_complete_index_file "--modified"
+		fi
 	esac
 }
 

base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
gitgitgadget

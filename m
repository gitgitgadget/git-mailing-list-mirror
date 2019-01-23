Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01561F453
	for <e@80x24.org>; Wed, 23 Jan 2019 05:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfAWFGU (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 00:06:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46052 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAWFGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 00:06:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so480878pgc.12
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 21:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rYi1sBI6bUszRxeUIq5B+1t0ndRMBCFpOLMoAg80C/U=;
        b=YqR8WMG/Oet0OT2HC5mx2h7TadIcH3cnysW6o7oafByKvNYCjH7VfTFhlaPCV6N39y
         lKcn9HYUGTUsGaJVQmzpMUsJRcNPCJGFLJe2obtag3dEzYDEQkw7+EO/Xy1wE31uUnnt
         9/dFWQj7xwcVSDBm7FnpJCW0JdhebjmwqXG8rjXl2AJlUVlHml+rHrAPFpn06byy3Wyd
         oQB6bNf6STV+5nsFyIv7il7LSXhePmhu2921W5O8RkOO0EJTZ+lwgz3Ei1iqpC0Cmb2L
         j/xeRAdX+rTNJOVNF3cdvzq0csh2CWdbh5kUM8TO2IzmGFwsQcMJPIfStDeToiSwr8hr
         JdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rYi1sBI6bUszRxeUIq5B+1t0ndRMBCFpOLMoAg80C/U=;
        b=nzM0eOKnsuVp+HHNdUiQShmIt75v591Cqgu8Rt8stNVcCX2rXEYDNZSWxbSOKcPHRS
         j0XEOtjK+chenio/5PU5c/qpJotcLd/IVS9zfBvRDnFmqP3PvE93JEou42AypjBueQrw
         nCG65ww+zck0FiH0zYF3DNfVemAk1DpgmDbdQkXq899vaZqjqTvyBwLIflhYJKYMpqU+
         U/Lez7Apv5LcTMMul7FDE0PFduhQtUc0nqDz7KuMm9D4grbVvKxqyNH5gBW/RoE0A8M3
         klCo8HYZj412ALgZLsAZHPBU5C6wfvAUMjU5wx0rhhcy+3v/S1x5AfDYXQZgAbbI8lhA
         ZJ9Q==
X-Gm-Message-State: AJcUukdunKeTwpW3i7wCMF75rPGnBeh9eUJ2tq2mQlMtNVKwwpATCnKm
        DpFaf2jeKR3bicqHAiFONGtUgWE/
X-Google-Smtp-Source: ALg8bN6brmTzhrKPcbZ9Ees4oF69lzXLe29LOQhj74bow+1MfZjf0bkHAjHbMToKOEFRuRxdy8cTLQ==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr768006pgq.58.1548219978430;
        Tue, 22 Jan 2019 21:06:18 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id x186sm21726433pfb.59.2019.01.22.21.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 21:06:17 -0800 (PST)
Date:   Tue, 22 Jan 2019 21:06:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v6 0/4] Add git-merge --cleanup support
Message-ID: <cover.1548219737.git.liu.denton@gmail.com>
References: <cover.1545745331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545745331.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were some merge conflicts since v5 so I've rebased the last few
patches on the latest master and fixed the conflicts.

Not related to this but while I was making my changes, I noticed that -F
and -m don't die properly in git-merge when they accept invalid
arguments. Instead, they just print an error message to stderr and the
program keeps running. Is this the expected behaviour?


Changes since V1:
	* Only check MERGE_MSG for a scissors line instead of all prepended
	  files
	* Make a variable static in merge where appropriate
	* Add passthrough options in pull
	* Add documentation for the new option
	* Add tests to ensure desired behaviour

Changes since V2:
	* Merge both patches into one patch
	* Fix bug in help message printing logic

Changes since V3:
	* Add patch to cleanup 'merge --squash c3 with c7' test in t7600
	* Use test_i18ncmp instead of test_cmp to pass GETTEXT_POISON tests

Changes since V4:
	* Add patches so that git-merge messages will be cleaned up like in
	  git-commit

Changes since V5:
	* Rebase on latest master and resolve merge conflicts


Denton Liu (4):
  commit: extract cleanup_mode functions to sequencer
  t7600: clean up 'merge --squash c3 with c7' test
  merge: cleanup messages like commit
  merge: add scissors line on merge conflict

 Documentation/merge-options.txt |  7 ++++
 builtin/commit.c                | 41 +++++++++-------------
 builtin/merge.c                 | 45 ++++++++++++++++++++----
 builtin/pull.c                  |  6 ++++
 sequencer.c                     | 29 ++++++++++++++++
 sequencer.h                     |  4 +++
 t/t7600-merge.sh                | 53 +++++++++++++++++++++++++---
 t/t7604-merge-custom-message.sh | 61 +++++++++++++++++++++++++++++++++
 wt-status.c                     | 12 +++++--
 wt-status.h                     |  1 +
 10 files changed, 221 insertions(+), 38 deletions(-)

-- 
2.20.1.3.ge68552ea27.dirty


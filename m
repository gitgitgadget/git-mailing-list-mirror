Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252E620133
	for <e@80x24.org>; Fri,  3 Mar 2017 13:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbdCCNER (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 08:04:17 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33995 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdCCNEP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 08:04:15 -0500
Received: by mail-pf0-f193.google.com with SMTP id x66so9855425pfb.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 05:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Dhgr6f/A/IZMX4syU3v/TTJyuxqYQkmvLluXNA4mnfg=;
        b=bHUs7P0I71tN94sIjqGBLv+LPLY/jVnlXHimloT0Ljqm7G+AvQRQlOXE5KjTUd4t8L
         KC6gFQffQCioPI2RgaILYNyDh2BWotNgxefn9UNIIvH0LXb/ShDWk9a7v/oZU0HYCFIV
         a4uESpV0kKNZkqxaQM1cvUBMuccmWvMkaPo4FFPmvo+2lvtJ65OQOs+9gqQwE2nxwK6p
         /RTRIO1br6L3JjirS04xBNq2RmW3QUP485ri/WfmKt2hWutU3b8ncOVzCYRBuslPUAVr
         th3ujkvXF1bjOBVz2zIAQoytMDZwL8b5/qpcXZgZ7Oagz273QZcp89tfei39mOxxLn4G
         rd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Dhgr6f/A/IZMX4syU3v/TTJyuxqYQkmvLluXNA4mnfg=;
        b=sczpCiuU6tXn2pt0/HFf89m+0vkXkXxXAi4iSglmY+Q16fxugc0Mn592bDzp3k716g
         ar6Er2mSz8F6nFvfKIQTuX3c+tlssw1c4zTNfd57pDAtFy3rQbRotBZjRGeC9QsUSwCu
         qGkCBcuKtNodNHu9CvTRyK+8VCabR7GfNFtLo1gxQp3dXjThmy1XlfkuUSKyG0OTxtz+
         9xQ0j4d1CTym3AxaBae038ZTIbDjg3mqipsGEYSAnva+o4T9U+tOwGcRTO5Dg55NCa/8
         23XbWedUEt0dkDKMgSdneU4v1eb1I5AjMATfZSo1hRWziPn+EuGAnsi/JHEZdIg5e69/
         sRbQ==
X-Gm-Message-State: AMke39kXshXhMZUkrtsAQTrFf7hlh01PsNet4a1jqTontrjIgCUSpIzkdBJjkSnkc11D+w==
X-Received: by 10.98.28.72 with SMTP id c69mr3251183pfc.8.1488544535380;
        Fri, 03 Mar 2017 04:35:35 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id b83sm23339776pfe.12.2017.03.03.04.35.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 04:35:34 -0800 (PST)
Date:   Fri, 3 Mar 2017 04:35:33 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 2/2] completion: add bash completion for 'filter-branch'
Message-ID: <20170303123533.GA19539@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
If the last patch (PATCH 1/2) is not included, we can remove the call to
__git_complete_rev_list_command.
---
 contrib/completion/git-completion.bash | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 412485369..933dac78b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1307,6 +1307,23 @@ _git_fetch ()
 	__git_complete_remote_or_refspec
 }
 
+__git_filter_branch_options="
+	--env-filter --tree-filter --index-filter --parent-filter --msg-filter
+	--commit-filter --tag-name-filter --subdirectory-filter --prune-empty
+	--original --force
+"
+_git_filter_branch ()
+{
+	__git_has_doubledash && __git_complete_rev_list_command && return
+
+	case "$cur" in
+	--*)
+		__gitcomp "$__git_filter_branch_options"
+		return
+		;;
+	esac
+}
+
 __git_format_patch_options="
 	--stdout --attach --no-attach --thread --thread= --no-thread
 	--numbered --start-number --numbered-files --keep-subject --signoff
-- 
2.12.0.1.g5415fdfc5.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EC420756
	for <e@80x24.org>; Mon,  9 Jan 2017 08:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757410AbdAII4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 03:56:07 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33366 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdAII4G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 03:56:06 -0500
Received: by mail-pf0-f195.google.com with SMTP id 127so24185482pfg.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 00:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yL1trimcmoTYUV2+dt9ybujpxZrajmWsBYr5wYgFmoI=;
        b=mreSqVPZkdbpakTek2WncwGsi/alpO5tWNSv/PgZAeJ/v5Ee/kvnErTR8xxILEbleH
         B5puar6xRPCiXtET/QZsiosOcQyyu/ifLsqctEqXR4SEpFQeopnNFrdRIZQnsq8AEUGc
         uLwJLtp5aL5OJ9rUbjIQgqND7lEJzUIxMTzgnaKoyM1RJn+1d4nWpDKwPecIz9Gmuala
         T80jnGtSeUgpqOIFIdGdmA13lse7PGwiwyZudmgHluV8ukWTptKjTScq03v34yrmjz8y
         Lk2HnHbCegwhiJc7LGt2YCZ6umv+Mi9aVxFqBsEJOmAyGygs2pIgMBBEblnDNdi1whwd
         BIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yL1trimcmoTYUV2+dt9ybujpxZrajmWsBYr5wYgFmoI=;
        b=MWvZoM8eVCH7d579Ep2U3xwTOvr73i4RCk6Dga9WRmagrpTYOfV7fMgVysfFJWH8UR
         sjZVNUN2e/mB1X956/XrI1JPhHctQ5mCXQQJ4ofOPJsl34q/Hi2DMrIWsVZ2U82SIxU8
         T23HiQvfP/QfsK51MI48kZuC46LODMaTnmvRwfK2hv2Wz+Vb8NBju9g84PY8Q33xaX6H
         BJaZ/1g5BusD6GzrPExs7MIWn/hd55reJX6rftPlC1YayX6e4NLRnTiCeyhVu3uhQ+8H
         U2zCQWvZ3EV5mjFsIw4GKJZI1MKfPLzhonVkBIRL/0lkxahK7y9yGBRAlfGBdban8czq
         uEzw==
X-Gm-Message-State: AIkVDXIvXOEG/2FIoihPKgzbHs+Q5o2eBRcbDCnEiKSM3hUGu+KOLBzvkENkW0SmFd5ZKQ==
X-Received: by 10.99.226.83 with SMTP id y19mr160231903pgj.147.1483952165921;
        Mon, 09 Jan 2017 00:56:05 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id 16sm177157913pfk.54.2017.01.09.00.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2017 00:56:05 -0800 (PST)
Date:   Mon, 9 Jan 2017 00:56:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     spearce@spearce.org
Subject: [PATCH 1/2] completion: add bash completion for 'git rev-list'
Message-ID: <20170109085603.GA496@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8d..51832108e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2430,6 +2430,36 @@ _git_revert ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_rev_list_options="
+ --max-count= --skip= --max-age= --min-age= --sparse --merges --no-merges
+ --min-parents= --no-min-parents --max-parents= --no-max-parents --first-parent
+ --remove-empty --full-history --not --all --branches= --tags= --remotes=
+ --glob= --ignore-missing --stdin --quiet --topo-order --parents --timestamp
+ --left-right --left-only --right-only --cherry-mark --cherry-pick --encoding=
+ --author= --committer= --grep= --regexp-ignore-case --extended-regexp
+ --fixed-strings --date= --objects --objects-edge --objects-edge-aggressive
+ --unpacked --pretty --header --bisect --bisect-vars --bisect-all --merge
+ --reverse --walk-reflogs --no-walk --do-walk --count --use-bitmap-index
+"
+
+__git_complete_rev_list_command ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp "$__git_rev_list_options"
+		return 0
+		;;
+	esac
+	return 1
+}
+
+_git_rev_list ()
+{
+	__git_has_doubledash && return
+
+	__git_complete_rev_list_command || __gitcomp_nl "$(__git_refs)"
+}
+
 _git_rm ()
 {
 	case "$cur" in
-- 
2.11.0


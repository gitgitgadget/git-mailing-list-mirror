Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594711F453
	for <e@80x24.org>; Thu, 18 Oct 2018 07:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeJRPa2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 11:30:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJRPa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 11:30:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id r17-v6so72648wrt.9
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 00:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8K7djETruL4t7+IdB2wN0z2+5+5VJWHr6oZFBVxU+r4=;
        b=CrZGbhclETc3a5gVU4UmTLeopSjQB6TKWbbtQGMieKyc9Brn94dl+ssWrLgHxHNDOZ
         2J5nzpZfMawOvtxmmaH5STpKbZ+d9RZVndbYyouA441AJZPDXgI1gVq5eje1HZx6ky4c
         pGaLTA3bJCsfS/09iEFa4aOBKua3aW/vIxmL2WuyDIR/NCDWKwDjKX5Ve8CULsm0TqRF
         Igt5dyw8IT/X/aAPJYOD2NtjSCuWZN6QJgYAssJN6TXEmdxHLhxRQId379Ymh2Ke8HEk
         aBibtAHtTfgSvrF3NlrUACMCbbEJl/jEmQCIyPutnawmosNQu82ItOBL2Khj9Dq8M2yn
         +erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8K7djETruL4t7+IdB2wN0z2+5+5VJWHr6oZFBVxU+r4=;
        b=ueJpXwRKzOvJb9DqhKn/G5JskF1JjEIbBuCoGkQ9TNAb3oeFbfXwMrFYTPIAOmfRyO
         q0cbjMXkvexjJa7TTj50sPr9JHsZ5nU/sjERM+Fuq+c4QzjfxQ5cveYMsARdZ01DM7Ql
         uabGruzRhcC0CvUD59ml/7rUvg2K/XG/nSRHkgBnN1+y3uGxGoitDm7ogw8k/8Gv0kuT
         MFdaZ5Fz6b2cYPtVYasHIWAINJxfN0z8jLhiK2V3lt5Yws+9uO7r+gc56p1YDRnai16K
         2zkto68N7DMxxr0LAPPVWTMHQczRTy9mwvFH3hgVn+dBws4rBkVSu3wxX74EqMHg9Vbo
         kAwg==
X-Gm-Message-State: ABuFfoi2RMiizGkMIZRG1gUEmjPOmLz9YBG2uHPTFGliBIQxlBnjWCJk
        V0ky2cTCoIgz65YcmpOS5pNhIs3w7aY=
X-Google-Smtp-Source: ACcGV60Cjjj7A/ey99ZqTbW49Ofupel8PBjmerRthWF3xhJRqWJ7zkTbZZ2WMwq78br0mioXRI+iHw==
X-Received: by 2002:adf:e842:: with SMTP id d2-v6mr25440928wrn.175.1539847846910;
        Thu, 18 Oct 2018 00:30:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x15-v6sm11726626wrt.90.2018.10.18.00.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 00:30:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
References: <20181016181327.107186-1-sbeller@google.com>
Date:   Thu, 18 Oct 2018 16:30:45 +0900
In-Reply-To: <20181016181327.107186-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 16 Oct 2018 11:13:18 -0700")
Message-ID: <xmqqa7nb67a2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is based on ao/submodule-wo-gitmodules-checked-out.
>
> This resends origin/sb/submodule-recursive-fetch-gets-the-tip, resolving
> the issues pointed out via origin/xxx/sb-submodule-recursive-fetch-gets-the-tip-in-pu
> by basing this series on origin/ao/submodule-wo-gitmodules-checked-out

Applying this round to the result of merging ao/submodule-* to
'master' requires this to work, it seems, as you've introduced a
call to repo-init thing in the meantime with another topic.

Subject: [PATCH] fixup! repository: repo_submodule_init to take a submodule struct

---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5f8a804a6e..015aa1471f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2037,7 +2037,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 	if (!sub)
 		BUG("We could get the submodule handle before?");
 
-	if (repo_submodule_init(&subrepo, the_repository, path))
+	if (repo_submodule_init(&subrepo, the_repository, sub))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
 	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
-- 
2.19.1-450-ga4b8ab5363


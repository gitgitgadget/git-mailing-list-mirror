Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23F01F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfJKTM4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 15:12:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44236 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfJKTMz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 15:12:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so2324649pgd.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZSZH5+2EEJd2sjHV3a18wFzu+QVrscNWnmELBNehQH8=;
        b=A6C0mLnzOclRHL86KLommwTnrZsmsVMRDZ/cOOTZL82ug8xYDk7sdfwyfi3OSMSoZj
         +qx+UGvdQllHchPacCl4laNFUn7Ot06/OtkJDGAJuhu1iWc4q20FQLB7ZkOwSuQHVujM
         wjslBo+HDO0lpsa0Jq+nDE6vQ5YI+wL2tF9mezlmhUsdD6vJpZUJzndBoW+R9KGie6CH
         SnMsb/5vJqzpEXNEcAuEM47deONGixV/tuAsX7OI8oCdUe113iA3hd77yaFZ3wraCYc/
         WQ3kggK+feb/z+6+2ARyAnNM5G/5ZBEI/3imyDQ5PMGmBRHoZhU/lsTMNmGIeProFLgW
         TftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSZH5+2EEJd2sjHV3a18wFzu+QVrscNWnmELBNehQH8=;
        b=fGvcaBjhviy0tUKyxYQikGvAUQ2PTUV71fCZ9EceA/5fUcP/9zKNerrNo+p+ZMPc3q
         o6CJu6WcG8SkefqwHlDCynUmxsBpMMXamFl+wAxLdLF4PET/O4RbptJFWgKdtUv0H3Au
         R5ooxdVbh9K32tIhT9E049pz4+qCUoWaowGvwQgUteUP4hHVQK/ITLnNjX0ALlNTs5Az
         RPG9s0cvxHIVwW+UrdYBYWK1wVDKc00/v/Ms4nyNLjcWvj9uLmx5IPhccOpi0QDhaqrW
         m4+EjMMGDh2En9ZKX1ZNIi8S+y4J7StvX7PbKRquQgAJEWykjlGjl7TGQnbfNmfFGgDS
         n+RA==
X-Gm-Message-State: APjAAAUrX0p/NAWW30DszKCo+n/HbDmPsRSGIbQCmz0M8UZdgq7Gkx+W
        8PieBEdNc5gFzGnoHS3CeXf99XE6
X-Google-Smtp-Source: APXvYqxI8gLO4lVzHhw0kqkwKxGK/DmEdmbRCIlKUJ5zYtUKqUlQUZWiDeGhGLSEGsj6NGbkS501Gg==
X-Received: by 2002:a65:51cd:: with SMTP id i13mr18868572pgq.142.1570821174335;
        Fri, 11 Oct 2019 12:12:54 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id w5sm9733147pfn.96.2019.10.11.12.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 12:12:53 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:12:52 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 1/3] format-patch: remove erroneous and condition
Message-ID: <5fa7cbbd7a68eae76347b90371201e20cba1c381.1570821015.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1570821015.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570821015.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 30984ed2e9 (format-patch: support deep threading, 2009-02-19),
introduced the following lines:

	#define THREAD_SHALLOW 1

	[...]

	thread = git_config_bool(var, value) && THREAD_SHALLOW;

Since git_config_bool() returns a bool, the trailing `&& THREAD_SHALLOW`
is a no-op. Remove this erroneous and condition.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..7d658cecef 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -835,7 +835,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			thread = THREAD_SHALLOW;
 			return 0;
 		}
-		thread = git_config_bool(var, value) && THREAD_SHALLOW;
+		thread = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "format.signoff")) {
-- 
2.23.0.17.g7cce04acd6.dirty


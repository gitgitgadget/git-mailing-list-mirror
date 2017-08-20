Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B6F1F667
	for <e@80x24.org>; Sun, 20 Aug 2017 04:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdHTEzH (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 00:55:07 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35562 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdHTEzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 00:55:07 -0400
Received: by mail-qt0-f179.google.com with SMTP id x36so2014848qtx.2
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 21:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qUQyTzkZvJ1ONIOjrNffrWHKPqNCsvo624kp6j5xJCI=;
        b=s9RWazjgqgTZ7Js+ZFurXowHRzxeQkwqeP02SXL/CM297hhS38ZZtS78bxiDiSWkPk
         kGLMfWb3q7Asj9AuJYj/FeqL+Go7RKteAIo2v+3SgVtGdUw7p8iQweDF4JTTo3YY4yDw
         J4TQUlAcLMRCnETXc49A8mDSh02y/BcscpHVL55q31qNWfRIJBoxK210cv4ouTOhg4x7
         f4OhKfiUjS/WIgTpbw9oPxtql5RYO30l67y93WjTHNt8Fn0i5gU2xQ6HXu1wthAN5SY8
         RJakEE3iEX6neJ//blhumnQHukIPyJaCmaEscCUHB4fHTbWhQWNbMn/n6IjHTIsUjXMv
         oLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qUQyTzkZvJ1ONIOjrNffrWHKPqNCsvo624kp6j5xJCI=;
        b=ZPzjpildxDKqUdU6ReYvtAKK8MBPIyTKZXFqF1pMfEMSVxo/VVogaDA8wuZRLHOfUH
         ilR/LvGI4Bf8JLV6YOrks+bZd093IH4ryebsEtoYWfw83noiljSld73x8ggWVFCNVZAN
         Xrp5sCaHCe4rhDYH3bpPvoE2ll1gCdcQnxYq+ojKzleyX/YDiGYnxatapDG1cDIc6aKQ
         vCBN7qNByX/k55hr8QoWRsPt0ps3X0uWcJ97f3hGmS8rwGse910JTDrYHHnn0XgImzTR
         HIVwehz/+BugIjVrkIx+kOeVe5UQnqzXysW8oK0QAxzU6rsp5fmU81IPjQQxF1E/idWk
         i3aA==
X-Gm-Message-State: AHYfb5hWnsYGdmxCtT7nvSlOUo6Pfik5CxGm3RSCXCaifMh9vckO20mK
        G/QHhrExcqbBMQ==
X-Received: by 10.200.9.108 with SMTP id z41mr6209571qth.234.1503204906271;
        Sat, 19 Aug 2017 21:55:06 -0700 (PDT)
Received: from ?IPv6:2604:6000:b40b:7800::4? ([2604:6000:b40b:7800::4])
        by smtp.gmail.com with ESMTPSA id p1sm5890785qke.16.2017.08.19.21.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Aug 2017 21:55:05 -0700 (PDT)
From:   Sonny Michaud <michaud.sonny@gmail.com>
Subject: [PATCH 0/1] Add stash entry count summary to short status output
To:     git@vger.kernel.org, gitster@pobox.com
Message-ID: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
Date:   Sun, 20 Aug 2017 00:53:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this patch adds a header in the same style as the one provided by the --branch option when the user supplies both --show-stash and --short.  My attempt at creating a new test is broken[1], and I assume my changes could (and, likely need to) be improved.  Any assistance would be greatly appreciated; I just wanted to get started by hacking first and asking questions later!                         
                                                                               
Thanks,                                                                        
Sonny                                                                          
                                                                               
1. https://travis-ci.org/sonnym/git/builds/266428128

--
From 9e9ffca5c4ed7dda34cad416c3eb68dc94a78b7e Mon Sep 17 00:00:00 2001         
From: Sonny Michaud <michaud.sonny@gmail.com>                                  
Date: Sat, 19 Aug 2017 23:46:15 -0400                                          
Subject: [PATCH 1/1] status: learn to show stash in short output               

This patch extends the functionality of the recently introduced                
--show-stash option to the status command, providing a header similar to       
the one displayed when using the --branch option.                              
---                                                                            
 t/t7508-status.sh |  5 +++++                                                  
 wt-status.c       | 12 ++++++++++++                                           
 2 files changed, 17 insertions(+)                                             

diff --git a/t/t7508-status.sh b/t/t7508-status.sh                             
index 43d19a9b2..734001bc6 100755                                              
--- a/t/t7508-status.sh                                                        
+++ b/t/t7508-status.sh                                                        
@@ -1619,6 +1619,11 @@ test_expect_success 'show stash info with "--show-stash"' '                                                                             
        test_i18ngrep "^Your stash currently has 1 entry$" expected_with_stash 
 '                                                                             
                                                                               
+test_expect_success 'show stash info with "--show-stash" and "--short"' '     
+       git status --show-stash --short >expected_with_stash &&                
+       test_i18ngrep "Stash entries: 2" expected_with_stash                   
+'                                                                             
+                                                                              
 test_expect_success 'no stash info with "--show-stash --no-show-stash"' '     
        git status --show-stash --no-show-stash >expected_without_stash &&     
        test_cmp expected_default expected_without_stash                       
diff --git a/wt-status.c b/wt-status.c                                         
index 77c27c511..651bb01f0 100644                                              
--- a/wt-status.c                                                              
+++ b/wt-status.c                                                              
@@ -1827,6 +1827,15 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)                                                                          
        fputc(s->null_termination ? '\0' : '\n', s->fp);                       
 }                                                                             
                                                                               
+static void wt_shortstatus_print_stash_summary(struct wt_status *s)           
+{                                                                             
+       int stash_count = 0;                                                   
+                                                                              
+       for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);     
+       if (stash_count > 0)                                                   
+    color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## Stash entries: %d", stash_count);                                                                    
+}                                                                             
+                                                                              
 static void wt_shortstatus_print(struct wt_status *s)                         
 {                                                                             
        struct string_list_item *it;                                           
@@ -1834,6 +1843,9 @@ static void wt_shortstatus_print(struct wt_status *s)    
        if (s->show_branch)                                                    
                wt_shortstatus_print_tracking(s);                              
                                                                               
+       if (s->show_stash)                                                     
+               wt_shortstatus_print_stash_summary(s);                         
+                                                                              
        for_each_string_list_item(it, &s->change) {                            
                struct wt_status_change_data *d = it->util;                    
                                                                               
--                                                                             
2.14.0

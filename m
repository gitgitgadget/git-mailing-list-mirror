Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A6D1F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEQSaE (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:30:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38887 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeEQSaD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:30:03 -0400
Received: by mail-pg0-f65.google.com with SMTP id n9-v6so2181408pgq.5
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tWmIOasdO4qHFkUeqQg4RLEQ0zXeIZQjVDNDIvhkELw=;
        b=u4iP0Uu8FUhp1JixIZu1/S5SKuUWi74NdMHEd8CXO3f25/TqhYFPRKZAbhSFFz6ZnU
         GNRrNgl1YPBwE1br8Y7SAPfairvZWOjn6Z5HwZbd5t1q+Ak79LkcGxvNWqIyHdhoFFc4
         owmahbhKXIqtRFrPKSRwweVLuTfhMFU/a4L5LBLiNn9kfzv1ylZhlsHyDPQoxoQ63YW/
         ZmqimQRpdI9UW4nShIDc+e3hmOTfGgAP+SL5ATatUrJMDymKHzmTlQYLyCPK9bx4NzTr
         69BPntuIihzj+2kBbo0U8BG1bKU3PKjqHPMOA21Kr4Rp1eHCha4YKsBApzl2eF5j+EaD
         Clrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tWmIOasdO4qHFkUeqQg4RLEQ0zXeIZQjVDNDIvhkELw=;
        b=mamDpWorGD6ll0Cj8hP6Pgyte3afmSW4ihNTTVojadiGyfIv0M/VHPygOhxG2OdmQv
         6nSMONRtf8376FIF/KQGS/Qv+xmr6bkuiJPlGmp+t0KuHcSmHkJp9a360L6pUMrca4+3
         N8F7gFl4Lq/QVZ62LMQv16tpD93KCdXPVrtfjovI7q2n8h0FdKCWra/fGZXMk6tg4C14
         bi2wt0i+CyffJ1Bfd+Bpn1Mb8YaCel9VZGBCBS0uDIMmbrGOwTpJC9KAgyQXWDsku15J
         a2ea8aDfhSt1XU+QLlhhD85Ij0Z6AjbBfUkDoaFTkWGY6A+XbH2QWfPu422vuefrabOd
         Br/A==
X-Gm-Message-State: ALKqPwew1GP1FJt4IV4Vz1A1VcUJUGQ4HsfiAb4I7AdPBGAVdVKXbZQ/
        dwpFL0HZaaZRS1TNY5H/nHVGfg==
X-Google-Smtp-Source: AB8JxZqO+MdZlaksWsUcoqBVtmSvWejLSkqMBS1evvbCBou2vxoZHDquWwrkyFo2x+NWIdghbdVCow==
X-Received: by 2002:a62:a096:: with SMTP id p22-v6mr6214516pfl.9.1526581803009;
        Thu, 17 May 2018 11:30:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 76-v6sm803960pge.8.2018.05.17.11.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 11:30:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 0/2] Reroll 2 last commits of sb/object-store-replace
Date:   Thu, 17 May 2018 11:29:57 -0700
Message-Id: <20180517182959.22961-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> * sb/object-store-replace (2018-05-10) 2 commits
>>   (merged to 'next' on 2018-05-16 at 41bbedcc81)
>>  + replace-object.c: remove the_repository from prepare_replace_object
>>  + object.c: free replace map in raw_object_store_clear
>>
>>  Hotfix.
>>
>>  Will merge to 'master'.
>
>Please do not.

Here comes a reroll with another fix, diff below, as the branch-diff did
not give a good output[1].

Thanks,
Stefan 

$ git diff origin/sb/object-store-replace
diff --git c/object.c w/object.c
index cdf520084df..97245fdea25 100644
--- c/object.c
+++ w/object.c
@@ -480,6 +480,8 @@ void raw_object_store_clear(struct raw_object_store *o)
 {
        FREE_AND_NULL(o->objectdir);
        FREE_AND_NULL(o->alternate_db);
+
+       oidmap_free(o->replace_map, 1);
        FREE_AND_NULL(o->replace_map);
 
        free_alt_odbs(o);

[1]
$ ./git-branch-diff origin/sb/object-store-replace^^..origin/sb/object-store-replace sb/object-store-replace^^..sb/object-store-replace
1:  d5873072054 < -:  ----------- object.c: free replace map in raw_object_store_clear
-:  ----------- > 1:  88d456c5d24 object.c: free replace map in raw_object_store_clear
2:  74fd0705bb3 = 2:  6da07fe2f9c replace-object.c: remove the_repository from prepare_replace_object

Stefan Beller (2):
  object.c: free replace map in raw_object_store_clear
  replace-object.c: remove the_repository from prepare_replace_object

 object.c         | 3 +++
 replace_object.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.0.582.gccdcbd54c44.dirty


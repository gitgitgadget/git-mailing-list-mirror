Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213B0200B9
	for <e@80x24.org>; Mon,  7 May 2018 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeEGOFH (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 10:05:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37592 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeEGOFF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 10:05:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id h5-v6so4978959wrm.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sTl7iFOjLXuuiN/h4X1VZqknzZB3OOY61ZrfeGRW4no=;
        b=FyfsURuD2flxT1kL+cchw1mQFEvMDb4ou1dumKrXaSTpWY9wbQRo8T00H9u9bttD9k
         ENlq64vcOZDs+B0++6IVQG4yqoSWTXdozO29QMHknd8mOlF34xcXnZuyHHm+hHNZjC/0
         K4SshgrdqOX9A604Djpp1NY8+J3Fo+ApQInYpWNeWgbD5a2wwdzqBDKvooIcwKHXqPYi
         FvWyELGKkqYwvlwMhyI/NllidDtJscdHj4qotlH8noG8yQOcMapPR45m3U4W4hXRCbrS
         p6FOAgr6Re/6P8n3P3fp97eZbBNBQL/tPAkEKIR80VlDTKNOU5BoPX0Eg1/KfM46xj7w
         sMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sTl7iFOjLXuuiN/h4X1VZqknzZB3OOY61ZrfeGRW4no=;
        b=B88CWKZhBkUdZAfsXwbtOTyW7aN2CZPrZWF2RuOpH40KtNMpmi3wxMUPw0v6IdmP60
         Elc8qIIkOeBZn20ayA6Lkef/6anm01UnmpKTKAgc9sGkMg8hiHVfnvO+4MC04yXifruY
         pNbJezSTLXIAtguT3R9ZefeINqexbtxYC44//JwTjA/44bl2cD6jkCWsREy0KKdpiuID
         wN0EFH9f7aoFIZjVKPBL4jLhWNUyu3rCtG43Wp4LhAcA14y7V4uQhY9NQjO19i5/NGq5
         hy34YBfRDMDIG9jqE47A7X8uGvd4y3HeuJ6PDvatzuWApIUSS3qrlnvkZskDmy9rlnnC
         pFNQ==
X-Gm-Message-State: ALQs6tAFydVmr8Ouu0BsVcHlikAo2Q2rQvs4ezuBK23DDNJw/HVVua2k
        f4Mm8l/DssTD9i011cmIp1w=
X-Google-Smtp-Source: AB8JxZrxu8si71d3fstJeoqNe+6r9gcj9/7jPK6o+e3nqQm10HTScjgGiQdHpKxl+uss9U7+bGs4Uw==
X-Received: by 2002:adf:d0cb:: with SMTP id z11-v6mr27302644wrh.281.1525701903789;
        Mon, 07 May 2018 07:05:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z192-v6sm1923702wmc.10.2018.05.07.07.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 07:05:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jamill@microsoft.com
Subject: Re: [PATCH 00/13] object store: alloc
References: <20180501213403.14643-1-sbeller@google.com>
Date:   Mon, 07 May 2018 23:05:01 +0900
In-Reply-To: <20180501213403.14643-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 1 May 2018 14:33:50 -0700")
Message-ID: <xmqqo9hrpnn6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This applies on top of sb/oid-object-info and is the logical continuum of
> the series that it builds on; this brings the object store into more of
> Gits code, removing global state, such that reasoning about the state of
> the in-memory representation of the repository is easier.

I am not sure how well this topic is done, but I've queued the
following patch at the tip of the topic to make it compile after
getting merged to integration branches (curiously, the topic by
itself compiled file for whatever reason). I think I haven't send
that fixup patch out, so here it is.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 2 May 2018 19:09:50 +0900
Subject: [PATCH] alloc.c: include alloc.h

Otherwise the definition in alloc.c would not see the matching decl
in alloc.h, triggering warning from compiler.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/alloc.c b/alloc.c
index 66a3d07ba2..f47a67153b 100644
--- a/alloc.c
+++ b/alloc.c
@@ -16,6 +16,7 @@
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
+#include "alloc.h"
 
 #define BLOCKING 1024
 
-- 
2.17.0-391-g1f1cddd558


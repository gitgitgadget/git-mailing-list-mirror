Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9731F453
	for <e@80x24.org>; Thu, 20 Sep 2018 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeIUD0F (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 23:26:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIUD0F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 23:26:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so10868385wrc.0
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dPdrX14Mo35j4pUuKZht77AK94IucY2Np6l3E4CGTkY=;
        b=oQB8Nw9O92ohOUYioJw1AmEOUWhPtHhuhKwgXyMFSwTSGPsf4GV7ivJB9pDdBFkO6n
         rFtHW5hNn614qGXmnkR615/hyXdNmqr2mrCBTtJBVtsWJTispW/M/292aqGO4LTXhtt3
         +NsqyGtwqGepjC5vvysL1CpnmkDwW3vhCFKWdwcpV+dDYNTYXDGFzZIlyUKTks/4z2AV
         Z1hYgf8nRnJeJKJd/RVDtwzS7b2xulmPqzK2vlslDMkURkNIjoxoeSy5DVNrVc0C6qvW
         uV8ycUTBDNX1GgZAbqDcnKqZnZtSU8gOBVNF4r+lrpMEjxI93unEUD/l/95YYs0XIAy6
         uPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dPdrX14Mo35j4pUuKZht77AK94IucY2Np6l3E4CGTkY=;
        b=WKRlHBCnghIHB/Usjoy3NvkPqB7jVpEAaB9cFxDqw9ur2Zzofy9PFM1khTI6QO2ZVW
         VE5ZPNzqiX2lutpZenc3dD9Ogak7XJc2QClzOp1ZXhOTjaXH+GMwwbP3GvxGEfgt2Zk1
         EOzRLOLI37KW8dOXXmAAVq5XYJ9fj3MGeDkYXfpRxDrvmZisSjjZrPjrm5rpzIXc3vtD
         VDErvwp6W/s6c1aBpvARVNubS61BqiKPOiCrSY0vEX36DmVBUzYRbP7qd+wWSRcm2Qjh
         CXBI5eW6q+ExSnJSsofv15aK0twEiVpqa0PlRiS3snoQJf1AgospjRY3PjZFWX7c91Zu
         JKzQ==
X-Gm-Message-State: APzg51CWilyTwXGjHQdg48Y/yEmTTu3bZ7pd9CAVrinWkzShDI4OeZUg
        AV7JqsS90lrfN6wQUE6kC8k=
X-Google-Smtp-Source: ANB0Vda6KIlgVxZXhsXRDpyQBlpdQR+AYlQpc+xWT+LeS4462efJONdAJZIqfgc0gDJamGRs6irLQw==
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr32796379wra.19.1537479630521;
        Thu, 20 Sep 2018 14:40:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e133-v6sm4659518wma.33.2018.09.20.14.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 14:40:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, smaudet@sebastianaudet.com
Subject: Re: [PATCH] add: do not accept pathspec magic 'attr'
References: <20180917015259.GA26339@sebastianaudet.com>
        <20180918173159.30300-1-pclouds@gmail.com>
        <xmqqk1nh47no.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 20 Sep 2018 14:40:29 -0700
In-Reply-To: <xmqqk1nh47no.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 19 Sep 2018 12:19:23 -0700")
Message-ID: <xmqq36u3zw36.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> Commit b0db704652 (pathspec: allow querying for attributes -
>> 2017-03-13) adds new pathspec magic 'attr' but only with
>> match_pathspec(). "git add" has some pathspec related code that still
>> does not know about 'attr' and will bail out:
>>
>>     $ git add ':(attr:foo)'
>>     fatal: BUG:dir.c:1584: unsupported magic 40
>>
>> A better solution would be making this code support 'attr'. But I
>> don't know how much work is needed (I'm not familiar with this new
>> magic). For now, let's simply reject this magic with a friendlier
>> message:
>>
>>     $ git add ':(attr:foo)'
>>     fatal: :(attr:foo): pathspec magic not supported by this command: 'attr'
>>
>> Reported-by: smaudet@sebastianaudet.com
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  Since Brandon is currently unreachable, let's do this for now.
>
> Thanks.  This certainly make it better than the status quo.

And of course, there is an interesting glitch found after I almost
finish day's integration cycle X-<.

-- >8 --
Subject: [PATCH] fixup! add: do not accept pathspec magic 'attr'

[Add the following when squashing]

Update t6135 so that the expected error message is from the
"graceful" rejection codepath, not "oops, we were supposed to reject
the request to trigger this magic" codepath.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6135-pathspec-with-attrs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index 77b8cef661..e436a73962 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -164,11 +164,11 @@ test_expect_success 'fail if attr magic is used places not implemented' '
 	# when you attempt to use attr magic in commands that do not implement
 	# attr magic. This test does not advocate git-add to stay that way,
 	# though, but git-add is convenient as it has its own internal pathspec
 	# parsing.
 	test_must_fail git add ":(attr:labelB)" 2>actual &&
-	test_i18ngrep "unsupported magic" actual
+	test_i18ngrep "magic not supported" actual
 '
 
 test_expect_success 'abort on giving invalid label on the command line' '
 	test_must_fail git ls-files . ":(attr:☺)"
 '
-- 
2.19.0-216-g2d3b1c576c


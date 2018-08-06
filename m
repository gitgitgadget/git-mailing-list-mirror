Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDCF208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeHFTxG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:53:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40295 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeHFTxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:53:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19-v6so11270367ljc.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FTzBc+vyWsPJld2EdvluIKOgD7ZFWO6Yy0gRIiR9du0=;
        b=ajUxjEhRmFkQNNoBQIgb3IZ6h+8Tl0jt+xq08XSbRt/YAKu8W0/nCVQFvyKOwPB1eQ
         Ps32GJLqtZw8mi+j3inSGAZjhFm15qkRDtntdIcme1Gnu+g9lyUt5r5HUUOBQAQmFqR7
         9RxN4emZZbsePfQYIQFpo9p6+CSyGMYBQjc6ue5XYkoZkBe5W7RRjSz9aPb7LRn664Ow
         ttIcubbQzg9cyYrSXeCjVU3vLlmMZOyd0zXnId5HxcIJTOlVG9JaCixWhYzUN1NPiMmq
         V/y0SFnlvR8eyMP6YzIe+UKVyiPdf65tL+seFpU7JORnH8u5SiJyCKWoKS2+EWbAGKnN
         Lxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FTzBc+vyWsPJld2EdvluIKOgD7ZFWO6Yy0gRIiR9du0=;
        b=UCP6d9WnthvkSpdbpxLkdMT/gmj9osAiqQc+mX7NbuvUkry89ouv0fGp2Zev2Tfsmx
         /9W7qFarP0TTQGUFShFbvaR2gmu2UPlLhd9K6HWRoqpR0ZQkXWzgpoPVeDfRygKFnQW/
         uG+M27wP167cx5jSq0CJfrKyoK3tT6feZttjfdc7+bETLcik10I22+G2LSML9XVan2Xf
         vVWe6jNxUgq3dyUfvmjC41ztRYgKS+i5P+GtrptgN29dWDBmiEKJR1oBvv7BcVeXfJE4
         1J9eBQgMMfX+1bswawEfKX0dx/AzMJjz+uA6oCHOqVLf6f+X82/MsJZDjxvrIHY1UUsC
         KdBw==
X-Gm-Message-State: AOUpUlGsrTS68dazi3/oenaD2hXNhEYiYoS/mjZ/q9GbAht9dl4gWW6i
        1hdDKoS0nd1+noE4q0jLoLE=
X-Google-Smtp-Source: AAOMgpcMbV5je2olgfn+t8tQz1KE4EO/ZWroJthdJ0C4CIFju3ics/zykB7Y/EiUzTKpHryXfAdMyg==
X-Received: by 2002:a2e:94d5:: with SMTP id r21-v6mr12969764ljh.126.1533577376553;
        Mon, 06 Aug 2018 10:42:56 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id q14-v6sm2318893lfq.7.2018.08.06.10.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 10:42:55 -0700 (PDT)
Subject: Re: [PATCH v2] t4150: fix broken test for am --scissors
To:     Paul Tan <pyokagan@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
 <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
 <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
 <CACRoPnTWxYvGfqgGt2r5ETOhfJZnqr1fTO9Fzwp-u25XbMGPPQ@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <a50da318-1f15-3dc8-53e0-c40365a053f7@gmail.com>
Date:   Mon, 6 Aug 2018 19:42:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRoPnTWxYvGfqgGt2r5ETOhfJZnqr1fTO9Fzwp-u25XbMGPPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-06 10:58, Paul Tan wrote:
>> +       git commit -F msg-without-scissors-line &&
>> +       git tag scissors-used &&
> 
> Nit: I'm not quite sure about naming the tag "scissors-used" though,
> since this commit was not created from the output of "git am
> --scissors". Maybe it should be named `commit-without-scissors-line`
> or something?
> 
>> +       git commit -F msg-with-scissors-line &&
>> +       git tag scissors-not-used &&
> 
> Nit: Likewise, perhaps this tag could be named `commit-with-scissors-line`?

How about "expected-for-scissors" and "expected-for-no-scissors"?
Junio, I'll send out v3 with updated tag names, if that's OK.
Also, squash-able patch below.

> So, this patch fixes the 3 problems with the tests, and so looks correct to me.

Thank you for such thorough review.

--- 8< ---
From: Andrei Rybak <rybak.a.v@gmail.com>
Date: Mon, 6 Aug 2018 19:29:03 +0200
Subject: [PATCH] squash! t4150: fix broken test for am --scissors

clarify tag names
---
 t/t4150-am.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bb2d951a70..a821dfda54 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -155,14 +155,14 @@ test_expect_success setup '
 	echo file >file &&
 	git add file &&
 	git commit -F msg-without-scissors-line &&
-	git tag scissors-used &&
+	git tag expected-for-scissors &&
 	git reset --hard HEAD^ &&
 
 	echo file >file &&
 	git add file &&
 	git commit -F msg-with-scissors-line &&
-	git tag scissors-not-used &&
-	git format-patch --stdout scissors-not-used^ >patch-with-scissors-line.eml &&
+	git tag expected-for-no-scissors &&
+	git format-patch --stdout expected-for-no-scissors^ >patch-with-scissors-line.eml &&
 	git reset --hard HEAD^ &&
 
 	sed -n -e "3,\$p" msg >file &&
@@ -421,8 +421,8 @@ test_expect_success 'am --scissors cuts the message at the scissors line' '
 	git checkout second &&
 	git am --scissors patch-with-scissors-line.eml &&
 	test_path_is_missing .git/rebase-apply &&
-	git diff --exit-code scissors-used &&
-	test_cmp_rev scissors-used HEAD
+	git diff --exit-code expected-for-scissors &&
+	test_cmp_rev expected-for-scissors HEAD
 '
 
 test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
@@ -432,8 +432,8 @@ test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
 	test_config mailinfo.scissors true &&
 	git am --no-scissors patch-with-scissors-line.eml &&
 	test_path_is_missing .git/rebase-apply &&
-	git diff --exit-code scissors-not-used &&
-	test_cmp_rev scissors-not-used HEAD
+	git diff --exit-code expected-for-no-scissors &&
+	test_cmp_rev expected-for-no-scissors HEAD
 '
 
 test_expect_success 'setup: new author and committer' '
-- 
2.18.0

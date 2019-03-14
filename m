Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D48B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCNFze (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:55:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNFze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:55:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id t5so4435608wri.7
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F0rKfHh3wyXjlaLP5eBn+57hKJInwluNMY/Utv0nhho=;
        b=sIFv5SDYkWLL65K4J8gJ0u/IEsS791NIR6cCa8lwj96WKQz9T5H4yobzT2tjBcnLAP
         w7Qtk4uaa65zwFYTNLft/2x9wHtlHUraHaJ7DcU4FO2HZ21mE6kh6KeQ2IiG/1z+Vrkj
         /YA2VC5kXZ/vo4rNK8MjP4axGOKDUkY8Y8++h1NfyowqQ6LaHVN85uDq/k5M1cSra85f
         1gDwbR3njvvaw52wbCyQ46NiXRrdtIUTiRpmm1s0YOgDmFPyvOwWGdmCHDaa9odxgH76
         UKdoA70MeQZAAmeOyNPFDvP8IFbaLZQcSYyajBlCZLPx4RuAUzbI5u5QO+VmS7UuynPN
         OCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F0rKfHh3wyXjlaLP5eBn+57hKJInwluNMY/Utv0nhho=;
        b=SgDoNDqTK5TABlZp08aMH9aU0nUGeykgHeXMQQYPHXM9UsL7buvpUZ/2RhxWybSCq0
         z+9f1toWnrQeCWHtioRFsvZeY5QYqOoxsa6BDUuL9k4iatWbzXi5d6PifsIt1LTTf2Xh
         rZHX5g7yUzFhSApnHglTXO9t8DTeidT5p3rXWe/lSjJJ2cHhacMkFcHqPYCueCLyEmNo
         eO+0SzbWRqD2uafIow2XKzQPH3KbeefYRM3fo0jXNBfeiyxTjuXV5kDoso2fz3ee2P1/
         2Z0Xq5oCRcrekQS04daqTPMjIl2PYqlRr1KYwgA0n88puTObrIhfyYsXBaQQSAUydgTd
         El2g==
X-Gm-Message-State: APjAAAVX0XjApfUnDXoJ5MzLQOX6mEghpRZBWnywjkGcWaEtb+geA+8S
        Xt995jfvUAhZtTyi86OmMFo=
X-Google-Smtp-Source: APXvYqy+7+RZjR3P8C/9q2Prye+AZQ6SDvQpAjxq2tKdopkYmqFoJZZYm+8+0iZzBx5x8rYBG6EYdQ==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr30034037wrv.121.1552542931049;
        Wed, 13 Mar 2019 22:55:31 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id p5sm1699796wme.14.2019.03.13.22.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 22:55:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v1 09/11] t: add tests for restore
References: <20190308101655.9767-1-pclouds@gmail.com>
        <20190308101655.9767-10-pclouds@gmail.com>
        <xmqq5zsm9ffv.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 14 Mar 2019 14:55:30 +0900
In-Reply-To: <xmqq5zsm9ffv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 14 Mar 2019 14:45:56 +0900")
Message-ID: <xmqq1s3a9ezx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'restore -p without pathspec is fine' '
>> +	echo q >cmd &&
>> +	git restore -p <cmd
>> +'
>
> This stands out as a sore thumb, being an invocation with '-p' while
> all the other tests for the '-p' feature are in t2071.

I'll have this inserted immediately after 09/11 in the meantime.

I wonder if there is a clean way to make everything in 2071 with
PERL prereq.  I generally do not like the pattern used by some tests
that manually check the prererq and have test_done early, though.

Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 14 Mar 2019 14:48:47 +0900
Subject: [PATCH] SQUASH??? move -p test to 2071 from 2070

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2070-restore.sh       | 5 -----
 t/t2071-restore-patch.sh | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index df91bf54bc..3dc7032839 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -23,11 +23,6 @@ test_expect_success 'restore without pathspec is not ok' '
 	test_must_fail git restore --source=first
 '
 
-test_expect_success 'restore -p without pathspec is fine' '
-	echo q >cmd &&
-	git restore -p <cmd
-'
-
 test_expect_success 'restore a file, ignoring branch of same name' '
 	cat one >expected &&
 	echo dirty >>one &&
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 46ebcb2413..98b2476e7c 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -16,6 +16,11 @@ test_expect_success PERL 'setup' '
 	save_head
 '
 
+test_expect_success PERL 'restore -p without pathspec is fine' '
+	echo q >cmd &&
+	git restore -p <cmd
+'
+
 # note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
 
 test_expect_success PERL 'saying "n" does nothing' '
-- 
2.21.0-155-ge902e9bcae



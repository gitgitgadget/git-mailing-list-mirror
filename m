Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C071F597
	for <e@80x24.org>; Mon, 30 Jul 2018 22:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbeG3Xuq (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:50:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45550 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeG3Xuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:50:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16-v6so4709605edq.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IZQNAIeeM6+LNOxM1U+SPuSX6dWFl8AJmvbH1YHbFU=;
        b=q7Kt0YfEhg+5NIbvJFHpS1U96jDbjh8xY1bvy1lg6tB9sMcWrJ5xjoXBYV3GxZ4BsZ
         twD3ti1hTq1t6avvaZHg+KKK2yRWmZ8bXeC9Td17bT7u2+8YnnC5ovg1fRXJNjZ3tdpU
         FjZE5sW39Bt1CLuSYXYEok8Po8Cd+WPAP6mRZWEV2xmZPdsZUWjs5ZtUudV/JYQgnZt0
         WOsTN7Vr/eYK4nX+00RYGTNcRwhm3xi0wPaC9WhY1rkwxfjyCUlbNozNBiL1Sg86N+/y
         v7ozFSFAUL70zTz8Tkgq3NMWMpWY6HGTC1G1zWxShxCgUEpBDW+6XtFAvYQYE58s+TfS
         /DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IZQNAIeeM6+LNOxM1U+SPuSX6dWFl8AJmvbH1YHbFU=;
        b=d9fQMhRhXMZkLtvpZOl4U7J9KAAWTwfbYs4XbAWV18zsoHPSjECyjiL4EeYO/BCpUp
         AFuESBBNY9kUrBamFgarobcVCq40RoOuT6JSGCYvYRDSOWG7/SPhGAyk5jZ5VDNZoTFu
         5YALwbekgvH4Q+FQKa5VxcezDVWuZcBEClE31Mm0QkApgKZaKt/ufGVRll+mU3xYbVYm
         e7HcszBvzZDVebONTYDCk33YqNAoyDduIt1o3f9aeoOfuSXv3fROYuNBtMg7KmNefUH4
         qc1G9rbvyj5btk0pc7yPamZlVMmjLbhpsqVKVgQZJPLenFQnX7vUFTx+70Fc+JBy0EXf
         Dn0Q==
X-Gm-Message-State: AOUpUlGafYKlPlF3fc6XxuXCfLqSNlnCYNF85j5kX768ljbeBMWeHjqk
        xiYFRVelbIMR95cuT9AutE4=
X-Google-Smtp-Source: AAOMgpf5UfaofGU28G4rt3ElPfHwkn3knc+bqrC4aBRvDDsMEWg7MFlzYfpzFLF16GOPilkdCC1fGg==
X-Received: by 2002:a50:9fe9:: with SMTP id c96-v6mr9692270edf.17.1532988822454;
        Mon, 30 Jul 2018 15:13:42 -0700 (PDT)
Received: from localhost.localdomain (x590d1455.dyn.telefonica.de. [89.13.20.85])
        by smtp.gmail.com with ESMTPSA id u3-v6sm2468486edo.44.2018.07.30.15.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 15:13:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 00/10] fsck: doc fixes & fetch.fsck.* implementation
Date:   Tue, 31 Jul 2018 00:13:19 +0200
Message-Id: <20180730221319.8991-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180727143720.14948-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com> <20180727143720.14948-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


't5504-fetch-receive-strict.sh', in particular the test 'push with
transfer.fsckobjects' failed on me while building this branch the
other day, caused by 'test_cmp' failing, because 'git push' didn't
print anything to its standard input.

I was unable to reproduce the failure with the usual means (running
the test repeatedly for a long time while the machine is under heavy
load), and given that this test has a history of raciness[1] with the
same symptom, I'm not sure whether this patch series does something
wrong, or perhaps the fixes[2] are incomplete.  Or the Blood Moon.


Sidenote: I found some of the error messages from the expectedly
failing 'git fetch' and 'git push' commands misleading.  Some of them
output "fatal: object of unexpected type", even though the original
and the corrupted objects are both of the same type (blob).


1 - 8bf4becf0c (add "ok=sigpipe" to test_must_fail and use it to fix
    flaky tests, 2015-11-27)
2 - five commits leading up to c4b27511ab (t5504: drop sigpipe=ok from
    push tests, 2016-04-19)


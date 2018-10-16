Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3D11F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeJQHCb (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:02:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37628 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeJQHCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:02:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so27424458wrd.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=sYq8i55PzQJhizvnZBRJdfwzidMpLfcuIioleYbmoKw=;
        b=GIyIvzhyXPxgBsoTrVbi39w1vr1hPJWLX4ZAN61845ubljTo0m7cjkpzqJMW9CH//m
         KxBNacmaWL66FYHbFIjQswd3Ssu3rPkSqlasoJOfY5a66PSe8BRpoHmcONmD/rt6LJGt
         omoif08rUxGvGfJTiFuXrfezMM14fP1PHlP+c/Pzt48xB9XC+W8DD18fpodOmYmtpeIJ
         zvdPmkqZCQooCW9HAC4mRABM78TmMvR7LUR9GyJ/1+AyPtQJeyZ6kDApBkgbYuB21Om7
         c6+BIEewlh5JdaLKOXmAv4Joo4M7Qt+lEtKjdiGrYJqKpGZ/8RhzqH66Wu2EzF+C8thS
         TO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=sYq8i55PzQJhizvnZBRJdfwzidMpLfcuIioleYbmoKw=;
        b=BtQzEPi+DciSsCRrRCtNBepGp3uKACjR/ZqKHjgCOCRlcjbJRnMXfUMgEEKoz13H7E
         rbbuSIKql8S7MjNqrEbFDYH0CY0QJttbRwYtuUQ8b0o2DJyZ2i8OEbU95YD5aZDUraJC
         Bt9nAGAQSJDn+pwKr8KWEatZ+Ctg6Ffe3b1Om0Er1OMcrTIvFy7w3/L3wCnZX84DPRDc
         HaBz+1vKVohLweuMzXwq1ulkCMNcBVqeL68PnFyS5u6Bbtlo2MJTHLQXiilsewddI0dW
         RGZPuCIgs+CZ7A4Uje4LQPC3pirI9drzWSVruw6yvCTMP/MeOcEi6FJV8idAk3nU8XRn
         XR1g==
X-Gm-Message-State: ABuFfoja399f/pPsJaTsdqvps4xNgxRPn2cBaPw2ecQ1d9AZ2uwiaDOL
        3jkKsbKiZ4xrXcjxZ1P1I/w=
X-Google-Smtp-Source: ACcGV62hY/E8d4zxFZ384709XTauMZnhjvwhdrzts9Da3bV0h0tqSi8CoVl5WgDmxszT/BzRPAA6SA==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr20521271wru.105.1539731390326;
        Tue, 16 Oct 2018 16:09:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o201-v6sm105536wmg.16.2018.10.16.16.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 16:09:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] branch: introduce --show-current display option
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com>
        <20181012133321.20580-1-daniels@umanovskis.se>
        <CAPig+cRCfO=3BB6bvDSKLKkhiSA-4=p4-zZkAXvN446_6B1_HA@mail.gmail.com>
Date:   Wed, 17 Oct 2018 08:09:48 +0900
Message-ID: <xmqqk1mhxzcz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +test_expect_success 'git branch `--show-current` works properly when tag exists' '
>> +       cat >expect <<-\EOF &&
>> +       branch-and-tag-name
>> +       EOF
>> +       test_when_finished "git branch -D branch-and-tag-name" &&
>> +       git checkout -b branch-and-tag-name &&
>> +       test_when_finished "git tag -d branch-and-tag-name" &&
>> +       git tag branch-and-tag-name &&
>> +       git branch --show-current >actual &&
>> +       git checkout branch-one &&
>
> This cleanup "checkout" needs to be encapsulated within a
> test_when_finished(), doesn't it? Preferably just after the "git
> checkout -b" invocation.

In the meantime, here is what I'll have in 'pu' on top.

 t/t3203-branch-output.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 1bf708dffc..d1f4fec9de 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -119,12 +119,14 @@ test_expect_success 'git branch `--show-current` works properly when tag exists'
 	cat >expect <<-\EOF &&
 	branch-and-tag-name
 	EOF
-	test_when_finished "git branch -D branch-and-tag-name" &&
+	test_when_finished "
+		git checkout branch-one
+		git branch -D branch-and-tag-name
+	" &&
 	git checkout -b branch-and-tag-name &&
 	test_when_finished "git tag -d branch-and-tag-name" &&
 	git tag branch-and-tag-name &&
 	git branch --show-current >actual &&
-	git checkout branch-one &&
 	test_cmp expect actual
 '
 
@@ -137,8 +139,7 @@ test_expect_success 'git branch `--show-current` works properly with worktrees'
 	git worktree add worktree branch-two &&
 	(
 		git branch --show-current &&
-		cd worktree &&
-		git branch --show-current
+		git -C worktree branch --show-current
 	) >actual &&
 	test_cmp expect actual
 '
-- 
2.19.1-328-g5a0cc8aca7


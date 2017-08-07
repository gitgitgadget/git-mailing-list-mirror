Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE5F2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdHGOjd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:39:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38625 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGOjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:39:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id h75so572715pfh.5
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hNIPk6LVdkCl4VWLZjdKuS/H6BxkboKowWaAX09IbZE=;
        b=padQ4XEKtYkjUiJ3xda040mUXK8AkIqawZ4OlLcVE4PDCxA0+8s77+Q/K0KRRsiSoC
         kitI6m50vF93KHXPFadb9m/N1L0zThcnd1UXwoqd7ByNaXzlZR170IOIVd+tMuDve30f
         cTPHJsHhAHuv/VKHRCJrmc3O5jxqW9gcSQXnWcNkxS8qSrf3p/c5uZkjR/DfIwJ+zljh
         4HF48L6x5zKdwrZiI/Pf6X0/BqD9qtVDIQQa0nHYIllF9LXbK7pPYVrTkNVczBUrtyVq
         92nWmHF4jg4Luka6pfH+0qXK3bqc5HfmSt1hpdO1SaHPHGwt7IPD4rpp/YEIqvO9d8Dh
         Dv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hNIPk6LVdkCl4VWLZjdKuS/H6BxkboKowWaAX09IbZE=;
        b=cKPHln62yLUOryxvopwoSvddK5EzU/+PSVRczRqu1FhQaVmiGYFZ0J5uzWfrOuA2fV
         KJ1AnNEAMkzZoZH7S/XrWq+kfv78WLeCkZCMtHE97+vOrC6yhLPqf0PpULyCg5+DPt4x
         pDAt47zKMlOEZia8eMJlOWK8/2w153kX2s25qtuN0xKqFrBHI+vhsUZZ7CEmnVbsZW1J
         3jHvVBEAe5S4/sZij+iy846HHQPitFKYGoFcL1artW1WUtw1ampy5ju2wx9IcKmKUQHn
         x7PSET1rZF9HwWDqYs1R19suF60u3UzB6SaIwjWyccuwA6Q0iT6WPq/ZszCk2+gTjRSM
         lPJA==
X-Gm-Message-State: AHYfb5hawSe4ZfC2HFjUST+ctgpj69k9628WM8dneIS98WK8lHWcirQx
        qa1SOVmSxgGkLRUjihA=
X-Received: by 10.84.228.214 with SMTP id y22mr857330pli.245.1502116771864;
        Mon, 07 Aug 2017 07:39:31 -0700 (PDT)
Received: from localhost.localdomain ([117.249.222.33])
        by smtp.gmail.com with ESMTPSA id u69sm15279812pfa.70.2017.08.07.07.39.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 07:39:31 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: Can the '--set-upstream' option of branch be removed ?
Date:   Mon,  7 Aug 2017 20:09:36 +0530
Message-Id: <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I refactored builtin/branch.c to remove the '--set-upstream'
option,successfully. The corresponding patch follows. 

There's just one issue with the version of git that doesn't
have the '--set-upstream' option. It's described in the commit
log message of the following patch.

I guess it would be difficult to detect the removal of the option in
case it's used in scripts and might cause confusion to users?
Is it ok to proceed with the removal?

BTW, It's now clear  to me that removing '--set-upstream' has nothing
to do with merging the two parameter of 'validate_new_branchname'.

-- 
Kaartic

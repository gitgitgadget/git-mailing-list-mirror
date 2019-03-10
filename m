Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4ABB20248
	for <e@80x24.org>; Sun, 10 Mar 2019 08:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfCJIIC (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 04:08:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40077 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfCJIIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 04:08:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so1581023pgo.7
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Txbvw3ykeK0tHI3h7wW9bM1dZVlB7b9I81arU3APvWM=;
        b=ow6bScpasW9MCC1juorxtdpUtrFiX68zHknHjfGkAUE4/J5++q3hRkTTn8lk7v8sJ1
         X8+/6i9MvZ9LUE0h5l4IXZm7bFSOboOAsTQDjWtaVvLIMAWhe984AI9mree29NSCkqxl
         4cOxGIBZz8Y0WjI5DCt/WILtX67MMvXLYWrvGu4RJCg+QO3BvWaehw/TQmrdpR25/Ngl
         gSwKxvi/ygZfNz6y+Fc2opfe7Ob6Z6sab623yVF2kiAm6v3AtvK2er5hRETLnHsDfFag
         nO1sw6p+rSoCdrPXR+kyJw+oVBWhrvUvQYG7rA2sBmdKQrbxGD51cRo7xvWJKBPHN6vu
         RnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Txbvw3ykeK0tHI3h7wW9bM1dZVlB7b9I81arU3APvWM=;
        b=HGmk255CjFGX8ssCG0dR82MvLtPKFhjHoqDAQHmWheIG1VrFKx3EfkgzIZ0Uz2TH66
         tbnEZG5VzV1tGLKQkZoqgkVRR3jEM6M+VVEgulQlxj/I3AeDzY6DlGcj/Jlule1aR3mB
         up+AW6nxXcIFC5BUWLUP44aKHOGRYmPQ6gCCHw+7t/ZnCyc4iK+Vo8Gt/hqs8D3BQ6v8
         vJMqzSJxH6uLbuOxLmy5gENf6GMR6gNeLVXTqwALViq2TOI2J/5uoeMS0pXbgTFcc1/4
         oGvz+0IH1+UMjDE8l8io9cT33DbuOVfearSvnyBgmak1iuR9IV2/MBF3RY9oUTx82TfD
         MAcA==
X-Gm-Message-State: APjAAAXb70H5IVTlQcJ0q6e1Q/qXszg6Neu8Eit86sQkEjJSNo4X9sDj
        smNEgZMY1BzWk0oEriwut3U=
X-Google-Smtp-Source: APXvYqyR69g+TzkA5dP0Lt4EeGmeIK1XWzXOXEbmELFdCXAZhxidJVXQtZe5UrLtE9M99o849H/bsA==
X-Received: by 2002:a63:fd12:: with SMTP id d18mr23903551pgh.88.1552205281213;
        Sun, 10 Mar 2019 00:08:01 -0800 (PST)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id x15sm3381894pfn.74.2019.03.10.00.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Mar 2019 00:08:00 -0800 (PST)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: [GSoC][PATCH v2 1/5] t0000-basic: fix an indentation error
Date:   Sun, 10 Mar 2019 16:07:39 +0800
Message-Id: <20190310080739.63984-1-ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190309164508.GB31533@hank.intra.tgummerer.com>
References: <20190309164508.GB31533@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the reviews.

Here are the changes in the second version:
	- bug fixes
	- add preparatory patch
	- seperate different files to different patch
	- change to use test_line_count in a seperate patch

Also I found that there is no such function as test_char_count, 
is it worthwile to add such function? Here are some stat:

`git grep 'test_line_count' | wc -l` = 626
`git grep 'wc -l' | wc -l` = 294
`git grep 'wc -c' | wc -l` = 68

-- >8 --

This is a preparatory step prior to removing the pipes after git
commands, which discards git's exit code and may mask a crash.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b6566003dd..53821f5817 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1132,7 +1132,7 @@ test_expect_success 'git commit-tree records the correct parent in a commit' '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
-	     parent=$(git show --pretty=raw $commit2 |
+	parent=$(git show --pretty=raw $commit2 |
 		sed -n -e "s/^parent //p" -e "/^author /q" |
 		sort -u) &&
 	test "z$commit0" = "z$parent" &&
-- 
2.21.0


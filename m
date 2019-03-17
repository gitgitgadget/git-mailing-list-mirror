Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E155320248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfCQKQD (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:16:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35422 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQKQD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:16:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so9304424pfa.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JEUcjZWzAIG9eXYnfQ0anKegnuSK2H+kNBChGsHs26g=;
        b=bgXs/JCP/xAXxmgyvlQZAo96JrZNP0aSRz/ky7Ta1SQYz1Kyf2SA7Qq8ryWgSPgns1
         S3AnZErJ+oqNVlC/yqV+Yg3d9V+4TOuOAeimgfuPx22w52Mh26/1Cp7Sq2gWZJHsMcLB
         gQPh/VsyyUMCfjX6cTrUzinTCF6MR21Mi0XeTIbN2lW9M9JCe95aFwib02yAgbqETDJE
         +Ruz1xbgM0aW44MkGHXa6joPRzHkZCJgytesEEkhsM0ChRIpC9chZ0iUIeceOmbfNMK4
         aKOh6ioIU2rLbLDs+6tylV5tMLpsLBGRWlu5AFx9pyjILBTYPIWms36MfmI+K161LGEl
         f9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JEUcjZWzAIG9eXYnfQ0anKegnuSK2H+kNBChGsHs26g=;
        b=iHsHzxVzwHoBSNRlrwmFkYygO55yFrid68+NoDX7VD8x0p/p9IwT3pzNmP6wV4kGa3
         Cf5QDs4pJq59HoSBPqp2ki6imNYVWPJVjuPpqoAxpGb8tEhPM/DULxBLKygJoRP9uwPZ
         KUDE1iFPS5trzjnad0VO2dyUlFy/U83FjN44ZS4RZ6oNEutXZHYpj8FFX/o6CJqWuDkC
         KSv0HyIICanOUBJRF66JJJxoGn0Su6sPKLMODZv9+FDTGrx2Hy4yOd3kxtYEC2G39BAb
         /cjT8yN3TirLbNHuwVyOyb+OzSsB8kiwsz3HVGe8aNTsuXbSOxrKSzCPsP2w9wiI00Vo
         oYSQ==
X-Gm-Message-State: APjAAAXucTwdHlyKDRnmWqDkh0aWAur9eqtPMj6aPJ3nnIbf08eoKpmN
        sPpqikpwshIcoIZOmfCwsoXw54Im
X-Google-Smtp-Source: APXvYqxdBu+OWiHZVl5rr0u/I/FB9ufor8AkRFqnely5eosy7xVKSvMtUTc+p33IuHJyrJy3mreRHQ==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr14212135plr.188.1552817761803;
        Sun, 17 Mar 2019 03:16:01 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id f65sm11882167pff.21.2019.03.17.03.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:16:01 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:15:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 03/11] t7604: refactor out Git commands upstream of pipe
Message-ID: <9db7453b4e2b7221a039aa18509589e5c4f662b3.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, we had some Git commands which were upstream of the pipe. This
meant that if it produced an error, it would've gone unnoticed. Refactor
to place Git commands on their own.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7604-merge-custom-message.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 89619cf446..b045fdb413 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -36,14 +36,18 @@ test_expect_success 'setup' '
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
 	git merge -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp exp.subject actual
 '
 
 test_expect_success 'merge --log appends to custom message' '
 	git reset --hard c1 &&
 	git merge --log -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp exp.log actual
 '
 
-- 
2.21.0.512.g57bf1b23e1


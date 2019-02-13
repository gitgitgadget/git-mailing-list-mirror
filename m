Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767821F453
	for <e@80x24.org>; Wed, 13 Feb 2019 23:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfBMXbj (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 18:31:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35144 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfBMXbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 18:31:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so4271730wmt.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 15:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hEZGhWGUiFrPRwsZJ0tt2CrsGxtrecNZ0HAvtQNPLeU=;
        b=dzTpvoU5sEktFtmLoyebWn9cbEqXAjHM2n0QeiHDWQZtsyzKIUUmfnhFoPtx0B1SHh
         7Cz5rJUp8Iwz2YHByVnzBQbeyGhgNfYrP1ucFeo5X9LHE+RsqCBBTVtG/iKRiXwd8Q9u
         jStDm0YBR0UNynqlxTBkTLt8VNxqjRD6VB9nnyH/Gl7t1mk37E4qfqzdnO7zJWvahWuK
         JuXUxPkPvZaqaP3bR0VJP8yZ0mQCFPCkDzPncJz1oqexY582UyeoO0O0JTkeydA4AT1+
         SOgSIOXxSkXdc5dYs+7GI40MdZYFTbyz7xnVjveTzFimVdZ5AhTnCogWVjJRVje3Om5T
         e9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hEZGhWGUiFrPRwsZJ0tt2CrsGxtrecNZ0HAvtQNPLeU=;
        b=YyzZ4AAW7pjBubhfAueRfZUuDBcpXbeApQEN3Cq0MZof72Bv3CEq6Z9EycOGobTEgs
         /8Dtqkqyq7ZwQvFIap46mvUUUaT7/3SaFmVdCOGg5kL9kWYHs8gYuo2rB0lGhMxepLS9
         t3zwbUhaircAlVOGF3G0QoYhbHQfB0zxlw0A4CA6tsrbHbLqk8lm3KYR3XMfpYpiS0yE
         fvePNdhD0zEr2Dgzn2cXdD5zjxQqg8hTYhD6uvEhdADO3bJAmLVuKX0Ef61WClioytHt
         aZk1VzQfTeb3TUY2GRvBbR3EsoMdRC4zUkzSMrT6JYDSeCmTVAW1QsdkS2Rftb2ufbCk
         mE3Q==
X-Gm-Message-State: AHQUAuZp293LSN8h3agFhPFMeK3v1uxwPmurnFTXbDlZcLLDCHRuNyqP
        7c97iZJJzxYN+1ZYTpEjI0g=
X-Google-Smtp-Source: AHgI3IaaUqLFhZfnUWqAGrq0EWK1ffR4r0/tafAxZGAUAFrUy6TzyJytMsNXlbN2xPJkSx3IOQxtHA==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr415389wme.114.1550100697005;
        Wed, 13 Feb 2019 15:31:37 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r14sm418104wrv.77.2019.02.13.15.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 15:31:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 5/5] blame: add tests for ignoring revisions
References: <20190212222722.240676-1-brho@google.com>
        <20190212222722.240676-6-brho@google.com>
Date:   Wed, 13 Feb 2019 15:31:35 -0800
In-Reply-To: <20190212222722.240676-6-brho@google.com> (Barret Rhoden's
        message of "Tue, 12 Feb 2019 17:27:22 -0500")
Message-ID: <xmqqef8b9sfc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> +	git rev-parse Y > expect &&

Not limited to this one, but lose the SP between the redirection
operator and its target pathname, i.e. "git rev-parse Y >expect".

> +	sed -i -e "s/[0-9a-f]/0/g" expect &&

Don't use "sed -i" in-place rewrite, that is not portable.

In the meantime, I'd patch it up with this so that we can keep 'pu'
working.  Placing "git rev-parse" upstream of a pipe is not kosher,
but in the meantime...

 t/t8013-blame-ignore-revs.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 3a4ad7cf93..e3396a78d0 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -57,8 +57,7 @@ test_expect_success ignore_rev_adding_lines '
 	git commit -m Y &&
 	git tag Y &&
 
-	git rev-parse Y > expect &&
-	sed -i -e "s/[0-9a-f]/0/g" expect &&
+	git rev-parse Y | sed -e "s/[0-9a-f]/0/g" >expect &&
 	git blame --line-porcelain file --ignore-rev Y > blame_raw &&
 
 	grep "^[0-9a-f]\+ 3 3" blame_raw | sed -e "s/ .*//" > actual &&




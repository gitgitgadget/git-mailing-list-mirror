Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11572211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 10:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLBKH5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 05:07:57 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39261 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLBKH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 05:07:56 -0500
Received: by mail-pf1-f177.google.com with SMTP id c72so4906028pfc.6
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 02:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l/GLGRj09ZztoQAYHyCfETVcz9G0gXuUBxfiop2Bn88=;
        b=BkCD3r3Us+8/ghNTwD+kEGnpgm7xt+M11VnRuF/c9pktzUNhDEK6IZJfpDBdQ8LRkH
         YMrekWCIUhszYf7TBniguHkJ6q6ChGN+udxWixXjrvdfBy/NCF9+ldaBHBUf1hl5OlGo
         QH4pTej5q/tboOno+HK/RQMHBDeOTOcDwMtGMv0QfXmtZXrkU8jfXPVhXLbWyiL67Hax
         AlhbCqdOm1P8hO/ac1DVrI4NyRtz9eLhSFVlZ3waoquEgVlNtYJUW+2+EgzJxiFeMMMc
         UY6bhiVyukqpVddpnKt1zG52NYZazXOpo0W2amYZRwKhpawv+ANQ7YFfwxZIdnuJ6lOE
         1Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l/GLGRj09ZztoQAYHyCfETVcz9G0gXuUBxfiop2Bn88=;
        b=qYWL4EzPFt1p10TS6Q9htoRA7uyqbr4z9WtS9MXZ7YQSxl2Cq8yqjfG4AAbTXUNRhu
         UvMUhx3wMdMnUtkkkhtp47B9oPkQmg296hfd0f4+iFMevjn+fTrmd0+kJ8L2z08dvawo
         /VnMQvGTmc5yaKGQlCYcn5JVUyXBz7RWoa4W9AIKHbFXp5E1Xq7UsOON5cvjmtnGEGde
         TV4x9ZeLGilQ2YMmgiff48TvEfwmqz+HJLzVG48yhH6KtTncLeK24oelye3moq35krcp
         19NYmoARRrKva31/0R2VsWZSTa7ra7eGCqcCmZOTRRwQbSPJqF6CBsP5W4ibuZR9yyNk
         B3bQ==
X-Gm-Message-State: AA+aEWZAgm8mdB5eIHeTp0Z7isv4V68VhkfVOkkS3Vr9jyGHNnsSYxb7
        6B47XVyzAk4SHn7F1u1xeFNw1xzz
X-Google-Smtp-Source: AFSGD/X2gQdevWsy+jNIDp+JRcw6fTAe0KQHMQHQPDo1Lj/9D00Iq10ig4c8z8XPzT9p5QCve35PTw==
X-Received: by 2002:a63:c70d:: with SMTP id n13mr10187376pgg.108.1543745273745;
        Sun, 02 Dec 2018 02:07:53 -0800 (PST)
Received: from laptop ([60.230.90.217])
        by smtp.gmail.com with ESMTPSA id u78sm23447173pfi.2.2018.12.02.02.07.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 02:07:53 -0800 (PST)
Date:   Sun, 2 Dec 2018 21:07:47 +1100
From:   Robert White <rjwhite2453@gmail.com>
To:     git@vger.kernel.org
Subject: Confusing inconsistent option syntax
Message-ID: <20181202100747.GA5019@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git log --pretty short` gives the error message "ambiguous argument
'short'". To get the expected result, you need to use `git log
--pretty=short`. However, `git log --since yesterday` and `git log
--since=yesterday` both work as expected.

When is an = needed? What is the reason for these inconsistencies?

---
Robert White

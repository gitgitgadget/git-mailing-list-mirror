Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4029E20248
	for <e@80x24.org>; Mon, 15 Apr 2019 22:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfDOW3W (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 18:29:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44903 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOW3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 18:29:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so9267602pgj.11
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I2gdflZsdPqtUK38DAYl5ZYeGaLjFYtpC/SF7vBD53c=;
        b=T4115nu/ZXgjGamta71H9Zj7k/iVdhc1i2YUvFhYLDi1xUu+DslEJSHUjk2KxURHlD
         oe01W/mO8eYGn6s66wEXPyhdxjZSOPmtd0cgal2fj5dhJFamJSNC+c1CvyirkXgW3Yq/
         a+y8hozpiCAl+ewSgHZzyaG6OEXLz/vwr6mnQWil8n7W75yN0kmwcyHP0wcO9pH6XKsd
         Wpr+Nd4hN9PgYlOdiQGO/NVUcFOoA8c0lV8t6vZEGapf9VluTDTGoEHr6cgCrAIbYgk3
         NTbm41K7teToUtAUcFclnxqjRb3ngqmlDTT5KODXHaoVi7mu9asRM2BKK6ZJVr5+XL4b
         CrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I2gdflZsdPqtUK38DAYl5ZYeGaLjFYtpC/SF7vBD53c=;
        b=S64sJryZtRMkG9+DEYvJcJaSUee6BNUwCsQGKZgiiG4D7MsEN06QwKHRMmyFSvr7Oh
         J96lVbqpbg/Y5S8ai0pUcIgbJe0nyjufXIbtKiwbUYhxdVsWNLSp68EI+q6OkGEk3glZ
         KQ/WKY/IOG4xDjDXsK2y8fKOwaL7NRDRZmQOkOp1aNwZ52q6MfQPkAWD7O+Plm/mlviN
         ywmQZJVdffDyVTn7sPnBs8jnAs/3rNdlKaZBf5k5J/yFq+iKdyMdmcneGdqcpseOfscX
         72TKIZlurXFm2f0hVRkil7ZLBMJ/GYd4PeSI5Vc183ZYCfs0PeyhEmScBRs26HxORTwM
         FhHw==
X-Gm-Message-State: APjAAAXiyUhcXUVRDfS/9ldJlGyYlq7apqGZm9J4MIIW9AkmG42+VliZ
        uuJujxS9EMML0jvj+5dc+Y9xsej1
X-Google-Smtp-Source: APXvYqwVJ/vNCdC+Evr4DhBIs5AMEQYkqvgCZHvDXODhdkT4px2azwqA3H8y9TUYZZQMsaeG3snUQQ==
X-Received: by 2002:a62:ed05:: with SMTP id u5mr51840828pfh.63.1555367360742;
        Mon, 15 Apr 2019 15:29:20 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id h71sm23687954pge.49.2019.04.15.15.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:29:19 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:29:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 0/5] rebase: teach rebase --keep-base
Message-ID: <cover.1555366891.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1554500051.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the example, Ævar, it clarified a lot. I think that _now_
we're on the same page. ;)

I made can_fast_forward detect this case and now, it should behave as
expected. The change can be seen in 4/5. Hopefully this saves you some
work later.

---

This patchset now depends "[PATCH 1/8] tests (rebase): spell out the
`--keep-empty` option" which is the first patch of Johannes's "Do not
use abbreviated options in tests" patchset[1]. (Thanks for catching
that, Johannes!)

Changes since v1:

* Squashed old set into one patch
* Fixed indentation style and dangling else
* Added more documentation after discussion with Ævar

Changes since v2:

* Add testing for rebase --fork-point behaviour
* Add testing for rebase fast-forward behaviour
* Make rebase --onto fast-forward in more cases
* Update documentation to include use-case

Changes since v3:

* Fix tests failing on bash 4.2
* Fix typo in t3431 comment

Changes since v4:

* Make rebase --fork-point fast-forward in more cases

[1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/

Denton Liu (5):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: fast-forward --onto in more cases
  rebase: fast-forward --fork-point in more cases
  rebase: teach rebase --keep-base

 Documentation/git-rebase.txt     | 30 ++++++++++--
 builtin/rebase.c                 | 77 +++++++++++++++++++++--------
 t/t3400-rebase.sh                |  2 +-
 t/t3404-rebase-interactive.sh    |  2 +-
 t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++
 t/t3431-rebase-fork-point.sh     | 57 ++++++++++++++++++++++
 t/t3432-rebase-fast-forward.sh   | 83 ++++++++++++++++++++++++++++++++
 7 files changed, 284 insertions(+), 24 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

-- 
2.21.0.921.gb27c68c4e9


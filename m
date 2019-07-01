Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8196A1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGAVVM (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36032 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so15378191wrs.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRtZor2ThOzxTlO/uzt4TxTZD6fA187y4ITyvhEGfUY=;
        b=c4io57UDk2BtqvW3IJVJAjOlNqDEAz4IZ4Q8HPGmXSTkmVoZYh80wvebRhalcdJKdc
         mogs4DgKgswhI1Bg1s2Es4M8Ssi9fqInOwWL3P3AetyQlh4HW5qmDnr1hfPM+i242K6y
         iy5Nh123TgF1pUCggrXRm8PPSmSShCYn3MxIticCsZ4VRwSwcqtadX7IG8xH0J7j+NKX
         7nbhIE9JQFGqr93c/bQL04AredtseDdOe0irs9+gxQCFw+05b8WB4lGHPOP2nCWjxc+v
         DBulz2MWxnsky9gvd8L+QlKCDusXtmPY2MLnDxnHqWonYY3VP1wQnqLYQpRiXo1oHHyo
         IFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRtZor2ThOzxTlO/uzt4TxTZD6fA187y4ITyvhEGfUY=;
        b=EXDZTTfjmTq3B26vJzah76kTpzylh+F1O6tVx/yOvzwSdDLI2jrSgw3RyJq4O+0Msx
         gVItomppJmEVz5+Q6KuuNAFg4Oy9jnDejlUJfuLJkZS8G1Qig4DRlC8SoOQFar/loUF8
         UUfHhnnhnVo4aAQgXDN+NK5ahG7YeQdqdGn8yibGlSNcu1quLZH9+LefrFkYlFonWgzh
         dNR4HN16ivB/vRcmuAhLUvlAv5ujAI9KO0IQw/HUIXotcCNaKYWWkGtQhWSOB0pCLHqV
         SgihFarNK0wQ60zCSl355bIc/O0rcpCjvT2td4euEic5jjkVGEVp2nD6MK4eYcx94p8y
         Y5PQ==
X-Gm-Message-State: APjAAAWaiSOWM3yQRHjrx3KzqJNjUADKoEhfEL+OrIaaVNR7CaQGanGj
        gjDadXUwxBSvCJSWhdGPqneS/u6K
X-Google-Smtp-Source: APXvYqyoTdnXTOpbL4ENzvyWyrUmKh9uCGZTel6rNPBfm9zfdGXxjr06n/Z1jccAKWNHakGkbPoNzg==
X-Received: by 2002:a05:6000:1011:: with SMTP id a17mr10150927wrx.0.1562016068780;
        Mon, 01 Jul 2019 14:21:08 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
Date:   Mon,  1 Jul 2019 23:20:50 +0200
Message-Id: <20190701212100.27850-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v3 has a new patch (3/10) that I believe fixes the regression on
MinGW Johannes noted in
https://public-inbox.org/git/nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet/

As noted in the updated commit message in 10/10 I believe just
skipping this test & documenting this in a commit message is the least
amount of suck for now. It's really an existing issue with us doing
nothing sensible when the log/grep haystack encoding doesn't match the
needle encoding supplied via the command line.

We swept that under the carpet with the kwset backend, but PCRE v2
exposes it.

Ævar Arnfjörð Bjarmason (10):
  log tests: test regex backends in "--encode=<enc>" tests
  grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
  t4210: skip more command-line encoding tests on MinGW
  grep: inline the return value of a function call used only once
  grep tests: move "grep binary" alongside the rest
  grep tests: move binary pattern tests into their own file
  grep: make the behavior for NUL-byte in patterns sane
  grep: drop support for \0 in --fixed-strings <pattern>
  grep: remove the kwset optimization
  grep: use PCRE v2 for optimized fixed-string search

 Documentation/git-grep.txt                    |  17 +++
 grep.c                                        | 115 +++++++---------
 grep.h                                        |   3 +-
 revision.c                                    |   3 +
 t/t4210-log-i18n.sh                           |  41 +++++-
 ...a1.sh => t7008-filter-branch-null-sha1.sh} |   0
 ...08-grep-binary.sh => t7815-grep-binary.sh} | 101 --------------
 t/t7816-grep-binary-pattern.sh                | 127 ++++++++++++++++++
 8 files changed, 234 insertions(+), 173 deletions(-)
 rename t/{t7009-filter-branch-null-sha1.sh => t7008-filter-branch-null-sha1.sh} (100%)
 rename t/{t7008-grep-binary.sh => t7815-grep-binary.sh} (55%)
 create mode 100755 t/t7816-grep-binary-pattern.sh

Range-diff:
 1:  cfc01f49d3 =  1:  cfc01f49d3 log tests: test regex backends in "--encode=<enc>" tests
 2:  4b59eb32f0 =  2:  4b59eb32f0 grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
 -:  ---------- >  3:  676c76afe4 t4210: skip more command-line encoding tests on MinGW
 3:  cc4d3b50d5 =  4:  da9b491f70 grep: inline the return value of a function call used only once
 4:  d9b29bdd89 =  5:  c42d3268fa grep tests: move "grep binary" alongside the rest
 5:  f85614f435 =  6:  36b9c1c541 grep tests: move binary pattern tests into their own file
 6:  90afca8707 =  7:  3c54e782e6 grep: make the behavior for NUL-byte in patterns sane
 7:  526b925fdc =  8:  8e5f418189 grep: drop support for \0 in --fixed-strings <pattern>
 8:  14269bb295 =  9:  d1cb8319d5 grep: remove the kwset optimization
 9:  c0fd75d102 ! 10:  4de0c82314 grep: use PCRE v2 for optimized fixed-string search
    @@ -15,6 +15,15 @@
         makes the behavior harder to understand and document, and makes tests
         for the different backends more painful.
     
    +    This does change the behavior under non-C locales when "log"'s
    +    "--encoding" option is used and the heystack/needle in the
    +    content/command-line doesn't have a matching encoding. See the recent
    +    change in "t4210: skip more command-line encoding tests on MinGW" in
    +    this series. I think that's OK. We did nothing sensible before
    +    then (just compared raw bytes that had no hope of matching). At least
    +    now the user will get some idea why their grep/log never matches in
    +    that edge case.
    +
         I could also support the PCRE v1 backend here, but that would make the
         code more complex. I'd rather aim for simplicity here and in future
         changes to the diffcore. We're not going to have someone who
-- 
2.22.0.455.g172b71a6c5


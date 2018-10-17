Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95341F453
	for <e@80x24.org>; Wed, 17 Oct 2018 10:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJQSeO (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 14:34:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50893 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeJQSeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 14:34:14 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so1731087ite.0
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pewNFdfLqpyEzYqdAVfk4Hy2U+Fu7jLJ7PaZBwrQ0/U=;
        b=JwMkFE5YsN7ZqphwvWm54PZ68f5PBaqBvYTYhwKymAStpFQcJQo7Vk0QZbIv3OLyKE
         GSbeZWQ2WPatb1Yz0GVLtzGHPyhI+uAHMRIVFsbeEz/10CPjausKugpTqj8MEh0iGDxs
         lFFrWK6ej9MYV9BpL1IRMzuPA6GHOXur0QMwLSCFNny/E9SI17evFsLly5h72l07aeey
         Lb6R0rsypbrLqz/nFHd+Eh5pWjDt7EURfCBpiB5MrpxhUKB7hRBHDyz3SvktX60/2wWC
         y8yjs32aoMWPUQ2kr+3+lUa0hpx3pUJmth53OaW7NG+FEkkXp58cRbEFSSAXr67Pn7px
         ySZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pewNFdfLqpyEzYqdAVfk4Hy2U+Fu7jLJ7PaZBwrQ0/U=;
        b=McV2Rv7xTJLv2oD5OCBrd/wAHSUR/lWXVDWRsYNFut7fWeegzjh1oFCQgiuMNwhzLc
         98ZB2AIZAkHw/gK5RAFiAbjCQ0dzkARtH9g4i2po8Ukro86uceJSNxALfLqmyGGEU6ox
         J88qh7MyvIpo8I1ndUxh4bdud+iV9+mEKwa+AieGs0Ymra3WJXHAszKAkytJv+DiohGL
         lGQJ8NLnhcyKRDWkLy02aielGM3aWdPvNTbrg6Kf2fBeRfrfBT1bbm3j+2kqd2yrwq7e
         KgfQUV2b0NlaQL1z7ACeEsV1Z4gmIw62/hzz9h5at/T4wd89Dx8z/M70B+BSE1cy918U
         wvVA==
X-Gm-Message-State: ABuFfoic2u5VwYLKlYE7PFLSwhgM3dfnUiN2jpBujoFNf7mOMleWh2Lh
        sQf7EjsonmUfO0d+Y/wCo2E=
X-Google-Smtp-Source: ACcGV63ndaPg3UBqdOxghND41Mt6I9B1ebsDkdCxhwnAwqEkSo+vLAgb9SQKlm/XE4QfB4SIjcQ2bw==
X-Received: by 2002:a24:368d:: with SMTP id l135-v6mr1079527itl.76.1539772747981;
        Wed, 17 Oct 2018 03:39:07 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o194-v6sm757883ito.11.2018.10.17.03.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 03:39:07 -0700 (PDT)
Date:   Wed, 17 Oct 2018 06:39:02 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] branch: introduce --show-current display option
Message-ID: <20181017103902.GA12137@flurp.local>
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com>
 <20181012133321.20580-1-daniels@umanovskis.se>
 <CAPig+cRCfO=3BB6bvDSKLKkhiSA-4=p4-zZkAXvN446_6B1_HA@mail.gmail.com>
 <xmqqk1mhxzcz.fsf@gitster-ct.c.googlers.com>
 <CAPig+cRwy2Xhq7uJJ0OfY2nRZgPK9yHr=G+KMKuWx-PXyWv8Gg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1810171211440.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810171211440.4546@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 6:18 AM Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I realized yesterday that the &&-chain linting we use for every single
> test case takes a noticeable chunk of time:
>
>         $ time ./t0006-date.sh --quiet
>         real    0m20.973s
>         $ time ./t0006-date.sh --quiet --no-chain-lint
>         real    0m13.607s
>
> My suspicion: it is essentially the `(exit 117)` that adds about 100ms to
> every of those 67 test cases.

The subshell chain-linter adds a 'sed' and 'grep' invocation to each test which doesn't help. (v1 of the subshell chain-linter only added a 'sed', but that changed with v2.)

> With that in mind, I would like to suggest that we should start to be very
> careful about using subshells in our test suite.

You could disable the subshell chain-linter like this if you want test the (exit 117) goop in isolation:

--- 8< ---
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f95bfda60..48323e503c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -675,8 +675,7 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
-			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
 		then
 			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
 		fi
--- 8< ---

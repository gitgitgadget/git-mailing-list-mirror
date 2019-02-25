Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4968B20248
	for <e@80x24.org>; Mon, 25 Feb 2019 14:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfBYORr (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 09:17:47 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39873 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBYORr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 09:17:47 -0500
Received: by mail-ed1-f51.google.com with SMTP id p27so7684738edc.6
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cIEBjpZqSlx2JfPFrHEth5VwcVQBx3OEnjL9dgJeYg0=;
        b=RFGPzS1fMS1Tc/foVrE0iagAwlWTVsFzomNbAgPYT2FnyqzOS4r0GsibmHuXW9hJf8
         V631zSfR3p0JRsHFJXdNZ3pt7YAjhkmQQeqTt34k47MRXAiKuTHRrfXP1KD2AZIrba+p
         sLLrIdupDC3CInwFZ3JJ7KXJobh97tuE/MXe4V9RRseZ1z+GVitpbCDnO7c3WrKTUvKx
         sUkiEHjk2ssBlN9r1/79CGSZ9daVb9/1qU/lGDRolSnM4mvxMbvjOYzOcYVxEe5e84nd
         mlNcptZ6jj1Aw+9bM0a44sTT4Cnutcckp/9/dc3pGEdwNAHEfOON49qQYJ9GyKCqZ+gq
         WsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cIEBjpZqSlx2JfPFrHEth5VwcVQBx3OEnjL9dgJeYg0=;
        b=uChLBV2rWY74btkrH/HMT0KhevZrPbBCJC4UOWFRuZWY5LRacQVmCRPFyIUaTVdz/s
         I5xlEllLC2oaQNj0+qyNClMWDMTOgE0kXlZgM7gzDukBkpqMwjbRIpxUYK3I9Vx8xiwu
         gI1B5mQ9xqcZNmCY0mw0d0ziZFnZ92CTVNvYhSdduSlNV/0baaEPXXO7/xRF/l57e3mD
         qV40//aCZPeBXeymEaOCUUAysWciOVgBKA09a1dCBaBlAakKliD33ySY/ZBX2wEHCoiL
         3vi/anhSj5gWac4mq1mdH6Md9xQB+U5Y7QzWGX+xHuO1onVsGdVXtX+4Vu4/gluJx2jM
         CGMg==
X-Gm-Message-State: AHQUAuZsO/15dygIFHTRKw6bLu+0NQ0EaVXt/PTDvdkSCqe4+B6lmpj2
        llF6W/SaQ3Q5qhV8Y7ifvioO7djc
X-Google-Smtp-Source: AHgI3IZVbWvGBl4bxTyuHSVyMF5/9UzMBuo3CU7WJ63XEP8TefkiOPpI0P+1yFNTomBHO3M4jBCNBg==
X-Received: by 2002:a17:906:c2d9:: with SMTP id ch25mr13249120ejb.180.1551104265041;
        Mon, 25 Feb 2019 06:17:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm2750254edl.59.2019.02.25.06.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 06:17:44 -0800 (PST)
Date:   Mon, 25 Feb 2019 06:17:44 -0800 (PST)
X-Google-Original-Date: Mon, 25 Feb 2019 14:17:42 GMT
Message-Id: <pull.140.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] t5580: verify that alternates can be UNC paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was fixed in git.git's master some time ago, unfortunately not
upstreamed from Git for Windows' patch thicket (my fault, or better put: the
fault of the twenty-four hour days not being longer). We carried a
regression test on top of the fix, and I can at least contribute that.

Johannes Schindelin (1):
  t5580: verify that alternates can be UNC paths

 t/t5580-clone-push-unc.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-140%2Fdscho%2Ftest-unc-alternates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-140/dscho/test-unc-alternates-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/140
-- 
gitgitgadget

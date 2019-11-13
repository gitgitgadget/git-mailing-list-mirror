Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22CF1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 21:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMVHl (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 16:07:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38592 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfKMVHl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 16:07:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so3593119wmk.3
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oLXzcyIPgD4wL4zlcvYI0OidfYALIMX025+Z/TIJr3Y=;
        b=s3plCVD9h4fbeGrvtdaHTBo35ZtBvdjntFRvzg7xUnUpAuQPAe6hq1RMSVDOVoLu6c
         sGs1sInxdiXRyS6FYi7gis9RLFNdKiF6LKbeqyRuxk7QhfOyhTUWkj0kVDBYaMcgFbOD
         hxDhbzerz9CUvHeRxzZVd4eRv8dcI6ZHDFZbJiVBHVTY3AyRxTcXVXMooAcA0FD2VbRK
         V6ZQRkX+U4mcniG/RStkhEmZauZlCHWz8c4oEv7FFaxPmE1JrcAHLylXvp6M5NTcUfuY
         Wcq/y1KoPz8vyrUwwms5ByzbrYxvUYBzzGhuA/8VC6kNCxJdpBOMyarUvU5mvT0mlSii
         cDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oLXzcyIPgD4wL4zlcvYI0OidfYALIMX025+Z/TIJr3Y=;
        b=HTskmKS7khwxiQwoqwlwx9oUA5noD5Wdes+Wmdxm0BCDXxgjvZQRbUEsHL3PdvPN9L
         66tHO6jonvDKGqdxwhv1ZO5AQM8LDZnFQ/fu48csgjp+quCns5qSHoEffTN8Vj6iAn00
         Bzat/x0eJi3uZW/NI4D+vd5t1LHaF52C8AAx/Qk/6tAVts26aoqExFEY3lbp1rWY/51Q
         e0ck1fnLc/UoYqxZYJvc6hWxhawtC3g/V8eZb/JcImwRElhuXm319eigvXzMI+xqLhRd
         GRHE1E6OC/1ldY+5XocAHjqKo+CqxLGLA36eFivqB+QuYnNhO56p/daHCEa2EjRbpXR9
         J4YA==
X-Gm-Message-State: APjAAAVT62sMbR6PfpXcYIctswWjpmoPoIHWjhcc8KIchTAYh2at0R9n
        lYQ1PdNZJA2tT/yY1zSnioesF1u7
X-Google-Smtp-Source: APXvYqykN2F2yqGWfTcjmyEqou4UZZbULB8Pbw+RrEmzKlNZGsu9Ycy2l9cHMIZCyw7vRxl9DRmFDw==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr4580365wmc.157.1573679259053;
        Wed, 13 Nov 2019 13:07:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i71sm5142739wri.68.2019.11.13.13.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:07:38 -0800 (PST)
Message-Id: <pull.463.git.1573679258.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 21:07:37 +0000
Subject: [PATCH 0/1] git-p4.py: Cast byte strings to unicode strings in python3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit: git-p4.py: Cast byte strings to unicode strings in python3

I tried to run git-p4 under python3 and it failed with an error that it
could not connect to the P4 server. This is caused by the return values from
the process.popen returning byte strings and the code is failing when it is
comparing these with literal strings which are Unicode in Python 3.

To support this, I added a new function ustring() in the code that
determines if python is natively supporting Unicode (Python 3) or not
(Python 2). 

 * If the python version supports Unicode (Python 3), it will cast the text
   (expected a byte string) to UTF-8. This allows the existing code to match
   literal strings as expected.
   
   
 * If the python version does not natively support Unicode (Python 2) the
   ustring() function does not change the byte string, maintaining current
   behavior.
   
   

There are a few notable methods changed:

 * pipe functions have their output passed through the ustring() function:
   
    * read_pipe_full(c)
    * p4_has_move_command()
   
   
 * p4CmdList has new conditional code to parse the dictionary marshaled from
   the process call. Both the keys and values are converted to Unicode.
   
   
 * gitConfig passes the return value through ustring() so all calls to
   gitConfig return unicode values.
   
   

Signed-off-by: Ben Keene seraphire@gmail.com [seraphire@gmail.com]

Ben Keene (1):
  Cast byte strings to unicode strings in python3

 git-p4.py | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-463%2Fseraphire%2Fseraphire%2Fp4-python3-unicode-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-463/seraphire/seraphire/p4-python3-unicode-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/463
-- 
gitgitgadget

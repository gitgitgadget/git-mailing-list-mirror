Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D551F453
	for <e@80x24.org>; Fri, 18 Jan 2019 13:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfARNY4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 08:24:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44825 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfARNY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 08:24:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so11077235edd.11
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fwRAmAB+72dMs+a64IVtGgYWpzTngmM41TDhIDC31os=;
        b=VbkzF3buC9gLuXx5npP2QZbmCMLuZXM08yQEJxcFHpghODX/mnIdRjRFCyxCS123rF
         UJGaGeaDEoHOYPP1E/XsfskgKw9QVZKvKheh3nKfhMapKXRXITwO1mIMp0uck6UkkC3M
         OexBNtoieNSgkMiYpOyq3v7gdrvWoSakBsfC3rxom9Kj+gUUY1/aP6wBHh8U5TzW9O5p
         7NNPPTEoFgalXY36IuoSyKc7nLYDx8WAL4ZyRi/4Bg3jYZSUD6Qu+dHnm7SrNgZZTzqU
         YyPbMhjgzywbVwPPw0aGlFsegkCL0QTaXHkWz2WD86UoCDsv5sqxKEtW7OToieSHyNQC
         pIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fwRAmAB+72dMs+a64IVtGgYWpzTngmM41TDhIDC31os=;
        b=niPGroiOPlpjEP7IMAd3kUysa16CXam2P43hb5Anx6b+WDtbsHsdihpq84npxrFSQu
         u8gUmXLzvBV+lt36DUcM/CUMYINjRBukDQ9SKilJHeGQDUwS+gc+Fc22j/sv09c5+T2i
         pGyWQUY7zIyCRr+00zMBX2WVlL+o6MsyFxzlD5n2mo62ZisIcDA9EwuHL7sRPanIktS7
         OfX0cFZ3u3uQQI2OEsOc9vXccAKKiqUKKk7c6t2uP205KE2JrPrKETeyweDx8EkjViir
         vtTjwlDFW/R8I6aKD7nCgdnJZQiuod8tnU5II5saeOhcL1WrQQBdYPzwCogMq76a9Asj
         jAJQ==
X-Gm-Message-State: AJcUukdCyg4wavu6UPvxdZ3sR93xS6Yvdn+4II1+W1ogbdR82HgP20hg
        cego/wYfWDGiiark+m4Q+Ap541e2
X-Google-Smtp-Source: ALg8bN4r/e0s3BkEjKij9VOnsS3MynlrzD+THPxlgkmAgp2/H7gk0ntF6RGNkCAgiA/WgIBRSHjPcA==
X-Received: by 2002:a17:906:4b19:: with SMTP id y25-v6mr14617102eju.89.1547817894085;
        Fri, 18 Jan 2019 05:24:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm8025908edc.27.2019.01.18.05.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:24:53 -0800 (PST)
Date:   Fri, 18 Jan 2019 05:24:53 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 13:24:52 GMT
Message-Id: <pull.104.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.104.v3.git.gitgitgadget@gmail.com>
References: <pull.104.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/1] Make abspath() aware of case-insensitive filesystems
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

It is completely legitimate these days to call git add with absolute paths.
Of course, on a case-insensitive file system, users rightfully expect the
argument to be handled case-insensitively, too. This patch makes it so.

Git for Windows carried this patch for over one and a half years already, I
think it is time to get it into git.git.

Changes since v3:

 * Fixed the oneline (it talked about core.fileMode when it really wanted to
   talk about core.ignoreCase!).

Change since v2:

 * Replaced MINGW prerequisite in the test by CASE_INSENSITIVE_FS. v1 was
   sent out without a change by mistake. Sorry.

Johannes Schindelin (1):
  abspath_part_inside_repo: respect core.ignoreCase

 setup.c        | 6 +++---
 t/t3700-add.sh | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-104%2Fdscho%2Fcase-insensitive-abspath-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-104/dscho/case-insensitive-abspath-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/104

Range-diff vs v3:

 1:  b935e11d21 ! 1:  3fb927fc77 abspath_part_inside_repo: respect core.fileMode
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    abspath_part_inside_repo: respect core.fileMode
     +    abspath_part_inside_repo: respect core.ignoreCase
      
          If the file system is case-insensitive, we really must be careful to
          ignore differences in case only.

-- 
gitgitgadget

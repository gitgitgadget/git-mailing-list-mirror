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
	by dcvr.yhbt.net (Postfix) with ESMTP id 597DB1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 14:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfGSOS5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 10:18:57 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45180 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbfGSOS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 10:18:57 -0400
Received: by mail-wr1-f43.google.com with SMTP id f9so32407960wre.12
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QxE5ugy6lFyUfD//AwcJaJ3whtc82QV+Njm6CgWbztw=;
        b=ObZUltlWpcq2pxq4aTIXb/+Rk4iCcWLTQp0EA6uERguZBSyzd2BibABkYfW1K0SmaI
         LJGJ7fUDDs0iiRooDp4ssbYxT86/uqUxOdZHI3crQ7ySXfhQbbyvrN+qE96lKv7SHcVt
         Iblu2g0k55jNPXmW1kOsm4FAqfPiqfUNTqDend8CY5jAsfpOAB3+jePf5ajdjQ5hDycH
         7xxs62vWFouYiVEK2OYcvg3sSS1c6yJwtv2cpfRyA3Ku4ZMBzU/57UWbq1M0++k3HekZ
         Tu2LQ7y2Z/m2PbRIUidUH+VlM/rYROTQiK35lHzcyVPDZZ+0PNPnJJeKbRq/g+d/ytNm
         5/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QxE5ugy6lFyUfD//AwcJaJ3whtc82QV+Njm6CgWbztw=;
        b=Z7CjE3ZGFwK21hs5b+ivzOonN8QnsM7DWveD6DSHlZzafBmI5zKGf/hfwynoAVKO9y
         I4hPwZek76YjGNQFp90/hyozOy1HBh6SEB/mXHbeC4iOQ1rxRG0EuZBj2HQ6zCXtTPrQ
         uaIL8ZHc1nGkHryKwS2QeNB0Oi6DsBRPmhIkCEGuDPxPEY34v5VF8uQsRjVUmdeKJjEp
         HxdIdTTMX1wrnYYcmaL3MEFDSKKwG1r9gtjEuAUJvXLfzd+S7NogtmTgpBL/k5RlpEHA
         jTGJ5C9JS0FEDAYGANMNa/qsfZf0/Gzm1Bz8R6p1eXkJ0zs885l/s30NZ5O8FVEa2ohL
         WCIg==
X-Gm-Message-State: APjAAAUsmCR08dp+O8xSpZyTPkOAkw21aulOjGgCWu3A+VxTHCUlH6cD
        8w+cLZGu/kAfVcSr+9QXMDQpzQzY
X-Google-Smtp-Source: APXvYqzYzPXeC1ZCb0dHTzFHkeWYWm45rFqdwv6WcETX2j6/jz9bxSCeqcgWONlRvcECM2tmsd6yWA==
X-Received: by 2002:adf:f591:: with SMTP id f17mr42064253wro.119.1563545934880;
        Fri, 19 Jul 2019 07:18:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm28713333wma.25.2019.07.19.07.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 07:18:54 -0700 (PDT)
Date:   Fri, 19 Jul 2019 07:18:54 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Jul 2019 14:18:52 GMT
Message-Id: <pull.290.git.gitgitgadget@gmail.com>
From:   "Christian Clauss via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Travis CI: Lint for Python syntax errors and undefined names
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

Several things were changed between Python 2 and Python 3. Here we are
making changes to make the code run on both Py2 and Py3. We are doing this
because the end of life of Python 2 is in 167 days. We are using print() 
function because legacy print statements are syntax errors on Py3.reduce() 
was moved in Python 3 and raw_input() was removed so we make changes to
avoid NameErrors at runtime. Signed-off-by: Christian Clauss cclauss@me.com
[cclauss@me.com]

cclauss (1):
  Travis CI: Lint for Python syntax errors and undefined names

 .travis.yml                        |  4 +++
 contrib/fast-import/import-zips.py |  3 +-
 contrib/hg-to-git/hg-to-git.py     | 47 +++++++++++++++---------------
 git-p4.py                          |  3 ++
 4 files changed, 33 insertions(+), 24 deletions(-)


base-commit: 9d418600f4d10dcbbfb0b5fdbc71d509e03ba719
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-290%2Fcclauss%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-290/cclauss/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/290
-- 
gitgitgadget

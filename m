Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6CA1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfD2V6t (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:58:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42901 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfD2V6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:58:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so10501684eda.9
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1v1uqP2oZbM8zNm+2Q3C+T8SuSIImipR6NjYWh8KoiE=;
        b=uRSyobknaYAizzZrfCrOkL8nNJ6vh9WTuoIqQU8biuOywpmI/IqwGxBt2L5UkXi0Ww
         RAQeBpJ4M7fa4uRQUMFPhVaH5xcLNhSRQyr2v7t4VLf8FSePxx0e19aMyd6pqLQVy7sd
         fDH7V//iUZhfXrTR77qkz5cC+eO22SszySkzEl1AFcQm/RxBj7wYib+51l65mOUomIIa
         IWftYPmdB6drj1QnEulFRzLlBRJGGGgSZpxeM71+4g00KeLwwEbW4xD/ADuatytcxH+1
         7MXk6hlr/2GLwTvcGYncV9j+wt+4HKXZ1siPS/pbYzd55hVwSJDhoMSraT9+wgj6spjy
         IMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1v1uqP2oZbM8zNm+2Q3C+T8SuSIImipR6NjYWh8KoiE=;
        b=YGgXTMwZbFVjlq+McBMc4sSod5CYhG6bgycKEYRYpLDXDUK8QMGn0v/fNiymgUXdrP
         GUmosxe2iW5ZdY4HH0sgahckytxV2GsmI9UK23TdyYSL6kZkkF1DN36VwfY9QSB41/oP
         S1rYe3cIJmnSVnSPsW11MPNEPxO/ryIS9Fjf2VI2RjPESskeSWznNrMFerP6JPHugMgv
         rLJ7t39h88hkm/mIxbrc29jNgvY0bHBNrhDn8uJOBsDm0Q1xbGbZE8Aw4mU/Datc+h2h
         lvIA2hWF7x69DkrO+pLR6POE/8yHoi3LPJq8Mcbck4mHTd4kL7tYnqrAn6EFUShXdZyC
         G5gQ==
X-Gm-Message-State: APjAAAWFDj+i8o2AEyGEKq8+19I5LnXYhvh3q0S8yqdilzrtDVG5Odqs
        ZrARagd6dEevydAmXz1AeLyxrVa7
X-Google-Smtp-Source: APXvYqyldUq+Af1aihresJrBoDCLZnXCoTJp9i2EPzgFispn/pPGr7KMZyrP0Pb1+hJQbEc6yjUGvg==
X-Received: by 2002:a05:6402:1610:: with SMTP id f16mr7913517edv.171.1556575127284;
        Mon, 29 Apr 2019 14:58:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm6003352ejn.37.2019.04.29.14.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:58:46 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:58:46 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 21:58:45 GMT
Message-Id: <pull.132.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix cvsexportcommit with CR/LF line endings
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

When using CVSNT, we need to be prepared to grok CVS output with CR/LF line
endings.

While we do not use CVSNT in Git for Windows, this patch made its way into
Git's source code via the Git for Windows project (probably because of the
ease of GitHub PRs), and we had not a single complaint for over 2 years, so
I would consider this patch ready to be included in core Git.

Dustin Spicuzza (1):
  cvsexportcommit: force crlf translation

 git-cvsexportcommit.perl | 1 +
 1 file changed, 1 insertion(+)


base-commit: 39ffebd23b1ef6830bf86043ef0b5c069d9299a9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-132%2Fdscho%2Fcvsexportcommit-crlf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-132/dscho/cvsexportcommit-crlf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/132
-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6CE1FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbdIKScm (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 14:32:42 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38610 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdIKSck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 14:32:40 -0400
Received: by mail-qt0-f177.google.com with SMTP id q8so20897689qtb.5
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+kGgNMvKe1KDz8tq7I66OQzs6q0GnIiM/uqFqJ/otGQ=;
        b=SrEQm/K6DksZqV7iqrLNol0IO40vBMKW8XTkBS0PgnyDekdriXmT42mFz4D9LVeSc1
         vH5EmrmRZC32ddgCDlHQ5Vz5CKHtRZvbpwyh76t5dGX2yY8s5TeA3rix4RG5skkUtGGb
         iL7H0wFIKP8Cnqevb/8XboTzAnM7Wl39uQ0Zo9wpT/ePkEhhux3AFpDAMAlHiwmNGgNl
         9/Oh5NA3vRb0bBcAOw1A6ZCRH8L8VktZfK/JCblDt7n+bKQEony29U5btMTYxQxRuTAv
         /hJTLpd1lVq4XCSI5YwmZZwAxxlyVrbrHIESSWC8RigF+/vQLgTMSiDWXhMBBiTuT7ep
         C+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+kGgNMvKe1KDz8tq7I66OQzs6q0GnIiM/uqFqJ/otGQ=;
        b=fwV+LIYc8wqTj1xGysC+a15HX9YMrGkEG3zQMY8HOX7xPBsscrigBxColYaSTTC0AR
         kIKJnJE2ZiJkPNeJFlN9BCZzPr57SvV0+/yH0pccDAZ3xs8a+yTFSOMZq8R+gHX82jr6
         OCDji4Dkh/CKU8yBTkV30nTb+JZnRcOyRVYHSIC4ISZkxtw5M3OxZMIGIMofLwBvbxIj
         bP8XNsnUyV2m2Ksdj31r9rU0+w9mpW/D/kYuovLfUvCTXjCvcTUkjbjytF/CiQ1s16Bw
         UDXQGG4A6aKNtQYHKPiuz8wms/qJM4MLnYDCMTYsBUhK0ldL7ZXSzZrKxOZ3h1vBW0L6
         XSlg==
X-Gm-Message-State: AHPjjUhti0b1mzjUhd6T6qhbdaFTyn5QsjtTKdSVCQ5P7f5XpjVP6BRr
        25C8emIWTE4nGHNKpyQe/CvMvs05ttVQRDQ=
X-Google-Smtp-Source: AOwi7QBTB3gueM6mvqkSoor2G8yrTh+2XeK1o87CS1Ji+g8sgaHZz9k5xNaxU+IHNErwpjZr8JxZ8Wrj7LJ/j+2pCnQ=
X-Received: by 10.200.57.83 with SMTP id t19mr18515349qtb.150.1505154759829;
 Mon, 11 Sep 2017 11:32:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.49.212 with HTTP; Mon, 11 Sep 2017 11:32:39 -0700 (PDT)
From:   Allen Li <vianchielfaura@gmail.com>
Date:   Mon, 11 Sep 2017 11:32:39 -0700
Message-ID: <CAJr1M6eS0jY22=0nvV41uDybcHUdjBv8CgRhHmBNFM=Z0J9YCA@mail.gmail.com>
Subject: --work-tree does not work for git-stash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.14.1.581

This does not work:

$ git --git-dir ~/foo/.git --work-tree ~/foo stash create
fatal: /usr/lib/git-core/git-stash cannot be used without a working tree.

This does:

$ git --git-dir ~/foo/.git --work-tree ~/foo -C ~/foo stash create

I found a description of the bug here:

https://stackoverflow.com/a/5863555

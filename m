Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812311F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbeGWODz (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:03:55 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44852 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbeGWODz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:03:55 -0400
Received: by mail-ed1-f51.google.com with SMTP id f23-v6so877099edr.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=id3AdUaCI2c8/r7i7Z4T+KAabIMijJ7aMPowI2Mr1Gc=;
        b=pD/4fqHLphw0VnpY8S3G1BWd0FrXTLeZpeMpHe2EKcP2QIXB2QTEQDYvFqOs1KSCpK
         DgPe5pNwwScnQTLr/FIqw/HSE7W8bN09XgWyS+QMPQC3M5cYwAfdqxXXCnUvkBE5yXZu
         w17KGWX1iTF4fTj5seNN1BHf9I25XG7GlU7x8rNS9si+PfG14fedZe4u/61apOYq6pnE
         XZjj4HmAhlCCUpii7ovZ/M3sGR3QGDPKV6/XK+ypD6mfiqJFPNNYWGam44giVZjiUc4p
         kQIzAhPRgT3w2mSj+FuWwh4TxgkGBpVhVQaTo0dcqHa1oduhM1wDULyn9uN+SAf3p0cQ
         Eunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=id3AdUaCI2c8/r7i7Z4T+KAabIMijJ7aMPowI2Mr1Gc=;
        b=WNANWXUs3+I3R9Ja71pUNooInVyMTtn7VDZioZtMZ5U7w1FxL7JFf09smA4+I0Wrn9
         1dNOyKyJQzXW0FbYO9sJ+5cRniaoW6Cdqt6Capt5RgjdR7QU9RufPjkbTWwQEJMOP+Bk
         HC4BdCYoz60LQ7s+m14C9yvj9qWXSLmli5k/S+FWvHZY6Qet6a5c9fSMDRPlZmDz14Ey
         /fZBLRW8YcO3hfb63+qYHmImBnPpfP8nT8Uw7gHXzftv6mO3mxTgnBujdfP+Rb0paAXI
         LX8chhmQ10Kj72asMk5WP2bIoJf+AwyruoTp4AdHjxjQRBHsnJqcKVWIpoElLKUMEi/9
         DYEw==
X-Gm-Message-State: AOUpUlFN/8nO8SH4QMeZu1NjUOytGHtkTEbiizPiRSf/ZMZ9oVaslAYg
        P0vaJ7HtUroi8ciq4pjFmWc=
X-Google-Smtp-Source: AAOMgpfGPt0k/0KVALArj5936VV5f29SM1ZLEJGSxdxRJ90J54L3zpdOWPaob+JvE9zBkxZIRaBfyw==
X-Received: by 2002:aa7:d717:: with SMTP id t23-v6mr14298762edq.102.1532350965405;
        Mon, 23 Jul 2018 06:02:45 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a5-v6sm8834263edr.1.2018.07.23.06.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:02:44 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] travis-ci: fail if Coccinelle found something to transform
Date:   Mon, 23 Jul 2018 15:02:28 +0200
Message-Id: <20180723130230.22491-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch makes the static analysis build job on Travis CI
faster by running it with 'make -j2'.

The second patch makes it more more useful by failing the build job if
Coccinelle finds something to transform, thereby drawing our attention
to undesired code patterns trying to enter the codebase.


With these patches applied, the static analysis build job would fail
on current 'pu' because of two small issues on two branches:

  - js/range-diff: Dscho has sent out v4 of this series over the
    weekend, which already incorporates Coccinelle's suggestion, so
    it's basically done.
  
  - pb/bisect-helper-2: this topic has not seen an update in about 9
    months, so I'll send a followup patch 3/2 to be applied on top or
    squashed in, whichever is deemed better.


SZEDER Gábor (2):
  travis-ci: run Coccinelle static analysis with two parallel jobs
  travis-ci: fail if Coccinelle static analysis found something to
    transform

 ci/run-static-analysis.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
2.18.0.408.g42635c01bc


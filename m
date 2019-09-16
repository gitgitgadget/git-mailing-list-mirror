Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97361F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfIPTAu (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:00:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40355 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:00:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so818166lfa.7
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lz7VnqyePRz1aAOKkeeJeZ97fxwpxMJVc7ZqLhuxH3g=;
        b=QaKiJTpy7h2ply8PG+KuimmlpmyPBEGPe7Li6YMTSDePbmZ6Vze9ItqvkYg783oWal
         8ccBm1/vNukYd4lJsQOPKrxu3K8Pf6oH603896qScqgavKNX+1x+6dyO2Okk7rUim6If
         OseGTqp7Z+vZCPZ2roBhb1c+kbTHHVd9BFx1sJUQnAL91g2+ZUE86TNyDgxnj5iAd8Ei
         qMzBP+uT5EfAUuM0s1NlwjCrBSwQJKVozp70bNaiB8nFU2e+83h3STvQWhCGR1sC5Vey
         HYyoKgFUfu0hLaGpl1cXyL37zQ9g9TP/KvhYWZarfb+UtPcVmq7FRpTsJhW7XkP69/F5
         uQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lz7VnqyePRz1aAOKkeeJeZ97fxwpxMJVc7ZqLhuxH3g=;
        b=XfXIezTHhwhw1coGzE765d1/JCKasaKxomlOcReS/ybuzujHGdFSwnny6kA9XaZpq2
         1slpWY5849CwZ7VbKKPsdBKv4x1fvhNVU0lollUuH4TK+s1ohiYy+Bgs1uL9IVot7nYO
         NldYuvRnkMc0MklLxJwJZstRCEVpSCvmPZtF+hQEkPH2A+vMSY9XiWBdDT2c6DezVLqh
         hdt+ukGl0Y/q7yJnK1qk7pIEpDrf9RV9iXkuH6eq+ewpzMufh7hy2OgCsuPvEgZalgXo
         UEOTaFxNTy82aRRx2+OvLbXxhZ24rI9Go1wbZ8IwRnlhSHIIUQktexAb1xrW+Ciz1IQf
         GABQ==
X-Gm-Message-State: APjAAAUO7130ehdYJV40O3yJZ19Tbj02se5H+HHlZpqpIYP+bisQpwnY
        oj8FoUaan/iTaUZXapzUDsBrtyoW
X-Google-Smtp-Source: APXvYqxr/V9LmcBYNYptQHnmezbBRHIKaRoo9inIyvYX5VfFROvggA8IQSHh3iJaq6GNmv9QYS7CRA==
X-Received: by 2002:ac2:558e:: with SMTP id v14mr467807lfg.161.1568660446986;
        Mon, 16 Sep 2019 12:00:46 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j28sm9127608lfh.57.2019.09.16.12.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:00:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] asciidoctor-extensions: provide `<refmiscinfo/>`
Date:   Mon, 16 Sep 2019 21:00:25 +0200
Message-Id: <cover.1568658269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567534373.git.martin.agren@gmail.com>
References: <cover.1567534373.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's v3 of ma/asciidoctor-refmiscinfo to align the headers and footers
of Asciidoctor-rendered manpages with those from AsciiDoc. Patch 1 is
new.

It turns out that with newer (>=1.5.7) versions of Asciidoctor, we get
default values of these refmiscinfo attributes put into the xml. The
hack in patch 2/3 (previously patch 1/2) happened to inject these
attributes after the default ones and it seems like the earlier ones
happen to win when xmlto processes the xml. This explains what Peff
noticed in [1], where the attribute values introduced by the hacky patch
2 are effectively ignored and blank values are used instead.

Rather than trying to game the order of those attributes, I decided to
do a patch 1 which uses a saner way of providing these attributes to
Asciidoctor. This allowed me to reframe patch 2 from "fix all of these
attributes with Asciidoctor" to "fix some of them with some Asciidoctor
versions".

My test results:

  AsciiDoc (8.6.10): Each patch in this series is a no-op.

  Asciidoctor 1.5.5 and 1.5.6: Patch 1/3 is a no-op. Patch 2/3 fixes the
  header/footer to be as with AsciiDoc, except for how the date is
  rendered.

  Aciidoctor 1.5.7 and 2.0.10 [2]: Patch 1/3 fixes the header/footer
  partially -- the version number is still missing. Patch 2/3 fixes the
  version number, after which the header/footer are just as with
  AsciiDoc, except for how the date is rendered.

  So in short, "all" versions of Asciidoctor now render the headers and
  footers like AsciiDoc does, except for the date formatting.

[1] https://public-inbox.org/git/20190913050634.GB21172@sigill.intra.peff.net/

[2] The tests with 2.0.10 were done on top of brian's recent patch to
build at all with Asciidoctor 2:
https://public-inbox.org/git/20190915224332.103930-1-sandals@crustytoothpaste.net/

Martin Ågren (3):
  Doc/Makefile: give mansource/-version/-manual attributes
  asciidoctor-extensions: provide `<refmiscinfo/>`
  doc-diff: replace --cut-header-footer with --cut-footer

 Documentation/Makefile                  |  3 ++-
 Documentation/asciidoc.conf             |  6 +++---
 Documentation/asciidoctor-extensions.rb | 17 +++++++++++++++++
 Documentation/doc-diff                  | 17 ++++++++---------
 4 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.23.0


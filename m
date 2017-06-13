Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE76F20282
	for <e@80x24.org>; Tue, 13 Jun 2017 08:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdFMISR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 04:18:17 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32965 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdFMISL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 04:18:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id v104so27412941wrb.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IKiDdRKLlMHBIxIdPBNbup1NbnsVAMHldKsyH7cgZFo=;
        b=LNSAltszXuu8dGv6CxExetBepo0IY61tWT56c8E9XjHZL3JKDz0yxS9+yR+RGupMjl
         rqkrHpm+m554G+HtmyS7vEFPOjDvxmwJxSOozL2B+r0igVWsdNuKy5pcipDX4EfyJtNU
         p/UsgUEatVx+9OdvX5gKXf226q27Y9RUtCi76Nh53tJsn2GR5bhBYyigR94tvDGwmAwX
         Ea6LQzOTKO3ZXppOMuwxtiU+0qLOdm4AfoIhq8MCqmTh183nQ/q3iWgOQdANtp0TkTXJ
         RpIQywzSovuz/F58Je49VvTIiDVeCIMrqV4QYFnTTGwk35k3Si9RFN6JpBDypCEDX8JS
         vrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IKiDdRKLlMHBIxIdPBNbup1NbnsVAMHldKsyH7cgZFo=;
        b=EsD1s26Gkth6mNSzkKtfBd6bqeBN1H7RWfx2D8fTzFrXieBpgEbIqHh4zn0BpwKpyQ
         wtS5pkPUAr0UarCGHTsQFJj2P1BwZ4qHrclisvJCjX93rd/a2Ph98Osie8fSiHQrWXG0
         ocyO33dXv1coLv+7Zw3fbc/HymuTaSesAAF2nkEOUBMWFx+mEB0h/q/z1eqtRhyG4pae
         i6/B8J9xqP/HiGcdGX/QMyIzTAN0xD/qS50CGpa1ZnT+nc8pwXLcR1TxL240NxyW7sPv
         Lti1zR7TmgYQiIL3SLqh6rfDI2O2CJwUrpXLHHa6T4QcSlNzpe65jO9H0eqvldCx7GdU
         odpA==
X-Gm-Message-State: AKS2vOweBm5PlgmWg8UqUwpJki5hdpEclV3mVdcn5MPkkf3GZFkWG+u0
        SN9MyxmLUuHmWbxB
X-Received: by 10.28.155.65 with SMTP id d62mr1805875wme.78.1497341889748;
        Tue, 13 Jun 2017 01:18:09 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id 22sm23413380wrt.36.2017.06.13.01.18.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 01:18:08 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, philipoakley@iee.org, jrnieder@gmail.com,
        avarab@gmail.com, peff@peff.net
Subject: [PATCH v2] Configure Git contribution guidelines for github.com
Date:   Tue, 13 Jun 2017 10:18:07 +0200
Message-Id: <20170613081807.33196-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many open source projects use github.com for their contribution process.
Although we mirror the Git core repository to github.com [1] we do not
use any other github.com service. This is unknown/unexpected to a
number of (potential) contributors and consequently they create Pull
Requests against our mirror with their contributions. These Pull
Requests become stale. This is frustrating to them as they think we
ignore them and it is also unsatisfactory for us as we miss potential
code improvements and/or new contributors.

GitHub contribution guidelines and a GitHub Pull Request template that
is visible to every Pull Request creator can be configured with special
files in a Git repository [2]. Let's make use of this!

[1] https://github.com/git/git
[2] https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

changes since v1:
* mention submitGit
* link to mailing list address instead of mailing list archive
* reformat long lines
* move "read" out of link title
* use kernel.org repo for "A note from the maintainer"
* reference "A note from the maintainer" with the correct name

You can see a preview here:
https://github.com/larsxschneider/git/compare/master...larsxschneider-patch-1?quick_pull=1

Thanks,
Lars


Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/c438291da7
    Checkout: git fetch https://github.com/larsxschneider/git contrib-guide-v2 && git checkout c438291da7

 .github/CONTRIBUTING.md          | 19 +++++++++++++++++++
 .github/PULL_REQUEST_TEMPLATE.md |  7 +++++++
 2 files changed, 26 insertions(+)
 create mode 100644 .github/CONTRIBUTING.md
 create mode 100644 .github/PULL_REQUEST_TEMPLATE.md

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
new file mode 100644
index 0000000000..fc397bb8fc
--- /dev/null
+++ b/.github/CONTRIBUTING.md
@@ -0,0 +1,19 @@
+## Contributing to Git
+
+Thanks for taking the time to contribute to Git! Please be advised, that the
+Git community does not use github.com for their contributions. Instead, we use
+a mailing list (git@vger.kernel.org) for code submissions, code
+reviews, and bug reports.
+
+Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
+conveniently send your Pull Requests commits to our mailing list.
+
+Please read ["A note from the maintainer"](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo)
+to learn how the Git project is managed, and how you can work with it.
+In addition, we highly recommend you to read [our submission guidelines](../Documentation/SubmittingPatches).
+
+If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q4&feature=youtu.be&t=6m4s)
+might be useful to you as the presenter walks you through the contribution
+process by example.
+
+Your friendly Git community!
diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
new file mode 100644
index 0000000000..2b617f4c25
--- /dev/null
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -0,0 +1,7 @@
+Thanks for taking the time to contribute to Git! Please be advised, that the
+Git community does not use github.com for their contributions. Instead, we use
+a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
+bug reports. Nevertheless, you can use submitGit to conveniently send your Pull
+Requests commits to our mailing list.
+
+Please read the "guidelines for contributing" linked above!

base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
--
2.13.0


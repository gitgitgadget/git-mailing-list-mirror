Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36321F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 14:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdFIOXY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 10:23:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36452 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdFIOWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 10:22:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id e23so7156800wre.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H8FPKpw/Y47X5cabEll1x+PKwtjeOtTU3aTOMLk9JnQ=;
        b=czegC/eiBTTOZsARwQGXdHdKtrFjcEQM4PrKP5dmQhQRYbWZuAPF1p1a5nUZKp9+ik
         lkXIVNCKSfPJ5yW0jpELY4QK3XeRSgINZK2JaC3heReXmCdhnm9bREjlUkKnZm3tF48Z
         Wy2bRfMhuDEc5wl/UnCICGIZao2tEfhUjsH3iCtsSDVQtZKeodIfA4VpjLnbCg2fDHSa
         rBVay6lVTnyrGJFmQXqWYTxX2YnLF6RyRffr9ayHFBCGTTx0KDiLpYHns/0ks7HAPxqC
         /IFffVjZMMBhu/4aIDm6QOHrR/DmEqdvkGWZumQV7gwmpb7h8uCrFj7TA/FcSXPL5qeO
         /VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H8FPKpw/Y47X5cabEll1x+PKwtjeOtTU3aTOMLk9JnQ=;
        b=T4DwsNhUysw+DiKoBvUPeKmAdIvZX1iMnHwUpV66GFFJrN+gurO0fLtIzNSt2tlGd6
         Z/eFJHzDkWapktd3qXhGGCauc/yJSKT7MITfL4i8lUt86u6bYr/zszE3MWwSpnsRBcHI
         NrIVumToDjF/jeQ2DXyKfuraqSh98SMU6RFLm/nRPbjgI5y+iVcB+nOl3KqNT52wJ9eX
         PsEmOiWK42KJKhT4ZtZVRn19WkSmzo8V/Pcxo6Z11+KtccbogJ+8yqorWoe7owQd6nO+
         QfYXePwKJcjqQ+5e9XriOPP0RD8kF/WlsfkKON46JY83H+T3eMOTjSxFkZ20fXFV9QCb
         z58A==
X-Gm-Message-State: AODbwcBywxsi4hA6IMboolyaAkPxFjhvr3vC4y6Yg1hbKJ7DHmDpxaAk
        umvwO2hEUQ7ERHuy
X-Received: by 10.223.144.4 with SMTP id h4mr11925841wrh.182.1497018114081;
        Fri, 09 Jun 2017 07:21:54 -0700 (PDT)
Received: from buc98hyl12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id t15sm2601951wmd.13.2017.06.09.07.21.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 07:21:53 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH v1] Configure Git contribution guidelines for github.com
Date:   Fri,  9 Jun 2017 16:21:51 +0200
Message-Id: <20170609142151.94811-1-larsxschneider@gmail.com>
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
Requests become stall [2]. This is frustrating to them as they think we
ignore them and it is also unsatisfactory for us as we miss potential
code improvements and/or new contributors.

GitHub offers a way to notify Pull Request contributors about the
contribution guidelines for a project [3]. Let's make use of this!

[1] https://github.com/git/git
[2] https://github.com/git/git/pulls
[3] https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

I am perfectly aware that adding a ".github" directory in the Git core
tree is ugly. However, I believe the benefits ("well informed new
contributors") outweigh the injury.

You can see how a github.com Pull Request creation window would like here:
https://github.com/larsxschneider/git/compare/master...larsxschneider-patch-1?quick_pull=1

I added a link that jumps to a part my GitMerge 2017 talk which explains
Git core contributions from my point view. Although I tried my best, the
presentation is not perfect and might not reflect the view of the Git
community. I wouldn't have a problem at all with removing the link.

I also did not break the lines in the .github/*.md files as I thought it
renders nicer on the github.com web interface. I am happy to change that,
too, though.

Cheers,
Lars


Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/d859be5016
    Checkout: git fetch https://github.com/larsxschneider/git contrib-guide-v1 && git checkout d859be5016

 .github/CONTRIBUTING.md          | 10 ++++++++++
 .github/PULL_REQUEST_TEMPLATE.md |  3 +++
 2 files changed, 13 insertions(+)
 create mode 100644 .github/CONTRIBUTING.md
 create mode 100644 .github/PULL_REQUEST_TEMPLATE.md

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
new file mode 100644
index 0000000000..8d01be6a71
--- /dev/null
+++ b/.github/CONTRIBUTING.md
@@ -0,0 +1,10 @@
+## Contributing to Git
+
+Thanks for taking the time to contribute to Git! Please be advised, that the Git community does not use github.com for their contributions. Instead, we use a [mailing list](http://public-inbox.org/git/) for code submissions, code reviews, and bug reports.
+
+Please [read the maintainer notes](http://repo.or.cz/w/git.git?a=blob_plain;f=MaintNotes;hb=todo) to learn how the Git
+project is managed, and how you can work with it. In addition, we highly recommend you to [read our submission guidelines](../Documentation/SubmittingPatches).
+
+If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q4&feature=youtu.be&t=6m4s) might be useful to you as the presenter walks you through the contribution process by example.
+
+Your Git community
diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
new file mode 100644
index 0000000000..c737a64620
--- /dev/null
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -0,0 +1,3 @@
+Thanks for taking the time to contribute to Git! Please be advised, that the Git community does not use github.com for their contributions. Instead, we use a mailing list for code submissions, code reviews, and bug reports.
+
+Please read the "guidelines for contributing" linked above!

base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
--
2.13.0


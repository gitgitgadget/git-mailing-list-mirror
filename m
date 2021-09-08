Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD0C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB1460F5E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbhIHIFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:05:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:49687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350049AbhIHIF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 04:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631088257;
        bh=WTCPMOFdW8eS78Q+pCkBGUtf2STzA3puIo85JkvVXPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lfOV+Y+IwV8c8OuKkiGiRWZfXOMTl7mmrHtGGodQlyGidH/RX2vt9qshOi0xDTFFZ
         u6MGi242UAa8Qoyf6czkcVyDy0OFJdbNWZwF+QJC81s4VifXDMo03vXmWt2VbvDKZO
         LSH5wzmCuKUXXXox0Kc3BRRMGIZRueDpmX02yLxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1mRd1T0HgE-00YifW; Wed, 08
 Sep 2021 10:04:17 +0200
Date:   Wed, 8 Sep 2021 10:04:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Fix D/F issues in stash
In-Reply-To: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109081003270.55@tvgsbejvaqbjf.bet>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:McL76nQ+3I85e1NKRTqJM5tfvVXY0lyWFf0Enn35uKQu+PHk2Wd
 Aji2Y2rRemrqBurpHH4WWqGbaCvtkH8LASJvv20rhYmjMQMXAt2/78Y3Ro+zSRSDfDKlTeL
 EER+0igjiV8ArbV8MsLQZmZZzuy6lr7MYF0gvFdvqQPt0y+VBQnJbHptWKPf+RUlqTZF3Vu
 nFbzOIDSIPehT1Le76KZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bk9hC5H+t/o=:rFrPFDPpZjhW98YIhcE0Yf
 m74EIkDDRBd+fwScuE0fwkBn89mZ6BeR6mB1gqZSzO9N82ULQspSqEOAPEVWiJjArbmF1gYLO
 7yeNF8O6OjJ/geYa1k7PMGERKlwLc423dYoEoYaHlfmWjVvQt844vwsmyGmRRaHst+FF1g1Yb
 d43j2J4XTZjJcBbB2ReJPpMCpleGB3FnHnvQll/tvSjjfumqkvxugSZNkkXx3BvAbs8Wl0h38
 7hFNXL4WKUFjd/kpLuwv/TW5dW7coMBG0k5gL7BXLr17eDxv6Fz7r9Bt4qWA/wRtx+LsheLoQ
 YDEsCSXw/ktgXG2M1ysA2P9YtjmLhesWdKO88ysfnGo+o52BjmCouaNR7SSsgncKlU60sqTwT
 7Ljx1KKlwtDfD6FgxYkZ8a+SbU/DRo4rCW4YnQH50pmikteSP+8cs7QMHci7/X0AY5NB+gf8F
 VCrkizzVzUbXxh+1kbYXtAYdnDhszDKmyY/iVDp7wv0gTzZMjsxVKd2PlQxd41aHWI5qL8UP7
 +CUpx0Y4XbAwc+Hnpgs4vx1NJi+JXwSeGy2h1wT2Ch52Ftf8DgcO1hsQtpM146N3PMndNGD9r
 xO1dfSRl1WDnx7Cl4xKh2IvEyRjKXd30ZHt4zcaY0/79++/ou0NvWQ2NDWfk3iP8aY864h3i6
 LHiDqh6vZpcfooHeIJsoupW3BiTtF2YALJRYFnrfJFQjKLIRVckxZAr+Yg9ttyFiZvXyixj7+
 0VCrsUsCC73t6Z9cEfegkY1vj3m2cNbbud5oezYbswrbM/pdELJzLHqWprq4RJJ2xTkQW+DzX
 g4qaQ8X3r1QCND+M1l9CoyI3UsI93xnc4B61PPz+ckOQTgu2lYSOVHGv91GYJCL1SGMJGafQE
 yl5K/9E2lT2yQQixjv9Q4cHjyqBbDkUYlqQGks+HfQefPypyNfEbhfLSHQJyLahjxHnknGzNC
 uvFTGfZ3zKGs6sqmpkFzncNo+fqgYhDf/AqHgoUFmWiPGIQgGhtHCwo/Pr0kViDYA93n5Nobm
 CX7vfRY7PO1Id5gq/Q1JJqgqrErX2Jm1Kueo2Hc1NO+VIDMDatZ9nXYF6wJzuMjZbHWjV13Y4
 jotyhdjVw5qpQw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 8 Sep 2021, Elijah Newren via GitGitGadget wrote:

> This series fixes a few D/F issues in the stash command. These were some
> issues I found while working on unintentional removal of untracked
> files/directories and the current working directory, and I'm just submitting
> them separately.

Awesome work! Apart from asking for an additional clarification in the
commit message of the second patch, I have nothing else to offer but my
sincere thanks for working on the `stash` code.

Thank you,
Dscho

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6D11F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdLKXfV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:35:21 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:45048 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdLKXfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:35:16 -0500
Received: by mail-wm0-f48.google.com with SMTP id t8so17529930wmc.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aghyEdXD3AzfGncTksemRIXTDvX+swhW2HLPBCXwlOA=;
        b=LBUY58nCMj+ajMkvlCGGGq4/kBfuB6DsDXmxDxYihOoTXnKx7j/dAuICWwi+8c2TTh
         fuzXQ71HWltNqIhxbGUjZSQDjjnuTpVFOn4ADRKW5VNGbHnzuYdKTHIw0aOMNex5f1vC
         pWB9zk9+SFEkwWzflFcWz1eY0iUhufqqynt49Wi3zovUgeYhMT+Pwmf4VqrZNP+VKK5/
         mqZg/bePOcFwjw+NX9xKJqLD7zMUhwZgi5rEEREWs1VKjW3tlRj2ajzg63exvp5Crd4W
         85p/LOYX18Tz84sWsF7N+KSCIceu6c0dTyUS2F5vBLf93qLMn3bxK0swVzpEihzTwgV+
         6LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aghyEdXD3AzfGncTksemRIXTDvX+swhW2HLPBCXwlOA=;
        b=TlJMAazPGG0AMNdoeviO+gdWfGSyKygl2WiDgKr3M82qCHGv+IEPxNKwAbTRSuDttM
         xnmnPSvLNqVM5x7HTLSd4g24Tg2174GO7AnNKlcyuIo4qC9o/hVYcEdZKj2i0+Te2kJJ
         WxXirTrNqi9qVEIRvYovql6/8HZs1VzY7ug0fO7LE9R8/GgQz4e/OYLi5C2ulLNw36Vt
         mKEFn6rmIelDy02gzmdB1b9p0umQG+MKAkNHxsEpYFJjHegeGOcDpguw20Gxzj/pt/Wx
         40DE1YNyFnxCRbxP/loPl3DGM4IY6VPO10CbblXFiueNwFrPm+x94/X5AcN2ubxkyrao
         L9qA==
X-Gm-Message-State: AKGB3mIm8BD98q1Z0R3l/6K7YLsbHJrAUoz8qh167oMuYauPmHh2i49f
        TUlNtv0DsWR1pP5/IgbncAxbqw==
X-Google-Smtp-Source: ACJfBot1OObzn8Oivz8cSy3dyQ6gTA2X1hT9XNn14upJsGd9b/9KPfOpHPTCYDGmQEiIrRcYmxM+/g==
X-Received: by 10.28.95.7 with SMTP id t7mr17271wmb.86.1513035315434;
        Mon, 11 Dec 2017 15:35:15 -0800 (PST)
Received: from localhost.localdomain (x590d9245.dyn.telefonica.de. [89.13.146.69])
        by smtp.gmail.com with ESMTPSA id h12sm15408811wre.52.2017.12.11.15.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:35:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/4] travis-ci: clean up setting environment variables
Date:   Tue, 12 Dec 2017 00:34:42 +0100
Message-Id: <20171211233446.10596-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.421.gc469ca1de
In-Reply-To: <20171101115535.15074-1-szeder.dev@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Was: [PATCH] travis-ci: fix running P4 and Git LFS tests in Linux build
jobs)

On Wed, Nov 1, 2017 at 12:55 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> However, after these
> embedded scriptlets were moved into dedicated scripts executed in
> separate shell processes, any variable set in one of those scripts is
> only visible in that single script but not in any of the others.

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index a29246af3..5bd06fe90 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -12,20 +12,18 @@ case "${TRAVIS_OS_NAME:-linux}" in
>  linux)
>         export GIT_TEST_HTTPD=YesPlease

Astute readers ;) might have been wondering what's the deal with this
environment variable in the patch context, since this won't have any
effect outside of this script, either.  Alas, it's not as easy as moving
setting GIT_TEST_HTTPD to 'ci/lib-travisci.sh', like the quoted patch
did with paths to P4 and Git LFS, because then it would be set for the 32
bit Linux build job which runs everything as root, thus can't run https
tests.

This patch series deals with this by adding means that 'ci/*' scripts
can use to identify which build job they are taking part in (patch 3),
and then setting environment variables in 'ci/lib-travisci.sh', where we
have now more freedom to set a specific variable only for specific build
jobs (patches 3 and 4).


This patch series conflicts with the last patch in Thomas' split index
fix series.

  https://public-inbox.org/git/20171210212202.28231-4-t.gummerer@gmail.com/

The conflict is not overly difficult, but to resolve it we should first
come up with a reasonable job name for that build job, e.g. something
like "misc-knobs" or whatever, because the combination
"GETTEXT_POISON-SPLIT_INDEX" is just too long to exist and won't scale
if we enable further knobs in the future.


SZEDER Gábor (4):
  travis-ci: use 'set -x' in 'ci/*' scripts for extra tracing output
  travis-ci: introduce a $jobname variable for 'ci/*' scripts
  travis-ci: move setting environment variables to 'ci/lib-travisci.sh'
  travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh'

 .travis.yml                | 26 +++++---------------------
 ci/install-dependencies.sh |  8 +++-----
 ci/lib-travisci.sh         | 34 +++++++++++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.15.1.421.gc469ca1de


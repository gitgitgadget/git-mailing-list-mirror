Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D0E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeJWEnT (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38609 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEnS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so39230441ede.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fy1Qcr7/U2ZH287A538Lwxfxe3Kb809OmzqiaeT6R+g=;
        b=Qqsh/y1tp4TFxhIWLG1aaSmIdtxK26+yPWFudJZTVsMVi7tgFyaODnVkbyAvzgNBCr
         ZcPhuRi4JsAldYAGrosqcRyUQzli3czVHnlaHfXJphKbpS3oPullNOk1eTnqjcQ/lNGZ
         szjnmhODfz1k+76BbsdQP9Y0x/c8UVqtun0F0DYQJkQ0bq4WhqngSIFwycaG/dprTEYg
         zHi7fmc86FEdl6XprZRgVTtilOZBHx0PCRufYOKPy+cdzmsHKoaBf+eYeZu6SHf0/E8a
         Trw6Avws2KLF9ULWEyPd4oVMsebQ1/e4XI6xFdV/or74DMt2yqpOuZmwkbVD6SyS7qla
         CwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fy1Qcr7/U2ZH287A538Lwxfxe3Kb809OmzqiaeT6R+g=;
        b=hOZ8UkU+m3qrXHOPIbBBX+qPbDcbogTu6AXrMJNBAcfozSgGtXF1YuEs8C7D8+5A1T
         JOkqNXEL+eEzQlwt5gtBdF5QVB4UDBD5tMuAxP8esR+uxe7m1T9PS0WiEBnF9s5cKgAa
         iM1z3iUdrx6VMonwa+CmYGUfSYe+mQ+HY02whLMwtPsdUD0+tE29Z7dSCRK4+tx7pIlG
         Cb+8l33zcJ2KjfymNCz409qS+QyPZTM9g1bAvOZTwyAGzCAak6LpWbzKYlbRhr4xeYUL
         5q2xbCCqTdsXPDAl7SDC9rrOajLXY5c5LAtNGvNVcszFfX4xV7N3zne5hN95n/lo6+t6
         V5PQ==
X-Gm-Message-State: ABuFfogFbjHD7LzdKTanSiWJpxaYVsD/u9o6o5R38byuqsnEGb5h8w67
        LauRBo0o33VUATIoXN5BqFoiCSuk
X-Google-Smtp-Source: ACcGV62A8ThUVaWQNNq9gYwuGyKlvKB+7VXqMCGJeTdYLyIFvlf4z0byiCttE8izRPcOMiAMkb0L+w==
X-Received: by 2002:a17:906:70c3:: with SMTP id g3-v6mr1345286ejk.194.1540239797281;
        Mon, 22 Oct 2018 13:23:17 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
Date:   Mon, 22 Oct 2018 22:22:33 +0200
Message-Id: <20181022202241.18629-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022153633.31757-1-pclouds@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 05:36:33PM +0200, Nguyễn Thái Ngọc Duy wrote:
> The current gettext() function just replaces all strings with
> '# GETTEXT POISON #' including format strings and hides the things
> that we should be allowed to grep (like branch names, or some other
> codes) even when gettext is poisoned.
> 
> This patch implements the poisoned _() with a universal and totally
> legit language called Ook [1]. We could actually grep stuff even in
> with this because format strings are preserved.

Once upon a time a GETTEXT_POISON build job failed on me, and the
error message:

  error: # GETTEXT POISON #

was not particularly useful.  Ook wouldn't help with that...

So I came up with the following couple of patches that implement a
"scrambled" format that makes the poisoned output legible for humans
but still gibberish for machine consumption (i.e. grep-ing the text
part would still fail):

  error:  U.n.a.b.l.e. .t.o. .c.r.e.a.t.e. .'./home/szeder/src/git/t/trash directory.t1404-update-ref-errors/.git/packed-refs...l.o.c.k.'.:. .File exists...

I have been running GETTEXT_POISON builds with this series for some
months now, but haven't submitted it yet, because I haven't decided
yet whether including strings (paths, refs, etc.) in the output as
they are is a feature or a flaw.  And because it embarrassingly leaks
every single translated string... :)


SZEDER Gábor (8):
  test-lib.sh: preserve GIT_GETTEXT_POISON from the environment
  gettext: don't poison if GIT_GETTEXT_POISON is set but empty
  lib-rebase: loosen GETTEXT_POISON check in fake editor
  gettext: #ifdef away GETTEXT POISON-related code from _() and Q_()
  gettext: put "# GETTEXT POISON #" string literal into a macro
  gettext: use an enum for the mode of GETTEXT POISONing
  gettext: introduce GIT_GETTEXT_POISON=scrambled
  travis-ci: run GETTEXT POISON build job in scrambled mode, too

 Makefile                  |  2 +-
 ci/lib-travisci.sh        |  1 +
 ci/run-build-and-tests.sh | 10 +++++--
 gettext.c                 | 63 +++++++++++++++++++++++++++++++++++----
 gettext.h                 | 33 +++++++++++++++-----
 t/lib-rebase.sh           |  2 +-
 t/test-lib.sh             | 17 ++++++++++-
 7 files changed, 110 insertions(+), 18 deletions(-)

-- 
2.19.1.681.g6bd79da3f5


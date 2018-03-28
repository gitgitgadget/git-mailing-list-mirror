Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F3F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeC1R4Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:25 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43337 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeC1R4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id v207-v6so4713798lfa.10
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIwxbeJnrfF4tgQZrtCPhMKNZIj6iZuaVMPQEQK8ma8=;
        b=EHlIUz7fg3CsgcQ2w2E7jumNzr2Gu3400MFubkHaA3XvB6hQkb3qnc7i24JCZXl0DU
         UDmEikMysfbo/q0FhoJYfDBippmRNKInMaVysyx19HWy2NUAgJDnpvzF+o5gEZ71H2JP
         NrHx42EIbT4aCoo/aXD798Q5dvxI784LTdI98FQz8CoPikSyP2m5ZGaCo1o2Y0+GcUSn
         27OnzpfBK22TXeUnNEPpKmwk07hzXcCFjXeArC8umaY2jREz7OqsxlNo472X1mFwBJoR
         U0cwRNmekrIUdpkCVtPRtrhM+rPbwiFSqbkred5yCEdBepwINUdtvlBn6XzghVA20R/T
         xgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIwxbeJnrfF4tgQZrtCPhMKNZIj6iZuaVMPQEQK8ma8=;
        b=jOLy6cDMyzztVFXfMiEvhk/aapwZt21qEtErDcvLbhrVjt9kjnx1cjckr9p6zgRlLf
         9sPmaDuTsXiLNKEmsSJidxh+4+SX8+hYyPJb3mA+wH13EnS+4Z3qJCZrXxHFA2oBMRdw
         BUFRuTN4UfUfDX1jRjiRnWTYqvcwMbE/fMbjlZfbfqCvCdvHeYqwIRxN7ytWXNnLlbU8
         lfH+A9ODV2b2wc9hQPrmGtpSLnaPBvKeG+Dk34bhpve5ESpYv/IPfk+UrdQNp4Rl9dMZ
         weAEhsJlV2LN0sFuYj0ElibkKMnzKMN2tTu04lDT6J6m2uQJzukMds+zHFEw/xOQn4lL
         WrIA==
X-Gm-Message-State: AElRT7GvvLmZFDHakM/xs1kK3f2p9caGpz21DPjwLJsPJdJGbIMzJ8I4
        VsiqxcAGwC4BGkGcxyK90KIJuQ==
X-Google-Smtp-Source: AIpwx48fbuJiFICGCSBzWPowaXzmh86GcS7AT376PPsto9Wmj+8iQoM4uI9eL1aAI/jXhOPSaS3XXw==
X-Received: by 2002:a19:2044:: with SMTP id g65-v6mr3186803lfg.0.1522259780961;
        Wed, 28 Mar 2018 10:56:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/8] Re: git complains packed-refs is not a directory when used with GIT_DIR and GIT_WORK_TREE envvars.
Date:   Wed, 28 Mar 2018 19:55:29 +0200
Message-Id: <20180328175537.17450-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328094733.GA1523@sigill.intra.peff.net>
References: <20180328094733.GA1523@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 7:36 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 28, 2018 at 12:10:21PM +0200, Duy Nguyen wrote:
>
>> > I think it might be clearer if a single call is given both the old and
>> > new paths. That requires the caller of chdir() storing getcwd() before
>> > it moves, but I don't think that should be a big deal.
>>
>> The problem is switching relative paths relies on the old $CWD if I'm
>> not mistaken and we need  getcwd() for this. I'd love to have one
>> callback that says "$CWD has been switched from this path to that
>> path, do whatever you need to" that can be called any time, before or
>> after chdir(). I'll look more into it.
>
> I think it should be OK to save getcwd() and just construct the original
> path after the fact. Here's some patches which do that in a nice way.

Heh.. I should have checked mails more often while coding ;-)

This is what I got, which is slightly different from your series
because I want to call set_git_dir() just one time (by
setup_git_directory) and never again. I think the API looks close
enough.

I will probably rework on top of your chdir-notify instead (and let
yours to be merged earlier)

Note, this one is built on a strange base, which is a merge of 'next'
and 'sb/object-store' (I needed 'next' and Junio would have another
evil merge if 'sb/object-store' was not in the base).

Nguyễn Thái Ngọc Duy (8):
  strbuf.c: add strbuf_ensure_trailing_dr_sep()
  strbuf.c: reintroduce get_pwd_cwd() (with strbuf_ prefix)
  trace.c: export trace_setup_key
  setup.c: introduce setup_adjust_path()
  setup.c: allow other code to be notified when $CWD moves
  environment.c: adjust env containing relpath when $CWD is moved
  repository: adjust repo paths when $CWD moves
  refs: adjust main repo paths when $CWD moves

 abspath.c             |  4 +--
 builtin/difftool.c    |  6 ++---
 cache.h               |  8 ++++++
 dir-iterator.c        |  3 +--
 environment.c         | 46 +++++++++++++++++++++++++++++++++
 object-store.h        |  3 +++
 object.c              | 15 +++++++++++
 path.c                |  9 +++----
 refs.c                | 10 ++++++++
 refs/files-backend.c  | 15 +++++++++++
 refs/packed-backend.c | 12 +++++++++
 refs/refs-internal.h  |  4 +++
 repository.c          | 28 ++++++++++++++++++++
 setup.c               | 59 ++++++++++++++++++++++++++++++++++---------
 strbuf.c              | 43 ++++++++++++++++++++-----------
 strbuf.h              |  8 ++++++
 trace.c               | 14 +++++-----
 trace.h               |  1 +
 18 files changed, 239 insertions(+), 49 deletions(-)

-- 
2.17.0.rc1.439.gca064e2955


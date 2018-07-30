Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7397A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 23:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbeGaBST (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 21:18:19 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44646 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeGaBST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 21:18:19 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so5458204ybk.11
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dwSnhQv6a85Tk/fUttakr56mKQYuVUiYCJotnVyCVI=;
        b=WtWcSshXm8lWgfQ7kiDtbYxd/utkfmserg2QlGiXR6CCNcUNsuKG0ETzd1+exXvbj2
         TPyrqWnAgFSoLvm3sxyG0UkL4YUbQvL3w5yjPt3k9EPHZZ21LBcEYbTYPcfUq7VfIDCJ
         RAzpRsvJY+BPE+E92thPa1dRvrFIIXiSAQA5lOBl3NdxkVpnqo3lXr8iOBoW6aEVbF6m
         SMSSE6PjhJNLQYVFxqSwZ5InS6rIvW4hwbW9ireleE61yHRvrg5cm7bDJDvCPx9PQfTV
         W/RrB7ZcIhM7IL0tt7rIV3UZXyjYxIqL//k/Qt9vZGm5lEbYayxFW4GZvFzuw2F4Jtam
         /bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dwSnhQv6a85Tk/fUttakr56mKQYuVUiYCJotnVyCVI=;
        b=Tx712RUJzoHcjQpJFd8gUXL1qCH+edVV7Tm+OV4l/y6CqP3QBcow9uapUuKzqrnyrA
         QfBYDdhrcLBl0N+UO8DBOt9aqmEHHSyLr9MyuYy/W4FWNwVNLcAR+D5ctzc7tUrgSoAX
         7suDg7+uHZa8IJQu7T8sflVynax39ZnsAtvHR8VAqiY6buWj/tvsWBPxqxfL8hr9g58l
         ICmhQaitu291BMwomYlnRC0uVfYti3bnr9BefMMVFbBeVgqKV7jCm3jePzcs4h1GBamP
         lNd7Hf/vd3d+gV78wxKDtPsYY5D+AxQB+/dMC9tsZmsNkWE0a7+FiABkDrFpVIUBKVQQ
         RdbA==
X-Gm-Message-State: AOUpUlFOG3gRz+N2TbR8/s/vJmszNCk+bD+NsEok5J5TysYHnR6nTXvD
        wU1QlJBa6TvkV/oecwb+ZssBNLlWS2mIF1NpOHormA==
X-Google-Smtp-Source: AAOMgpfWmaOYYFpMrmCKy0qgf/VyE1gi31sPjVJ3DXWqT+WSMf/e0viOYMYNy+ueEejFxblPLW9fEdhAlUmHYy/0qpA=
X-Received: by 2002:a25:cc97:: with SMTP id l145-v6mr10315386ybf.334.1532994056414;
 Mon, 30 Jul 2018 16:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
 <CAPig+cRd2V_hN0BVCcevXhu1v_QpL76mhqTGQmWPLK7sAD4Ytw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807301830330.10478@tvgsbejvaqbjf.bet> <xmqq600wfpfl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq600wfpfl.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Jul 2018 16:40:45 -0700
Message-ID: <CAGZ79kbnrBHscQUS8WdU9f6edGS=yH9wpVywLGyBxGHU0c_WfQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/21] range-diff: add tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 1:18 PM Junio C Hamano <gitster@pobox.com> wrote:

> > I already pushed an update to https://github.com/gitgitgadget/git/pull/1.
>
> Should I take "pushed to ... GGG" to mean "do not merge what you
> have to 'next' yet, as there will be an updated series (not
> incremental) being prepared"?

Not speaking for Johannes, but I think that *could* work.
On the other hand full rerolls are more expensive to prep
(at least for me, I guess GGG might change that)

git range-diff gitgitgadget/pr/1...origin/js/range-diff
shows there is

* a different header guard:
   @@ -418,8 +419,8 @@
     --- /dev/null
     +++ b/range-diff.h
     @@
    -+#ifndef RANGE_DIFF_H
    -+#define RANGE_DIFF_H
    ++#ifndef BRANCH_DIFF_H
    ++#define BRANCH_DIFF_H
     +

* another different header guard:
    @@ -239,8 +240,8 @@
     --- /dev/null
     +++ b/linear-assignment.h
     @@
    -+#ifndef LINEAR_ASSIGNMENT_H
    -+#define LINEAR_ASSIGNMENT_H
    ++#ifndef HUNGARIAN_H
    ++#define HUNGARIAN_H
     +

although this one is the other way round. Did you
squash in one header guard and Johannes fixed a
header guard in a different file?

With that said, I can send my series for more color testing
and better diff.c code on top of either.
(https://public-inbox.org/git/20180728030448.192177-1-sbeller@google.com/)

Stefan

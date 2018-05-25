Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D601F42D
	for <e@80x24.org>; Fri, 25 May 2018 21:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030215AbeEYVBW (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 17:01:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41004 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968376AbeEYVBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 17:01:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id u12-v6so11254850wrn.8
        for <git@vger.kernel.org>; Fri, 25 May 2018 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oc0GJeDeseFtLfGmNy1RUvW1N8XnpfmPP6qwNxSwEKY=;
        b=oVyX9+8nos54mFFhYlClzClbHFJ5kIN2/KskE7GRAgdSfz1yQYWja1x8YtuOmgtdjy
         f9a4KlnItOwPmaR3Kf99oeO+wq+BvKeVZIvNUn+iy5Y34KWsT648thimAuI8naghm/F5
         /b7ICOHFZ7Dq1tqT2Eyn+c346i12LC/INpsn1wKz2EtQPt4fHutlYdVm2AcU6ryltyQJ
         1uGSjRSASGhx2QrQ33OZ11eenXs4M4T1kH9p4ior23y8Z1EIvdNAS+oZpCEvOIkEd04v
         6+ELD4yaasWqG8nMPZ0n8Qum9/bXQJCq/zEj4YcFJtRkXidszDrtGSawZKlP/Aq36XNG
         YAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oc0GJeDeseFtLfGmNy1RUvW1N8XnpfmPP6qwNxSwEKY=;
        b=ZzL016u4tMYib8VLRQxBwBE0BkD8NdtwmykRWGihsihX6HRymcIyYrI/2A4ARFz4bB
         R3VANGb0Z8ALbBBW1MR+WMBaqoap8BqnmHhdBjvbPZ423+lEbNNFGA1GyjEuh5gR5xTb
         SQQH0FAayH/5gYJJJ8c5ktv6n6gXrGxudNPqgBrP52PUcxGyid+DHvP4hd31HVZJuzkl
         U7UkXGREwFZi03K/9bxhwOKYbH0WREzFotsLD3G3cD9DEs3WfK10p5ghBBHOeluDiohy
         9XWulQJ7wwEsWXFp7FBlSPk4FvuS4EpG81DdOy89Qzwkuijz1jFwY/jOQKq4YBTeSvyv
         2qCw==
X-Gm-Message-State: ALKqPwfA/bQ0EE9/MvAkdkSHhBvahMiHXY/6cIcacdyFyvBM+f4C4LpH
        2VJT7WtR5kQ7lhNXtdaRCd/+f5KJ
X-Google-Smtp-Source: AB8JxZq8HnOF3K5JDaKuTH4KrYb+8aeyVhjMQ5AZbCZCxzDCnps/5yMJGolwI01qKvXbnKBtiPH37A==
X-Received: by 2002:adf:b722:: with SMTP id l34-v6mr3798437wre.85.1527282079220;
        Fri, 25 May 2018 14:01:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q9-v6sm2520105wmq.45.2018.05.25.14.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 May 2018 14:01:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/3] usage: prefix all lines in `vreportf()`, not just the first
Date:   Fri, 25 May 2018 23:00:52 +0200
Message-Id: <cover.1527279322.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.1181.g093e983b05
In-Reply-To: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 May 2018 at 11:14, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +                    warning("the '-l' option is an alias for '--create-reflog' and");
>>> +                    warning("has no effect in list mode. This option will soon be");
>>> +                    warning("removed and you should omit it (or use '--list' instead).");
>
> By the way, this is one of these times when I feel that we should
> have a better multi-line message support in die/error/warning/info
> functions.  Ideally, I should be able to write
[...]
>         warning(_("the '-l' option is an alias for '--create-reflog' and\n"
>                   "has no effect in list mode, This option will soon be\n"
>                   "removed and you should omit it (or use '--list' instead)."));
[...]
> and warning() would:
>
>  - do the sprintf formatting thing as necessary to prepare a long multi-line
>    message;
>
>  - chomp that into lines at '\n' boundary; and
>
>  - give each of these lines with _("warning: ") prefixed.
>
> That way, translators can choose to make the resulting message to
> different number of lines from the original easily.

How about something like this? The first two patches implement the
above three points, except for the translation of "warning: ".

The third patch is the main reason this is marked RFC. It translates
"warning: " and similar, and breaks quite a few tests under
GETTEXT_POISON since we grep for, e.g., "warning" on stderr. I could
annotate those tests, but since I'm running out of time anyway, I
thought I'd post this as a heads-up of "I'm looking into this".

I do wonder: If our tests rely on grepping for "warning" (for pretty
good reasons), how many scripts out there do something similar (for
maybe-not-so-good reasons, but still)? Do we want to avoid breaking
them?

Also left to do is to convert any existing lego-ing users to the
single-string form that Junio wished for above.

Martin

Martin Ågren (3):
  usage: extract `prefix_suffix_lines()` from `advise()`
  usage: prefix all lines in `vreportf()`, not just the first
  usage: translate the "error: "-prefix and others

 t/t1011-read-tree-sparse-checkout.sh |  6 ++---
 t/t1506-rev-parse-diagnosis.sh       |  2 +-
 t/t1600-index.sh                     |  6 ++---
 t/t3600-rm.sh                        | 36 ++++++++++++-------------
 t/t5512-ls-remote.sh                 |  6 ++---
 t/t7607-merge-overwrite.sh           |  6 ++---
 t/t7609-merge-co-error-msgs.sh       | 39 ++++++++++++++--------------
 git-compat-util.h                    |  8 ++++++
 advice.c                             | 18 ++++++-------
 usage.c                              | 28 ++++++++++++++++----
 10 files changed, 89 insertions(+), 66 deletions(-)

-- 
2.17.0.1181.g093e983b05


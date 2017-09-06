Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C41E208CD
	for <e@80x24.org>; Wed,  6 Sep 2017 11:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbdIFLI7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 07:08:59 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36749 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbdIFLI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 07:08:58 -0400
Received: by mail-oi0-f41.google.com with SMTP id x190so23949638oix.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mGCMRVEH3eA7K7SMqxUkewzw/6sSsEdxLDdSaDmomqw=;
        b=TcmHEXIYhlOdXISRnoiecI7765NdUhFM2ifJ/Im1VFInvzpcRVhbuw8nRB8fSkWvQT
         AhoqWLErc7tjvtMoRTcof3UEfngujiOayr7DxXAGU66+UAtLBe0+Cypm3dCBYzrlpwdH
         Hwlh0sOcRY0K0WzHSBqf9T/fAKOB6ffXZUqnV9vx87YBFkELPnHl/G3wlrUofjQs+uy4
         oaMGWVXr4+FkjGkptcCaUMZ3qWI6mZTXup1PsNNpzZtotLPVYf/X4rlkjrdmxq/jJwuP
         iw1fTR8VfRHzeRbzKsCvm7yYEB0HZkZz34BIP+X8dvQc0RvlbOpBborgpSh84CBCBb7K
         CqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mGCMRVEH3eA7K7SMqxUkewzw/6sSsEdxLDdSaDmomqw=;
        b=izXxtaUz9A3wnrwOEHU+K+rKqUcljpxMt0yh0VtyiATJK2LjJpbrd13MZeaogwpwTf
         STNEu6r5SaWMj9PgpesbKVV/HJ71lU0xOqQOBRtFJhIA+INLED42elWoJ222W7Ivt0Y2
         6Xpk8qeof5u+Ya3qVS4Z7YSVywKkXfqimYvooDizG5eNpUaXz5qxKOqn9ITH/pqX4eNT
         JVFdCY2f2IbZaTRFJrFdEIc1Ljrt5ge8VDSmRy1+l4R//G3kbRwZNvSpA7gK/R1LSRTE
         DcTkCORYCOdFebaZE40WiNMCkNdl0Q3s+e/jDzJ5TY2y1/RwIUdIE8HRTgxfJUGt/ZbB
         Io+g==
X-Gm-Message-State: AHPjjUi+ykjwzG54gnej4XLQDYH69muZc51oqhtzLU7OXzmLYMiYZvWj
        zYxAcOzTlD3chiMGsy2/SggeeIbhgw==
X-Google-Smtp-Source: ADKCNb6YbYTct2fNhlDLK7XNs3leDE+YOW6mihc8mRwbAATvdkvE8J8YaHOsqXz9uEYNDFZnaiK7BCtlhO7rocWSkYg=
X-Received: by 10.202.8.129 with SMTP id 123mr2727871oii.40.1504696137735;
 Wed, 06 Sep 2017 04:08:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.176.69 with HTTP; Wed, 6 Sep 2017 04:08:27 -0700 (PDT)
In-Reply-To: <CAGZ79kbvKZXGy80RCU3zkdm0S3M-tGB=LAJYiY=o+YwUB9RNHA@mail.gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-3-pclouds@gmail.com>
 <CAGZ79kbvKZXGy80RCU3zkdm0S3M-tGB=LAJYiY=o+YwUB9RNHA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Sep 2017 18:08:27 +0700
Message-ID: <CACsJy8A0x-PJsO+uhv8=mdfeKLEBPfT3sq3_Fi2_HffeexDeAw@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] refs.c: use is_dir_sep() in resolve_gitlink_ref()
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 2:14 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 23, 2017 at 5:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> The "submodule" argument in this function is a path, which can have
>> either '/' or '\\' as a separator. Use is_dir_sep() to support both.
>>
>> Noticed-by: Johannes Sixt <j6t@kdbg.org>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>
> Immediate questions that come to mind:
> * Could this go in as an independent bug fix?

It probably could. But it may depend on other submodule changes in this ser=
ies.

>   -> If so do we have any test that fails or stops failing on Windows?

It was spotted during the review [1] so I guess no test fails on
Windows (not that I would know because I can't run tests on Windows)

>   -> If not, do we need one?

Since I don't use Windows, I don't particularly care. And I can't add
one anyway because I can't run it.

[1] https://public-inbox.org/git/%3Ca74cf309-fb16-2f45-8189-d1d0c655dea4@kd=
bg.org%3E/

> * Assuming this is not an independent bug fix:
>   Why do we need this patch in this series here?
>   (I thought this is about worktrees, not submodules.
>   So does this fix a potential bug that will be exposed
>   later in this series, but was harmless up to now?)

The series could probably be split in two. The first part is about
using the new refs_* API in revision.c. This helps clean up refs API a
bit, all *_submodule() functions will be one. Not strictly needed to
be part of this, it's just a continuation of my previous series that
introduces *_refs. Since submodule code is touched, this is found.

The second part is actually fixing the prune bug.

Should I split the series in two? I think I separated two parts in the
past (maybe I misremember) at least in the description...
--=20
Duy

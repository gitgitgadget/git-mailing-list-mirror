Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5596BC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 08:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE7664EAE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 08:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCKIHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 03:07:02 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:40940 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhCKIGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 03:06:43 -0500
Received: by mail-ej1-f44.google.com with SMTP id ci14so44154845ejc.7
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 00:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImDyZ2SQIsTecHInX5JT6BBxuspWd1HaN3kqBTKxph0=;
        b=G7PJ+ZBtdP7pKWd3fYOvxyBST3aWp/4Eg4vEdWLUHOK9ZazVmpI2dTbNRzDz/cKsob
         JMvPdB6w9E64TOe1y032gTTillwttCHpU0AHNRBinU4qXxInHkexwtM4pRDiXksQBMJj
         pojWMnaWkoie4j7/A8oaOPLajJhsw+tiW4ggsJTDp6ISP2o9PG1VuZRGFRbwYg8oSt6D
         Pwnoljx7Qpx1jzuhxNF8DK5cJktCxdkLZnqqsfXWKTPC9RJ6Am7bOKn/wvD68fvoQ1Hm
         ecn1X3NMgpTcp75ZoyFj6+ET+84gc4il4MgHLcHSBjeoVam4MPNrxIF8zc+KJyXszD0P
         DCQA==
X-Gm-Message-State: AOAM5303xl4R5SAc6d+Mn25d2lMrifT2P7eA1fZe4sNtEuBIZYrgF6Wo
        b09krLqc5B/ulDP9a4Gsli0io6Ve+D1Stn23dIQ=
X-Google-Smtp-Source: ABdhPJzkvJOgU9ymTk69AJFUpSbRHZmopa4tD74K/Eqe3VT6ZJxxkEqll301wxPNBbj2NsFdJkiIRISPrnNsCJmSIE8=
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr1939200ejp.138.1615450002625;
 Thu, 11 Mar 2021 00:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-1-charvi077@gmail.com>
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 Mar 2021 03:06:31 -0500
Message-ID: <CAPig+cREZvoFLNNmZROXOP5EKW36L7SKQMjYJJTsbtMeiK2wNw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6][Outreachy] commit: Implementation of "amend!" commit
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 2:43 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> Changes from v3 :
> (Thanks to Junio C Hamano and Eric Sunshine for the reviews and suggesting the
> improvements required in the previous patches )
>
> * Now `--fixup=reword:` aliases `--fixup=amend: --only`. Added the respective
> test and updated documentation.
> * Modified prepared_amend_commit() in commit.c.
> * Renamed the subject_length() to commit_subject_length() [v3 - 1/6]
> * Modified the --fixup=[amend|reword] documentation
> * Also, updated the commit messages and some other minor cleanup.

Thanks for re-rolling. I left some relatively minor comments on patch
[2/6] and some substantial documentation-related comments on [6/6].
(If you take my suggested documentation rewrites verbatim, you can
have my Signed-off-by: along with them.)

One final request: Please consider using the --range-diff or
--interdiff options or both when preparing your series with
git-format-patch. Doing so can really help reviewers focus on the
changes made from re-roll to re-roll without having to painstakingly
re-read each patch in the series -- even if a patch didn't change --
thus saving time.

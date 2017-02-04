Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADAE1FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 05:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbdBDFJZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 00:09:25 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36114 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbdBDFJY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 00:09:24 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so2889154pfo.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 21:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SJWY+2GwZVAiXizDc9ZaII/gLEtL1jf6vNtL0ht40Fk=;
        b=ey7EBs4zN/dFksnB5Vpj9B4ceXQZ+9F1obYFaprGngMqBma46RGQSELbpD8+GDU9f3
         7ldPUemlhbHXQNWVHCwi6zIEUsClgSxLfGZR+sTsVb2fdukqNGcqor26ALAddws3ey4J
         0agQEnexoqRvWKX09ceoCQa0ihiOY945sOxSfWQYyPJLsvX5EReUexPuIQNDBgLdheNK
         L2vFXkRJdUNgYnfVzr8HCIth/Mp5ebZR/qL6/tPI4FUygRnq+VMccKQpVwN7WnCXyLPS
         14Ht+FQDhOBuQ6dPLLi1NlJfsdLP6bgKeY/iRIgByatKnu2CP2oUe59xEwiNYcSbjMYW
         4YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SJWY+2GwZVAiXizDc9ZaII/gLEtL1jf6vNtL0ht40Fk=;
        b=bMr92tHRYbLfvCW86Nz5MbHd0dYg+rz0IZFennv69aO8SQI8bDLu4WmPsxz9y40SSR
         ynuEcmEOm8OGvEvJn9RJsNrNddJgsYzhJq9ljAspRJQc09CgylQiQU0z7bSD4aj+StS9
         Xk0f01v4/m+hc0zKJiVWuoyoLzGbgrIX1Mnsd2q4omkKcw0UzaZBfVEn+zLtbEy4fAgc
         gTi7LCVUKm4LUv7oWfOW2MqtKzCi7qhpmJ+nf9eQdKIRteKCw6jHnSA/gTniX2Yr1Evr
         YRicMv3SN/S12FTcUJG3MH7MSjiHnkI+rNZEqUiFucmEwbt8uqFqe3zffNNL5/d6/XcE
         DnvA==
X-Gm-Message-State: AIkVDXJtPgmZ9plGv4DZSrMFcWe+Zz97MHfOdjjyGUFvR1rWD1dMOLUCThtpiWgn7wFZsw==
X-Received: by 10.99.149.66 with SMTP id t2mr764492pgn.152.1486184963997;
        Fri, 03 Feb 2017 21:09:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id b67sm70927572pfj.81.2017.02.03.21.09.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 21:09:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] git-parse-remote.sh: Remove op_prep argument
References: <1486146489-8877-1-git-send-email-kannan.siddharth12@gmail.com>
        <CAFZEwPMGTzVuLMSzm8wiNxvia4AV0T79C1ZTfcuO4=Bydz_zQA@mail.gmail.com>
Date:   Fri, 03 Feb 2017 21:09:22 -0800
In-Reply-To: <CAFZEwPMGTzVuLMSzm8wiNxvia4AV0T79C1ZTfcuO4=Bydz_zQA@mail.gmail.com>
        (Pranit Bauva's message of "Sat, 4 Feb 2017 05:34:08 +0530")
Message-ID: <xmqqd1ey8rul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> So if you want a better commit message then you could probably use this,
> "parse-remote: remove reference to unused op_prep
>
> This argument was introduced in the commit 15a147e618 to help in
> writing out the error message but then in commit 045fac5845, the
> reference to op_prep got removed. Thus the argument is no longer
> useful and is removed.
> "

Expand the reference to commits like so:

    15a147e618 ("rebase: use @{upstream} if no upstream specified",
    2011-02-09)

Also pay attention to the subject, in which it is unclear whose
argument "op_prep" is.  Other than that, your rewrite is more
readable than the original.

    The error_on_missing_default_upstream helper function learned to
    take op_prep argument with 15a147e618 ("rebase: use @{upstream}
    if no upstream specified", 2011-02-09), but as of 045fac5845
    ("i18n: git-parse-remote.sh: mark strings for translation",
    2016-04-19), the argument no longer is used.  Remove it.

>> The contrib/examples/git-pull.sh file also has a variable op_prep which is used
>> in one of the messages shown the user. Should I remove this variable as well?
>
> Not really. We have kept the file git-pull.sh just as an example of
> how git-pull was initially implemented. So previously git-pull was a
> shell script which was then ported to C code. After that conversion,
> the shell script was just put as it is in contrib/examples/ as a use
> case of how git-pull should be implemented. 

Yes, with s/should/could/.  I agree with you that we should leave it
as-is.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9600A1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 04:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbeKFNkH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 08:40:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35241 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeKFNkH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 08:40:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so11890177wrv.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 20:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kqQQk67XgwqHCnAtrY6v9KziDUw5p91UE1vXt9RMNSU=;
        b=veV1J1QlHZjsuu5hdpsVR3pD6dk1tPzHDt0cGQkDDIdsIgYra4jNTU5NA5Gwj6fr9e
         qvz0hFme4pyL5Epy3+wPaG5FjZI7EFjVa4kWAGnINj2yy+MAmp05lAvU1pTWsqFJTG7C
         j7UPlgT3HQ3SxEq7s+pmG7vH/RK6SVSGf11EjxDLRxslDz++kYoMotAx5Ihuxutykakl
         NEra6KWNYJc0gfvG35DxQw5qZDLN6HycbInMMWngbBGJiI84WdrcghhcVFm6Zc3Lng6E
         879cw+PCwzNEt7wNf9ON5HBjCoSXJAavxyf5mcCTd5oEFHj2YlVWSfsNL7GvlrSdyQpT
         xwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kqQQk67XgwqHCnAtrY6v9KziDUw5p91UE1vXt9RMNSU=;
        b=S56lZbpdBr6DJzb+Rz+qdCjZpowczWE6MkybcXa1VAQYKNm0Ap5EW4widA7cP4Yp6u
         Q16Ys/9zCUwVHWNyv5j3yQlQOKR3w2hbhOc1ZAg1VzNTb8HOKcgzphTSKaWokCX6P4sy
         B3T3bFdJ+2WMzR2yv0jOhU9SU2b1wnJJyCO2INckAnWkwphyDLuTq4uZ1iicwhLM2Q5f
         mChMIllgfn1TLQ4AIe6ZXU+9ceYN6rqyWr8VUEnk5G/39/EAkuuqVchouDGMF5T/7ogY
         qEGyzHSnC/tbbm2TFfA8x8Kb0YRHDFoHh2OeIH5Q+pRSO6lH2F3Q4ogi7YNfAFrBRION
         y4AQ==
X-Gm-Message-State: AGRZ1gI/mVBAw5r0xyvOPl46KWyYY7smstZ7pq0ahIVYfRhwboQWj5jh
        CYkTt/oCRCG5Qe8kUFNB6PU=
X-Google-Smtp-Source: AJdET5fWvx5tLzEJkONhuNETdL05n2MXQLJwSx7B/aC3K+aHI27d+mNtGEjpHZtvU7C71Y40TrTn9A==
X-Received: by 2002:adf:e808:: with SMTP id o8-v6mr22051653wrm.112.1541477811549;
        Mon, 05 Nov 2018 20:16:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v10-v6sm11537936wrq.4.2018.11.05.20.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 20:16:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
References: <20181105200650.31177-1-avarab@gmail.com>
Date:   Tue, 06 Nov 2018 13:16:49 +0900
In-Reply-To: <20181105200650.31177-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 5 Nov 2018 20:06:50 +0000")
Message-ID: <xmqqva5aet72.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This change doesn't update git-format-patch with a --no-patch
> option. That can be added later similar to how format-patch first
> learned --range-diff, and then --creation-factor in
> 8631bf1cdd ("format-patch: add --creation-factor tweak for
> --range-diff", 2018-07-22). I don't see why anyone would want this for
> format-patch, it pretty much defeats the point of range-diff.

I am OK not to have this option integrated to format-patch from day
one, but I do not think it is a good idea to hint that it should not
be done later.

Does it defeats the point of range-diff to omit the patch part in
the context of the cover letter?  How?

I think the output with this option is a good addition to the cover
letter as an abbreviated form (as opposed to the full range-diff,
whose support was added earlier) that gives an overview.

Calling this --[no-]patch might make it harder to integrate it to
format-patch later, though.  I suspect that people would expect
"format-patch --no-patch ..." to omit both the patch part of the
range-diff output *AND* the patch that should be applied to the
codebase (it of course would defeat the point of format-patch, so
today's format-patch would not pay attention to --no-patch, of
course).  We need to be careful not to break that when it happens.


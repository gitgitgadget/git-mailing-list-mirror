Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62FDA20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 02:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLMCih (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 21:38:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39262 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeLMCig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 21:38:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so406606wra.6
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 18:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tFKzL8gIbVflJIxPnC+gKyLtyNUE3L6JLn0rI9a9siw=;
        b=glvlfbELbzAjtbcyykrLO9GlxMxNxz93XfWBdPpITqAB1cgdMghd7E9rE9ucnuGjUm
         LrLQXxMLIN+C1hFOH5lz2A2LCUcNysOmK+6/WJTzAGMJGdoGmO7e5Tc7WRkJBdb7iMIk
         lM3TWYUIheZdjKowpmP2MqCv7gKFBah1VSrmRNz0hRcB1oxWdnKxb9cyNtW/esc0xYZ5
         t9euBq6dqE0WNWTXgDrNn6Zn7k4ktH5NSassEvXbskGlzCfYUPGLAwn0airAYsiIh1VE
         +5VVupIQFGDIoKsdd5kM0yW0J6uaSowsWwgtAgpkI7cCCTAjIy8OonJqnL8Lrh9p9/Rh
         St+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tFKzL8gIbVflJIxPnC+gKyLtyNUE3L6JLn0rI9a9siw=;
        b=duvKo/UK8sUMfrYbP4H30GZi2bnsNvkFvNPYkeiuUmoF/53S2614oio8kAAj7JVepb
         MJtNS2AEuYqXcNhRSR9Zc8TodvG5nqm1/L2sWFAOcjLdnpiOkWR7SGG6GpfcufDSPZOG
         mM+Ji5Mqg2QBZJVp6jC/di0OvtNMWbSjVbgC71PiXQsxVjI0A0C8VYCAkriv3JVJrSvg
         2BPOZyIWAo22ODE+oW7DiVRW96NoP/L0fSH5xtkrvqqCqiFWlLJQIMukpiE9mw8saJ+c
         91aZnWZ0IxpFljV+V7UKokxZzT9h5nCvhZIFUTLmqaLft5J3X3iVEVoa3utcUaFYve+3
         i6tw==
X-Gm-Message-State: AA+aEWZw1Vt2mJnr6w4Eh/6oLNyveuwc/sRZbzIfDhCOz+TCXIZzU01U
        S9VHS0sBEsvTyAseSyyiYHk=
X-Google-Smtp-Source: AFSGD/Xm5tQ1TwaqXToYq67LompaDaZDLVZRwUKGwovy+3eenhGIfiuscIMeHnGCOycWok7LP5PrrA==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr18592956wrw.323.1544668713898;
        Wed, 12 Dec 2018 18:38:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 202sm1163328wmt.8.2018.12.12.18.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:38:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] .gitattributes: ensure t/oid-info/* has eol=lf
References: <pull.98.git.gitgitgadget@gmail.com>
        <pull.98.v2.git.gitgitgadget@gmail.com>
        <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Dec 2018 11:38:32 +0900
In-Reply-To: <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 12 Dec 2018
        10:14:53 -0800 (PST)")
Message-ID: <xmqqva3ygnh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The new test_oid machinery in the test library requires reading
> some information from t/oid-info/hash-info and t/oid-info/oid.
> The shell logic that reads from these files is sensitive to CRLF
> line endings, causing a problem when the test suite is run on a
> Windows machine that converts LF to CRLF.
>
> Exclude the files in this folder from this conversion.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

It seems that this step is identical to v1, to which SZEDER Gábor
had trouble with (cf. <20181212133945.GV30222@szeder.dev>).  I am
guessing that the review and v2 e-mails have crossed.

FWIW, I personally do not think "is sensitive to CRLF" is too bad,
as my attempt to clarify it does not make it much better, e.g.

	The logic to read from these files in shell uses built-in
	"read" command, which leaves CR at the end of these text
	files when they are checked out with CRLF line endings, at
	least when run with bash shipped with Git for Windows.  This
	results in an unexpected value in the variable these lines
	are read into, leading the tests to fail.

So, I'll keep what I queued when I received v1 for now.

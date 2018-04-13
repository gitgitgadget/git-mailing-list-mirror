Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9026C1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbeDMVDG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:03:06 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:40374 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeDMVDF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:03:05 -0400
Received: by mail-yw0-f174.google.com with SMTP id r145so4693586ywe.7
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IJVT/LpF3uvzR3/qwgkQVzsQ+/HGkN5HZi/+dV7MMaw=;
        b=vP1U+Gi32ohIHtZeMpzNM4QNoKKBn7V/T5weC7SMma2bq7+HlIiG9OrjfE5pk8VYae
         +oTd6JmdThiZc/oOeD6CWmKZamDaUNO2hVtkv0pKjgbBHInxBVjHQctYtmSV8JQy9aVj
         yO8CITJ5Ral9aDmQXsCzh9bJGHb90oGIrflDmvC9p1u7LOW1F+lRBqEDEJnY1thto4U4
         A4aefeR1ygOuMNQNUpEKEgnsJ1m3I5cOkVYg79fNrSdwu8gzLtVweGS7ES4WXko6i+rY
         hN3lgZpSVB0sHbuidwRzNAG4LGW7dnAgRUdUAnBIqS357g8KLTCPsQEYHBDdUP7DOEYT
         o09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IJVT/LpF3uvzR3/qwgkQVzsQ+/HGkN5HZi/+dV7MMaw=;
        b=cHFoUE7F+i/42JlZqCQiDGg5o0Vjc6dpDYE9LJstJYwEQAKI91ZtuUGo5kaf4XG3+8
         pAtk1MFgDeog9JjtaFme8ZRpmSIdsN/99/KvWwUx97zZiK/p0ZxHVCW94lMXSw+MReTs
         MxqHL1eBng50c0rrll4oLei5pPrnKx/n6kWVMjgKdYAsVK/dt/qPJIEqXWgpMY8iylVf
         MlUykDhqMk1TT97/CNA4R+bDKpSioGPh0fPLFmXfra6oV09pul78ZYxFnughpWwek34B
         GUH7C29Q0ssxUqqGIm8a067otfSfYjQfQRQhxwi5lm7jREPE+77F2zKOCosYUvalEKa9
         7fhw==
X-Gm-Message-State: ALQs6tDPqXW6BN9M6aJ+1/PYdsty7k178DSU65yOg/hlLjPRGuZhAmX9
        EZhzsv5Q/fAUujAvlz5sMvCKwPXQ9kvnH/IyDOTda4u9FQg=
X-Google-Smtp-Source: AIpwx494+DnBLK74waXAx7VDvJU4gTKkJlCy+VrujsawmQWGppUzmw/DLs+dhb/K2RZPIX8oLywOfeR9aIkF+HE88mw=
X-Received: by 10.129.232.5 with SMTP id a5mr6069034ywm.421.1523653384468;
 Fri, 13 Apr 2018 14:03:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 13 Apr 2018 14:03:03
 -0700 (PDT)
In-Reply-To: <20180413195607.18091-3-newren@gmail.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com> <20180413195607.18091-1-newren@gmail.com>
 <20180413195607.18091-3-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Apr 2018 14:03:03 -0700
Message-ID: <CAGZ79kaWnyuQXr8bHjrKL2xs+h-DQL8hekGJX8-prW+JY8kwUw@mail.gmail.com>
Subject: Re: [PATCH v9 29.50/30] t6046: testcases checking whether updates can
 be skipped in a merge
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 13, 2018 at 12:56 PM, Elijah Newren <newren@gmail.com> wrote:
> Add several tests checking whether updates can be skipped in a merge.
> Also add several similar testcases for where updates cannot be skipped in
> a merge to make sure that we skip if and only if we should.
>
> In particular:
>
>   * Testcase 1a (particularly 1a-check-L) would have pointed out the
>     problem Linus has been dealing with for year with his merges[1].
>
>   * Testcase 2a (particularly 2a-check-L) would have pointed out the
>     problem with my directory-rename-series before it broke master[2].
>
>   * Testcases 3[ab] (particularly 3a-check-L) provide a simpler testcase
>     than 12b of t6043 making that one easier to understand.
>
>   * There are several complementary testcases to make sure we're not just
>     fixing those particular issues while regressing in the opposite
>     direction.
>
> [1] https://public-inbox.org/git/CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com/
> [2] https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This is
Reviewed-by: Stefan Beller <sbeller@google.com>


> +               test_tick &&
> +               git commit -m "O" &&

minor nit: I think you can omit the test_tick before creating O
for each setup.

Stefan

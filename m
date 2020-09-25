Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9657AC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C572311D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgIYRuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:50:23 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43824 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYRuX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:50:23 -0400
Received: by mail-ej1-f66.google.com with SMTP id o8so4733893ejb.10
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDdWE4aD/LpIlQPt8tieRgJ/RvaXu4zovYN1eTU0hcc=;
        b=tjt59pV35a2ZG/NqvLu097R89zV8+sHqG3heex/InLdGFZpdYnIbv6yT052DWYarTM
         aV+TxZWUfAtNgUEFzpPkF5Uid060OIdCFr4jITVogUJsBNs1f4y/m/RkaWErOw6jQ2HU
         lWmUWRGnxmmhDFCYFNeXInJS2iuxPpbPdNieO1BBVNM/FgRTCDPkxj3kbKcx6P+1cDTE
         8eDfF6ivipGjDd0TpgScva9AZPTMCIJLx0Kl03a4YUy5Nd3f6jfrPY37UVY2R827S/GZ
         Jt9jtyDxJ4Ik8CKPgbCNP/EnpL5fqA/uT9+cL4JT/f7kyhuXkTDUuFUi4HPMki9OIte0
         5UZg==
X-Gm-Message-State: AOAM532aNOP6HWBdB/+3XbpuZK5OMi9tnf5yBZrqia5cQzFMRHF8wvFG
        iVGeBs5rAaZuUorSwkYI/GaUvPtSL40iTJDoqxN0CaMS
X-Google-Smtp-Source: ABdhPJyD7a4+gWvWb91ovBO0JFZqc5WuG3X8E3MSCRqEqXf9z4J3RE3ii6VVish1871HDl031lTnaR2pHs7AQM6z2VU=
X-Received: by 2002:a17:906:552:: with SMTP id k18mr3803638eja.482.1601056220739;
 Fri, 25 Sep 2020 10:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-4-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-4-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 13:50:09 -0400
Message-ID: <CAPig+cQWvn0YXUZRHE2ocH8+FS1aAnhjKiMsQvXXkNQ7LgEmfg@mail.gmail.com>
Subject: Re: [PATCH 03/11] t7001: remove unnecessary blank lines
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> Some tests use a deprecated style in which there are unnecessary
> blank lines after the opening quote of the test body and before the
> closing quote. So we should removed these unnecessary blank lines.

s/So we should removed/Remove/

Otherwise, nice explanatory commit message.

One comment below not related directly to this patch (just something
noticed in the patch conext lines)...

> Signed-off-by: shubham verma <shubhunic@gmail.com>
> ---
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> @@ -182,7 +182,6 @@ test_expect_success "Sergey Vlasov's test case" '
>  test_expect_success 'absolute pathname' '(
>      ...
>  )'
>  test_expect_success 'absolute pathname outside should fail' '(
>      ...
>  )'

It is very uncommon style to hide the subshell as these two tests do:

    test_expect_success 'title' '(
        ...
    )'

Instead, these should be formatted as:

    test_expect_success 'title' '
        (
            ...
        )
    '

Note that the "(" and ")" of the subshell are indented with a TAB, and
then the body of the subshell is indented again with another TAB in
order to comply with current style guidelines.

Fixing these might possibly be done in patch [1/11], however, they are
so unusual and would change indentation of the body lines that they
might deserve a patch of their own to avoid being lost in the noise of
[1/11].

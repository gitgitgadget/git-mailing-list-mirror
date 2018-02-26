Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0161E1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeBZUqR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 15:46:17 -0500
Received: from mail-yb0-f172.google.com ([209.85.213.172]:46852 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbeBZUqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 15:46:13 -0500
Received: by mail-yb0-f172.google.com with SMTP id e142-v6so3602920ybc.13
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 12:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6gGn2RcbqcUaFH8fuAfKhpsS29Z6aa9prdYDhCzu6WQ=;
        b=FLwiqcnnGXnOKg1+46Qy5iLWnpEag5pFpAqwHgUc51yCwTfh82BZkxSBnAfd1G14U0
         r1yFzEos4W3qmjZzp+jY6L7B/UIgQJEJ2PNI9w0mObCokPo/oAZDnitqfQ3STRjjKpX6
         ETPt0gSDt7aexzDZv85OoX35K0zu6BeQOk+CGSzO6RCco0BybXI4rKnfkosxpag+qst5
         1Kf+X0y807Ctf6nyDf8v3yHnCx+pRrUB/ARvDRZJMFsQIRYouU0ev5oA75sl4SCgiK8R
         O8yFuRZRG4RUZT9fI5Dt6v3we0vSwiHs2k5pjsmSBKuj6lUzay3+aNTURbAz5/NqO37c
         YXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6gGn2RcbqcUaFH8fuAfKhpsS29Z6aa9prdYDhCzu6WQ=;
        b=poPyCLo8wb3fsxUzwgp5qBgZuY2uiYyDl9ooOrhIvf131ojQzOZAYBPiAfjCrRJgi4
         XcjmiuCvZHgBAyDkod5oXXLj+smWMttesyh1XTxWOwOVyyu5eeSioin8ptuFEM/bhRCH
         fJNx9reyXVQuFsuWVofSHNJhlo0MSX8BX2VLrSN3niKJtyEdHY4Zbj23Ifj0mHz6SkxZ
         ghiINEbNBIesSh+x4MDOAL5qLmU3kS3Y6wpHdArtDEDnAwpatXd2/Qy6ShzUg865N8Wv
         NA0P7/nNfiNw58/CCYku2twXRz+jwEf05I/LNGgyiKnWVWR0ny4idn26efknIS152eGX
         Dp1w==
X-Gm-Message-State: APf1xPAyoZ0TASx5oCYnRZ+bsecf1K9/FBUsrVgQ0HzWhmbtlM6bvmDC
        lA/et2PZ1zekpgZ3L3kHyxAxb6SuL5Gqm/61swX5dpBn
X-Google-Smtp-Source: AG47ELvvDe8el0axBTYiDVs0LixSVSR27QDmSGNhZi6UX1fPrBpvTLG0v76AGgcp5aJx1kwY8TLoGQ8qZ3F9cPyyONQ=
X-Received: by 2002:a25:6b0e:: with SMTP id g14-v6mr8034924ybc.292.1519677972626;
 Mon, 26 Feb 2018 12:46:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Mon, 26 Feb 2018 12:46:11
 -0800 (PST)
In-Reply-To: <20180226103030.26900-1-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com> <20180226103030.26900-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Feb 2018 12:46:11 -0800
Message-ID: <CAGZ79kbyrOc6zDSC4cirUW4ZLbDtEeOB=JwPrqxyye=wFR197Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Delete ignore_env member in struct repository
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 2:30 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> It turns out I don't need my other series [1] in order to delete this
> field. This series moves getenv() calls from
> repo_set_gitdir()/repo_setup_env() and prepare_alt_odb() back in
> environment.c where they belong in my opinion.
>
> The repo_set_gitdir() now takes $GIT_DIR and optionally all other
> configurable paths. If those paths are NULL, default repo layout will
> be used. With getenv() no longer called inside repo_set_gitdir(),
> ignore_env has no reason to stay. This is in 1/4.
>
> The getenv() in prepare_alt_odb() is also moved back to
> setup_git_env() in 3/4. It demonstrates how we could move other
> getenv() back to if we want.
>
> This series is built on top of Stefan's object-store-part1, v4. I
> could rebase it on 'master' too, but then Junio may need to resolve
> some conflicts.
>

Thanks for working on this,
I found this series a pleasant read, the only issue I saw was Erics upbring=
ing
of multiple getenv calls without strdup()ing the content.

What is the plan from here on?
Should I build further series on top of yours? The next series will
focus on the pack side of things (pack.h, packfile.{c,h})

So maybe we'll have Junio merge down my series (and yours as it
needs one reroll?) and then build on top of that?

Thanks,
Stefan

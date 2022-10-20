Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA1C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJTS4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJTSz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:55:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F9D141399
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:55:55 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w3so206426qtv.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6dr98mo9g6P5vnRu6TVPj2+e93wtbxkZ2pN8Q1G7cZA=;
        b=N+i75HI75/kNh89whJBeH4bcKob8Un5/jBAA0Vk9iX14688DTMTSaDhp1HDTrVkkMA
         LCdl6Ltm2ttbWXqf+UuhzkPZ2sL1v7mxlEpS0XxgRe6T0Gyd0AM+1a8yYt8n2J6sgPaG
         H8jamdZw+/olDr8uW+uupWkYKgUmUJHM9dvhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dr98mo9g6P5vnRu6TVPj2+e93wtbxkZ2pN8Q1G7cZA=;
        b=IrTT2+u9QzP7miWMycEIBaF5E9TzF1JuQWze2WhPj+mb83JODUjjd5WFF+7/FIfql/
         2/qqCp7IvhGkHmlA/z5J/VdjVWdgtiGLPxUA4Bmliu4e7czJUsTYi4lR2zb6D2lIYd78
         xdX++2Jv++mECnIg/KFOQ55KnnrEX0BJCR+ISX3JpM7oLOqrT01sp37BtHIjFk3cqkDN
         R1QDe5H8KyyrjdcpkiufAtA3fmO9deJV4zPI48AtIijXllVEoKz+wX7ViaPx4Y0Hf96g
         BuvGP0h9+OXe9191O7NNm7mFolbMhjG0AxVHKmpmOy9512YpQYqV/bW+8nckj226tOjV
         q5sw==
X-Gm-Message-State: ACrzQf3xofBrfaOsKCXtuzVdUjR5aT1on+fRPtSiRRM1zGDEYDPyoK+n
        r6tacc0Xxzs9oVGywicwCuG7jHDtTZ1nWQ==
X-Google-Smtp-Source: AMsMyM4G3o40TA1QjH+XrC3Y7E9yDGTwYqTKQGNUOHoxuqEadavtitstRjvWePEFnCccOQBq+q4/bw==
X-Received: by 2002:ac8:588b:0:b0:39d:13b5:1b63 with SMTP id t11-20020ac8588b000000b0039d13b51b63mr2787521qta.670.1666292154162;
        Thu, 20 Oct 2022 11:55:54 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a450600b006e8f8ca8287sm7764149qkp.120.2022.10.20.11.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:55:53 -0700 (PDT)
Date:   Thu, 20 Oct 2022 14:55:52 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc:     git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
Message-ID: <20221020185552.la6ewgjre7dlq6xx@meerkat.local>
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
 <20221020124612.xivhb4xk52yvy5nk@meerkat.local>
 <a2b0abfa-3533-b22b-1e8f-5be4c00163ce@cepl.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2b0abfa-3533-b22b-1e8f-5be4c00163ce@cepl.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 07:29:35PM +0200, Matěj Cepl wrote:
> > Linux Kernel supports end-to-end attested patches (including using PGP), but
> > the implementation took a slightly different direction, because there are
> > important downsides to PGP-signed messages when it comes to patch workflows.
> > 
> > See the following project:
> > https://pypi.org/project/patatt/
> 
> Hmm, that's very interesting and it seems that at least somehow sr.ht has to
> work with (https://is.gd/qea0gF), but if I understand it correctly the GPG
> signature is on the email, not on the commit, so git-am(1) (or even b4
> shazam) sees just unsigned commit and when pushed to GitHub/GitLab or any
> other repository which knows about signing git commits, it doesn’t get green
> check-mark, right? Although, the line “you can use PGP keys to sign git
> tags/commits, not just mailed patches” in the README makes me wonder.

No, you are correct, these signatures are not carried into git commits,
because the commit message is almost always modified to insert the
Signed-off-by or other trailers, which invalidates the git commit signature.

The goal of patatt signatures is precisely to attest *patches* and operate
completely independently from in-git signatures.

> Hmm, I should probably ask on the sr.ht list.

In my previous interactions with Drew, he was not really interested in this
work. I know that sr.ht does check DKIM signatures on incoming patches, so it
does have domain-level attestation.

Regards,
Konstantin

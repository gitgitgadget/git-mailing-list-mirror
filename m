Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E392022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdBWRUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:20:07 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:33982 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdBWRUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:20:05 -0500
Received: by mail-ot0-f179.google.com with SMTP id x10so28361015otb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=a7BW807DpV+oUIoZU612BmIlRtoqBfpPTpf2LG6adiM=;
        b=QND24vOZsYJ5eL+Rk3D7IL+ZkrzEeK8SZ7y+E3UchSR9ve/af0glxqWjFXmUpjsnPW
         eNum4+MvYl5LLKU5TqD98WjqI+aRrz2aUTrzPKfPw/RttxCcoR+eyrOIKoF7UO6rrENg
         UQ/JiMiYp3fTKy9J/j3mO1isbNvbUqrP1DRXRl4bagwG2vCTcOq+hVBtBkpW+i/4Qbzp
         /0x9Y0CUrWhRon7ynE9MmXgxOD4BqI2pIFQLNJBciGY1mxKGrOxkvxT2a/A44MT/uFSm
         8K/zEeIJPa4EFIEkEyvlgxjasen7na7Tv6htlpWKj2hoLtJSkR4ogMCd9wKb0Axv2Zuf
         D48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=a7BW807DpV+oUIoZU612BmIlRtoqBfpPTpf2LG6adiM=;
        b=in02cDR7gBDfVLr/61s+lwSK2TgFflCo9k++j1ANGqBfgSBwHDdnoyrMcG+c0Ja2lf
         IxpP3zh/mmGJ2XWv2tYZP7w5AFXakLeBhz5/zgTqtevM+ei8q8EC6i0V2nzCsKnB02SM
         tcskCTQkhazhZEFo+Y3p5kItTjDuRC9VF/EoeTd7rmrpJZCoXf4uUTuJa226CCZAM1Qs
         H38Gs6OBS1tGSkSxYn1nnfVLm8vaaFuUE8uiduZ75OKJuPZfWy335RS3c/W6AM75mgI5
         IQWvhU0dDSH0CqDnGLKQgusdTfudlvof52mMVTz6kK9usw85dd7xxJ8YJgbUDNCoTOzT
         97BA==
X-Gm-Message-State: AMke39ljpwIuV4tLr3FCrzZ7XB5Fm06iOpwEr7r+SkKlb9UW4uHK7yH9RXRZ1vhIRMAPA8h/X/I+KFBqCR9d1Q==
X-Received: by 10.157.41.135 with SMTP id n7mr18823179otb.165.1487870346446;
 Thu, 23 Feb 2017 09:19:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 09:19:06 -0800 (PST)
In-Reply-To: <20170223164306.spg2avxzukkggrpb@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 09:19:06 -0800
X-Google-Sender-Auth: ngDWgnb1sBZA8L8E6wgHkbGXLWo
Message-ID: <CA+55aFxJGDpJXqpcoPnwvzcn_fB-zaggj=w7P2At-TOt4buOqw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 8:43 AM, Joey Hess <id@joeyh.name> wrote:
>
> IIRC someone has been working on parameterizing git's SHA1 assumptions
> so a repository could eventually use a more secure hash. How far has
> that gotten? There are still many "40" constants in git.git HEAD.

I don't think you'd necessarily want to change the size of the hash.
You can use a different hash and just use the same 160 bits from it.

> Since we now have collisions in valid PDF files, collisions in valid git
> commit and tree objects are probably able to be constructed.

I haven't seen the attack yet, but git doesn't actually just hash the
data, it does prepend a type/length field to it. That usually tends to
make collision attacks much harder, because you either have to make
the resulting size the same too, or you have to be able to also edit
the size field in the header.

pdf's don't have that issue, they have a fixed header and you can
fairly arbitrarily add silent data to the middle that just doesn't get
shown.

So pdf's make for a much better attack vector, exactly because they
are a fairly opaque data format. Git has opaque data in some places
(we hide things in commit objects intentionally, for example, but by
definition that opaque data is fairly secondary.

Put another way: I doubt the sky is falling for git as a source
control management tool. Do we want to migrate to another hash? Yes.
Is it "game over" for SHA1 like people want to say? Probably not.

I haven't seen the attack details, but I bet

 (a) the fact that we have a separate size encoding makes it much
harder to do on git objects in the first place

 (b) we can probably easily add some extra sanity checks to the opaque
data we do have, to make it much harder to do the hiding of random
data that these attacks pretty much always depend on.

                Linus

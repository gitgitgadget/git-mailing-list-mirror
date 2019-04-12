Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6AA120248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDLJ0C (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:26:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38760 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfDLJ0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:26:01 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so14438317ita.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3x8G7vr878QLEzb3/hgfVUSwvseN5uCCF2C1CK5aHE0=;
        b=jLmvOxWrFlU2b2IkhLjt5R8ZAgkZrvOJcqwqPFmdDK77t+lUyLjisoh18UGR9Cicl7
         6gDb9k4v5K/lfCJVivBPsjWlzRqg7C7Hg9+L37yDpVX/neU8qW06KimYXwCYSIhOKf0Y
         btmE7Ml3p7AyREu44q8ffK96M0uh+CF47R5nea/YyeYYl0/FfDEdQBkg+XOw8O5H647x
         V67v9qKg41MeTnbfTPAFakev5hnpx8nvSI/XZJIu5yPHlqSAE6z+dXekTaZWvCUoPAij
         EhsC0wu5KC+7OXs8IuXiG++ODbnOUjnfLSbr8q/twCiAV1YWqB7YpG9P1gfIXZrFrx8T
         VF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3x8G7vr878QLEzb3/hgfVUSwvseN5uCCF2C1CK5aHE0=;
        b=eHXcsVEyCBqwRXJXtAdkLYmobxUaicPtvXQUDKOwmqBNM+UVvytc4UZUzZM4rpDQ3x
         m3qc8/8IBpYVwh/5JjzqmuTGr9nJkRiuU3NM1TnjuXMVS3dWKIuaajii+BeQaDxT64Tj
         4HFBerd/VWjpjz7VmZGmyobyrt+Np48nz21ZhPjZyuCSjGiJP2z1eC9ax28LGfIEXdDn
         uN29wvJ4jW0NanCnDZW58rObwsCEt3VJh5WQczZfjjYeYIAuv/h5lnoo5hj3KctNPh6G
         KkQgANi1iYZ24/E64XLNDzCImpZBMfyFQ0cZn8fQQIlb/pYpu1LCBaNVVTJ4g/BBI7wX
         8vAg==
X-Gm-Message-State: APjAAAW21ySlN+6YCH/vBsdqy4wLm4KJ1HPLLY2PF6FoEd45HVpbG4aK
        ce5w416M6ViDtcjgXKjL3tTlfYRbPLLAAZGMkYhOrw==
X-Google-Smtp-Source: APXvYqwE1+KriaDmoiffjoLXGAZT4kwh+bIynC5/hOCHJ2LGqpjvxZogtRFJQyaXPsu1nt/PK7RbNzGqAXuB7F4F8wU=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr11199390itb.107.1555061161033;
 Fri, 12 Apr 2019 02:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
 <robbat2-20190410T062730-540884809Z@orbis-terrarum.net> <20190410111834.GA25638@ash>
 <robbat2-20190412T063235-859985527Z@orbis-terrarum.net>
In-Reply-To: <robbat2-20190412T063235-859985527Z@orbis-terrarum.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 12 Apr 2019 16:25:34 +0700
Message-ID: <CACsJy8DpFYiWJpRULKXEYFLnNU4Xnz5pNn1DHpb0bJnJrTwN3Q@mail.gmail.com>
Subject: Re: regression AGAIN in output of git-pull --rebase
 --recurse-submodules=yes --quiet
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 2:09 PM Robin H. Johnson <robbat2@gentoo.org> wrote:
> > -- 8< --
> (snip patch, please add my DCO signed-off-by)
> Tested-by: Robin H. Johnson <robbat2@gentoo.org>
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> > -- 8< --
> >
> > I'm a bit reluctant to follow up with a proper patch because I can't
> > digest the t5572-submodule-pull.sh tests. And we definitely need to
> > add a test case about --quiet to make sure it won't happen again.
> Find testcase attached. Please submit in a series with your patch

Clever. I was stuck thinking about actually pulling things. But yeah
"echo --quiet" does the job just as well. Making patches (and maybe
trying to fix that pull --rebase --quiet thing as well)
-- 
Duy

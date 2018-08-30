Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB551F404
	for <e@80x24.org>; Thu, 30 Aug 2018 18:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeH3WRH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 18:17:07 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:38629 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeH3WRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 18:17:07 -0400
Received: by mail-qt0-f182.google.com with SMTP id x7-v6so11469820qtk.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 11:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCrIPxZEu+84o2CzC4rVQBDrZYjc+66QTlTRrtQ5gRk=;
        b=oZcF9kHHsFE0+enV61aChCFcR8VTpuGcrxzk0BwwwjCZIUNlsfYIQTdgOT0+k3GfKP
         rY3XjldG+V4tdVw/ihfhQj6+taOzBJ3tu44ZIt3DKApda7cKRWsDELQ9hEb5pfB0KcTv
         ScWPp1QAmXqdBUzInoTuKL48epOAk8Uxqm1utaERkNRGKHkOK7GZWF7WtyRV3gVb6uz0
         poObVCsyXaUV4MWJuFbADJc9ZH83i1r9a4ieRvvkm/2PyejPLcOMVJK+doVIbd4b5DB0
         vYdAUS7BDZxRL63bE90+JwoMs9HKjR73QG171shrF9udg83GSnFgew+slvoIm/3fRkcu
         mL6A==
X-Gm-Message-State: APzg51DVVi8+/7p2uU+kDu4ZmGq0VAs/kK0ngw37e9TkVHE63IYfLUDx
        39aPJ2Hs4k3+u9AU5DvGKZNzS3nPDK1lf0X3voqDRA49
X-Google-Smtp-Source: ANB0VdaftQM3cwEx3rnmC6OMntnT+Wzf1KxF7NEwD5kQRjghmJ/MHaktbb7QRx+GrbX2VrSjok4yhtbdy5s2rdvaXvM=
X-Received: by 2002:a0c:b88f:: with SMTP id y15-v6mr12406897qvf.203.1535652824070;
 Thu, 30 Aug 2018 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk>
In-Reply-To: <0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 14:13:32 -0400
Message-ID: <CAPig+cTnvDfYaDh7JSXXGGA=+DE4WAiuTZEKpxv67u1_OyT-qA@mail.gmail.com>
Subject: Re: feature request: allow commit.email config setting
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 7:26 AM Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> I can set GIT_COMMITTER_EMAIL in the environment, but that is
> rather inconvenient, since that means I have to remember to do that in
> the shell I'm using for that particular project, and I can't use that
> shell for other projects. So it would be really nice if I could set
> commit.email = $private-email in the local .git/config for that
> particular project.

Aside from modifying Git itself to support such a use-case, another
(perhaps more pragmatic) approach would be to use a tool, such as
direnv[1], which automatically sets environment variables for you
depending upon your current working directory, or just use some ad-hoc
shell programming to achieve the same (for instance, [2]).

[1]: https://direnv.net
[2]: https://stackoverflow.com/questions/14462591/set-environmental-variables-in-a-particular-directory

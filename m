Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F3C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357870AbiDCNUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiDCNTz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:19:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD256E54
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:18:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so8285695iod.6
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AccaQqMVKVKijVOsce3DUcv0kft+57pbkAKprKdxyyQ=;
        b=O0DmpPm2aOLtyjgz/V3rlUqxR+VdTJWhf6rB+KByBTxnFgpJolZHIzWWGD5qx3+kEa
         dFk3xM1o3x4Tg0O+CrjRU0xHiiOxC0qpzZP8/ngDVvnbY9dZ7IN0XgQndwpjm39jZpnE
         4dBA1iisjo/U7CTkgz/lKBr674hUOssgokOpIqzGwljicm56heZnf9I6cJL9qg+oBN0v
         5/SM9klHze8DYAX3FfmdusvgZ5eDZrNuRm0ELPBs00qx89yPbS+oJEVQjxL4+S+hoWuK
         gO6sYTIatHVmJpS/uVV1mIioSNxGgazhkRtd5wusmpmVq5bDxMDxH6sCxDZyMt22Fdvk
         /P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AccaQqMVKVKijVOsce3DUcv0kft+57pbkAKprKdxyyQ=;
        b=0Aioa8dAWQKo9v/jjnQXcMRwdRrm3hqPQNhRMdxjskaSonRemYWesTDRM+/Xw98xnD
         4rgHS88qRrVcrLyWLNm1d2lBUN5KAFzGLnLltOny7UpZ8ccPkhJK+QiqbQg61KiL3riz
         GwFVmxRC/U9w9DQpYeoTEmIDGieHIUeXKkHfCizZ1UF0yYtqx45mK+l2S9LGlxAFhGAg
         wJnxMIq58U79DlVRxYghE/s/hL+JqK1IUlZPL70UqmtauIzfhggFIpHiRTOnmFqjdX26
         InHydU7Fcp0G6zbDJ62tLg10i5pUdZ6TbehheO1sDjDVf3BjCpkZ32NcId2Q3RvbhEGH
         wNfQ==
X-Gm-Message-State: AOAM532qw5M/FCHSOAEBxJMSb+0CG+im2BB1GZ+UbbgfZHox53W51/qs
        /5dzfg2N6x/VQnO5fZwec2VlQAyQEsF7/HHEoMXnSFe0kKL45A==
X-Google-Smtp-Source: ABdhPJwhMOFuynt8+JpxRfQV5d1q8ZG4lT2AjzeFV/EneJlLNiHVYdtjvNqG+8Ah26tB04lqp7qUFnrGhahC4K4hRDc=
X-Received: by 2002:a05:6602:2f04:b0:648:cfb5:974a with SMTP id
 q4-20020a0566022f0400b00648cfb5974amr3461882iow.187.1648991881023; Sun, 03
 Apr 2022 06:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com> <21ca0635-8a70-14ff-6dbc-213eeba85750@kdbg.org>
In-Reply-To: <21ca0635-8a70-14ff-6dbc-213eeba85750@kdbg.org>
From:   xing zhi jiang <a97410985new@gmail.com>
Date:   Sun, 3 Apr 2022 21:17:49 +0800
Message-ID: <CAN_FRN+kN=nQWmH-VhV3Cu7PKcLFJ0uvV=mawR5FWJLTX3_8Qw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late reply. I've been busy the last two weeks.

On Mon, 14 Mar 2022 at 05:54, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 12.03.22 um 17:48 schrieb xing zhi jiang:
> > diff --git a/userdiff.c b/userdiff.c
> > index 8578cb0d12..51bfe4021d 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -168,6 +168,38 @@ PATTERNS("java",
> >        "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> >        "|[-+*/<>%&^|=!]="
> >        "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> > +
> > +PATTERNS("javascript",
> > +      /* don't match the expression may contain parenthesis, because it is not a function declaration */
> > +      "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
> > +      /* don't match statement */
> > +      "!;\n"
> > +      /* match normal function */
> > +      "^((export[\t ]+)?(async[\t ]+)?function[\t ]*[\t *]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"
> > +      /* match JavaScript variable declaration with a lambda expression */
> > +      "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
> > +      "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>[\t ]*\\{?)\n"
>
> It would help readability if this second line of this regex were
> indented because it is a continuation of the first line.
>
This will be fixed in the v3 patch.

> > +      /* match exports for anonymous fucntion */
> > +      "^(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
> > +      /* match assign function to LHS */
> > +      "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)\n"
>
> This should be written as
>
>          "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*)?\\(.*)\n"
>
> Notice that the whitespace after the identifier can only appear when
> there is actually an identifier. The point is to reduce the different
> matches permitted by the sub-expression "[\t ]*[\t ]*" when there is no
> identifier in the text.
>
> Can the keyword function ever be followed by a number? I guess not. Then
> [$_[:alpha:]][$_[:alnum:]]* could be reduced to [$_[:alnum:]]+
This will be fixed in the v3 patch.

> > +      /* match normal function in object literal */
> > +      "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*)\n"
> > +      /* don't match the function in class, which has more than one ident level */
> > +      "!^(\t{2,}|[ ]{5,})\n"
> > +      /* match function in class */
> > +      "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",> +    /* word regex */
> > +      /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, DecimalLiteral and its big version */
> > +      "(0[xXoObB])?[0-9a-fA-F][_0-9a-fA-F]*n?"
> > +      /* DecimalLiteral may be float */
> > +      "|(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
>
> Having alternatives that begin with an optional part make the regex
> evaluation comparatively inefficient. In particular, both alternatives
> above match a decimal integer. I suggest to have the first alternative
> only for hex, octal, and binary integers, and the second for all decimal
> numbers including floatingpoint:
>
>          /* hexIntegerLiteral, octalIntegerLiteral, binaryIntegerLiteral, and
> their big versions */
>          "0[xXoObB][_0-9a-fA-F]+n?"
>          /* DecimalLiteral may be float */
>          "|[0-9][_0-9]*(\\.[_0-9]*|n)?([eE][+-]?[_0-9]+)?"
>
> and if floating point literals can begin with a decimal point, then we
> also need
>
>          "|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?"
>
I agree on separate decimal regex from others. And in JavaScript
floating numbers can start with a dot. So need add new regex -
"|\\.[0-9][_0-9]*([eE][+-]?[_0-9]+)?".
This will be fixed in the v3 patch.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976E91F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 08:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeL1ImQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 03:42:16 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37715 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeL1ImQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 03:42:16 -0500
Received: by mail-ed1-f45.google.com with SMTP id h15so16998808edb.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jicygVuCkAtyYe/k3a94eghuL2VEGvmHjAcfkCvINnQ=;
        b=LnNP/CsxMj/SaIg/RtZw7T2AJBMHQTWH9TFvh9/LnwJDrarr5gz5bejfLJzItIjyRe
         m/dsCaVgEOglpdko44rXxkbxouG8+Vw5dO96k6SlT2BvVmwPOuJNy70VXUz/Gg1rOeTq
         P9y6bQ3ZEgKJt2EH/Fmn1gJRmLPw55dKHZdXPK3xKIMZAty4TyfyrdAklOAXdDCK3/FS
         R+IbPYugRYp7bh/jrsiU5inyTtKcWkmBEL4TEGJQbfE0ICDOb4giSXK1i9kKi8dFjPf+
         MeEWBPEJY0p8PUZbR47anLcc4UlbghUUB21t4p1m8MN+FVkvOG1eV7ebobvW5Wr2eu9h
         x3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jicygVuCkAtyYe/k3a94eghuL2VEGvmHjAcfkCvINnQ=;
        b=QIXa9vY4aeAx5BIRzGtNPYcwMUVq1MOLZws9K7y2FEVIQngVfOas+/DmlE9EODAcqu
         34RBtAMscYVyqq8Rf+mjF5zcXsUQgrOBSFQltS3ffiHHZ9SIDecIiSvEZES99Uzh0H10
         47xcnsHjJpQsnPKG+B+q6A4dYOpM776Hp77A1KPaIZ8QJBcBS8Kh0GeFk5ejMEUZM82u
         JjRdwDfoytgD652sxYG/4sxth+i3yu62JCeld31c80RkrEvHTfQ+Y3iYEvYuCbBaXryy
         6g7nb80l3tjoidLvdwzoXttiYsT14Kdb4SrVEmf+GDWNkl0lqTEp8VzbyjEqMGQxG3N4
         BuTg==
X-Gm-Message-State: AA+aEWZkiVZJ1N26w3IalATOqQcCi4TI8T4e+Rdkwwu8DfW9jq5pyrRd
        j9ftfMpEfjx6x9GrId9rac2ujBqAOUo=
X-Google-Smtp-Source: AFSGD/ViuQjfDpGAqwS4VUGHb0c2SaMmU0S6Z5xdkevDQRClIICQw6/JCnBkY6FcPbqonPURW3yaPQ==
X-Received: by 2002:a17:906:51d4:: with SMTP id v20-v6mr18064495ejk.184.1545986534336;
        Fri, 28 Dec 2018 00:42:14 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id w31sm13009540edw.82.2018.12.28.00.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 00:42:13 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     git@vger.kernel.org
Subject: Re: RFE: version-controlled merge rules
References: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
Date:   Fri, 28 Dec 2018 09:42:10 +0100
Message-ID: <87muoqdov1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 27 2018, H. Peter Anvin wrote:

> Right now, merge rules can get selected in .gitattributes, which is
> version-controlled. However, there does not appear to be any way to *define*
> custom merge rules which is version controlled.
>
> There are a lot of different files which can benefit from custom merge rules,
> especially ones that are in some ways cumulative or version/tree-dependent.
> For example, I use this rule to merge version files:
>
> [merge "version"]
>         name = Version file merge driver
>         driver = sort -V -r %O %A %B | head -1 > %A.tmp.1 && mv -f %A.tmp.1 %A
>
> (Incidentally: the need for an explicit temp file here is frustrating. It
> would be better if git could manage the temporary file. Overwriting %A
> directly truncates the file too early.  See other email.)
>
> However, I can't even put this in .gitattributes, because doing so would break
> any user who *doesn't* have the previous rule defined locally. Even worse, if
> this rule needs to change, propagating it to all new users has to be done
> manually... never mind if it needs to vary by branch!
>
> The simplest way to address this would presumably be to let the
> repository/working directory contain a .gitconfig file that can contain rules
> like that.  (Allowing it to be in the repository proper is probably a
> requirement for merges to be handled correctly on bare repositories; I'm not
> sure how .gitattributes is handled for that.)

This would fall under the general umbrella of allowing repos to set
configuration, see
https://public-inbox.org/git/?q=87zi6eakkt.fsf%40evledraar.gmail.com for
some previous discussion.

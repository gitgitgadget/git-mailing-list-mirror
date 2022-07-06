Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C445C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 12:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiGFM23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiGFM22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 08:28:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D822DF5A
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 05:28:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d7-20020a056830004700b0061b8749957fso735953otp.8
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GiQZaigUiohrubqIFtu/MUyKftSg2vXCF9UlY2LhXpc=;
        b=SSCbGp09nRL3+mWjVNLf1/MS8BAA4HzYcZ0LYMH7iJqhNtE5koDwnAGJHtehV/MV1R
         GMPrYzcaOkB0tWLLoITpWRjACD71IAcXmue2ygTZXEu+lomU9hnnvSWOYt44lpYgTOap
         G6vW2WRypvgJNx+EdtoL0t0cC12s+DBUGJ84jbTVqP1kzFsVkyzRw7TnyHOc72+9eaVf
         cAjQEcLdM+jF28/yvOf3PFEjbcbCFNM/XlNPPrIGyEzFUTVqvVRL0AynR4tBUvjpFH4t
         0QNWDjZht7/j573LmMmT4Zs6MarcoEiZ01gnpoEXUg01so3VDdHpzxHwpBe/jGbHvKMx
         oWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GiQZaigUiohrubqIFtu/MUyKftSg2vXCF9UlY2LhXpc=;
        b=yy4YS3+4PBm1CHr4ELNURGxemQkO6TsI2lqAoQEGgSa0gndGCITvP9u8L6f/if5V0L
         0LWVih0ybkpjBgCPl+1a1XW4t9ppD1nmcYEd8cM4RD1He77VWYVckq/c4bJ7wTVohZq8
         PIOvIKAqK2YVzLOnWcyYqSQkvVy+iJndQf3H5ifyk0hT8IdORwrQdmovxNC4ZpZy1VIT
         ZcpLzgobYD/BYrREc4qjhAWJLYBZiT8IwhkKxJ0AWJXRddunIxX3xTPV5vkJJo259ydh
         /zvvKh61QPgDG1NQK5P8EiwGvH+SOUZDRo5O6eegWfqMPN29/Npk+yRg9MdlUFMXlALI
         fqRA==
X-Gm-Message-State: AJIora/2hnELsWE7zl992eChheDkyQbMG9XbQMMX8vDGQAd32BYMF4kg
        mYne+OnUTEFY7TEjt1SAA9/cRyG4XqJ3trbHaoyOWK4lnm4=
X-Google-Smtp-Source: AGRyM1s57+WK2aDGr5oIwaBLXzdYqzcQVwYgqsewY/WsPZ3NUItj+uuMiOmDVypdb5GxUx/GVjhYXB6Vk6/6QbbM/jQ=
X-Received: by 2002:a05:6830:3106:b0:618:8052:e8b2 with SMTP id
 b6-20020a056830310600b006188052e8b2mr15395676ots.76.1657110506546; Wed, 06
 Jul 2022 05:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X_a+z-=K5BfDpMiWAnnVma6ihh6kUXb84CCrHL5gte5WykMw@mail.gmail.com>
 <220706.867d4qa9b3.gmgdl@evledraar.gmail.com>
In-Reply-To: <220706.867d4qa9b3.gmgdl@evledraar.gmail.com>
From:   Sim Tov <smntov@gmail.com>
Date:   Wed, 6 Jul 2022 15:28:13 +0300
Message-ID: <CA+X_a+xu3WqJH-SRh2e733Z4izARRqjWjoVEaby=0iQ+T1rfGg@mail.gmail.com>
Subject: Re: "mixed" or "merged" submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much! Simple and elegant! A solution that is actually
better than the hypothetical mixed submodules... no overhead on
maintaining several repos...

On Wed, Jul 6, 2022 at 12:18 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Jul 05 2022, Sim Tov wrote:
>
> > Hello,
> >
> > here  https://stackoverflow.com/q/72770397/1876484
> >
> > I asked this question:
> >
> > I'm aware of git submodules which dwell each in its own separate direct=
ory.
> >
> > 1. But is there such thing as "mixed" submodules whose content is
> > "merged" together?
> >
> > For instance:
> >
> > - Submodule1 (path ./), consist of files `a.txt`, `b.txt` and
> > directory `C` with the file `1.txt`
> > - Submodule2 (path ./), consist of files `x.txt`, `y.txt` and
> > directory `C` with the file `2.txt`
> > - Resulting "mixed" repo of both submodules: files `a.txt`, `b.txt`,
> > `x.txt`, `y.txt` and directory `C` with the files `1.txt`, `2.txt`
> >
> > 2. If it is not implemented in git - is there a workaround to achieve t=
his?
> >
> > Here my use case:
> >
> > Both submodules - independent libraries (collection of books as plain
> > text files), which have same structure (directories =3D book
> > categories). I want to present the combined parent git repository as
> > full collection of books, while both projects evolve independently and
> > do not overlap (in terms of file names =3D books).
> >
> > I got a very detailed and informative answer. My question now - do you
> > see any other practical use cases for such a feature? Would such a
> > more general case of submodules be a good feature in git or not?
>
> Good question, but to answer the thought experiment don't conflate
> submodules with this, instead suppose that you have two branches A & B,
> which have:
>
>     A: A.txt
>     B: B.txt
>
> How will you create and maintain a third branch C which has the union of
> the two?
>
> The answer to that question will be the same as with the submodule case,
> i.e. you'd need to have some third branch that you maintain (e.g. with a
> push hook?) that would be a merge of the two, and ensure that you don't
> have path conflicts there.
>
> Then if you wanted to use such a branch as a submodule you'd grab that
> down like you would any other branch.
>

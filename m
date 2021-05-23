Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD86AC47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 10:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1FD610A2
	for <git@archiver.kernel.org>; Sun, 23 May 2021 10:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhEWKzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhEWKzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 06:55:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF69C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 03:53:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l15so17169298iln.8
        for <git@vger.kernel.org>; Sun, 23 May 2021 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BBvwZqH7qF57GxVXNZ2HdoollhmwPKjsTE8xJUrl10Q=;
        b=NGDyZea6ttuz53yIB1fgF2b1dusZClAqeqZX57swlgjPei8fn9E48oKLglSL5fHPIT
         J7kKagPO+alXezuR2KIYV2CvYd6IDY72GuOCI5CSszzK93pmU2Ar6XuMH9QYlm7dwPpV
         4oDz34mkrBoxGKnaUUIHmWmN93PAcuUvhXwF3eCRZQk89RV1ZtXrsm50AhrIaq41HDq+
         HQd47iIRgvZhBmE5KQh/7KPqBzm4EGPH+fiEnQDQfuTSel4YmgylewkIciHMHj5tW/Py
         RyYkyCDn1/LhXEfv2O91JXKThMWwZHDAfXui1oAxKMrgt71k04PkCmhgeMXuSA77HVS/
         DCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BBvwZqH7qF57GxVXNZ2HdoollhmwPKjsTE8xJUrl10Q=;
        b=MvEqyJL2HHF1IlLbasAtt8bUgsL9h2Ef0TcH8zsaj7SejrHor6fIA14iRfsNZJ3NVj
         ItMPD5l6bNORpTbu3CaBsyq57I5RXjwW5QLtHDfYXvd5fkTTzimwl1wMwjygslNs2WtB
         H3UVjaGOckLt/VD4TeJkl1abmPseo4t6LEJgt8Hk7ZrVg2C6PAzzSlAtEvnuGwjLq+w3
         Um2KDF91Uet/vGzzaU+1S9Xv2bZRj7x+qlFLX6SnpXKGzQgoO9PGeM4ipmtBiH8rDtv+
         F3GQDUzHZ9QIbHusVrcsUWVBf4vyH0d/IkrHtG2AfwJoeSZTEqRFoIjTonmGqjgw7sSE
         uEcg==
X-Gm-Message-State: AOAM531noGKlwVTu0nEQ4GxqMggvC0W5D1mx3l/P1wInCLbKaP4Iv3wz
        MoXEB0oMoSmVrZ35yiAyALfwcOvUVvQY9Ta4Iqm78sDo97C0Bg==
X-Google-Smtp-Source: ABdhPJy8dPa8mrpyt3S7Ra19fEigO0PesjnY8nuBp+T459w+t7LHcaCa+MBvtIVSLQ6eK9Njwc4rwVbVvb4so7+f+ec=
X-Received: by 2002:a92:2004:: with SMTP id j4mr10193039ile.53.1621767214107;
 Sun, 23 May 2021 03:53:34 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 23 May 2021 18:53:18 +0800
Message-ID: <CAOLTT8Tu1Xvc6sJ79n6f9B6TiuKp3akTQcQcuzEe7sG-kVOXAA@mail.gmail.com>
Subject: [GSoC] Git Blog 1
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My first week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-1/

-----

## Week1: Git Adventure Begin

Use Git to submit Git patches to the Git community.
Does it sound magical? I fell very lucky to be selected
by the Git community this year and start my Git Adventure
in GSoC.

I am no stranger to Git usage, and before the start of GSoC,
I have learned some Git source code content, but I only saw
the tip of the iceberg of Git source code, there are still many
things that I need to explore.

### What happened this week
- In [[GSoC] Hello
Git](https://lore.kernel.org/git/CAOLTT8SHE-ok3D+oLNSWFi7KPU=3D=3DVQnTMDmC4=
YxUyNBJKmBD8A@mail.gmail.com/),
Christian and JiangXin interacted with me.
- I checked Olga's patch at Christian's prompt and learned a way
to make `cat-file --batch` use `ref-filter` logic: Use `format_ref_array_it=
em()`
in `batch_object_write()`, this is indeed a good entry point. But
before implementing this function, we must make `ref-filter`
support the function of printing the original data of the object
(as `cat-file --batch` does). I decided to reuse the atom
`%(content:raw)` in ref-filter to implement this function.

### The difficulties I met
In [[PATCH] [GSOC] ref-filter: add contents:raw
atom](https://lore.kernel.org/git/pull.958.git.1621500593126.gitgitgadget@g=
mail.com/),
I submitted a patch, which support atom `%(content:raw)`
for `ref-filter`.

Unfortunately, this patch has a big problem:
I ignored the breakage on the test. This led me to
discover a bigger problem:

If our references points to a blob or a tree, and  these objects may
be binary files, this means that we cannot use functions related
to `strcmp()`,`strlen()` or `strbuf_addstr()`. The possible '\0' will
cause the output to be truncated. We have to think of a way to make
`ref-filter` can accept the output of these binary content.

So I searched for all the codes in `ref-filter.c` that buffer might be
truncated by '\0' and use the appropriate method to replace them.

Just like replacing `strcmp()` with `memcmp()`, We can use `strbuf_add()`
instead of `strbuf_addstr()`,
At the same time I also wrote the equivalent `*._quote_buf_with_size()`
to replace `*._quote_buf()`.

I just submit it to the mailing list right now:
[[GSOC][RFC] ref-filter: add contents:raw atom]
(https://lore.kernel.org/git/pull.959.git.1621763612.gitgitgadget@gmail.com=
/)

I don=E2=80=99t know if this is the right approach at the moment, let
us slowly wait for the suggestions of mentors and reviewers... ;-)

Thanks!
--
ZheNing Hu

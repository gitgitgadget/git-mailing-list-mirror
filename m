Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2371F462
	for <e@80x24.org>; Wed, 19 Jun 2019 13:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSNY2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 09:24:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37394 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfFSNY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 09:24:28 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so38164957iok.4
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JXZ99MkcvvoeCjNfj7eqtqc+Xky/29qmWB0gMjQfmV8=;
        b=riQSDqRDOqIdgoJMt7J9WYHwg60sralWxuTkwduRcCQ1ACEiClIZii0MJUC1W313Ii
         +yMr/j14qZyNeUDgsb7aq+JtH7miDXZEIUGaCqwySyFtm+5+SOV+pHgs5nyyUOhVWJMY
         NS/bt/pUCXsIspMital7nBleSAkBOeGcDowa9lz5LuWKE5bRQqUpfO+wG0hgS5szeZco
         f+SL+09QmtwfL8mC7kwVZawgL1IflOAeCo1atvfSfJrpFsTfncrHSqnWTRK2oNdjeofd
         pH0FNhlb2eqDyihsOwIWpGNjg2wvzJ1xFdHM01oofQ5hggheN51afcX2wYItFeHAPm6w
         CRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JXZ99MkcvvoeCjNfj7eqtqc+Xky/29qmWB0gMjQfmV8=;
        b=JUToBQBNN7VEmOvqjvEhZJrLyYLRHe2yvFMe3pMFjt489eWs8YmqcVq46xZBX5T17T
         ylauIqhK8dEWeUDZiW4XrJkqEJ6NU2bZTfe+DqJOXPa8W3Sz44Qt9m/nqQMLJ5qNsx1j
         1d1dvGStc9aeWpXIeuzUHcYuizrkUAcGgjD/e2pJQXLZMZt/IkJk3afDNDKPHG9fpW6A
         Yj0n/VFMGC+bJGvZqfGpWOr4nY0TaC1no84Bd6T+2XtMEA17W8taYZ4ciNGPvunIZam/
         dLG8Tl8Mq+YFfGPH0aCesg+EsM+0AVaywI8sGRPLBMRpPbSXSqQQxBoiOtPqGQls52Lp
         NpuQ==
X-Gm-Message-State: APjAAAWMQOlOrd+uylACUzlPsZ4BaBhiwVlUCFzg440AiI4KcbowOMg3
        bBrDW5ZvL9TEUqImvuYgQU3kh3vzpiixk94Xmok=
X-Google-Smtp-Source: APXvYqzqzFoxZyPuqEBKvF0DyBxVhFgkpnMsrOlKDTk4wmwkTd/1x2HaH5hSCYzu1kKqQd71HRWg0cTBDHppNTxLq/8=
X-Received: by 2002:a5d:8347:: with SMTP id q7mr28136612ior.277.1560950667526;
 Wed, 19 Jun 2019 06:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619095858.30124-7-pclouds@gmail.com>
 <8a56ac88-f3b9-c80d-441e-8e74eb64921d@gmail.com>
In-Reply-To: <8a56ac88-f3b9-c80d-441e-8e74eb64921d@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 19 Jun 2019 20:24:01 +0700
Message-ID: <CACsJy8A1Zkkf-QxZSioD61UUj05Xap=f5NJLhOzabVc=dLz25A@mail.gmail.com>
Subject: Re: [PATCH 6/8] read-cache.c: dump "IEOT" extension as json
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 8:18 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/19/2019 5:58 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:> @=
@ -2266,7 +2271,7 @@ int do_read_index(struct index_state *istate, const ch=
ar *path, int must_exist)
> >        * to multi-thread the reading of the cache entries.
> >        */
> >       if (extension_offset && nr_threads > 1)
> > -             ieot =3D read_ieot_extension(mmap, mmap_size, extension_o=
ffset);
> > +             ieot =3D read_ieot_extension(mmap, mmap_size, extension_o=
ffset, NULL);
>
> I tried applying this series on top of v2.22.0 and ran into an issue
> on this patch, and the message seemed to imply the problem was at this
> block. I couldn't figure out what was wrong, but maybe the series is
> based on a different commit?

it's on 'master', a6a95cd1b4 (The second batch, 2019-06-17). There are
a couple patches since v2.22.0 that touch read-cache.c, but they don't
touch these lines explictly...
--=20
Duy

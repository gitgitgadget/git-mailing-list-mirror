Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA131F516
	for <e@80x24.org>; Sun, 24 Jun 2018 14:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeFXOm4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 10:42:56 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45320 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeFXOm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 10:42:56 -0400
Received: by mail-wr0-f179.google.com with SMTP id s7-v6so1830713wro.12
        for <git@vger.kernel.org>; Sun, 24 Jun 2018 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2XJjlrDF2vVhG/4BmIBCEsFN0V9DKkT1mVN5zD3TM4E=;
        b=NzSd5LuPi+/ZkobDq9tbc3Z4jH/lHmPlVSup2SqAlKGLV2E6lfk8lo2R5UQ9sqyjYh
         y0+EyltXuo+OHPHM8USxxDnuUeSywkzV0+m7fOwoU1WRTEDHcDXzsygohbGjQVJtcN15
         gf/qIdnf/79cpSYnJTdbSTU4c3AbHGpvEOW+ebXXMu/TBictckpoWMzn4bZ5jg8jfoVa
         9WYsM3Lb+piWaGB+n2nDcNGws3a2YFlqN/cXLaP89kJCn8ZFD0EJwP3pGn9dicrlTSBl
         oqHbRv5Y9fqLmudr9x6hfnbNI5j1l8/84J3U7Aefl9doa/PgzxUcBPii6PXtRGiPVlDB
         VFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2XJjlrDF2vVhG/4BmIBCEsFN0V9DKkT1mVN5zD3TM4E=;
        b=Dv+8/isKT1o93cVV3hxCtZhc6uM3UVP9mPFgrVxJaSob1q4xl8VIQAMFx9UspAQJYw
         vz7E89vvUcr3pTmn4wSJYdjhv2+U0FuXxXiwsZtMKva6o5XgzATR573kQ5GZI5is9HNo
         yZ4wSjR6rns5fqrTag7QMGKjYvvzM797jOErfCjGiM0T5BQug5ZshVHE/ytZcIYy/k9W
         FhLwyHTapNvbuzJzYJ/dZymVqB+XWoHJM8VcrNLZm6IHJVz3d97657e8hoQQywMJNSiI
         yT7YkNcIQwTI15Z9gg8WNdHKGquUcxsGGx67OcRqXSDNj+fYwl+LFY9Y1DTYgh68ixQM
         YCDw==
X-Gm-Message-State: APt69E3+BH8MVosDPyy896EbfMmfVHCrtFN8vI9jSo3WKAvrB54P0YOq
        +ZWSCpKN2dMdwHdxSOv0IoR4ZwjOhM9Dl1t1oW4=
X-Google-Smtp-Source: AAOMgpexWldJZyaC6Hqg+AJNTO2q9mh9hiVJCj6rcANVbV4x/54EzD9Y2wL2wkAjR3x9GF8bGTQiLSaOyQ0euhAZT1A=
X-Received: by 2002:adf:ba8f:: with SMTP id p15-v6mr7827152wrg.139.1529851374839;
 Sun, 24 Jun 2018 07:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAL78Jw0mQWxO4xkzFBoG0Oe4wjomUGj=dP5ufdUrE5Ku0GGEtg@mail.gmail.com>
 <6d5d2536-0f69-544d-23c7-351e8618ba94@gmail.com>
In-Reply-To: <6d5d2536-0f69-544d-23c7-351e8618ba94@gmail.com>
From:   Daniel Penkin <dpenkin@gmail.com>
Date:   Mon, 25 Jun 2018 00:42:43 +1000
Message-ID: <CAL78Jw2v9sRznn0dfX+KMAT5TvsDCJ529-d1SahAKo0rmkfrxg@mail.gmail.com>
Subject: Re: Incorrect unified diff when run with "--find-copies-harder"
To:     rybak.a.v@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrei,

Thanks for the prompt reply.

I'm sorry for the false alarm, I should've investigated this more
thoroughly before submitting a bug.
Now I see I get that context hint in many diffs, I was confused by
many simple file diffs I was working with recently which didn't have
it.

Thank you for your time and help.

Kind regards,
Daniil Penkin

=D0=B2=D1=81, 24 =D0=B8=D1=8E=D0=BD. 2018 =D0=B3. =D0=B2 23:33, Andrei Ryba=
k <rybak.a.v@gmail.com>:
>
> On 2018-06-24 12:36, Daniel Penkin wrote:
> > Hello,
> >
>
> Hi,
>
> > I believe I found a bug in how Git represents a diff when invoked with
> > "--find-copies-harder" parameter.
> > Specifically, the unified diff header of a hunk contains an extra
> > piece of text which appears to be a line from the context (i.e.
> > unchanged line), something like this:
> >
> >     > git diff --find-copies-harder d00ca3f 20fb313
> >     diff --git a/test.txt b/copy.txt
> >     similarity index 81%
> >     copy from test.txt
> >     copy to copy.txt
> >     index 734156d..43a3f9d 100644
> >     --- a/test.txt
> >     +++ b/copy.txt
> >     @@ -2,6 +2,7 @@ line 1
> >      line 2
> >      line 3
> >      line 4
> >     +added line
> >      line 5
> >      line 6
> >      line 7
> >
> > Note "line 1" after the standard unified diff header.
> >
>
> This text after @@ is usually a function name in a programming language o=
r
> some other relevant part of hunk context, to help user navigate the diff =
more
> easily.  What you are getting is the default version of it, as it is just
> comparing txt files.  You can read more about it in the documentation of
> gitattributes:
>
> https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_header
>
> > I prepared a sample repository with a minimal file I can reproduce
> > this problem with:
> > https://bitbucket.org/dpenkin/find-copies-harder-bug
> >
> > I'm running Git 2.18.0 on a macOS, but I also tried with Git 2.15.0
> > and 2.8.6 running on Alpine Linux and was able to reproduce the same
> > problem.
> >
> > Please advise whether this is expected output or is indeed a bug.
> >
>
> This is expected output.
>
> > Thank you.
> >
> > Kind regards,
> > Daniil Penkin
> >
>
> --
> Best regards, Andrei R.

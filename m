Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC97211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 07:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLCHlM (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 02:41:12 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:42119 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeLCHlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 02:41:12 -0500
Received: by mail-lj1-f181.google.com with SMTP id l15-v6so10384070lja.9
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 23:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6hjqB2v3/vfTMtzDGZ/YeoV78QCNT1pcYlkxSR00K8=;
        b=nzg+WN+c5cx6R4GCJCoGNJaP5XwanVZDzBaTvXZQLPwM2io0fsq+cSF72GZJhvwG2d
         e3Q2zbRlfGuZdl/QeHfDzk+kQxTAoShLNEYLBuhLwAvXkatW+tcsiN3LIGcMiJPvSbD0
         V8Iowwv0+rcY4dnnhROZ/t0T+Qhvfo8MpONrd2wNfUdxjBEcTs5zxATvJEHI0QNI9xZr
         JctbDKaDPM18lGmN7LzIed7CoGtjkmVJVAFoVaEg4q0YFYgsFWe6kjfU5I0sIHUDrTrk
         9TC4yY50RJRGkyZDoz5Dd7127iyn2AbNTYA6BrUTbf/iIpjGpNh7N90EdbFQ/O2VnrGL
         bmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6hjqB2v3/vfTMtzDGZ/YeoV78QCNT1pcYlkxSR00K8=;
        b=iNOe1WlAFE6HFRpafya9tSQuIbxQdlsPviH/IoENOJeANZ4boDeVai0Z2AJYONwb9L
         r1OBIYRO05Xk7dL6m8ywwjTha9ffELimP0nC+tTzFxP3eq07p6qCTBhZJQVS6qBYUNkS
         RxXdqKsxlwyT8CCVBASHGvEbu6LVRblLMNquqzeQISu9PUi2A0HCdEbinrTrGhs+ytDR
         9ky62qfSi+ZQMzVmN5Ol24kE1wagJnCCNQopuWx+xKKioMP9UlVyruyyIZXWdbDDSYoW
         Q0jIyvuvGpb7ugjvL65rH8lUHEkWRQSPHFPZkiphMda7wyKIbd2WQlnNZ/U3eUBWQ8s+
         06VQ==
X-Gm-Message-State: AA+aEWYdMF2e4IwfFuzv16Ys6tzBHxOqsKYXr2OHqdaGQKatNYjiB71a
        NEvxMzI680+1kFir4FYQw/VCYoCv0NINmcYvpR4=
X-Google-Smtp-Source: AFSGD/WX2ylsZDHuFgkThkEKW/VHHu1yL1/NrlWRZ9UrcDzUS19YPPGvkWoPx8IADtyUc6XQrjHjnScLVVlqun6v/Jc=
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr10173806ljj.6.1543822867666;
 Sun, 02 Dec 2018 23:41:07 -0800 (PST)
MIME-Version: 1.0
References: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
 <87woosukkm.fsf@evledraar.gmail.com> <004101d48a65$afb0da40$0f128ec0$@nexbridge.com>
 <xmqqk1kriuu8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1kriuu8.fsf@gitster-ct.c.googlers.com>
From:   Cameron Boehmer <cameron.boehmer@gmail.com>
Date:   Sun, 2 Dec 2018 23:40:56 -0800
Message-ID: <CAM+q9MfiycW6kXRLHsseKp+n1k9goALjRY-ePke2vYDhqcpD=g@mail.gmail.com>
Subject: Re: [RFC] git clean --local
To:     gitster@pobox.com
Cc:     rsbecker@nexbridge.com, avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Would something like git clean --exclude=file-pattern work as a
> > compromise notion? Files matching the pattern would not be cleaned
> > regardless of .gitignore or their potential preciousness status
> > long-term. Multiple repetitions of the --exclude option might be
> > supportable. I could see that being somewhat useful in scripting.
>
> I think "git clean" already takes "-e", but I am not sure if it is
> meant to do what you wrote above.

It does already take --exclude=file-pattern, which is like adding
lines to .gitignore. (W/o -x/-X, that would mean DON'T clean them, but
with -x/-X, it means DO clean them.)

>
> If "git clean" takes a pathspec, perhaps you can give a negative
> pathspec to exclude whatever you do not want to get cleaned,
> something like
>
>         git clean '*.o' ':!precious.o'
>

I like this, but I'm also 100% satisfied with Junio's previous suggestion:
    git -c core.excludesFile=/dev/null clean ...

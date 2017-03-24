Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E219E1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 12:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdCXMnI (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 08:43:08 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38318 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935162AbdCXMnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 08:43:06 -0400
Received: by mail-wm0-f45.google.com with SMTP id t189so1222677wmt.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D1D7f0DXcLYw2C2o9gZm89lKxOklh/d7h0jGUJnaaLQ=;
        b=Sg+k099XrOXFTI3nMba4/J61cAnLeQa323xCr255wctR2r1FaTQI6tf6byZSxDlmYv
         lIadlSRLkTJkE4tIcFaJxP6Ae+AfljAQftU9XayBZiDXqiJDgZa3cJPkekqxLbx31ZCH
         dPLkMJoxj9pz/Wmrq1RaY9a/Chvg+/u85AW2gQ18CmW4N3K0zacQEHsANAlj8j6x65lJ
         MDMnfJfA5IRSFmDOGV1zsQ1UFdEiroof48MF/uu+aRt97O1+q7j4Pu9/upTqmLELxHJm
         7FhxAVR4ASTRIlTZsv2Ny8c3lr4l4y1tgpze36QYUjeMHKguc0PiwuJbsug0Md08e5AJ
         Fxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D1D7f0DXcLYw2C2o9gZm89lKxOklh/d7h0jGUJnaaLQ=;
        b=psP+c/BgmguUMrDlDt7Yi9GEiMsD6fEiKXz3bp/gsl/0dW5Tvm1UCvgIQkbpCHUPK8
         vUKJq/j5OEuEmBs9X+5Qher1x0W9fn1/0YgRokJO+1LuV1fV5vUBSfOqnusapwgN2jfJ
         Ts1vRdqadl7xlbCRyivWegKdB8jupuxFDS0V0WQDsAY70UwmZ9evsNN27gGhpEQP8cWm
         H1NYf5pvG3+JvCDtZeRIm5XtRUV7XKNaBGRRr0sRCWajWBQS2eD2vKlmbVYUT353UVTI
         ChzQRGerCeuPpzrQyw9DDuUm00c3cjkTiliukie1hEpMsMt0mWxwzvQiI6XqsXbVs8Qo
         A4mQ==
X-Gm-Message-State: AFeK/H2G6uzbglprrXpc4x8SxxgYlTnz2yjoblHHIDD+sABhvp4BkePGemEYA99Vv5bL/jL0afho3baLEIwkRg==
X-Received: by 10.28.147.129 with SMTP id v123mr2927087wmd.51.1490359384232;
 Fri, 24 Mar 2017 05:43:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.153.150 with HTTP; Fri, 24 Mar 2017 05:43:03 -0700 (PDT)
In-Reply-To: <CD7E9F8C-77CA-44D4-AEC8-CEACD0528E3A@gmail.com>
References: <20170324113747.44991-1-larsxschneider@gmail.com>
 <alpine.DEB.2.20.1703241242210.17768@tvnag.unkk.fr> <CD7E9F8C-77CA-44D4-AEC8-CEACD0528E3A@gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Fri, 24 Mar 2017 13:43:03 +0100
Message-ID: <CAHGBnuPdve_5Xrmde6cjbXBjSWfZLrT5eT90hayG0jfbBTkq6Q@mail.gmail.com>
Subject: Re: [PATCH v2] travis-ci: build and test Git on Windows
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Daniel Stenberg <daniel@haxx.se>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 1:35 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:

>> 1. use appveyor.com, as that is a Travis-like service for Windows. We do our
>>   windows-builds in the curl project using that.
>
> The Git for Windows build and tests are *really* resources intensive and they
> take a lot of setup time. AFAIK we would run into timeouts with AppVeyor.
> Maybe Sebastian or Dscho know details?

At lot of setup time, in terms of installing the Git for Windows SDK,
could probably be saved by only installing the required packages on
top of MSYS2 that's already installed in AppVeyor nodes [1].

[1] https://www.appveyor.com/docs/build-environment/#mingw-msys-cygwin

-- 
Sebastian Schuberth

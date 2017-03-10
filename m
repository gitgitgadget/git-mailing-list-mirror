Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DFBA202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 06:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbdCJGIQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 01:08:16 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33170 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdCJGIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 01:08:16 -0500
Received: by mail-qk0-f171.google.com with SMTP id y76so153943577qkb.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 22:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EX3Et6VRusd2ysJIjkfdkGk2mbvAh0WHjoZem//TkY4=;
        b=WZ51s6nG38l2hiOxG+gIh6PA+A6/AoQ3u0DIxyLmwmnyhPXVC1gwEGxdFHkZ5tIyPU
         +eTdAvxqBJRe+vyAdG/dH18AGjcWUOmRCQ4oOANLmB/pr/+1JMDryM/YAkH9zy7q4/8r
         N161nbwTGcf/Ndpdc3PShQ6U723iiGVBIelqKrPHklVWQZNebVCXYKi2hICL9nBheAVI
         AS97nnKpCuwbJzEeHlvr9uwtqO54QZ94fRgq5BVNA6/gyjRQDZu9yuvC/A4516EefAte
         2FQgc840n4SXlne79jMumI7knVWT8deqSj2i4OVTKhY5dzqQ2noiIuPXys5UG6teVm/u
         IuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EX3Et6VRusd2ysJIjkfdkGk2mbvAh0WHjoZem//TkY4=;
        b=iW88AuAPTtuJcjwTJc5G+NJcdJSXEPRq/OiyIZcnBk9KZwyxhpnDhK9UaFbFTJcF1T
         nKNIkj16bypgneQBVvPBsEUxzl3kBr+NaF8vL5Yx8u9XD3AgYsqKhTzFKc2ewUiV+lIN
         v7fRUDN3ijimfH6xbI9E0XYYEwgA7iw/X42JKyKUhhS/wuF0XllmvRYemv5QpYYW7z9X
         PNuWh1+7MwS2xcxuke5u4AHXFxrpi1pKuPIrDFHGaLaiFpSJODhyC3zoljDpZyrGoeoH
         Gf9FrJ38/yYm8NuR486Jsb19m3/oxY5f5uu0NxInhyqUDdSoWP2YmWAqZt9QcLw3p1gP
         vVbQ==
X-Gm-Message-State: AMke39mIwmXOUZ3Rc6J4qGZClawjoJkG7w7IHnr5wAm0RMlAqXWqs3TzxQcb095AHx9PLPc0Qz16BsIVTwnOXA==
X-Received: by 10.200.40.86 with SMTP id 22mr19495831qtr.245.1489126077473;
 Thu, 09 Mar 2017 22:07:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.86.164 with HTTP; Thu, 9 Mar 2017 22:07:57 -0800 (PST)
In-Reply-To: <20170310033058.GA1984@instance-1.c.mfqp-source.internal>
References: <0102015ab11ee091-f9f11bb5-559a-4c92-b5f6-9f7755e8f4b9-000000@eu-west-1.amazonses.com>
 <20170310033058.GA1984@instance-1.c.mfqp-source.internal>
From:   Shuyang Shi <shuyang790@gmail.com>
Date:   Fri, 10 Mar 2017 14:07:57 +0800
Message-ID: <CAE9=6bpVs5bqTgzt1uLDYsF2-Mtx3mgfEZB_ag2VzMg7MmmwYQ@mail.gmail.com>
Subject: Re: [PATCH GSoC] Allow "-" as a short-hand for "@{-1}" in branch deletions
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Siddharth,

It is good to know that you have been working on this, and sorry for
this "bump".
Although I see "git branch -d -" not so dangerous, it is okay for me that w=
e
keep it out of the shorthand range.

And your work is awesome.

Thanks,
Shuyang
=E5=8F=B2=E8=88=92=E6=89=AC Shuyang Shi
Undergraduate
Department of CS, School of EECS, Peking University
Email: shuyang790@gmail.com
Mobile: +86-18301336991


On Fri, Mar 10, 2017 at 11:30 AM, Siddharth Kannan
<kannan.siddharth12@gmail.com> wrote:
> Hey Shuyang,
> On Thu, Mar 09, 2017 at 09:47:12AM -0800, Stefan Beller wrote:
>> > The "-" shorthand that stands for "the branch we were previously on",
>> > like we did for "git merge -" sometime after we introduced "git checko=
ut -".
>> > Now I am introducing this shorthand to branch delete, i.e.
>> > "git branch -d -".
>> >
>> > More reference:
>> >   https://public-inbox.org/git/7vppuewl6h.fsf@alter.siamese.dyndns.org=
/
>>
>
> 1. I have already worked on this project, and my patch is in the
> "Needs review" section in "What's cooking". It implements this change
> inside sha1_name.c and doesn't touch git branch. So, your patch is
> mutually exclusive to my previous patch.
>
> 2. Matthieu made an argument against enabling commands like "git
> branch -D -" even by mistake [1]. The way that I have implemented
> ensured that not a lot of "rm"-like commands were enabled.
>
> My patch that would enable this shorthand for other projects is
> here[2].
>
> [1]: http://public-inbox.org/git/vpqh944eof7.fsf@anie.imag.fr/
> [2]: http://public-inbox.org/git/1488007487-12965-5-git-send-email-kannan=
.siddharth12@gmail.com/
>
> Thanks,
> Siddharth.

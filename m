Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5493A1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 17:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbdHVRv2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 13:51:28 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34133 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdHVRvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 13:51:25 -0400
Received: by mail-yw0-f181.google.com with SMTP id s143so112427665ywg.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4rM5M2lHsO7XKFrwyiqeUpKV8huDBKS10fAryzPMi5M=;
        b=BK+IsSbuDMj1/JBx4MOxBj+mza1f9HtcbtQaE4j0AfH2ChNDF9UhhZRMV8P17tSUrh
         Aqbp4JIc2d7QYUb1YmmmyzXoDCg6yNgI8s5xiD8K4WshRLhGqaZEqJZjBk/NdYPBzKRF
         vNGc5u9u8ZFq4Qv3SKoKHYAFHcSpnev2nb4bxJaOpVXg5eW1TSldsQOWjg/8EFbib6cs
         V4kJr5vqzqJcigbfRtcznMI1GhiQMbDlptfDdxJxf/CVUEAdN2AM1COsIgOK52zltPlY
         lnbSTWqrdTYaS+HNz2FhJPrIPOIicvVbSINePbq0IpdlvHHAL8V/nM7sfVFt4owTSdq9
         ToQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4rM5M2lHsO7XKFrwyiqeUpKV8huDBKS10fAryzPMi5M=;
        b=K8eV7d+A3f0V/2Ds5m1Sjg8QJSbktW7olavpEyGtVVm6vj3Hu0JbGOH2hWJeHnJhRd
         ADab/wxHAgyEiTy77uDIpMiwlX0IFZGaOVjSj4/DMm5ilLZURQX7WMSwvhJf1Ikwl62h
         XvN1q5J1GvjH9R8POxWGlqdO3GjsgHGS8gegh1i7hs7/XO+5yHE3yPM7lVbQKvncxXhy
         d8+TY7BTJeGe0Slp8e88mzpezS4V5n4N6YoMH5cmKwgsgpr8v2kKhNiFuunVxJJtyunK
         Gl7wfu1g1rVpOsBEflTxSLHcecxfHIzLEjxzcRsC6+o1lViSgZfXrT6SYk3UJltBo4le
         o3Tg==
X-Gm-Message-State: AHYfb5iK4VhRJwra7juc1T325z2iATb5CbjHRYKfYbWPhI+8WxfbtbH+
        l/iLdClVPilA0rMuD59QUub1q8c5YV21
X-Received: by 10.129.93.194 with SMTP id r185mr1263485ywb.33.1503424284577;
 Tue, 22 Aug 2017 10:51:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 10:51:24 -0700 (PDT)
In-Reply-To: <D44F6340-9011-4D41-B103-4A61E7248806@gmail.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com> <20170818220431.22157-1-sbeller@google.com>
 <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com> <20170821162056.GB1618@book.hvoigt.net>
 <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com>
 <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com> <CAGZ79kZMjGNOn0FnJGtO5gRY3rF0Eiow8n0uppTZsCUAHY+m3A@mail.gmail.com>
 <20170821182110.GA156514@google.com> <D44F6340-9011-4D41-B103-4A61E7248806@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 10:51:24 -0700
Message-ID: <CAGZ79kbpf-a_ZinPLuPh2Vq629=cQknuLVF-QVwOeae1ZGS2Cw@mail.gmail.com>
Subject: Re: [PATCH] pull: respect submodule update configuration
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 7:50 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> OK. I change my scripts to use ".active" and it seems to work nicely.
>
> I noticed one oddity, though:
>
> If I clone a repo using `git clone --recursive <url>` then the local
> Git config of the repo gets the following entry:
>
> [submodule]
>         active = .

bb62e0a99f (clone: teach --recurse-submodules to optionally take a
pathspec, 2017-03-17) makes it clear that this is intentional for
--recurse-submodules, but doesn't exactly state that --recurse will
behave the same. The idea here is that at clone time you can already
give

    git clone --recurse=:(exclude)sub0 <url> <path>

and have your desired set of submodules there.
Combined with the changes in the attr system, b0db704652
(pathspec: allow querying for attributes, 2017-03-13)
you could make up things like this:

  $ cat .gitattributes
  /sub0 label0
  /sub1
  /sub2 label1 label2
  /sub3 label1
  /platform-specifc-subs/* label1 label2

and then get a clone via

    git clone --recurse=:(attr:label2). <url> <path>

for example. The labeling via the attributes allows for
complex patterns, but a relatively easy command line, that you
can share with coworkers.

> Is this intentional? Something in the git/git test harness seems to prevent
> that. I was not able to write a test to replicate the issue.
>
> Any idea?

I do not seem to understand the perceived bug?
The setting of submodule.active=<pathspec> seems intentional to me,
but how would you not reproduce it? Maybe Brandon has an idea.

Thanks,
Stefan

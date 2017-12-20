Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4FBB1F424
	for <e@80x24.org>; Wed, 20 Dec 2017 08:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbdLTIXK (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 03:23:10 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:41036 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbdLTIXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 03:23:09 -0500
Received: by mail-pl0-f43.google.com with SMTP id g2so8603696pli.8
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 00:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=09m15cUdTZuWm6BOZgsVP86LJjjT4X0eMft2e9tuLZo=;
        b=FpnJkd19tCmGR+7KCyuSTisL+Fy7/PPiOxZ94CSTmD8Zk8jEiSm/nYQV1wHLvLxg+z
         rtL4djF/AeFV4Q5qaflHtuG0q6ghFt5dZXcZpPJgHSxq5Kd1BpcseNJzz0/vH1Lxn6Mt
         312ZMtnJbKjRTh6J7JZAIJAUMGP432l/rd4r8A3enE2HaXxjoVU3VgdFyhM/coKIT1HB
         fgHFStPIwfFFEcDV+egBrZLn1KlmtbcMEtbXqv/2LNRUVML2+sUUpnnCGwV1DH/YbIZc
         Wn/NDdRcxk6DT6XHeijwFnhso3HURVtf2DVEdnGsYVbITIRZ3P03O/dtt/7tPRSPtZVh
         P80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=09m15cUdTZuWm6BOZgsVP86LJjjT4X0eMft2e9tuLZo=;
        b=FLHnlfdR4cyw40SGbp8OjGZLZJRWCD2/uhtcyVCpxgG9YdpfltRfkw6ndxtzkQAPdu
         TP3AsY3oW7D+YNvRfBgtZJitCUAdaP78CtbCZjDqZxTdRMwtEk/qq6fCVZNCxDqWjBFF
         iV4dqs+JmlxVMzYrYUD8v7IvokaI5GGYWkO9yOMjSrJ6zkVsqwkwydyRjbAF8Bp5x2VA
         ORq3dC1phKNAtIF/G+TABMIB1CzrTDUYy/4qGRtvZfkPbwppkBV11Mkau4eMl2GFqzRg
         LogQ06csR2UBqrCs5VmKKnKx9sBAMvqcU+I5/0eKTpXOD9x7GfrlqJf95Cib/zeszhEc
         iTBw==
X-Gm-Message-State: AKGB3mIy5XcLt1he+IwWuWv655ObjtzLl8l0qvbo6QCfOtdnrg/wLxaa
        jBVSe7FQ86HR659VHx9nJa8weAW3/GLFLAVn3PI=
X-Google-Smtp-Source: ACJfBos1lT0ZaCRayiDF1pgKl3BRXzDgbmlNK2n7+1uyhezeVmL7ECNMUZ3OdAnzgvGzp9t9432xEk4xnWxe0lFj71c=
X-Received: by 10.84.131.3 with SMTP id 3mr6276261pld.200.1513758188599; Wed,
 20 Dec 2017 00:23:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.129.8 with HTTP; Wed, 20 Dec 2017 00:22:48 -0800 (PST)
In-Reply-To: <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
From:   Andreas Urke <arurke@gmail.com>
Date:   Wed, 20 Dec 2017 09:22:48 +0100
Message-ID: <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for looking into this.

I was able to reproduce it from scratch, but I followed my earlier
workflow where I first created the subrepos, and then later renamed
it. At the time I was not able to find any command to rename without
changing the path (and I was not able find one now either, is there
any?), so I edited name and path in .gitmodules and ran git submodule
sync. Am I asking for trouble doing it that way?

Let me know if you need the exact steps I followed.

Andreas


On 19 December 2017 at 23:33, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Dec 19, 2017 at 2:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> I tried reproducing the issue (based on the `next` branch, not 2.15,
>>> but I do not recall any changes in the submodule area lately), and
>>> could not come up with a reproduction recipe,...
>>
>> I do not offhand recall anything; the closest I can think of is the
>> three-patch series <20171016135623.GA12756@book.hvoigt.net> that
>> taught the on-demand recursive fetch to pay attention to the location
>> in the superproject tree a submodule is bound to.
>
> I tried the same test on 2.15 and cannot reproduce there either.
>
>>
>>     4b4acedd61 submodule: simplify decision tree whether to or not to fetch
>>     c68f837576 implement fetching of moved submodules
>>     01ce12252c fetch: add test to make sure we stay backwards compatible
>>
>> But IIRC, "submodule update" uses a separate codepath?
>
> Yes, any portion of git-submodule.sh that calls out to C is going
> through the submodule--helper. I want to revive the port of that
> shell script to C again.
>
> The "submodule update" uses the submodule helper to obtain
> the list of submodules and then does a "git -C $sub fetch" in there.
>
> Stefan

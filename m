Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4865B1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCPWI2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:08:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43511 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCPWI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:08:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id j2so4678420pff.10
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezv1io0CuUdaiFS416uiqYtzBFvz6huNHV/Ha+Xm704=;
        b=E25wqItwTK3hj7Y/Vw0DW3na/fp3NMOC/Mavlk2KAKkIhFSsUxaz3XhEdB3xvfu1KZ
         ttiX6KofAelo7yOc3hkTzWg5+0+kL06KzHuWO89iJ4uQ+Y3TNs4vn2yQkCmcMDY5TSYQ
         ds3p7pm1cSJasYktqxODsrZ5Vrk9lNMVzSXduycmN/eeIPvFi74eCuOlN3+Xm8vy9qNR
         LEDOolmknpHmx3VE870Cm7gOm7+uVCq9gTRGrFV/7O1808xCE8mSBd9p0sOyNXrD1Lby
         SnmQHtawLvS9Xr8n8sOJgLdbDeDhdvWjLeKqQ5w3No+71eEBCU7S1Te8feuP9PyTaOSa
         ETfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezv1io0CuUdaiFS416uiqYtzBFvz6huNHV/Ha+Xm704=;
        b=odbgOfRRFNzRrKAs+4pOzH6AS8ez20oSE6EXTh9goFihc+DWXlTvHYQ5SluOlZIivX
         GdDKz/mAPvxgYEfyr6cobKK98bw4Fzjlr0v6GuekhOHid6+nu16QpraRYkTONdIYWVsr
         ADgByRBXlVeu/8+ISJn1rfOYuqhlB7zpbfSmoS6qvfCtmw4Ip6pvKndK8icxa3Mvh4Mb
         SS4i7CL6XVDWdXLofL45fVNZric2YrtAiqNdgRoyBw7HNfwxZE7MD12PudT7T/TBcs5V
         cAA0V56JHEHHyPljdh/dJGdntV4QusktKqjz/TWQdVep/bjTpADKw5TQofRuDl2tKDSV
         EwTg==
X-Gm-Message-State: AElRT7H7GZtciqEjTQ9v1SzHzUu8ING8uLMyqnv8kJN1V/3VNUUseVRV
        tviPrNzpeF3fQ0YkSnhA/FQ=
X-Google-Smtp-Source: AG47ELt5HW5nKw04d9Gyt18pLOcufr+24xxdty3yMzg0XcRaiPaNkL+iGEeIB3syF8u2j3hvdgN3fg==
X-Received: by 10.101.78.5 with SMTP id r5mr2711831pgt.33.1521238106239;
        Fri, 16 Mar 2018 15:08:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n15sm4646716pfa.35.2018.03.16.15.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 15:08:25 -0700 (PDT)
Date:   Fri, 16 Mar 2018 15:08:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
Message-ID: <20180316220824.GC151588@aiede.svl.corp.google.com>
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
 <20180316143124.5b22d70861344cbcbbad46dd@google.com>
 <xmqqh8pfzo1h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8pfzo1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>> On Wed, 14 Mar 2018 18:34:49 -0700
>> Junio C Hamano <gitster@pobox.com> wrote:

>>> * sb/object-store (2018-03-05) 27 commits
>>
>> [snip list of commits]
>>
>>>  (this branch is used by sb/packfiles-in-repository; uses nd/remove-ignore-env-field.)
>>>
>>>  Refactoring the internal global data structure to make it possible
>>>  to open multiple repositories, work with and then close them.
>>>
>>>  Rerolled by Duy on top of a separate preliminary clean-up topic.
>>>  The resulting structure of the topics looked very sensible.
>>>
>>>  Waiting for a follow-up discussion.
>>
>> Would it be possible for this set to go in independently of
>> nd/remove-ignore-env-field? I understand that some patches might be
>> cleaner if ignore_env is first removed, but this patch set has already
>> undergone several rounds of review and (I think) is an improvement to
>> the codebase on its own.
>
> I thought the "remove-ignore-env-field" thing is a quite small and
> more-or-less straightforward improvements that would serve as a good
> preparatory change to give a solid foundation to the object-store
> topic.
>
> I was hoping to hear quick Acks for remove-ignore-env (and also
> Duy's reroll of their topics on it) from people involved in all the
> related topics, so that we can advance them more-or-less at the same
> time.

I can go along with this for this series, but I want to explain why I
am not thrilled with the process in general.

The series "Moving global state into the repository object (part 1)"
had gone through three revisions with relatively minor changes between
each and we were in the middle of reviewing the fourth.  In response
to a series that comes after it, "(part 2)", Duy created
nd/remove-ignore-env, a series that I quite like.

But with this reroll, the result is:

 * The patches that have already been reviewed 3 times (in their
   current incarnation; parts of this series have also appeared on
   list earlier too) and we were in the middle of reviewing a fourth
   time are now on a new base.

 * These three series, each of a manageable size, have been combined
   into a larger series of 44 patches.

 * I have fears about when they're ever going to land and be part of
   an API I can start making use of.

So even though I agree with the goal and I like the improved
initialization code, I am not happy.

I would be happier with just the new initialization code being its own
series that we can fast-track, then deal with part 1 separately on
top, and then deal with part 2 after that.

Thanks,
Jonathan

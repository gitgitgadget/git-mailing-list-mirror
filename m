Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821941FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdFSR6v (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:58:51 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36722 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdFSR6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:58:51 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so32070137pgb.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2W8zHzupPxexSKc6vjmeCKd4xJ84SzoWhT2BAq7Zp3E=;
        b=fRDhA01ghCgcOAQC2EhNXx6iIouzJD5MQ+QwFbtpE6n6d/Lv2Een3/Hnz15BXx6cVO
         IQFfHubf61tqXT/zEsWEfXfBhfFzY8rz1j84/2lZBGtnXaBDX39zwv/Q4q1Qq3Gum230
         mf6DncZbRDL+rMTieXu3vl6PjgYiFwVCZdvW1sRInn4cKnrWn3z+dB2Z4lWap7OQ3EAz
         xjy89knKZsWT4qfoVjAv1nij+aNbjIIuQRRyC2/788T/AslYcFQHylHMUr0NbETZut50
         oXc06ytrnfX0DJdu54kIrqxrM3fa3Ae776rTlaMzBTKbMdgq77j00t2921PCPPZFDWkR
         AE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2W8zHzupPxexSKc6vjmeCKd4xJ84SzoWhT2BAq7Zp3E=;
        b=LRrxnSrWA0107FGnC59p21varjydfvCd7H8F0ka4vjw1RR76XHXSUqnoFeBYuWdzh4
         KRCUb902iaF+qbPrHEOCXvnOw81Ypc0dXMbo6lkdjlcSK3n56E9WAo1BKCuFNyM6Fb+U
         1VtRdjoyOi8xEDAGjGifVz5yZG92lVKhnbrHcuCy84uT0CHfIaqC4h19i++0MrSgUHT2
         vfEld3GfoRK0m2WZGBLCCt/7p50a4sePL5cHY/QOuukofVZRbczM+kHentC+UnO9h2e6
         zsixRdLqxBZUB66jGvzlP3mNDgbNbbRWi/Mkq6787QD7GKCOCUzaAJDBm+32AaSS2MZR
         CF9Q==
X-Gm-Message-State: AKS2vOwC/8wXtDsvSD4EUBx8AX/2obVDamZQxOqzDrhVcQz9lGzrnEMd
        OJywDDWnHLllU/ENsYk=
X-Received: by 10.84.202.163 with SMTP id x32mr31355869pld.112.1497895129973;
        Mon, 19 Jun 2017 10:58:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id 84sm21960082pfq.125.2017.06.19.10.58.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 10:58:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: How to git push mirror local refs only?
References: <CAHd499BBNsai4SScOe6kADsgbGRLyGnDKyUcm8LZL-w8c9Webw@mail.gmail.com>
        <xmqqpoec4nib.fsf@gitster.mtv.corp.google.com>
        <CAHd499Aft6yE=8f8DGRVxMYNR5kg6AVs3tECVtz1VDdwFeL5fg@mail.gmail.com>
Date:   Mon, 19 Jun 2017 10:58:48 -0700
In-Reply-To: <CAHd499Aft6yE=8f8DGRVxMYNR5kg6AVs3tECVtz1VDdwFeL5fg@mail.gmail.com>
        (Robert Dailey's message of "Mon, 19 Jun 2017 09:20:22 -0500")
Message-ID: <xmqq4lvbuaef.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> On Fri, Jun 9, 2017 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Robert Dailey <rcdailey.lists@gmail.com> writes:
>>
>>> So I want to update my remote fork with all my local branches.
>>> Normally I'd do this:
>>>
>>> $ git push --mirror fork
>>> ...
>> Something along this line in your .git/config:
>>
>>         [remote "fork"]
>>                 url = ...
>>                 push = refs/heads/*:refs/heads/*
>>
>> and then
>>
>>         $ git push --prune --follow-tags fork
>
> Sorry for the late reply, I was out of town all last week. Thanks for
> your help. Does this serve as a good general default? I can't imagine
> a case where I'd ever want to push something inside refs/remotes.

It may, as a good general default to something other than --mirror,
perhaps.  When I ask for mirroring the state of my repository, I'd
expect it to preserve as much state as possible, including the tips
of histories I received from elsewhere.

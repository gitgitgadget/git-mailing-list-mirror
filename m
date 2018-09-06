Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B761F404
	for <e@80x24.org>; Thu,  6 Sep 2018 20:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeIGAwN (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 20:52:13 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35303 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeIGAwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 20:52:13 -0400
Received: by mail-ed1-f43.google.com with SMTP id y20-v6so9914290edq.2
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F47fuPC0M+UZjgnxU4/FrL7m4+TmVaBEGRzAOCASdhc=;
        b=qFAQJVQqTJM+LToE2dBat2X2nUfSDOB2vz2J8+FCRmbbuL9FsKq4+EL3Du1Ad8Zb90
         koJdVEdtOepsZSOu7Z5rKMtH9zi+ZO5Jm2RAaaR/umtlAuhGEy3aPyLEx8GErK00jbM7
         SGrUWpAy7X6pbWfbZY5VJMBnmW6XmdWIvDHfh2rhntTwySAU7yHwypc8bQW/GSsuiFOg
         VYFUuDkl9SZk8e0AWZdK3DOu2jt9dJ1YxzQ3pR2tejXXCHFTwGF4uEex8tsKbW4mbjLl
         d4rrLZvVfFWd0bGD4gFE7N0i7+LmppeBFRlc6zKEH8jsUM+ocHwgA2BR1SRt/KMqOaH4
         INAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F47fuPC0M+UZjgnxU4/FrL7m4+TmVaBEGRzAOCASdhc=;
        b=ptpNCLw+J+jy6QPz7JQde6N4CSs7oc2CqVdZOz1eo4UpiGxnlB0ZAIL1MiFd8CVzXA
         wQNfJ/qbz82zodpYuXpEGrh/ahcRTswZIu1kzi3TQLdIcBh0w8bFErVI3Y1D2lkP/o+R
         oq/zpU66ljpDdRhrJ7n/1rMDqin58nWHIruncHnigK7tjK2kc39w27tts1UHtjnDWj64
         q0ImPA50sHF4gWZNt7WuiA1d0g+tVlZ7Wr4rNKLQLXZL5mvdepLSWsAFkICvlpp3TlrY
         mAct4kvn3WO+VL5uuihbYX3T2PBFkmG3nhFzQMWPyoLjxhEy57by9tTv1Bt4CEWC+wUr
         G1Pg==
X-Gm-Message-State: APzg51ByrtbPjzd87p86LXMRO97NeoiNVGXxkmmhM9yh0tnDf5jDojat
        zSCbWV3Q19RL2EWMfj32B4sexnw9w3Wp7gx0x0SlFQ==
X-Google-Smtp-Source: ANB0VdZeum+otY9NWsZoEIFk1vQO3ElX3nOJuEwtYq8NkJvBPwhotINQinrT3vS7+32VSfxxdE22pXcoe3RKGkDB4jA=
X-Received: by 2002:a50:90c5:: with SMTP id d5-v6mr5186404eda.76.1536264906381;
 Thu, 06 Sep 2018 13:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <87lgc77wc7.fsf@evledraar.gmail.com>
 <CAGZ79kae4k=uLx-oX5emxas4KrqObzQhzgir0coOSBzzpO8APw@mail.gmail.com>
 <87tvn2remn.fsf@evledraar.gmail.com> <CAGZ79kYKzrRXy+GUCpMN3jpo4MvcpGvBFvEkTjrsy85XJb0K2A@mail.gmail.com>
 <MW2PR2101MB0970C7744A6FA72940DCB252F4010@MW2PR2101MB0970.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB0970C7744A6FA72940DCB252F4010@MW2PR2101MB0970.namprd21.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 13:14:55 -0700
Message-ID: <CAGZ79kY_+jNAu4jwVOhd+gVMELDSjk_MACKBRf51tksrzZMx-A@mail.gmail.com>
Subject: Re: sb/submodule-move-nested breaks t7411 under GIT_FSMONITOR_TEST
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Ben, do you have an idea?
> >
>
> I'll take a look as soon as I can (and at the other fsmonitor test issue =
=C3=86var sent email about) but it may be a few days before I get a chance.
>
> I haven't had a chance to look into this yet but here are a couple of SWA=
G's I'd start with:
>

> is it possible that "git mv" is triggering it early, making a change, and=
 then updating the index with stale fsmonitor data?

This is exactly what is happening. Thanks for describing the situation
precisely.

> I wonder if there is a missing call to mark_fsmonitor_invalid() in the "g=
it mv" codepath somewhere.
>
> refresh_fsmonitor() only runs once per git command

Just naively adding mark_fsmonitor_invalid doesn't work, as then
we have a sequence of

fsmonitor process '/u/git/t/t7519/fsmonitor-all' returned success
mark_fsmonitor_clean '.gitmodules'
mark_fsmonitor_invalid '.gitmodules'
write fsmonitor extension successful

and the marking invalid doesn't seem to override the first
mark as valid ?

>
> Sorry, I'll look as soon as I can.
>
> Ben

Thanks!
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A031F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbeGaRAH (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:00:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44561 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeGaRAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:00:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so17077108wrt.11
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ualhGUgmaFAhYwmcILYm/SF2f11gBch6DjNoHRCBjUk=;
        b=k2OzVunaZ8cxEdwMVR2xBFND3T0nH+qS72/3X2CPXMnUF0XSeI4o/M1viw1zmZfioo
         saNWQeNVtSyYUyaLShjGDxBsya3vtoXD/woTDBptv6kmApHDBe8MdQMkMhZeOXhjcbcq
         f4Keaguu1U+huFhFTOE2kqyWqqqEemLczBfWCo4n22+FKreXzpvKk5IQ1zOqWx7Lu3iJ
         1iqFbEboiOxnExehj96xKkgSLbtDduGAcuLdH6Mki+2hOpNlFI8t27GZDfvJ3gz0sfUZ
         7SONekzJPxWqbRraxIr+5R0QugrArZUcNfZobPMVAAhbnoqFXUnVniHp3QPH8HRKD/F6
         tyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ualhGUgmaFAhYwmcILYm/SF2f11gBch6DjNoHRCBjUk=;
        b=MsghU1OaM+R1+bJ/Z1p637ibCKeiJU30mb3sorcP4LTVcBowDbK2bTuixGhzYPop+D
         haNXdg1jgxQN+thOTNYAcRkKGfumqX0N3AWDMUsp3SM2XDBJC1xz8pRxpg64ZzHrV09x
         RB9eBWvoyKM83/EIw0zGlfGCTVOCGB8EpGgdeUEM7H73+KXhbhWqKQs/3VPex9eiYDhw
         weR8N9SLkFgt4LHnyNBqo83DOK2osY0PdwlnrCP98v2q5PxENxNse/ZYwjEl612+wZVZ
         3tDlBluGkGdtgbMfJ4nqX4eQMNRh0bxqHpoWaYwt5EI+WakNMlOF92Ayfg089edECEhf
         L9dw==
X-Gm-Message-State: AOUpUlE+2NMuCCcYge+jayUO77g3ybIICplZg1Q2TrYdy8j583pEjoQU
        P8MY69k93dO1yrdVLfRFNQg=
X-Google-Smtp-Source: AAOMgpe+uKAEjxoP/y9C7xWwgf95sLKjvuoe3O275Sbt18qVYiyMisxLfhpQYqlFWhqhKT1rw9tvdw==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr21945309wrg.203.1533050357232;
        Tue, 31 Jul 2018 08:19:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a84-v6sm3528941wmh.27.2018.07.31.08.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 08:19:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v4 11/21] range-diff: add tests
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
        <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
        <CAPig+cRd2V_hN0BVCcevXhu1v_QpL76mhqTGQmWPLK7sAD4Ytw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1807301830330.10478@tvgsbejvaqbjf.bet>
        <xmqq600wfpfl.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbnrBHscQUS8WdU9f6edGS=yH9wpVywLGyBxGHU0c_WfQ@mail.gmail.com>
Date:   Tue, 31 Jul 2018 08:19:16 -0700
In-Reply-To: <CAGZ79kbnrBHscQUS8WdU9f6edGS=yH9wpVywLGyBxGHU0c_WfQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 30 Jul 2018 16:40:45 -0700")
Message-ID: <xmqq36vze8ln.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jul 30, 2018 at 1:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> > I already pushed an update to https://github.com/gitgitgadget/git/pull/1.
>>
>> Should I take "pushed to ... GGG" to mean "do not merge what you
>> have to 'next' yet, as there will be an updated series (not
>> incremental) being prepared"?
>
> Not speaking for Johannes, but I think that *could* work.

I wasn't asking if it could or could not work.  I was asking for his
intentions.

Not knowing it means I cannot merge the topic as-is merged to 'next'
and have to wait just in case, but his not knowing my waiting would
mean an update version may never come.


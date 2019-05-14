Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC3E1F461
	for <e@80x24.org>; Tue, 14 May 2019 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfENNjJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 09:39:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 09:39:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so22913613edc.12
        for <git@vger.kernel.org>; Tue, 14 May 2019 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CpVnl7luspytUxumuET3NX9TotIw1A/lI3Ofepvsr4k=;
        b=UUxDM6/zwTCiYrWBJz/mwp75DWLa5ZerhI+VA85xUF1VKb3VZFq8R+UR9IIiUtvWEU
         D1MV+8JydkesIEvifkV9vF+ZFlSlsuIpLdYXhKOZhW1odn3pzfVPZ2KBfsmDDdzfTk7O
         Zi44mTOsxWhviwz6t2n/peo2K8Ib3BXz7cMdPMt2sTuN0EEInKhlEa5y+2iiTuARzDga
         m6e1GyLsp4BP/BKrpTDX2k5ql+Yydlmte6rTRcK/FD/bcl+WL7XLtoGesm0Ve2YsYshw
         ntGt8rc+nanAWwOJgdsRII6DwL6XJpoDARH275jXX2DlpE1ZPTmP7mbl/4pqj/8mKgOY
         uBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CpVnl7luspytUxumuET3NX9TotIw1A/lI3Ofepvsr4k=;
        b=PsIz+OFUOZmmp7gYTvztUM5UhdquBtm+VfjsGg4K7dlMDEfvkNZSs9yL/ILN3ZImp5
         qvlMuHpQa5AeeGrl/55ZNgTOS4ovIWRK0ae/uis1egFpgFdqooj2UskBPeBltFaVpWDf
         A8BmR3NQu1Ips7Q0vkMhOl8npy5JwDifHe/RTvruco5SX059xtJfrljsFOTj2gQWx4q6
         x3y+RB2JABzLFXG3ydpqoCD6KR5pMtUlHSODtb/sd25NxLqLHOblgdb7n/GA+tVg2Z0H
         1qRIjt+WVHBurJ/mAEuBobcwWNPR/yepdTNfnHJxJoDqYyFPsI8Gu2OiPM9p9I2X+PZ1
         +mUQ==
X-Gm-Message-State: APjAAAX1+lGn0tigrQ4TG5NFUWh+Pc+k78i6pqcqAXynKUq08y56D3cE
        HZk3AUnjkeGch4a22Uf++Ps=
X-Google-Smtp-Source: APXvYqzJYOJHf0bfgUiVLAc94MkQFiGWOFfhUsGydr+TY3YUiXsYm0at3F5SokuHNnKUU14GjZF7TQ==
X-Received: by 2002:a17:906:4d57:: with SMTP id b23mr27129369ejv.254.1557841147492;
        Tue, 14 May 2019 06:39:07 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id g47sm3555236edc.33.2019.05.14.06.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:39:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH] tests: add a special setup where prerequisites fail
References: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet> <20190513183242.10600-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1905140945220.44@tvgsbejvaqbjf.bet> <87lfz9wexs.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1905141434040.44@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1905141434040.44@tvgsbejvaqbjf.bet>
Date:   Tue, 14 May 2019 15:39:06 +0200
Message-ID: <87ef51w3yd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 14 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, May 14 2019, Johannes Schindelin wrote:
>>
>> > What would you think about a mode where random test cases are skipped?
>> > It would have to make sure to provide a way to recreate the problem,
>> > e.g. giving a string that defines exactly which test cases were
>> > skipped.
>> >
>> > I am *sure* that tons of test scripts would fail with that, and we
>> > would probably have to special-case the `setup` "test cases", and we
>> > would have to clean up quite a few scripts to *not* execute random
>> > stuff outside of `test_expect_*`...
>>
>> I think it would be neat, but unrelated to and overkill for spotting the
>> practical problem we have now, which is that we *know* we skip some of
>> this now on some platforms/setups due to prereqs.
>
> I understand, but I am still worried that this is a lot of work for an
> incomplete fix.
>
> For example, the t7600-merge.sh test script that set off this conversation
> has two prereqs that are unmet on Windows: GPG and EXECKEEPSPID. On Azure
> Pipelines' macOS agents, it is only GPG that is unmet. So switching off
> all prereqs would not help macOS with e.g. a bug where the GPG test cases
> are skipped but the EXECKEEPSPID test case is not.

It won't catch such cases, but will catch cases where a later new test
assumes that whatever the state of the test repo it gets is what's
always going to be there. In practice I think that'll catch most such
issues.

The other GIT_TEST_* modes assume similar non-combinatorial explosion
failure scenarios.

I haven't gone back through the test suite's commit history to try to
dig for other cases, so perhaps this mode is premature etc.

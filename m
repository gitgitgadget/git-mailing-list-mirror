Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896961F404
	for <e@80x24.org>; Wed, 20 Dec 2017 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756202AbdLTVus (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 16:50:48 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33675 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbdLTVur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 16:50:47 -0500
Received: by mail-qk0-f181.google.com with SMTP id x7so11184877qkb.0
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rlNkjR3gII3G4qAbdfiUZaRfAjkWS96biXFmB0XPtHs=;
        b=KzohCfd0SLur8qYp6nyAHVLEKpy8gTkK0nAssRMGvqYXn/JadMD5jD3xmomoW4OZ7Y
         mxrZZjW8mTQD4qR1vQ2U4mre6O4RSAyVnEsZJDxXjp7/h6dgkDqPzEQsBntBPdzl3evz
         vQg8WfymQVnRW21adUKOnE5SLr+PJlvKohzrpSC1FDUUuWHEI44hmoxhovnPXbbPDtS0
         1SiiHS1t1SrljQsERX0ZpsSKYhaW+k8f8wunVV1QRFVRXiScNuxoyxL2dXLreG705XdW
         4mDGSce67oimgOTFKly86YeO/AExIDp4m5q6Oeqrb/egRKo59PzfK9HjXhWOENgcJsto
         zKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rlNkjR3gII3G4qAbdfiUZaRfAjkWS96biXFmB0XPtHs=;
        b=ueCo03ao9BRk8KFu8BnjHFqamX9EYeGUhhUjDrga4+uQSE0CrjZvCiImka75CAgEqq
         ZI4XO8HN+qdaZIZeqi3Sxn5Pxm6hxXZeC63nyEwOGy3Rg+3esFgpVUP6Vhw+nllCaRSE
         L7mBZuWdZsQ8GsyCi4UKaldBYeuPSXcnsmT5gLlZYMnj0maIetS0qDK6oi2NpC3gU3rs
         x88UOuCcGgIQtDlRj6xNHbHI2WQ1wFCnvBL7iF5tDMSmTtGsjZU1pERo3fpffnIHuvB8
         AYru/8wO23ll8RsnWm5kpYrY2SKtxEMliJprf8Kk69OWxLqEXVRU3U3+mSVj177/6O2L
         ue2w==
X-Gm-Message-State: AKGB3mLmAapJ75DQBvhiMs+bO3MqQkXWUcaNixVenecdIlIcjXOco5C3
        v8EjZpPIesFUntCzJ+BET73GyqosDmlWnO216dY=
X-Google-Smtp-Source: ACJfBouTYTIhVaXGNmj6XetjS7DRaCEd5TusVmcV5hjod+Rmt2m1TPjZVNhdO5PxSEbLbPee04RiSzvVBd+/oVwijVA=
X-Received: by 10.55.102.149 with SMTP id a143mr11653341qkc.296.1513806646101;
 Wed, 20 Dec 2017 13:50:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Wed, 20 Dec 2017 13:50:45 -0800 (PST)
In-Reply-To: <87bmit5b8a.fsf@evledraar.gmail.com>
References: <20171220193845.11754-1-avarab@gmail.com> <20171220193845.11754-2-avarab@gmail.com>
 <CAPig+cSeRZR7J9WSozTETVu=Y9N2wMRpoCgUkLXyzAaBOmTNZw@mail.gmail.com> <87bmit5b8a.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 Dec 2017 16:50:45 -0500
X-Google-Sender-Auth: nI4FPAHpzXMxg85Mc2YFfRdjKqE
Message-ID: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] commit: add support for --fixup <commit> -m"<extra message>"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pat Notz <patnotz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 4:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Dec 20 2017, Eric Sunshine jotted:
>> On Wed, Dec 20, 2017 at 2:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> +test_expect_success 'commit --fixup -m"something" -m"extra"' '
>>> +       commit_for_rebase_autosquash_setup &&
>>> +       git commit --fixup HEAD~1 -m"something" -m"extra" &&
>>> +       commit_msg_is "fixup! target message subject linesomething
>>> +
>>> +extra"
>>> +'
>>
>> Hmm, so the first -m appended to the "fixup!" line, but the second -m
>> appended after a blank line? That doesn't seem very intuitive.
>>
>> Also, doesn't the text following "fixup!" need to exactly match the
>> summary line of the commit message in order for "git rebase -i
>> --autosquash" to work? Am I overlooking something obvious?
>
> It does the right thing and it's actually
> "$fixup_line\n\n$first_m\n\n$second_m" etc. It's just that this
> commit_msg_is function is testing against the "%s%b" format, so the
> first line of the body comes right after the subject.

Thanks for explaining. I guess I should have delved into
commit_msg_is() before commenting.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90992047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdI3SJN (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:09:13 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33302 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdI3SJM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:09:12 -0400
Received: by mail-qk0-f193.google.com with SMTP id b82so1246469qkc.0
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ymnt59eWX1kUOcaZH6iXshcm1OYpGkoBs5VbHMNf6Ro=;
        b=gzpUhp7bU+ZT1cgW7K9j22grYBvTtqsTLw5Gy5Rvys9In4TDvx4saHyqZQrG9bL34y
         OecjEfcvCk2VB9kTmyQatwYJciJkVfMFWSCHZnPW2IE0sg5K8aVervMp6FY7uFUBmeLy
         8ShUse6TO/eLORPRzaH5ArlCrZQKUcFJrfymrvAaFMld4CEdVHWZToBJSbhkl9cy4vkX
         B26rRjx4RIcxTwdKA4EUc8jfqvn8h6Bob2Pa/VMZ4Ey4anhbIrgmGgU/gNw9YoKJuIsN
         Dwfm4GjoG6XuhYDXII2XV3AaLvh+oRjluBNz3GDeS7sTRsyYJMW0A8y1RZRoNAn6etJq
         p8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ymnt59eWX1kUOcaZH6iXshcm1OYpGkoBs5VbHMNf6Ro=;
        b=YtebAtZsahMC/VfvaZK8Sq3qg30jVsN/SWUiO8Qdf8CPfiGJoDhxbmIpRgIRvMesf4
         GGcIO5H7Js7M0Zne8zeCVHKaNWa59yyrHfT9GkhoyNxesgzOnXaQh7ddkHJeh3XdA8ko
         EOJDp1BjiPQKWCoaru0OIOi1ksSK2xQj7OR2wQFmhLlPmcObHakVvTn+CjZG8z5uzc5p
         i8MSafJeloGwfcvfpbmVOFtJ9P1+kRY2Nqq92iqUV/IrBH2CxnXqdnosPjLYiX1kp3r6
         qdmNQNdmYeswAh9SiFs0X/EaWRv40Tt+I/J1MDeyQM1Fqt8JDVjlhrN4AAAJjfbQBUlB
         uXqg==
X-Gm-Message-State: AMCzsaUDpDe3utb9kHNGpbhdlMGt30JhedVUKOV8C0W7vk74u5kDv1Mz
        vrztlwD/m/gjonxmJBTCqtxI9Pysdtd0t5C5j2E=
X-Google-Smtp-Source: AOwi7QDyolAxFF2fpmZ/ywiw+mRCyhJaD7M5i0TmQbtb/POPlabutHSovGmf7ofWWu1V/6u0GrroLtIsSHVHJSjrW/o=
X-Received: by 10.55.174.129 with SMTP id x123mr8375902qke.306.1506794951758;
 Sat, 30 Sep 2017 11:09:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.20.23 with HTTP; Sat, 30 Sep 2017 11:09:11 -0700 (PDT)
In-Reply-To: <20170929234002.3fzaksoarz75p7e2@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net> <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
 <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net> <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
 <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
 <CAL21Bmma8gOYx9u4kxRaHJKcF3YsfrQP9=wdAiQX14f9uSPRAQ@mail.gmail.com> <20170929234002.3fzaksoarz75p7e2@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Sat, 30 Sep 2017 21:09:11 +0300
Message-ID: <CAL21Bmk2oN61CxJA0eju=FtAh2Ei9dLqRMPZKonCND4sC504Sg@mail.gmail.com>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added "v2" after "PATCH", but it does not appeared. Actually it was
written automatically and it was "PATCH Outreachy v2". I rearranged it
in the middle of the phrase.

>> I forgot about leak. I also need to add checking in mru_clear. That's
>> not beautiful solution but it works reliably.
>
> I'm not sure what you mean about checking in mru_clear(). It may make
> sense to just send your v2 patch and I can see there what you do.

I realized that I said something strange before. I solved the problem
with leak by deleting INIT in prepare_packed_git and adding init as
you suggested here:
https://github.com/telezhnaya/git/commit/7f8995835949f83e54efdfd88445feb6d54cb3e9#commitcomment-24576103

By the way, I asked to edit FAQ for Linux kernel newbies about linked
list that confused me a week ago, and that funny picture was deleted.
https://kernelnewbies.org/FAQ/LinkedLists
Maybe it will help to someone else :)

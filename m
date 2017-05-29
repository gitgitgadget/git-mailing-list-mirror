Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B252027C
	for <e@80x24.org>; Mon, 29 May 2017 11:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdE2Lbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:31:37 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33239 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdE2Lbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:31:36 -0400
Received: by mail-oi0-f45.google.com with SMTP id w10so75884425oif.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ueDco7pqrp2NQWyUE2TZvn7FkZvncKzSpnzxfpXxx10=;
        b=Xua+oXEY6zddOmB4wPgpsp/vym9ekcKEnCcdXB4ynDLxgmxVl6ViDt4w4zIQhm6KRB
         qEssgx2pZo7w7aFA3v8RZIIqb3PKyqgziVeVeq9PS7sVTNrFvR9ASekDzHxzHeqoHAJl
         en+zLrYgKNgjISl1Vm2jbQ7w1bvAwTHiZC/XxMBubog+OHRoCBwsw5oO/m8N0PtfLXKB
         inuObdH/eo0r5Pry6wCrn/d/s1uSWiF5g6Z5yfRHDjpqcp2jgJ8WimhAr9316AXSI6mF
         Iay8OE32uKn9P4pfpqyTs4jphgsck0yhOcI2Wyx8f4RkaLZKNE+uAlx2v1QQZEH+U4gq
         jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ueDco7pqrp2NQWyUE2TZvn7FkZvncKzSpnzxfpXxx10=;
        b=ZHA9th42Uotia/SopVT7nyfDi7RHXrwY+SPl22UV1C3d7faQgofZR8ilZL0DZ7sf1r
         TlCeO5VZgkOzLFmjZTtQ6yIPt4sL68KQDcW4ta+iO5JxsioE4wTbZxIFQtxHU0c9CEpd
         mwoml+DcBo7PwvuYMmR5ahxoiZiD5uRfVoKInLyBPpy4ElxFsp7cb3R+LA+O//zP8g19
         sbEOjeNVjsE412hY0m+jIEcvTFjHI5Qjfg+ikpZ45UiIzOL7JyycmwMVPjOXtRoXEn+M
         kPLYkoHoMKhNBYhkzdOpWUayDPvrrSlUfQaFpBMHxwCXgprI3O/7w7GK7zroZER9by3A
         07ew==
X-Gm-Message-State: AODbwcBR/Aqbe9YbpgAgyp6RJ7WUsMBwai26dvEScH7lKQR30C+J2Q2s
        sA1u4tv3+d103lAlSnJ7vlA7fi+WbQ==
X-Received: by 10.202.114.73 with SMTP id p70mr6919861oic.157.1496057495727;
 Mon, 29 May 2017 04:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Mon, 29 May 2017 04:31:05 -0700 (PDT)
In-Reply-To: <CACBZZX5GRxecDQkoqLv55FLuiSohGSR3U1U+sG0vFFpexcc54A@mail.gmail.com>
References: <20170518232134.163059-1-bmwill@google.com> <20170522193535.7cgivd6pmmqhw7ze@sigill.intra.peff.net>
 <CACsJy8DmsG_+ASEkisUTLejVkiOmYytvTCTQs=RCH6q=BeDAhg@mail.gmail.com> <CACBZZX5GRxecDQkoqLv55FLuiSohGSR3U1U+sG0vFFpexcc54A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 May 2017 18:31:05 +0700
Message-ID: <CACsJy8AtMNAE=5jihV+sYZqyx40JCJ0hkZAvqFbkOU1g5sZSYA@mail.gmail.com>
Subject: Re: [WIP/RFC 00/23] repository object
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 6:23 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>>> That said, even if we never reached the point where we could handle all
>>> submodule requests in-process, I think sticking the repo-related global
>>> state in a struct certainly could not hurt general readability. So it's
>>> a good direction regardless of whether we take it all the way.
>>
>> I doubt we would reach the point where libgit.a can handle all
>> submodule operations in-process either. That would put libgit.a in a
>> direct competitor position with libgit2.
>
> Wouldn't that be a good thing? We already have some users (e.g.
> Microsoft) choosing not to use libgit and instead use git.git because
> the latter is generally more mature, if git.git gains more libgit
> features without harming other things it'll be more useful to more
> people.

Whether it's a good thing might depend on view point. Similar to linux
kernel, we might want some freedom to break ABI and refactor the code.
But I think it's too early  to discuss this right now. There's lots of
work (the "die()" minefield comes to mind) before we reach the point
where libgit.a may be good enough for external use.
--=20
Duy

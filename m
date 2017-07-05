Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658F9202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 15:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdGEPsk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 11:48:40 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36664 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGEPsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 11:48:39 -0400
Received: by mail-it0-f51.google.com with SMTP id m68so116186731ith.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I5GioQ7xUQ9H5fXXCmntzv0GQIvWTOWUbe50tuhhBHA=;
        b=J+FCQacFSxSemdf02K6bBRSPkFtk9HUVhLRDlaR54rfX7DMIUGm9q9oQQF9L5A66Ao
         Uxgok3uT6wbyAD+bIsgQG57af698M4jil9iCMZdE0shvI5Q69/10su0XkuoiL3GVsCR+
         Lsbq/qAd10dRnXDVGfrL0XIPoglbyik0naliwF6T6tPXRNUEg7fQBSxXIWP9VZc9es64
         NN1xmzt/CVQpVdhTj/1cXpDLySGjygwTOwVhaIyHciNwf7nYEEqgmgoRCGtPvNfFhJLa
         XRsU8pZPNHk3DORirEvHrGH08FZJQI+br15L7PYFQSwXPOewJGS+HK9Nz3nyS8PTUcUD
         gdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I5GioQ7xUQ9H5fXXCmntzv0GQIvWTOWUbe50tuhhBHA=;
        b=P954DHW6nuFybQF4+qM/kMPKBBPdqDbLahXZ0FkloZN1xkUppEOboskpV3IYNhA9R4
         mrIvDUmSnT/OLiFvBrTVf7cYxPljoI1ZDULhEmAq3Xdu6WVr+40nTruqJ9PuFbZaEAG3
         j+yCWQTUews/7uVAyHH5pCHUUtoTfrG5sHUP5U9Nm0SKoy05dQ7nX7zAsT0bl9v0Juon
         +oPZJmfwG6K+ODFGJrP+s9Q/TWSLpnZvezqjd7/aEh6HfgVpZehaJxF13mOTQXy6j4Cm
         m4vfhz/yiCa2DgnLSWOLgG7/RH3v8sDq+j1kQ0aKlt8ITefff7d+ilk/sZFvFizkdiiU
         gl5g==
X-Gm-Message-State: AIVw113LAtOJF+v3wy6MEofwkzJx1lIJDtrw1Hc0lIIKlZM6en1Ekntk
        K/e9inWF1Hb2hbDIjZe4y3avmJuHi1MK
X-Received: by 10.36.142.195 with SMTP id h186mr18176198ite.94.1499269718587;
 Wed, 05 Jul 2017 08:48:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.155.195 with HTTP; Wed, 5 Jul 2017 08:48:17 -0700 (PDT)
In-Reply-To: <87eftvazvk.fsf@gmail.com>
References: <1499116727-757-1-git-send-email-f@mazzo.li> <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
 <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
 <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com> <87eftvazvk.fsf@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 5 Jul 2017 17:48:17 +0200
Message-ID: <CACBZZX5h2BNsnRC4rmsqEadXyJzrO-YpnXCEYYe__KY_UA0JAw@mail.gmail.com>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Francesco Mazzoli <f@mazzo.li>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 5, 2017 at 1:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Jul 05 2017, Junio C. Hamano jotted:
>
>> On Tue, Jul 4, 2017 at 11:34 PM, Francesco Mazzoli <f@mazzo.li> wrote:
>>>
>>> Could you clarify the danger you're referring to? E.g. give an example
>>> of surprising --force-with-lease behavior that we do not want to
>>> encourage?
>>
>> https://public-inbox.org/git/1491617750.2149.10.camel@mattmccutchen.net/
>
> In the context of this patch I don't understand why you're concerned
> that making --force mean --force-with-lease makes things worse.
>
> See my
> https://public-inbox.org/git/CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H=
5j8awqQ@mail.gmail.com/
> (follow-up to the E-Mail you posted):
>
>     To me the *main* feature of --force-with-lease is that it's less
>     shitty than --force, without imposing too much UI overhead. We have t=
o
>     be really careful not to make --force-with-lease so complex by defaul=
t
>     that people just give u and go back to using --force, which would be
>     worse than either whatever current problems there are with the
>     current --force-with-lease behavior, or anything we replace it with.
>
> I.e. yes there are workflows with some background auto-update that will
> make it less safe, which I documented in f17d642d3b ("push: document &
> test --force-with-lease with multiple remotes", 2017-04-19).
>
> But it is still the case that --force-with-lease is categorically a more
> safer option than simply --force, which has none of the safety
> --force-with-lease has. It would still wipe away history in this
> scenario you're pointing out *and others*.
>
> Surely the point of having an option like this is to have a net
> reduction in complexity.

I mean reduction in risk...

> I think it can be argued that it's bad UI design though to have --force
> mean different things depending on the config, and we'd be better off
> with a patch that disables --force.

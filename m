Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54CD1F406
	for <e@80x24.org>; Wed, 16 May 2018 21:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeEPVVn (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:21:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52172 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeEPVVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:21:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4-v6so4868555wme.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=av2ALtQ7dTN7K78oYmaojbcm0hJyTVESdEP/bmc5/Pg=;
        b=Grgh5bo8Bb6lJsInPlbix42L96wLRosQ1o7hbqJUmtRipNPh1jm62sRozzGplxV9do
         t0somcb2jcBp7vPG6nSu5nRzVOKAYclkXD5wLiB2tSSDp4GN8sGfjMQsI4ZJ1sE3BQX4
         CdpeyebG8Ks2dP57Yw1YjkZA0IXcwyi4cQB7qy/75X+W4HTOkiit2uwyZ8yFDNlWvN5B
         qCqgQ68NdbOGHD6U7n/RCrivxI8tyNT10Dy56F/FZYldYP2WCRF+Nx3bD979ZLpuBALN
         Nk5fheaRaD7ARIU7AmYC2xUHYg5uQoRaqX8qtJOH3pul9WaW5uPsVyORwG46U2eORzL+
         MYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=av2ALtQ7dTN7K78oYmaojbcm0hJyTVESdEP/bmc5/Pg=;
        b=C1ZUhV0fSJ2/6kbuRSYyjj5dxvXiFW3G/s6cm8sAVzPatoQHZOHcI+BxROwxdLtct9
         Vxhy5Js2aQ/dUlrGTv363VMZrkkQjdapzYyC9a0OrLWfavgTp0i2OeA5fEBW+JFjuPZ8
         9+Zb61yTmbbqb/aGISqOkHSetDbLPqruBhFjUQNwV17sJFyV2pJSnlX3A+5wru2c82F9
         Ix82XbhLV8UTNKF7PpPWklUn4c72urAk85dvZJ5Lyd5QqUq8/9nZr5f0Ozf9eLtl+74V
         ATdSaKXbMBN7TwdP6obhXmIrFm7knsjPXmiQqJP3+cqZXKFnn3mA4ruMP+y5nkKB1Zb2
         rqWw==
X-Gm-Message-State: ALKqPwfSW3cpVg6cvdt7b5ZXWvoSIpKswrvRRl4ksTziLHQkorfLojpa
        Lg0ZxfOfFosnQ2OsgIXlXqAle+Mb6m5k5Jqn2y0=
X-Google-Smtp-Source: AB8JxZrAeD09PVGgpf/hLcOhfLBJXS5La4CZvK4Jf5twYJhfodcjs/9viDVH9u+EVYxmP4OgmebgwHnBt+AO1/mIebw=
X-Received: by 2002:a50:b2e4:: with SMTP id p91-v6mr3319013edd.84.1526505701849;
 Wed, 16 May 2018 14:21:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Wed, 16 May 2018 14:21:21 -0700 (PDT)
In-Reply-To: <CAN0heSqdVB3SmQnBeJB06f4uXzUBM6OC2ySZNZnhJdisbR28Kg@mail.gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com> <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
 <CAGZ79kYBykcbzKxc_FHiL6dt=jkmK2Khe-e5aSxFephe=RsBFA@mail.gmail.com> <CAN0heSqdVB3SmQnBeJB06f4uXzUBM6OC2ySZNZnhJdisbR28Kg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 16 May 2018 14:21:21 -0700
Message-ID: <CA+P7+xrgB2NNFViy41bjhv10mxj4QpAuzUZOY9ghZ8E65tyaXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] merge: setup `opts` later in `checkout_fast_forward()`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 12:29 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> On 16 May 2018 at 18:41, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, May 16, 2018 at 9:30 AM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>>>
>>> This patch is best viewed using something like this (note the tab!):
>>> --color-moved --anchored=3D"      trees[nr_trees] =3D parse_tree_indire=
ct"
>>
>> Heh! Having a "is best viewed" paragraph is the new shiny thing in
>> commit messages as 'git log origin/pu --grep "is best viewed"' tells me.
>
> :-)
>
>> Regarding the anchoring, I wonder if we can improve it by ignoring
>> whitespaces or just looking for substrings, or by allowing regexes or ..=
.
>
> FWIW, because my first naive attempt failed (for some reason I did not
> consider the leading tab part of the "line" so I did not provide it), I
> had the same thought. Ignoring leading whitespace seemed easy enough in
> the implementation.
>
> Then I started thinking about all the ways in which whitespace can be
> ignored. My reaction in the end was to not try and open that can right
> there and then. I did not think about regexes.
>
> I guess this boils down to the usage. Copying the line to anchor on from
> an editor could run into these kind of whitespace-issues, and shell
> escaping. Typing an anchor could become easier with regexes since one
> could skip typing common substrings and just anchor on /unique-part/.
>
> Martin

Simpler approach is to just match substring instead. Then, the user
can decide how much of the string is required to get the anchor they
wanted.

Thanks,
Jake

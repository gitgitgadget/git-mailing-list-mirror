Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D349D1F406
	for <e@80x24.org>; Wed, 16 May 2018 21:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEPVzA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:55:00 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34805 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeEPVy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:54:59 -0400
Received: by mail-vk0-f68.google.com with SMTP id t63-v6so1498380vkb.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sB2h1T3S6g22Ea+U888L8d6IFsPa5ZFGey9cAPf9t9M=;
        b=vKr+nWAFJCjHARHcRkbPGsPgp9Ivzr+3BE9N2x3evbFQ1UBMMHfNENr444CJZ3g0ET
         BRNqtntDeeNGCegM2DoWvMovKFdGt4goYTmnFfDmEu4co0iBSUiqgou0qNUafOh/jmN7
         Q7LnkKTqNh7boJE9ENRAJ1pomUG4Ybwb5sfwTN9sdVLo4Bg0i6vWivBhu7CM0Z/aF4mw
         f/dgH2bGuArmuTGthM/Mqn766cxIsyYQg7vlqnvGgqO2hhdQzmLkwkl05LaT1CIN6C2H
         2uLF79+htr+tywdEDuV/1Nm9gXmvNE6q/E3ye9ZytUw88Px5bWCoq9UeeaT7Pp5mIu9Y
         UgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sB2h1T3S6g22Ea+U888L8d6IFsPa5ZFGey9cAPf9t9M=;
        b=Y1/ngRGQC4+WpdGDaIXAaGu/rX1ycyNohPhNvpJed6JEPlshNWHsOhZpTIlq/GkZy8
         fxeoOOkUrOuh2usyACUJqDkSLFxUK8XeZx2gRlX7aX6i5lcCE5gWyNdCq6N37dsk/I75
         0TBDpxS6+knNYJ6sUk6Y56mYloitohwS5x8MQyxuaD5JmFE6/kwJjMKSGlbQrn42zBx/
         6s5rU1qfPNJ5NdRI1pTHNnJ00STLqXz6vXT5U5r5e28idcSax5N0TNvXM7Harfp5vcKY
         zrQ20y1a2H9W52o3hsoaKeBwWh+CmwCuNO/q3S547jc7tdF/9MnGaA8U4DQwWIKzPwPJ
         comQ==
X-Gm-Message-State: ALKqPwdDSl3uaWv6ypSzZPDgtPlw3rbryVL4TWb7A9fFcAAeE698tAym
        +9LZRbXo0Z1i1By4bhhPzsXYZyWNkkbt/emHTGA=
X-Google-Smtp-Source: AB8JxZoKSoHM8cO6FJeqQMJfRLr7Gpq74N/+Eqgp9eezrUuUETlx1BHFmDDzyAQIBCfU4u6NiHSLfXqE9I7s9Q8Q6Ig=
X-Received: by 2002:a1f:2cc6:: with SMTP id s189-v6mr2422525vks.106.1526507698340;
 Wed, 16 May 2018 14:54:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 16 May 2018 14:54:57 -0700 (PDT)
In-Reply-To: <cover.1526488122.git.martin.agren@gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 May 2018 14:54:57 -0700
Message-ID: <CABPp-BFtMQMK_4RAQk=XHoXdFYDxkvwz-Gws9Fz-0DdcfiJKcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] unpack_trees_options: free messages when done
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Wed, May 16, 2018 at 9:30 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 16 May 2018 at 16:32, Elijah Newren <newren@gmail.com> wrote:
>> On Sat, Apr 28, 2018 at 4:32 AM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>>> As you noted elsewhere [1], Ben is also working in this area. I'd be
>>> perfectly happy to sit on these patches until both of your contribution=
s
>>> come through to master.
>>>
>>> [1] https://public-inbox.org/git/CABPp-BFh=3DgL6RnbST2bgtynkij1Z5TMgAr1=
Via5_VyteF5eBMg@mail.gmail.com/
>>
>> Instead of waiting for these to come through to master, could you just
>> submit based on the top of bp/merge-rename-config?
>
> Sure, here goes. This is based on bp/merge-rename-config, gets rid of
> all leaks of memory allocated in `setup_unpack_trees_porcelain()` and
> cuts the number of leaks in the test-suite (i.e., the subset of the
> tests that I run) by around 10%.

Awesome, thanks.  I've looked over patches 2 & 3; they look good to me.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EA51F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032492AbeBPRTj (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:19:39 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:38978 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032461AbeBPRTh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:19:37 -0500
Received: by mail-lf0-f41.google.com with SMTP id h78so5001323lfg.6
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+xBAN7DHNPVNKDKKO0Ht+g+NafBkuZ4iQn6aMio4dow=;
        b=XmwcUadWfAhuKRV1JbN4opHGLztFSzDjAb8SUzjWh5hgjjT7tsM1SKbHBcMqwriPTB
         p+ERrStNOyehBhlWMundukQi8ohnD0KFx/ZfrVH3BQFjExpdsbOAH0v81lau2cfQq07A
         jJdkiHjo0SM9i3c5hJ0hfv+IM2kphjz86XZkckmKM4W4xpF2UXKtMyem8tHHxrkbdP+P
         uU9+UNRyHP+XpsxjXQwkzM8jz1ToA5qzsOViOPtol3miq9YMYS67Gizz2EuminlXbB0K
         iivVJnJYYkhOC4HzpqykNneEDGBz6+oDB6Xx9kCPOeNE+Hq3B7jx6EnjhkXc1DdB5G2R
         FJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+xBAN7DHNPVNKDKKO0Ht+g+NafBkuZ4iQn6aMio4dow=;
        b=MuXq63CDUx1IG6U8tu9KNqG3kTDWYMPShzQuqJBYKZKYKddVzA6JfmcqzNMIe30UEO
         kO1k2m2EjbkDEZEkK0j9qWGtBNXwYhissvGSlmF5rpJefVuPRSweQUFguqHw9kBQZGAD
         2pv0NfiijfEuB6J4iy1c/aRdPqWTOzbwOifMmLkVd5uxJ3397ZPB7rdE8RkAttIEL8N8
         rjXK+nSbcQgY4wK9CsFJL54xM1Tz9AY3xMO0+hYrCYfLvcREjWUPiyrp73Fm+Fnxq7pw
         PFD7P31wayO0Dwg8HUB5GYmn/En8w0xQEd0UTLYgJsU79SphDCo13wZSFwg3X51Xab7R
         frwg==
X-Gm-Message-State: APf1xPBwyBUCpGC2W5OrU0+zC+Z/RbuAGi9l2qNqh6HU1KcP2ZKxsUA0
        4mH1U2iFRqE5wVvOcva0u9+w0zY19gqdUbrg2lc=
X-Google-Smtp-Source: AH8x2253cj0gyJA29zLbE2XrY8J3HWJXq6dmNPiZGvvaZ84H+F+Gw88OpkVYTDh08h4wXZ7pad8CIYyVg66uig/z38Y=
X-Received: by 10.25.158.67 with SMTP id h64mr4930989lfe.56.1518801575746;
 Fri, 16 Feb 2018 09:19:35 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.114.19 with HTTP; Fri, 16 Feb 2018 09:19:35 -0800 (PST)
In-Reply-To: <20180216163422.GA2659@tor.lan>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de> <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de> <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499CSe6d1SBaDYNRD9HXaWRJ9QYzmOCaBWFrV52UNRMVqhA@mail.gmail.com> <20180216163422.GA2659@tor.lan>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 16 Feb 2018 11:19:35 -0600
X-Google-Sender-Auth: LPKOlMy1nKUwumtI2IDt1djsjLM
Message-ID: <CAHd499BrJ9egFvkPSQdFXL6=3qq9FrtiLV0Nz6tPbf-WT-P1ag@mail.gmail.com>
Subject: Re: Line ending normalization doesn't work as expected
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 10:34 AM, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> On Thu, Feb 15, 2018 at 09:24:40AM -0600, Robert Dailey wrote:
>> On Tue, Oct 3, 2017 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote=
:
>
> []
>>
>> Sorry to bring this old thread back to life, but I did notice that
>> this causes file modes to reset back to 644 (from 755) on Windows
>> version of Git. Is there a way to `$ git read-tree --empty && git add
>> .` without mucking with file permissions?
>
> No problem with the delay, under the time we had the chance to improve Gi=
t:
>
>>Git 2.16 Release Notes
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>[]
>>* "git add --renormalize ." is a new and safer way to record the fact
>>   that you are correcting the end-of-line convention and other
>>   "convert_to_git()" glitches in the in-repository data.
>
> Could you upgrade to Git 2.16.1 (or higher, just take the latest)
> and try with
> git add --renormalize .
> ?

Thanks for the response. Unfortunately I've deliberately been stuck on
v2.13 because of [a bug in Git for Windows][1] that hasn't yet been
resolved (it's a bug *somewhere*, not sure if it's git related or
not). Curly braces in aliases are being stripped which makes newer
releases unusable for me. I'll try upgrading on a different machine
and see if renormalize works for the case of binary files with file
modes set to 755.

[1]: https://github.com/git-for-windows/git/issues/1220

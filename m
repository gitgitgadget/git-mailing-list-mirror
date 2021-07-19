Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C911C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 08:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAA2613F3
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhGSIRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:17:48 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:45807 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhGSIRr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 04:17:47 -0400
Received: by mail-pl1-f174.google.com with SMTP id p17so9218750plf.12
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=83ZwI96nmolfwjcNa7VbonPgOF8Rq/nzgQP6qmm1xmQ=;
        b=oSy9lrYRPxIaWdtJHPi2obOc6c7izqPlxW+7dPLAh+u+g/t3M/C49MrWgRLPuIImSP
         LX05dfT6GaJYPgXyISjGrgcipM30eniP8WqbQ9rc3mBFWHkgn4qZPV8SZsHdoAvqw1py
         mw+5Ao1El+qqi4hZdVZ+3XCNy7bBG0SWdd/FtF5lF6ytbDQcqJ3TkOD7CvBLNDOGGLSg
         5bgYIbX9Y8zBW9yIiqJHEIVOthGSDTyJzk37ILw0QA/BSyO74+JGRn0GBKgO2tIbIqEF
         MazIo+DLi9SzMXOVGziL3DGDXBEwDX+tRaL7++eVrAnSLn/M9Kx4ZpXg3iZS46ltKsqn
         eqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=83ZwI96nmolfwjcNa7VbonPgOF8Rq/nzgQP6qmm1xmQ=;
        b=uPgkUjP4DqFKqwCJSmZVL5Z6Uihlyz87VxZE7gDyrl8VRkq6a+Baa7Lzun3kKAGxTf
         gn1InorvglCOMx3I4GOwQebKf9eNdtCXdRnTJqPw27xWi3gEdMH+rxvX4wCsCq2qav52
         ZWzlGPluEF1/YqdhvbcI8KqGPx+/ChmZckWCv+qk3tog3myHuCcReMJ+dvWXm4LSXEUM
         r0lXElFn+EAsZgAOvUXuvW7u+aYhWq691bQ1R1TWBqNXDuwKx1N/51dKR282T+LkYK2l
         yOuBzuqo5oKfuqA0vJgB5hAdXEJ0tNdl67g2lQ6pnsXKhL+mknWocFXRAzroTIkO5Qdu
         P1QQ==
X-Gm-Message-State: AOAM530zDAnKuxMDQLn0LmHlGfbZ8hrBCfTgX8KAhgfAVNye/n1WgYDy
        4J9AUYURxLvNwLEdCtS95h4=
X-Google-Smtp-Source: ABdhPJxfqh+TVhgQ8hMxWanJd9u61N/aR/Aa90yRWpR043oimvtLln5X5xx5dIi2ieP9nsHeognIGQ==
X-Received: by 2002:a17:90b:3608:: with SMTP id ml8mr29840327pjb.215.1626685047980;
        Mon, 19 Jul 2021 01:57:27 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id j129sm19641673pfb.132.2021.07.19.01.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 01:57:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: My Git Dev Blog - Week 9
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com>
Date:   Mon, 19 Jul 2021 14:27:25 +0530
Cc:     Git List <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A644ECB8-E272-4EA9-9606-E13A36270C9D@gmail.com>
References: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
 <CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18-Jul-2021, at 18:45, Christian Couder <christian.couder@gmail.com> =
wrote:
>=20
> On Sun, Jul 18, 2021 at 1:59 PM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>=20
>> Here's my latest blog post:
>> https://atharvaraykar.me/gitnotes/week9
>=20
> Great!
>=20
>> A part that may be interesting to list readers:
>>=20
>> - In one section of the blog, I describe the problem of the git
>>  submodule configuration not updating properly, when I launch
>>  a subprocess that first initialises the submodule. I will
>>  appreciate it if someone has a possible explanation for the
>>  issue I faced at:
>>  =
https://atharvaraykar.me/gitnotes/week9#launching-the-init-part-as-a-subpr=
ocess
>=20
> My wild guess about why is_submodule_active() might not be working as
> expected is that submodule_from_path() uses the submodule cache which
> might not be properly updated when a submodule is initialized by a
> subprocess.

Right, I have made a note of this. It does feel like the most plausible
explanation, which I might look into after my update series is done.

>> The rest of the post talks about my project progress so far, and how =
I
>> avoided the above problem entirely for now by taking a different =
approach.
>=20
> Nice that you found a possible better way!


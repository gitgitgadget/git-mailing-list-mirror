Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55301FAE2
	for <e@80x24.org>; Mon, 26 Feb 2018 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeBZVWd (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:22:33 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:39772 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeBZVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:22:32 -0500
Received: by mail-pl0-f45.google.com with SMTP id s13so10031530plq.6
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 13:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xXS3Clv1XylUiG+bQefl66HFnokXHxss/CZVEPwFfZo=;
        b=myWwlawT3BmNB/A9wGkP/zU1Zw9kVbVaCXSnlWJWe3mgtGM1YEW0RPMUiWUo1ZlFO6
         hCs64wTKwpsANrKoymqD1p1WArhAz8GF/KmdppUXT3KjfnPqumTlyqNaOkucJrbZF5oP
         cXyoNLq46faxzcWk3fTVCEzg4rIZiqqK6/2zlZV79eBlea/Z2t8fIxpzaBRpao3NJh7m
         sXbHlgd9dA4F1lB/x9rqo/+qirn+JDBwj0KAPefvtlNv8bbwZJxkcs1RQJx0SnWfA2se
         qrRZ5KBpzMHiNpItBV3821dWYT7a6plJ7hsvKkENxB+q/UpQ3U/9kHDuSxA6b44k+i/c
         1lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xXS3Clv1XylUiG+bQefl66HFnokXHxss/CZVEPwFfZo=;
        b=WdwMuz71j4S1BUp0Wm34WNZXg2Dj0YBjX5Iu28D3lAHajXCCmc5TsK0JMHaA2atTK7
         5HgviqkBg4tq26FGKQueh02aJdEwZ6FsdFdUmMp27XcF4Q8PlD4pHDY4rcrfDXyhI+x3
         RS5yNle0V8+VTVdNqJsEZ/NpRSWZuvfp/EJgRH45WwrONAxPbkeEtmYrEhZy++HMChaV
         DCyYY3eifhJwbmuhvDMtkSVqM0uNH3pd6fe3j9VzVcQY3VUC9bayVJtgGWLJQyx4SzyC
         GfRurGZq1hilg5QKnlIP9AbaW/MR4NGS2Vw6qul7ZlAXXoODEMnhgDprr8YSgINmnkTj
         mUCA==
X-Gm-Message-State: APf1xPBp7jlBkOgN1Vk31cSWApLJXOSy+SLahKwHdDmWO3MWG83X99s6
        kZyk3+8FLnUnhW8WzU/1Yb7xjRhqjn+Zhs0ggpc=
X-Google-Smtp-Source: AG47ELtMxIkFT7E4ARtRPQnUZiXwV6Xhm01N5SqxiTV40M7p/emGgkYFcclyOfoSft8fz3WnFC0PdXRxqYC0zoSyzZg=
X-Received: by 2002:a17:902:b117:: with SMTP id q23-v6mr8312754plr.58.1519680152032;
 Mon, 26 Feb 2018 13:22:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Mon, 26 Feb 2018 13:22:31 -0800 (PST)
In-Reply-To: <a86793c8-2051-4d92-967b-1d24dbf4a2ff@gmail.com>
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com> <20180214215637.6462-1-martin.agren@gmail.com>
 <20180219212937.GB9748@sigill.intra.peff.net> <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
 <a86793c8-2051-4d92-967b-1d24dbf4a2ff@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 26 Feb 2018 22:22:31 +0100
Message-ID: <CAN0heSq0aWXkjEN7zjQs7yV8V0JSupNwy30yvqcM_V8M-rw-9A@mail.gmail.com>
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 February 2018 at 04:48, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Wednesday 21 February 2018 02:14 AM, Martin =C3=85gren wrote:
>> To sum up: I probably won't be looking into Travis-ing such a blacklist
>> in the near future.
>>
>
> Just thinking out loud, how about having a white-list instead of a
> black-list and using it to run only those tests in the white list.
> Something like,
>
> t/white_list
> ------------
> t0000
> t0001
>
> To run
> ------
>
> cd t/
> for test in $(cat white_list)
> do
>     white_list_tests=3D"$white_list_tests $test*"
> done
> make SANITIZE=3Dleak $white_list_tests

Yeah, that would also work. An incomplete whitelist can't cause errors
for those running other tests, as an incomplete blacklist could. So
that's good. At some point, the whitelist would need to be turned into a
blacklist. At the very latest when the whitelist is the full set of
tests, in order to flip the default of new tests. ;-) Right now, I think
whitelists and blacklists are about equally useful.

Let's hope we're heading for a future where a blacklist gets more and
more feasible, whereas a whitelist would get longer and longer. ;-)

Martin
